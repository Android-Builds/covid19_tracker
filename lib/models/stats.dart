import 'dart:convert';
import 'package:http/http.dart' as http;

String api = 'https://disease.sh/v3/covid-19/historical/';
String prefix = '?lastdays=360';
String globalapi = 'https://disease.sh/v3/covid-19/historical/all?lastdays=600';

class Stats {
  Map cases;
  Map deaths;
  Map recovered;

  Stats({this.cases, this.deaths, this.recovered});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
        cases: json['cases'],
        deaths: json['deaths'],
        recovered: json['recovered']);
  }
}

Future<Stats> getStats(String country) async {
  final response = await http.get(Uri.parse(api + country + prefix));
  final responseJson = json.decode(response.body);
  return Stats.fromJson(responseJson['timeline']);
}

Future<Stats> getGlobalStats() async {
  final response = await http.get(Uri.parse(globalapi));
  final responseJson = json.decode(response.body);
  return Stats.fromJson(responseJson);
}
