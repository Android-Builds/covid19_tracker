import 'dart:convert';
import 'package:http/http.dart' as http;

String api = 'https://corona.lmao.ninja/all';
String contAPi = '?country_code=';

class Info {
  String cases;
  String deaths;
  String recovered;
  String country;

  Info({this.cases, this.deaths, this.recovered,
  this.country});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      cases: json['cases'].toString(),
      deaths: json['deaths'].toString(),
      recovered: json['recovered'].toString(),
      country: json['country'].toString(),
    );
  }
}

class Latest {
  int cases;
  int deaths;
  int recovered;

  Latest({this.cases, this.deaths, this.recovered});

  factory Latest.fromJson(Map<String, dynamic> json) {
    json = json;
    return Latest(
      cases: json['cases'],
      deaths: json['deaths'],
      recovered: json['recovered']
    );
  }
}

class Country {
  String country;
  String code;
  String province;

  Country({this.country, this.code, this.province});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      country: json['country'],
      code: json['country_code'],
      province: json['province']
    );
  }
}

var keys;
List<Country> countries = new List<Country>();
List<String> countriess = new List<String>();
List<Info> info = new List<Info>();

Future<Latest> getLatest() async {
  final response = await http.get(api);
  final responseJson = json.decode(response.body);
  return Latest.fromJson(responseJson);
}

Future<List<Info>> getInfo() async {
  final response = await http.get(api);

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    if(responseJson.length>0){
      for(int i=0; i<responseJson.length; i++){
        if(responseJson[i] != null){
          Map<String,dynamic> map = responseJson[i];
          info.add(Info.fromJson(map));
        }
      }
    }
    return info;
  } else {
    throw Exception('Failed to load post');
  }
}

// Future<Latest> getInfo(Country country) async {
//   final response = await http.get(api+contAPi+country.code);
//   if (response.statusCode == 200) {
//     var responseJson = json.decode(response.body);
//     responseJson = responseJson['locations'];
//     if(responseJson.length>0){
//       for(int i=0; i<responseJson.length; i++){
//         if(responseJson[i] != null && responseJson['province'] == country.province){
//           Map<String,dynamic> map = responseJson[i];
//           countries.add(Country.fromJson(map));
//         }
//       }
//     }
//     return null;
//   } else {
//     throw Exception('Failed to load post');
//   }
// }