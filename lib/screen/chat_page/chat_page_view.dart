
import 'package:chatApp/enum/view_state.dart';
import 'package:chatApp/helper/color_presets.dart';
import 'package:chatApp/provider/image_upload_provider.dart';
import 'package:chatApp/widgets/chat_widget.dart';
import 'package:chatApp/widgets/modal_tile.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import './chat_page_view_model.dart';

class ChatPageView extends ChatPageViewModel {
  @override
  Widget build(BuildContext context) {
    imageUploadProvider = Provider.of<ImageUploadProvider>(context);
    return Scaffold(
      backgroundColor: blackColor,
      appBar: customAppBar(context, sender, widget.receiver),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: messageList(
                context, currentUser, widget.receiver, scrollController),
          ),
          imageUploadProvider.getViewState == ViewState.LOADING
              ? Container(
                  width: 170,
                  height: 170,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: senderColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )),
                  child: Center(child: CircularProgressIndicator()),
                )
              : SizedBox(),
          chatControls(),
          showEmojiPicker
              ? Container(
                  child: emojiContainer(),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget emojiContainer() {
    return EmojiPicker(
      bgColor: separatorColor,
      indicatorColor: blueColor,
      rows: 3,
      columns: 7,
      onEmojiSelected: (emoji, category) {
        setState(() {
          isWriting = true;
        });
        textFieldController.text = textFieldController.text + emoji.emoji;
      },
      recommendKeywords: ["party", "sad", "happy", "bad", "angry"],
      numRecommended: 50,
    );
  }

  Widget chatControls() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () => addMediaButton(context),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: fabGradient,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                TextField(
                  focusNode: textFieldFocus,
                  onTap: () => hiddenEmojiContainer(),
                  maxLines: 4,
                  minLines: 1,
                  controller: textFieldController,
                  style: TextStyle(color: Colors.white),
                  onChanged: (val) {
                    (val.length > 0 && val.trim() != "")
                        ? setWritingTo(true)
                        : setWritingTo(false);
                  },
                  decoration: InputDecoration(
                    hintText: "Type a message",
                    hintStyle: TextStyle(color: greyColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    filled: true,
                    fillColor: separatorColor,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (!showEmojiPicker) {
                      hiddenKeyboard();
                      showEmojiContainer();
                    } else {
                      showKeyboard();
                      hiddenEmojiContainer();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(showEmojiPicker ? Icons.keyboard : Icons.face),
                  ),
                ),
              ],
            ),
          ),
          isWriting
              ? Container()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.record_voice_over),
                    ),
                    onTap: () {},
                  ),
                ),
          isWriting
              ? SizedBox()
              : InkWell(
                  borderRadius: BorderRadius.circular(15),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.camera_alt),
                  ),
                  onTap: () => pickImage(source: ImageSource.camera),
                ),
          isWriting
              ? Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: fabGradient,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () => sendMessage(),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  addMediaButton(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      backgroundColor: blackColor,
      builder: (context) {
        return Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: <Widget>[
                  FlatButton(
                    child: Icon(Icons.close),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Content and tools",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
                ],
              ),
            ),
            Flexible(
                child: ListView(
              children: <Widget>[
                ModalTile(
                  title: "Media",
                  subtitle: "Share Photos and Video",
                  icon: Icons.image,
                  onTap: () {
                    Navigator.of(context).pop();
                    pickImage(source: ImageSource.gallery);
                  },
                ),
                ModalTile(
                  title: "File",
                  subtitle: "Share file",
                  icon: Icons.tab,
                ),
                ModalTile(
                  title: "Contact",
                  subtitle: "Share Contacts",
                  icon: Icons.contacts,
                ),
                ModalTile(
                  title: "Location",
                  subtitle: "Share Location",
                  icon: Icons.add_location,
                ),
              ],
            ))
          ],
        );
      },
    );
  }
}
