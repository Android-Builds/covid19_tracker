import 'dart:convert';
import 'package:http/http.dart' as http;

String api = 'https://corona.lmao.ninja/historical/';

class Stats {
  var cases;
  var deaths;
  var recovered;

  Stats({this.cases, this.deaths, this.recovered});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      cases: json['timeline']['cases'].toString(),
      deaths: json['timeline']['deaths'].toString(),
      recovered: json['timeline']['recovered'].toString()
    );
  }
}

Future<Stats> getStats(String country) async {
  final response = await http.get(api+country);
  final responseJson = json.decode(response.body);
  return Stats.fromJson(responseJson);
}