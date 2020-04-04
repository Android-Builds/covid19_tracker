import 'dart:convert';
import 'package:covid19_tracker/models/datasearch.dart';
import 'package:covid19_tracker/models/indiastatewise.dart';
import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/pages/tabs/allcountries.dart';
import 'package:covid19_tracker/pages/tabs/global.dart';
import 'package:covid19_tracker/widgets/drawer.dart';
import 'package:covid19_tracker/widgets/scrollbehavior.dart';
import 'package:covid19_tracker/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.latest, 
  this.info, this.indiastates, this.savedlatest})
  : super(key: key);
  final String title;
  final Latest latest;
  final Latest savedlatest;
  final List<Info> info;
  final List<IndiaState> indiastates;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  configureFirebase() async {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        if(!_isDoubleMessage) {
          print("onMessage: $message");
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: ListTile(
                title: Text(message['notification']['title']),
                subtitle: Text(message['notification']['body']),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
        _isDoubleMessage = !_isDoubleMessage;
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
    String token = await _firebaseMessaging.getToken();
    print("FirebaseMessaging token: $token");
  }

  @override
  void initState() {
    super.initState();
    configureFirebase();
    widget.latest != null ? latestcount = widget.latest 
    : latestcount = widget.savedlatest;
    infolist = widget.info;
    indianstates = widget.indiastates;
    for(int i=0; i<infolist.length; i++) {
      if(infolist[i].country == 'India') {
        india = infolist[i];
      }
    }
  }

  List<Info> infolist = new List<Info>();
  var india;
  int i = 0;
  Latest latestcount = new Latest();
  List<IndiaState> indianstates = new List<IndiaState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static bool _isDoubleMessage = false;

  Future<Null> _refreshGlobal() {
    return getLatest().then((_latest) {
      setState(() {
        latestcount = _latest;
      });
    });
  }

  Future<Null> _refreshAll() {
    return getInfo().then((_info) {
      setState(() {
        infolist = _info;
        for(int i=0; i<infolist.length; i++) {
          if(infolist[i].country == 'India') {
            india = infolist[i];
          }
        }
      });
    });
  }

  saveValues(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('latest', json.encode(value));
  }

  Future<bool> _onWillPop() async {
    i++;
    if(i<2) {
      saveValues(latestcount);
      _scaffoldKey.currentState.showSnackBar(
       new SnackBar(
          content: new Text('Press again to exit')
        )
      );
    } else {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData.dark().copyWith(
          backgroundColor: Colors.black
        ),
        home: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                iconTheme: getIconTheme(context),
                title: Text(
                  widget.title,
                  style: TextStyle(
                    color: getColor(context),
                  ),
                ),
                centerTitle: true,
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                bottom: TabBar(
                  indicatorWeight: 2,
                  labelColor: getColor(context),
                  isScrollable: true,
                  tabs: <Widget>[
                    Tab(
                      text: 'Global',
                    ),
                    Tab(
                      text: 'Countries',
                    )
                  ]
                ),
                actions: <Widget>[
                  IconButton(
                    color: getColor(context),
                    onPressed: () {
                      showSearch(context: context, 
                      delegate: DataSearch(list: infolist));
                    },
                    icon: Icon(Icons.search),
                    splashColor: Colors.transparent,
                  )
                ],
              ),
              drawer: AppDrawer(),
              body: TabBarView(
                children: <Widget>[
                  RefreshIndicator(
                    key: new GlobalKey<RefreshIndicatorState>(),
                    onRefresh: () => _refreshGlobal(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: GlobalPage(latest: latestcount, 
                      indiastates: indianstates, india: india)
                    ),
                  ),
                  RefreshIndicator(
                    key:new GlobalKey<RefreshIndicatorState>(),
                    onRefresh: () => _refreshAll(),
                    child: AllCountries(info: infolist),
                  ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}