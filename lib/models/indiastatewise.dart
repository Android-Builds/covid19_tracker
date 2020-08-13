import 'dart:convert';
import 'package:http/http.dart' as http;

String api = 'https://api.covid19india.org/state_district_wise.json';
String dailyapi = 'https://api.covid19india.org/states_daily.json';

class IndiaState {
  String state;
  int cases;

  IndiaState({this.state, this.cases});

  factory IndiaState.fromJson(Map<String, dynamic> json, String state) {
    json = json['districtData'];
    int count = 0;
    var dist = json.keys.toList();
    for (int i = 0; i < json.length; i++) {
      if (json[dist[i]] != null) {
        count += json[dist[i]]['confirmed'];
      }
    }
    return IndiaState(
      state: state,
      cases: count,
    );
  }
}

List<IndiaState> indiastates = new List<IndiaState>();

Future<List<IndiaState>> getIndia() async {
  final response = await http.get(api);

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    var states = responseJson.keys.toList();
    if (responseJson.length > 0) {
      for (int i = 0; i < responseJson.length; i++) {
        if (responseJson[states[i]] != null) {
          Map<String, dynamic> map = responseJson[states[i]];
          indiastates.add(IndiaState.fromJson(map, states[i]));
        }
      }
    }
    return indiastates;
  } else {
    throw Exception('Failed to load post');
  }
}

class StateData {
  String state;
  var dailycount;

  StateData({this.state, this.dailycount});

  factory StateData.fromJson(
    Map<String, dynamic> json,
    String state,
  ) {
    return StateData(
      state: state,
      dailycount: json[state],
    );
  }
}

class DailyData {
  List<StateData> confirmed;
  List<StateData> recovered;
  List<StateData> deceased;
  var date;

  DailyData({
    this.confirmed,
    this.recovered,
    this.deceased,
    this.date,
  });

  factory DailyData.fromJson(
    Map<String, dynamic> json,
    Map<String, dynamic> json2,
    Map<String, dynamic> json3,
  ) {
    var state = json.keys.toList();
    state.remove('date');
    state.remove('status');
    List<StateData> conf = new List<StateData>();
    List<StateData> rec = new List<StateData>();
    List<StateData> dec = new List<StateData>();
    for (int i = 0; i < state.length; i++) {
      if (json != null && json2 != null && json3 != null) {
        conf.add(StateData.fromJson(json, state[i]));
        rec.add(StateData.fromJson(json2, state[i]));
        dec.add(StateData.fromJson(json3, state[i]));
      }
    }
    return DailyData(
      recovered: rec,
      confirmed: conf,
      deceased: dec,
      date: json['date'],
    );
  }
}

List<DailyData> dailyData = new List<DailyData>();

Future<List<DailyData>> getDailyData() async {
  final response = await http.get(dailyapi);

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    responseJson = responseJson['states_daily'];
    if (responseJson.length > 0) {
      for (int i = 0; i < responseJson.length; i += 3) {
        if (responseJson[i] != null) {
          Map<String, dynamic> map = responseJson[i];
          Map<String, dynamic> map2 = responseJson[i + 1];
          Map<String, dynamic> map3 = responseJson[i + 2];
          dailyData.add(DailyData.fromJson(map, map2, map3));
        }
      }
    }
    return dailyData;
  } else {
    throw Exception('Failed to fetch value');
  }
}
