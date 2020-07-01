import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tatvasoftdamo/Modelclass.dart';

class ApiCall{

  Future<List<Users>> getData() async {
    final response = await http.get('http://sd2-hiring.herokuapp.com/api/users?offset=10&limit=10');
    if(response.statusCode == 200){
      List<Users> users;
      var res = json.decode(response.body);
      var rest = res['data']['users'] as List;
      users = rest.map<Users>((json) => Users.fromJson(json)).toList();
      return users;
    } else
      return null;
  }
}