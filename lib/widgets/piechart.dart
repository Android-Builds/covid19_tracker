import 'package:covid19_tracker/models/info.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieChart extends StatelessWidget {

  PieChart({this.latest});

  final Latest latest;

  _getSeriesData() {
    var active = double.parse((latest.active/latest.cases).toStringAsFixed(2))*100;  // double.parse((latest.active/latest.cases).toStringAsFixed(3))*100;
    var deaths = double.parse((latest.deaths/latest.cases).toStringAsFixed(2))*100;
    var recovered = double.parse((latest.recovered/latest.cases).toStringAsFixed(2))*100;

    var data = [
      GlobalData('Active', active),
      GlobalData('Deaths', deaths),
      GlobalData('Recovered', recovered),
    ];
    List<charts.Series<GlobalData, String>> series = [
      charts.Series(
        id: "Global Data",
        data: data,
        labelAccessorFn: (GlobalData row, _) => '${row.parameters}: \n${row.percentage} %',
        domainFn: (GlobalData grades, _) => grades.parameters,
        measureFn: (GlobalData grades, _) => grades.percentage
      )
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 300,
          padding: EdgeInsets.all(10),
          child: Card(
            color: Colors.transparent,
            elevation: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Global Data",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: new charts.PieChart(
                      _getSeriesData(),
                      animate: true,
                      defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 20,
                        arcRendererDecorators: [new charts.ArcLabelDecorator()]
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
    );
  }
}


class GlobalData {
  final String parameters;
  final double percentage;

  GlobalData(this.parameters, this.percentage);
}