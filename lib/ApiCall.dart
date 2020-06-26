import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tatvasoftdamo/Modelclass.dart';

class ApiCall{

  Future<Map<String, dynamic>> getData() async {
    final response = await http.get('http://sd2-hiring.herokuapp.com/api/users?offset=10&limit=10');
    if(response.statusCode == 200){

      Map<String, dynamic> map = json.decode(response.body);
      print(map);
      return map;
    } else
      return null;
  }
}