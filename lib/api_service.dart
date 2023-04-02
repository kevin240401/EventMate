import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'event_model.dart';
import 'searchscreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';



class APIService {
  static const _authority =
      "concerts-artists-events-tracker.p.rapidapi.com";
  static const _path = "/location";
  late final _query;
  static const Map<String, String> _headers = {
    "x-rapidapi-key": "d7d0217e8amshed7d01ec812f21cp1bc69ejsn68e3aca0c46a",
    "x-rapidapi-host": "concerts-artists-events-tracker.p.rapidapi.com",
  };

  APIService({required String name}) {
    _query = {"name": name, "minDate": "2023-04-01", "maxDate": "2023-05-30", "page": "1"};
  }

  // Base API request to get response
  Future<List<Data>> get() async {
    Uri uri = Uri.https(_authority, _path, _query);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      final jsonMap = json.decode(response.body);
      print("Api Call hat geklappt");
      print(jsonMap);
      final myData = MyData.fromJson(jsonMap);
      return myData.data;
    } else {
      // If that response was not OK, throw an error.
      print("api call hat nicht geklappt");
      throw Exception(
          'API call returned: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}



