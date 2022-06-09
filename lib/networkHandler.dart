import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart'; // logger used for arrange the result and error

class NetworkHandler {
  var log = new Logger(); // creating instance  for logger

  Future get(dynamic url) async {
    var uri = Uri.parse(url);
    // log.i(uri);
    // passing tocken to database
    var response = await http.get(uri);
    // log.i(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    }
  }
}
