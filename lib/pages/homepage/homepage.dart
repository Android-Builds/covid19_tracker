import 'dart:convert';
import 'package:covid19_tracker/models/indiastatewise.dart';
import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/models/stats.dart';
import 'package:covid19_tracker/pages/homepage/widgets/bottomsheet.dart';
import 'package:covid19_tracker/pages/tabs/gloabl_map.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  HomePage({this.latest, this.info, this.globalStats});
  final Latest latest;
  final List<Info> info;
  final Stats globalStats;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    print(widget.globalStats);
  }

  int i = 0;
  List<IndiaState> indianstates = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  saveValues(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('latest', json.encode(value));
  }

  Future<bool> _onWillPop() async {
    i++;
    if (i < 2) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Press again to exit')));
    } else {
      return true;
    }
    return false;
  }

  bool open = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              SlidingUpPanel(
                onPanelClosed: () => setState(() => open = false),
                onPanelOpened: () => setState(() => open = true),
                color: Theme.of(context).scaffoldBackgroundColor,
                body: GlobalMap(infoList: widget.info),
                panelBuilder: (sc) => OpenPanel(
                  latest: widget.latest,
                  globalStats: widget.globalStats,
                  scrollController: sc,
                ),
                collapsed: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 5.0),
                      Container(
                        width: 50.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CaseText(
                              count:
                                  '${(widget.latest.cases / 1000000).toStringAsFixed(2)}',
                              label: 'CONFIRMED',
                              todayCount:
                                  '${(widget.latest.todayCases / 1000000).toStringAsFixed(2)}',
                              size: size,
                              color: Colors.red[200],
                            ),
                            CaseText(
                              count:
                                  '${(widget.latest.recovered / 1000000).toStringAsFixed(2)}',
                              label: 'RECOVERED',
                              todayCount:
                                  '${(widget.latest.todayRecovered / 1000000).toStringAsFixed(2)}',
                              size: size,
                              color: Colors.green[200],
                            ),
                            CaseText(
                              count:
                                  '${(widget.latest.deaths / 1000000).toStringAsFixed(2)}',
                              label: 'DEATHS',
                              todayCount:
                                  '${(widget.latest.todayDeaths / 1000000).toStringAsFixed(2)}',
                              size: size,
                              color: Colors.red[200],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                minHeight: size.height * 0.25,
                maxHeight: size.height,
              ),
              !open
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.35,
                        margin: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                iconSize: size.width * 0.06,
                                icon: Icon(Icons.home),
                                onPressed: () {}),
                            IconButton(
                              iconSize: size.width * 0.06,
                              icon: Icon(Icons.bar_chart_outlined),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class CaseText extends StatelessWidget {
  final String count, label, todayCount;
  final Size size;
  final Color color;

  const CaseText({
    Key key,
    this.count,
    this.label,
    this.todayCount,
    this.size,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count m',
          style: TextStyle(
            fontSize: size.width * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          label,
          style: TextStyle(
            fontSize: size.width * 0.03,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          '+$todayCount k',
          style: TextStyle(color: color),
        )
      ],
    );
  }
}
