// import 'dart:collection';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// String api = 'https://api.rootnet.in/covid19-in/stats/latest';

// class StateData {
//   String state;
//   int indian;
//   int foreign;
//   int discharged;
//   int deaths;

//   StateData({this.state, this.indian, this.foreign, 
//   this.discharged, this.deaths});

//   factory StateData.fromJson(Map<String, dynamic> json) {
//     return StateData(
//       state: json['loc'],
//       indian: json['confirmedCasesIndian'],
//       foreign: json['confirmedCasesForeign'],
//       discharged: json['discharged'],
//       deaths: json['deaths'],
//     );
//   }
// }

// HashMap<int, StateData> states = new HashMap();

// Future<HashMap<int, StateData>> getStateData() async {
//   final response = await http.get(api);

//   if (response.statusCode == 200) {
//     var responseJson = json.decode(response.body);
//     responseJson = responseJson['data']['regional'];
//     if(responseJson.length>0){
//       for(int i=0; i<responseJson.length; i++){
//         if(responseJson[i] != null){
//           Map<String,dynamic> map = responseJson[i];
//           states[i] = StateData.fromJson(map);
//         }
//       }
//     }
//     return states;
//   } else {
//     throw Exception('Failed to load post');
//   }  
// }

