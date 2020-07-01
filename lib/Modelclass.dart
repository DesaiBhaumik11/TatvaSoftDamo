

class UserData{
  String message;
  bool status;
  Data data;

  UserData({this.message, this.status, this.data});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data{
  bool hasMore;
  List<Users> users;

  Data({this.hasMore, this.users});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      hasMore: json['hasMore'],
      users: List<dynamic>.from(json['users'].map((x) => Users.fromJson(x))),
    );
  }
}

class Users{
  String name;
  String image;
  List<String> items; 
  
  Users({this.name, this.image, this.items});
  
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'],
      image: json['image'],
      items: List<String>.from(json['items'].map((x) => x)),
    );
  }
}