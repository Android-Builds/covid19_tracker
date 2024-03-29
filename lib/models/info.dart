import 'dart:convert';
import 'package:http/http.dart' as http;

String latestapi = 'https://disease.sh/v3/covid-19/all';
String contapi = 'https://disease.sh/v3/covid-19/countries';

class Info {
  int cases;
  int deaths;
  int recovered;
  String country;
  int todayCases;
  int todayDeaths;
  int todayRecovered;
  int active;
  int critical;
  String flag;
  String tests;
  String testsPerOneMillion;
  String deathsPerOneMillion;
  String casesPerOneMillion;

  Info({
    this.cases,
    this.deaths,
    this.recovered,
    this.country,
    this.todayCases,
    this.todayDeaths,
    this.todayRecovered,
    this.active,
    this.critical,
    this.flag,
    this.deathsPerOneMillion,
    this.casesPerOneMillion,
    this.tests,
    this.testsPerOneMillion,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      cases: json['cases'],
      deaths: json['deaths'],
      recovered: json['recovered'],
      country: json['country'],
      todayCases: json['todayCases'],
      todayDeaths: json['todayDeaths'],
      todayRecovered: json['todayRecovered'],
      active: json['active'],
      critical: json['critical'],
      flag: json['countryInfo']['flag'].toString(),
      tests: json['tests'].toString(),
      testsPerOneMillion: json['testsPerOneMillion'].toString(),
      deathsPerOneMillion: json['deathsPerOneMillion'].toString(),
      casesPerOneMillion: json['deathsPerOneMillion'].toString(),
    );
  }
}

class Latest {
  var cases;
  var deaths;
  var active;
  var recovered;
  var critical;
  var todayDeaths;
  var todayCases;
  var todayRecovered;
  var tests;
  var casesPerOneMillion;
  var deathsPerOneMillion;
  var testsPerOneMillion;
  var affectedCountries;

  Latest({
    this.cases,
    this.deaths,
    this.active,
    this.recovered,
    this.affectedCountries,
    this.casesPerOneMillion,
    this.critical,
    this.deathsPerOneMillion,
    this.tests,
    this.testsPerOneMillion,
    this.todayCases,
    this.todayDeaths,
    this.todayRecovered,
  });

  Map<String, dynamic> toJson() => {
        'cases': cases,
        'deaths': deaths,
        'active': active,
        'recovered': recovered,
      };

  factory Latest.fromJson(Map<String, dynamic> json) {
    return Latest(
        cases: json['cases'],
        deaths: json['deaths'],
        recovered: json['recovered'],
        active: json['active'],
        critical: json['critical'],
        tests: json['tests'],
        todayCases: json['todayCases'],
        todayDeaths: json['todayDeaths'],
        todayRecovered: json['todayRecovered'],
        casesPerOneMillion: json['casesPerOneMillion'],
        deathsPerOneMillion: json['deathsPerOneMillion'],
        testsPerOneMillion: json['testsPerOneMillion'],
        affectedCountries: json['affectedCountries']);
  }
}

List<Info> info = [];

Future<Latest> getLatest() async {
  final response = await http.get(Uri.parse(latestapi));
  final responseJson = json.decode(response.body);
  return Latest.fromJson(responseJson);
}

Future<List<Info>> getInfo() async {
  final response = await http.get(Uri.parse(contapi));

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    if (responseJson.length > 0) {
      for (int i = 0; i < responseJson.length; i++) {
        if (responseJson[i] != null) {
          Map<String, dynamic> map = responseJson[i];
          info.add(Info.fromJson(map));
        }
      }
    }
    return info;
  } else {
    throw Exception('Failed to load post');
  }
}
