import 'package:covid19_tracker/models/indiastatewise.dart';
import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/widgets/globalcount.dart';
import 'package:covid19_tracker/widgets/indiawidget.dart';
import 'package:flutter/material.dart';

class GlobalPage extends StatefulWidget {
  GlobalPage({Key key, @required this.latest, 
  @required this.indiastates, this.india}) : super(key: key);
  final Latest latest;
  final List<IndiaState> indiastates;
  final Info india;
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {

  @override
  void initState(){
    super.initState();
    if(widget.india.active != null) {
      india = widget.india;
    } else {
      india.active = india.cases = india.critical = 
      india.deaths = india.recovered = india.todayCases = 
      india.todayDeaths = 0.toString();
    }
  }

  Info india = new Info();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          GlobalCount(latest: widget.latest),
          SizedBox(height: 10.0),
          IndiaWidget(india: india),
        ],
      ),
    );
  }
}