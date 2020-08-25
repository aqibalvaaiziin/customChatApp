import 'package:chatApp/db/log_repository.dart';
import 'package:chatApp/helper/const_config.dart';
import 'package:chatApp/helper/utils.dart';
import 'package:chatApp/models/log.dart';
import 'package:chatApp/screen/chat_list_page/widgets/chat_list_tile.dart';
import 'package:chatApp/widgets/chaced_data_image.dart';
import 'package:flutter/material.dart';

class ListLogContainer extends StatefulWidget {
  @override
  _ListLogContainerState createState() => _ListLogContainerState();
}

class _ListLogContainerState extends State<ListLogContainer> {
  Icon _icon;
  double _iconSize;
  Widget getIcon(String callStatus) {
    switch (callStatus) {
      case CALL_STATUS_DIALLED:
        _icon = Icon(
          Icons.call_made,
          size: _iconSize,
        );
        break;
      case CALL_STATUS_MISSED:
        _icon = Icon(
          Icons.call_missed,
          size: _iconSize,
          color: Colors.red,
        );
        break;
      default:
        _icon = Icon(
          Icons.call_received,
          size: _iconSize,
        );
    }
    return Container(
      margin: EdgeInsets.only(right: 5),
      child: _icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: LogRepository.getLogs(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          List<dynamic> logList = snapshot.data;
          if (logList.isNotEmpty) {
            return ListView.builder(
              itemCount: logList.length,
              itemBuilder: (context, i) {
                Log _log = logList[i];
                bool hasDialled = _log.callStatus == CALL_STATUS_DIALLED;
                return CustomTileItem(
                  leading: ChachedImageData(
                    hasDialled ? _log.receiverPic : _log.callerPic,
                    isRound: true,
                    radius: 45,
                  ),
                  icon: getIcon(_log.callStatus),
                  title: Text(hasDialled ? _log.receiverName : _log.callerName),
                  subtitle: Text(
                    Utils.formatDateString(_log.timestamp),
                    style: TextStyle(fontSize: 13),
                  ),
                  onLongPress: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Delete thos log?"),
                      content: Text("Are you sure want to delete this log?"),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              Navigator.maybePop(context);
                            },
                            child: Text("No")),
                        FlatButton(
                            onPressed: () async {
                              Navigator.maybePop(context);
                              await LogRepository.deleteLogs(i);
                              if (mounted) {
                                setState(() {});
                              }
                            },
                            child: Text("Yes")),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }
        return Center(
          child: Text("No calls logs"),
        );
      },
    );
  }
}
