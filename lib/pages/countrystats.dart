import 'dart:async';

import 'package:covid19_tracker/models/stats.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class CountryStats extends StatefulWidget {
  CountryStats({this.country});
  final String country;
  @override
  _CountryStatsState createState() => _CountryStatsState();
}

class _CountryStatsState extends State<CountryStats> {

  @override
  void initState(){
    getStats(widget.country).then((_stats) {
      /*var result = dates.map((e) => e.length == 7 ? DateTime.parse('${e.substring(0,1)}-${e.substring(2,3)}-${e.substring(5,6)}') : 
      DateTime.parse('${e.substring(0,1)}-${e.substring(2,3)}-${e.substring(5,6)}')).toList();*/
      setState(() {
      List<String> dates =  _stats.cases.keys.toList().cast<String>();
      List<int> cases = _stats.cases.values.toList().cast<int>();
      for(int i=0;i<dates.length; i++){
        casedata.add(
          new CountryData(confirm: cases[i], 
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
          new CountryData(confirm: cases[i], 
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
          new CountryData(confirm: cases[i], 
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

  CountryData data = new CountryData();
  
  List<CountryData> casedata = [];
  List<CountryData> deathdata = [];
  List<CountryData> recovereddata = [];

  _getSeriesData() {
    List<charts.Series<CountryData, DateTime>> series = [
      charts.Series(
        id: "Confirmed Cases",
        data: casedata,
        domainFn: (CountryData data, _) => data.date,
        measureFn: (CountryData data, _) => data.confirm,
        colorFn: (CountryData data, _) => charts.MaterialPalette.red.shadeDefault
      ),
      charts.Series(
        id: "Deaths",
        data: deathdata,
        domainFn: (CountryData data, _) => data.date,
        measureFn: (CountryData data, _) => data.confirm,
        colorFn: (CountryData data, _) => charts.MaterialPalette.blue.shadeDefault
      ),
      charts.Series(
        id: "Recovered",
        data: recovereddata,
        domainFn: (CountryData data, _) => data.date,
        measureFn: (CountryData data, _) => data.confirm,
        colorFn: (CountryData data, _) => charts.MaterialPalette.green.shadeDefault
      )
    ];
    return series;
  }

  Widget myWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line Chart Example'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 550,
          padding: EdgeInsets.all(10),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Statistical data since 22/01/2020",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: new charts.TimeSeriesChart(
                      _getSeriesData(), 
                      animate: true, 
                      dateTimeFactory: const charts.LocalDateTimeFactory()
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) 
          return myWidget();
        else 
        return Center(
          child: CircularProgressIndicator(),
        ); // Return empty container to avoid build errors
      }
    );
  }
}

class SalesData {
  final int year;
  final int sales;

  SalesData(this.year, this.sales);
}

class CountryData {
  DateTime date;
  int confirm;

  CountryData({this.date, this.confirm});
}