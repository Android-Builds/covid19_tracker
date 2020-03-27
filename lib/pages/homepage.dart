import 'package:covid19_tracker/models/datasearch.dart';
import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/pages/splashscreen.dart';
import 'package:covid19_tracker/pages/tabs/allcountries.dart';
import 'package:covid19_tracker/pages/tabs/global.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.latest, this.info}) 
  : super(key: key);
  final String title;
  final Latest latest;
  final List<Info> info;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    latestcount = widget.latest;
    infolist = widget.info;
  }

  List<Info> infolist;
  Latest latestcount = new Latest();

  Future<Null> _refreshGlobal() {
    return getLatest().then((_latest) {
      setState(() {
        latestcount = widget.latest;
      });
    });
  }

  Future<Null> _refreshAll() {
    return getInfo().then((_info) {
      setState(() {
        infolist = _info;
      });
    });
  }


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
      home: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
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
                    showSearch(context: context, delegate: DataSearch(list: infolist));
                  },
                  icon: Icon(Icons.search),
                  splashColor: Colors.transparent,
                )
              ],
            ),
            body: TabBarView(
              children: <Widget>[
                RefreshIndicator(
                  key: new GlobalKey<RefreshIndicatorState>(),
                  onRefresh: () => _refreshGlobal(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: GlobalPage(latest: latestcount)
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
    );
  }
}