import 'dart:async';
import 'package:covid19_tracker/models/indiastatewise.dart';
import 'package:flutter/material.dart';
import 'package:covid19_tracker/pages/homepage.dart';
import 'package:covid19_tracker/models/info.dart';

class SplashScreen extends StatefulWidget {
   @override
   _SplashScreenState createState() => _SplashScreenState();
 }
 
 class _SplashScreenState extends State<SplashScreen> {

  List<Info> info = new List<Info>();
  Latest latest = new Latest();
  List<IndiaState> indiaState = new List<IndiaState>();

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
      print(indiaState.length);
    });
  }

   @override
   void initState(){
    super.initState();
    getstates();
    getlatest();
    getcountry();
    // setcountrieslist();
    Timer(Duration(seconds: 5), () {
      Route route = MaterialPageRoute(
        builder: (context) => HomePage(title: 'Covid-19 Tracker', 
        latest: latest, info: info));
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
                  Text(
                    'Covid-19 Tracker',
                    style: TextStyle(
                      color:getColor(context),
                      fontSize: 30.0,
                      fontFamily: 'ShadowsIntoLight',
                      letterSpacing: 3.0
                    ),
                  ),
                ],
              ),
            ],
         ),
       ),
     );
   }
 }

 getColor(BuildContext context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  if (brightness == Brightness.dark)
    return Colors.white;
  else
    return Colors.black;
}