import 'package:covid19_tracker/models/graph_classes.dart';
import 'package:covid19_tracker/models/stats.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';

class LastSevenDays extends StatefulWidget {
  final List<CaseData> cases;
  final List<CaseData> deaths;
  final List<CaseData> recovered;

  const LastSevenDays({
    this.cases,
    this.deaths,
    this.recovered,
  });
  @override
  _LastSevenDaysState createState() => _LastSevenDaysState();
}

class _LastSevenDaysState extends State<LastSevenDays> {
  int start;
  int finish;
  int length;
  List<ReducedCasesData> cases = [];

  @override
  void initState() {
    int count = widget.cases.last.cases;
    length = count < 1000000000
        ? 1000000
        : count < 1000000
            ? 1000
            : count < 1000
                ? 100
                : 10;
    finish = widget.cases.length;
    start = widget.cases.length - 7;
    widget.cases.sublist(start, finish).forEach((element) {
      cases.add(ReducedCasesData(element.date, element.cases / length));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          majorGridLines: MajorGridLines(width: 0),
          minorGridLines: MinorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(
            text: 'x $length',
          ),
          majorGridLines: MajorGridLines(width: 0),
          minorGridLines: MinorGridLines(width: 0),
          //labelFormat: '{value} M',
        ),
        series: <ChartSeries>[
          ColumnSeries<ReducedCasesData, DateTime>(
            dataSource: cases,
            xValueMapper: (ReducedCasesData caseData, _) => caseData.date,
            yValueMapper: (ReducedCasesData caseData, _) => caseData.cases,
          )
        ],
      ),
    );
  }
}
