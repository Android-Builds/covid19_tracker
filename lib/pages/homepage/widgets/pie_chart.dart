import 'package:covid19_tracker/models/graph_classes.dart';
import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CasePieChart extends StatelessWidget {
  CasePieChart({this.info});

  final Latest info;

  _getData() {
    var active = double.parse(
        ((double.parse('${info.active}') / double.parse('${info.cases}')) *
                100.roundToDouble())
            .toStringAsFixed(2));
    var deaths = double.parse(
        ((double.parse('${info.deaths}') / double.parse('${info.cases}')) *
                100.roundToDouble())
            .toStringAsFixed(2));
    var recovered = double.parse(
        ((double.parse('${info.recovered}') / double.parse('${info.cases}')) *
                100.roundToDouble())
            .toStringAsFixed(2));

    var data = [
      GlobalData('Active', active),
      GlobalData('Deaths', deaths),
      GlobalData('Recovered', recovered),
    ];
    List<charts.Series<GlobalData, String>> series = [
      charts.Series(
        id: "Global Data",
        data: data,
        labelAccessorFn: (GlobalData row, _) =>
            '${row.parameters}: \n${row.percentage} %',
        domainFn: (GlobalData globalData, _) => globalData.parameters,
        measureFn: (GlobalData globalData, _) => globalData.percentage,
        colorFn: (GlobalData globalData, _) {
          switch (globalData.parameters) {
            case 'Active':
              return charts.MaterialPalette.blue.shadeDefault.lighter;
            case 'Deaths':
              return charts.MaterialPalette.red.shadeDefault.lighter;
            case 'Recovered':
              return charts.MaterialPalette.green.shadeDefault.lighter;
            default:
              return charts.MaterialPalette.blue.shadeDefault;
          }
        },
      )
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 30.0,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Case Distribution",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: charts.PieChart(
              _getData(),
              animate: false,
              defaultRenderer: charts.ArcRendererConfig(
                arcWidth: 20,
                arcRendererDecorators: [
                  charts.ArcLabelDecorator(
                    leaderLineStyleSpec: charts.ArcLabelLeaderLineStyleSpec(
                      color: getTheme(context) == 'Dark'
                          ? charts.Color.white
                          : charts.Color.black,
                      thickness: 1.0,
                      length: 20.0,
                    ),
                    leaderLineColor: getTheme(context) == 'Dark'
                        ? charts.Color.white
                        : charts.Color.black,
                    outsideLabelStyleSpec: charts.TextStyleSpec(
                      color: getTheme(context) == 'Dark'
                          ? charts.Color.white
                          : charts.Color.black,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Total Cases: ${info.cases}",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
