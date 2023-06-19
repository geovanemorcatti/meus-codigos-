import 'dart:convert';

class User {
  final String username;
  final int id;
  final String name;
  final String email;

  User(this.username, this.id, this.name, this.email);

  User.fromJson(Map<String, dynamic> json) :
    username = json['username'],
    id =  json['id'],
    name = json['name'],
    email = json['email'];

  Map<String, dynamic> toJson() => {
    'username': username,
    'id': id,
    'name': name,
    'email': email,
  };

  @override
  String toString() {
    Map<String, dynamic> json = toJson();
    return jsonEncode(json);
  }
}