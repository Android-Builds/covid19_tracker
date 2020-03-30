import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:covid19_tracker/models/inddata.dart';
import 'package:covid19_tracker/models/indiastatewise.dart';
import 'package:covid19_tracker/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:covid19_tracker/pages/homepage.dart';
import 'package:covid19_tracker/models/info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
   @override
   _SplashScreenState createState() => _SplashScreenState();
 }
 
 class _SplashScreenState extends State<SplashScreen> {

  List<Info> info = new List<Info>();
  Latest latest = new Latest();
  Latest savedlatest = new Latest();
  List<IndiaState> indiaState = new List<IndiaState>();

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  loadSharedPrefs() async {
    try {
      var l = Latest.fromJson(await read('latest'));
      savedlatest = l;
    } catch (Excepetion) {
      // do something
    }
  }

  getcountry(){
    getInfo().then((_info) {
      setState(() {
        info = _info;
      });
    });
  }

  getlatest() {
    latest.cases = latest.deaths =  latest.recovered = 0;
    getLatest().then((_latest) {
      setState(() {
        latest = _latest;
      });
    });
  }

  getstates() {
    getIndia().then((value) {
      indiaState = value;
    });
  }

   @override
   void initState(){
    super.initState();
    getstates();
    getlatest();
    getcountry();
    loadSharedPrefs();
    getStateData().then((value) {
      print(value[0].state);
    });
    Timer(Duration(seconds: 5), () {
      Route route = MaterialPageRoute(
        builder: (context) => HomePage(title: 'Covid-19 Tracker', 
        latest: latest, info: info, savedlatest: savedlatest,));
      Navigator.pushReplacement(context, route);
    });
  }
   
   @override
   Widget build(BuildContext context) {
     return SafeArea(
       child: Scaffold(
         body: Stack(
           fit: StackFit.expand,
           children: <Widget>[
             Container(
               decoration: BoxDecoration(
                 color: Theme.of(context).backgroundColor,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/corona.png'
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Covid-19 Tracker',
                    style: TextStyle(
                      color:getColor(context),
                      fontSize: 20.0,
                      // fontFamily: 'ShadowsIntoLight',
                      // letterSpacing: 3.0
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  CircularProgressIndicator()
                ],
              ),
            ],
         ),
       ),
     );
   }
 }
