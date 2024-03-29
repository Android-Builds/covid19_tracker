import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieChart extends StatelessWidget {

  PieChart({this.latest});

  final Latest latest;
  final red = charts.MaterialPalette.red.makeShades(3);

  _getSeriesData() {
    var active = double.parse(((latest.active/latest.cases) * 100.roundToDouble()).toStringAsFixed(2)); 
    //double.parse((latest.active/latest.cases).toStringAsFixed(2))*100;  
    // double.parse((latest.active/latest.cases).toStringAsFixed(3))*100;
    var deaths = double.parse(((latest.deaths/latest.cases) * 100.roundToDouble()).toStringAsFixed(2));
    // (latest.deaths/latest.cases) * 100.roundToDouble(); 
    //double.parse((latest.deaths/latest.cases).toStringAsFixed(2))*100;
    var recovered = double.parse(((latest.recovered/latest.cases) * 100.roundToDouble()).toStringAsFixed(2));
    // double.parse((latest.recovered/latest.cases).toStringAsFixed(2))*100;

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
        domainFn: (GlobalData globalData, _) => globalData.parameters,
        measureFn: (GlobalData globalData, _) => globalData.percentage,
        colorFn: (GlobalData globalData, _) {
          switch(globalData.parameters) {
            case 'Active' : return charts.MaterialPalette.blue.shadeDefault.lighter;
            case 'Deaths' : return charts.MaterialPalette.red.shadeDefault.lighter;
            case 'Recovered' : return charts.MaterialPalette.green.shadeDefault.lighter;
            default : return red[0];
          }
        },
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
                child: charts.PieChart(
                  _getSeriesData(),
                  animate: true,
                  defaultRenderer: charts.ArcRendererConfig(
                    arcWidth: 20,
                    arcRendererDecorators: [
                      charts.ArcLabelDecorator(
                        leaderLineStyleSpec: charts.ArcLabelLeaderLineStyleSpec(
                          color: getTheme(context) == 'Dark' ? 
                            charts.Color.white : charts.Color.black,
                          thickness: 1.0,
                          length: 20.0
                        ),
                        leaderLineColor: getTheme(context) == 'Dark' ? 
                            charts.Color.white : charts.Color.black,
                        outsideLabelStyleSpec: charts.TextStyleSpec(
                          color: getTheme(context) == 'Dark' ? 
                            charts.Color.white : charts.Color.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
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