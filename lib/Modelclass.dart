// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  dynamic message;
  Data data;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.users,
    this.hasMore,
  });

  List<User> users;
  bool hasMore;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    hasMore: json["has_more"],
  );

  Map<String, dynamic> toJson() => {
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
    "has_more": hasMore,
  };
}

class User {
  User({
    this.name,
    this.image,
    this.items,
  });

  String name;
  String image;
  List<String> items;

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    image: json["image"],
    items: List<String>.from(json["items"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "items": List<dynamic>.from(items.map((x) => x)),
  };
}
