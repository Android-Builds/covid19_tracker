 import 'dart:async';
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
  List<Country> countries = new List<Country>();

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

   @override
   void initState(){
    super.initState();
    getlatest();
    getcountry();
    // setcountrieslist();
    Timer(Duration(seconds: 5), () {
      Route route = MaterialPageRoute(
        builder: (context) => HomePage(title: 'Covid-19 Tracker', latest: latest, info: info));
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
                    'News',
                    style: TextStyle(
                      color:getColor(context),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ShadowsIntoLight',
                      letterSpacing: 3.0
                    ),
                  ),
                  SizedBox(height: 50.0),
                  // SvgPicture.asset(
                  //   'assets/news.svg',
                  //   height: 100.0,
                  //   width: 100.0,
                  // )
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