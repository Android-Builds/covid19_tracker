import 'dart:async';
import 'package:covid19_tracker/models/stats.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid19_tracker/widgets/themes.dart';
import 'package:flutter/material.dart';

class GlobalStats extends StatefulWidget {
  GlobalStats({this.country});
  final String country;
  @override
  _GlobalStatsState createState() => _GlobalStatsState();
}

class _GlobalStatsState extends State<GlobalStats> {

  @override
  void initState(){
    getGlobalStats().then((_stats) {
      /*var result = dates.map((e) => e.length == 7 ? DateTime.parse('${e.substring(0,1)}-${e.substring(2,3)}-${e.substring(5,6)}') : 
      DateTime.parse('${e.substring(0,1)}-${e.substring(2,3)}-${e.substring(5,6)}')).toList();*/
      setState(() {
      List<String> dates =  _stats.cases.keys.toList().cast<String>();
      List<int> cases = _stats.cases.values.toList().cast<int>();
      for(int i=0;i<dates.length; i++){
        casedata.add(
          new GlobalData(confirm: cases[i], 
          date: dates[i].length == 7 ? new DateTime(int.parse(dates[i].substring(5,7) + '20'), 
          int.parse(dates[i].substring(0,1)), 
          int.parse(dates[i].substring(2,4))) : 
          new DateTime(int.parse(dates[i].substring(4,6) + '20'), 
          int.parse(dates[i].substring(0,1)), 
          int.parse(dates[i].substring(2,3))))
        );
      }
      dates = _stats.deaths.keys.toList().cast<String>();
      cases = _stats.deaths.values.toList().cast<int>();
      for(int i=0;i<dates.length; i++){
        deathdata.add(
          new GlobalData(confirm: cases[i], 
          date: dates[i].length == 7 ? new DateTime(int.parse(dates[i].substring(5,7) + '20'), 
          int.parse(dates[i].substring(0,1)), 
          int.parse(dates[i].substring(2,4))) : 
          new DateTime(int.parse(dates[i].substring(4,6) + '20'), 
          int.parse(dates[i].substring(0,1)), 
          int.parse(dates[i].substring(2,3))))
        );
      }
      dates = _stats.recovered.keys.toList().cast<String>();
      cases = _stats.recovered.values.toList().cast<int>();
      for(int i=0;i<dates.length; i++){
        recovereddata.add(
          new GlobalData(confirm: cases[i], 
          date: dates[i].length == 7 ? new DateTime(int.parse(dates[i].substring(5,7) + '20'), 
          int.parse(dates[i].substring(0,1)), 
          int.parse(dates[i].substring(2,4))) : 
          new DateTime(int.parse(dates[i].substring(4,6) + '20'), 
          int.parse(dates[i].substring(0,1)), 
          int.parse(dates[i].substring(2,3))))
        );
      }
      });     
    });
    super.initState();
  }

  GlobalData data = new GlobalData();
  
  List<GlobalData> casedata = [];
  List<GlobalData> deathdata = [];
  List<GlobalData> recovereddata = [];

  _getSeriesData() {
    List<charts.Series<GlobalData, DateTime>> series = [
      charts.Series(
        id: "Confirmed Cases",
        data: casedata,
        domainFn: (GlobalData data, _) => data.date,
        measureFn: (GlobalData data, _) => data.confirm,
        colorFn: (GlobalData data, _) => charts.MaterialPalette.red.shadeDefault
      ),
      charts.Series(
        id: "Deaths",
        data: deathdata,
        domainFn: (GlobalData data, _) => data.date,
        measureFn: (GlobalData data, _) => data.confirm,
        colorFn: (GlobalData data, _) => charts.MaterialPalette.blue.shadeDefault
      ),
      charts.Series(
        id: "Recovered",
        data: recovereddata,
        domainFn: (GlobalData data, _) => data.date,
        measureFn: (GlobalData data, _) => data.confirm,
        colorFn: (GlobalData data, _) => charts.MaterialPalette.green.shadeDefault
      )
    ];
    return series;
  }

  Widget myWidget() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: charts.TimeSeriesChart(
                  _getSeriesData(),
                  animate: true,
                  dateTimeFactory: const charts.LocalDateTimeFactory(),
                  domainAxis: charts.DateTimeAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        color: MediaQuery.of(context).platformBrightness 
                        == Brightness.dark ? charts.MaterialPalette.white 
                        : charts.MaterialPalette.black,
                      ),
                    )
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    renderSpec: charts.GridlineRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                        color: MediaQuery.of(context).platformBrightness
                         == Brightness.dark ? charts.MaterialPalette.white 
                         : charts.MaterialPalette.black,
                      ),
                      lineStyle: charts.LineStyleSpec(
                        color: charts.MaterialPalette.transparent,
                      ),
                    )
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 5.0,
                      ),
                      SizedBox(width: 10.0),
                      Text('Confirmed')
                    ],
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 5.0,
                      ),
                      SizedBox(width: 10.0),
                      Text('Deaths')
                    ],
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 5.0,
                      ),
                      SizedBox(width: 10.0),
                      Text('Recovered')
                    ],
                  )                  
                ],
              ),
              SizedBox(height: 20.0)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Global Stats',
            style: TextStyle(
              color: getColor(context)
            ),
          ),
          iconTheme: getIconTheme(context),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: FutureBuilder(
          future: Future.delayed(Duration(seconds: 2)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) 
              return myWidget();
            else 
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).backgroundColor,
              ),
            );
          }
        )
      ),
    );
  }
}

class GlobalData {
  DateTime date;
  int confirm;

  GlobalData({this.date, this.confirm});
}