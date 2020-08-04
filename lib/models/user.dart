class User {
  String uid;
  String name;
  String email;
  String username;
  String status;
  int state;
  String photo;

  User(
      {this.uid,
      this.name,
      this.email,
      this.username,
      this.status,
      this.state,
      this.photo});

  User.fromMap(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    status = json['status'];
    state = json['state'];
    photo = json['photo'];
  }

  Map<String, dynamic> toMap(User user) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['username'] = user.username;
    data['status'] = user.status;
    data['state'] = user.state;
    data['photo'] = user.photo;
    return data;
  }
}
