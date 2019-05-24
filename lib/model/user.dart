class User {
  int id,createdAt,updatedAt;
  String username;
  String url;

  User(
      {this.id, this.username, this.createdAt, this.updatedAt, this.url});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['url'] = this.url;
    return data;
  }
}