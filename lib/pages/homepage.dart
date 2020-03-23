import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/pages/tabs/allcountries.dart';
import 'package:covid19_tracker/pages/tabs/global.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.latest, this.countriess, this.info}) 
  : super(key: key);
  final String title;
  final Latest latest;
  final List<Info> info;
  final List<Country> countriess;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark().copyWith(
        backgroundColor: Colors.black
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            bottom: TabBar(
              tabs: <Widget>[
                Text('1'),
                Text('2'),
              ]
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              GlobalPage(latest: widget.latest, info: widget.info),
              AllCountries(info: widget.info)
            ],
          )
        ),
      ),
    );
  }
}