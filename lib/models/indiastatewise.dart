import 'dart:convert';
import 'package:http/http.dart' as http;

String api = 'https://api.covid19india.org/state_district_wise.json';

class IndiaState {
  String state;
  int cases;

  IndiaState({this.state, this.cases});

  factory IndiaState.fromJson(Map<String, dynamic> json, String state) {
    json = json['districtData'];
    int count = 0;
    var dist = json.keys.toList();
    for(int i=0; i<json.length; i++){
      if(json[dist[i]] != null){
        count += json[dist[i]]['confirmed'];
      }
    }
    return IndiaState(
      state: state,
      cases: count,
    );
  }
}

var states;
List<IndiaState> indiastates = new List<IndiaState>();

Future<List<IndiaState>> getIndia() async {
  final response = await http.get(api);

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    states = responseJson.keys.toList();
    if(responseJson.length>0){
      for(int i=0; i<responseJson.length; i++){
        if(responseJson[states[i]] != null){
          Map<String,dynamic> map = responseJson[states[i]];
          indiastates.add(IndiaState.fromJson(map, states[i]));
        }
      }
    }
    return indiastates;
  } else {
    throw Exception('Failed to load post');
  }
}