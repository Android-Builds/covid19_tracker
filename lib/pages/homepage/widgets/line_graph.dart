import 'package:covid19_tracker/models/graph_classes.dart';
import 'package:covid19_tracker/models/stats.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GloabalGraph extends StatefulWidget {
  final Stats stats;

  const GloabalGraph({this.stats});
  @override
  _GloabalGraphState createState() => _GloabalGraphState();
}

class _GloabalGraphState extends State<GloabalGraph> {
  List<CaseData> cases = [];
  List<CaseData> deaths = [];
  List<CaseData> recovered = [];

  @override
  void initState() {
    storeData();
    super.initState();
  }

  void storeData() {
    widget.stats.cases.forEach((key, value) {
      cases.add(CaseData(DateTime.parse(formattedDate('$key')), value));
    });
    widget.stats.deaths.forEach((key, value) {
      deaths.add(CaseData(DateTime.parse(formattedDate('$key')), value));
    });
    widget.stats.recovered.forEach((key, value) {
      recovered.add(CaseData(DateTime.parse(formattedDate('$key')), value));
    });
    setState(() {});
  }

  String formattedDate(String date) {
    List<String> k = date.split('/').map((e) => e.padLeft(2, '0')).toList();
    return '20${k[2]}-${k[0]}-${k[1]}';
  }

  _getSeriesData() {
    List<charts.Series<CaseData, DateTime>> series = [
      charts.Series(
          id: "Confirmed Cases",
          data: cases,
          domainFn: (CaseData data, _) => data.date,
          measureFn: (CaseData data, _) => data.cases,
          colorFn: (CaseData data, _) =>
              charts.MaterialPalette.blue.shadeDefault.lighter),
      charts.Series(
          id: "Deaths",
          data: deaths,
          domainFn: (CaseData data, _) => data.date,
          measureFn: (CaseData data, _) => data.cases,
          colorFn: (CaseData data, _) =>
              charts.MaterialPalette.red.shadeDefault.lighter),
      charts.Series(
          id: "Recovered",
          data: recovered,
          domainFn: (CaseData data, _) => data.date,
          measureFn: (CaseData data, _) => data.cases,
          colorFn: (CaseData data, _) =>
              charts.MaterialPalette.green.shadeDefault.lighter)
    ];
    return series;
  }

  Widget myWidget() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Timeline',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.05,
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: charts.TimeSeriesChart(
              _getSeriesData(),
              animate: false,
              dateTimeFactory: const charts.LocalDateTimeFactory(),
              domainAxis: charts.DateTimeAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? charts.MaterialPalette.white
                        : charts.MaterialPalette.black,
                  ),
                ),
              ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                renderSpec: charts.NoneRenderSpec(),
                // renderSpec: charts.SmallTickRendererSpec(
                //   labelStyle: charts.TextStyleSpec(
                //     color: MediaQuery.of(context).platformBrightness ==
                //             Brightness.dark
                //         ? charts.MaterialPalette.white
                //         : charts.MaterialPalette.black,
                //   ),
                //   lineStyle: charts.LineStyleSpec(
                //     color: charts.MaterialPalette.transparent,
                //   ),
                // ),
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              colorIndicator(Colors.blue.shade200, 'Confirmed'),
              SizedBox(width: 20.0),
              colorIndicator(Colors.red.shade200, 'Deaths'),
              SizedBox(width: 20.0),
              colorIndicator(Colors.green.shade200, 'Recovered'),
            ],
          ),
        ],
      ),
    );
  }

  Widget colorIndicator(Color color, String text) => Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: color,
            radius: 5.0,
          ),
          SizedBox(width: 10.0),
          Text(text)
        ],
      );

  @override
  Widget build(BuildContext context) {
    return myWidget();
  }
}
