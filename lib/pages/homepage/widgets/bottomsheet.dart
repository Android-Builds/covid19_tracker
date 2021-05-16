import 'package:covid19_tracker/models/graph_classes.dart';
import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/models/stats.dart';
import 'package:covid19_tracker/pages/homepage/widgets/last_seven_days.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'case_charts.dart';

class OpenPanel extends StatefulWidget {
  final Latest latest;
  final Stats globalStats;
  final ScrollController scrollController;

  const OpenPanel({
    this.latest,
    this.globalStats,
    this.scrollController,
  });
  @override
  _OpenPanelState createState() => _OpenPanelState();
}

class _OpenPanelState extends State<OpenPanel> {
  List<CaseData> cases = [];
  List<CaseData> deaths = [];
  List<CaseData> recovered = [];

  @override
  void initState() {
    storeData();
    super.initState();
  }

  void storeData() {
    widget.globalStats.cases.forEach((key, value) {
      cases.add(CaseData(DateTime.parse(formattedDate('$key')), value));
    });
    widget.globalStats.deaths.forEach((key, value) {
      deaths.add(CaseData(DateTime.parse(formattedDate('$key')), value));
    });
    widget.globalStats.recovered.forEach((key, value) {
      recovered.add(CaseData(DateTime.parse(formattedDate('$key')), value));
    });
    setState(() {});
  }

  String formattedDate(String date) {
    List<String> k = date.split('/').map((e) => e.padLeft(2, '0')).toList();
    return '20${k[2]}-${k[0]}-${k[1]}';
  }

  Size size;
  Widget dataRows(
    String text,
    String value,
    IconData icon,
    Color color,
  ) =>
      Padding(
        padding: const EdgeInsets.only(
          left: 5.0,
          right: 15.0,
        ),
        child: Row(
          children: [
            Container(
              height: size.width * 0.13,
              width: size.width * 0.13,
              child: Icon(
                icon,
                color: HSLColor.fromColor(color).withLightness(0.8).toColor(),
              ),
            ),
            SizedBox(width: 10.0),
            RichText(
              text: TextSpan(
                text: value + '\n',
                style: DefaultTextStyle.of(context).style.copyWith(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                children: <TextSpan>[
                  TextSpan(
                    text: text,
                    style: TextStyle(
                      fontSize: size.width * 0.025,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ListView(
      controller: widget.scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      children: [
        Text(
          'Global Data',
          style: TextStyle(
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20.0),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    dataRows(
                      'CONFIRMED',
                      '${(widget.latest.cases / 1000000).toStringAsFixed(2)} m',
                      Icons.person,
                      Colors.yellow,
                    ),
                    dataRows(
                      'ACTIVE',
                      '${(widget.latest.active / 1000000).toStringAsFixed(2)} m',
                      FontAwesome.check,
                      Colors.blue,
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    dataRows(
                      'DEATHS',
                      '${(widget.latest.deaths / 1000000).toStringAsFixed(2)} m',
                      FontAwesome.ambulance,
                      Colors.red,
                    ),
                    dataRows(
                      'RECOVERED',
                      '${(widget.latest.recovered / 1000000).toStringAsFixed(2)} m',
                      FontAwesome.hospital_o,
                      Colors.green,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.0),
        CaseCharts(
          stats: widget.globalStats,
          latest: widget.latest,
        ),
        SizedBox(height: 20.0),
        LastSevenDays(cases: cases),
        SizedBox(height: 20.0),
      ],
    );
  }
}
