class UserRegister {
  Username username;

  UserRegister({this.username});
  UserRegister.fromJson(Map<String, dynamic> json){
    username = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.username;
    return data;
  }
}

class Username{
  String username;

  Username({this.username});

  Username.fromJson(Map<String, dynamic> json) {
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    return data;
  }
}