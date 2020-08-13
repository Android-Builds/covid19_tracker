import 'dart:async';
import 'dart:convert';
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

  Future loadSharedPrefs() async {
    try {
      savedlatest = Latest.fromJson(await read('latest'));
    } catch (Excepetion) {
      print('Failed to load saved');
    }
  }

  Future getcountry() {
    return getInfo().then((_info) {
      setState(() {
        info = _info;
      });
    });
  }

  Future getlatest() {
    latest.cases = latest.deaths = latest.recovered = 0;
    return getLatest().then((_latest) {
      setState(() {
        latest = _latest;
      });
    });
  }

  Future getstates() {
    return getIndia().then((value) {
      indiaState = value;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.wait([
      loadSharedPrefs(),
      getstates(),
      getlatest(),
      getcountry(),
      getDailyData(),
    ]).then((value) {
      Route route = MaterialPageRoute(
          builder: (context) => HomePage(
              title: 'Covid-19 Tracker',
              latest: latest,
              info: info,
              savedlatest: savedlatest));
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
                color:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Colors.grey[900]
                        : Colors.white,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/corona.png'),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    'Covid-19 Tracker',
                    style: TextStyle(
                      color: getColor(context),
                      fontSize: 15.0,
                      // fontFamily: 'ShadowsIntoLight',
                      // letterSpacing: 3.0
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
