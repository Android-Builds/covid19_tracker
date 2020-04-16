import 'dart:convert';
import 'package:http/http.dart' as http;

String api = 'https://api.covid19india.org/data.json';

class StateData {
  String state;
  String active;
  String confirmed;
  String deaths;
  String recovered;
  String deltaconfirmed;
  String deltadeaths;
  String deltarecovered;

  StateData({this.state, this.active, this.confirmed, 
  this.recovered ,this.deaths, this.deltaconfirmed, 
  this.deltadeaths, this.deltarecovered});

  factory StateData.fromJson(Map<String, dynamic> json) {
    return StateData(
      state: json['state'],
      active: json['active'],
      confirmed: json['confirmed'],
      deaths: json['deaths'],
      recovered: json['recovered'],
      deltaconfirmed: json['deltaconfirmed'],
      deltadeaths: json['deltadeaths'],
      deltarecovered: json['deltarecovered']
    );
  }
}

List<StateData> states = new List<StateData>();

Future<List<StateData>> getStateData() async {
  final response = await http.get(api);

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    responseJson = responseJson['statewise'];
    if(responseJson.length>0){
      for(int i=0; i<responseJson.length; i++){
        if(responseJson[i] != null){
          Map<String,dynamic> map = responseJson[i];
          states.add(StateData.fromJson(map));
        }
      }
    }
    return states;
  } else {
    throw Exception('Failed to load post');
  }  
}

