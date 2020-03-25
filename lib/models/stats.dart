import 'dart:convert';
import 'package:http/http.dart' as http;

String api = 'https://corona.lmao.ninja/v2/historical/';

class Stats {
  Map cases;
  Map deaths;
  Map recovered;

  Stats({this.cases, this.deaths, this.recovered});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      cases: json['timeline']['cases'],
      deaths: json['timeline']['deaths'],
      recovered: json['timeline']['recovered']
    );
  }
}

Future<Stats> getStats(String country) async {
  final response = await http.get(api+country);
  final responseJson = json.decode(response.body);
  return Stats.fromJson(responseJson);
}