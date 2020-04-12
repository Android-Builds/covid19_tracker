import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/widgets/themes.dart';
import 'package:flutter/material.dart';

class GlobalCount extends StatelessWidget {
  const GlobalCount({
    Key key,
    @required this.latest,
  }) : super(key: key);

  final Latest latest;

  @override
  Widget build(BuildContext context) {
    print(latest.cases);
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: MediaQuery.of(context).platformBrightness == 
          Brightness.dark ? Colors.grey[900] : Colors.white,
      elevation: 10.0,
      child: Container(
        height: 380,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Cases',
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'NewsCycle',
                fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 100,
              child: Divider(
                thickness: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: <Widget>[
                  GloablData(text: 'Confirmed', total: latest.cases.toString(), today: latest.todayCases.toString(), 
                    permil: latest.casesPerOneMillion.toString()),
                  SizedBox(height: 40.0),
                  GloablData(text: 'Deaths', total: latest.deaths.toString(), today: latest.todayDeaths.toString(), 
                    permil: latest.deathsPerOneMillion.toString()),
                  SizedBox(height: 40.0),
                  GloablData(text: 'Tests', total: latest.tests.toString(), permil: latest.testsPerOneMillion.toString()),
                  SizedBox(height: 40.0),
                  GloablData(text: 'Current', active: latest.active.toString(), critical: latest.critical.toString(), 
                    recovered: latest.recovered.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GloablData extends StatelessWidget {
  const GloablData({
    Key key,
    this.today, this.total, this.permil, 
      this.text, this.active, this.critical, 
      this.recovered,
  }) : super(key: key);

  final String text, total, today, 
    permil, active, critical, recovered;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          text,
          style: globalTile,
        ),
        Spacer(),
        Column(
          children: <Widget>[
            Text(
              text != 'Current' ? 'Total' : 'Active',
              style: globalTile,
            ),
            SizedBox(height: 10.0),
            text != 'Current' ? Text(total) : Text(active),
          ],
        ),
        SizedBox(width: 20.0),
        text != 'Tests' ? Column(
          children: <Widget>[
            Text(
              text != 'Current' ? 'Today' : 'Critical',
              style: globalTile,
            ),
            SizedBox(height: 10.0),
            text != 'Current' ? Text(today) : Text(critical),
          ],
        )  : Container(),
        SizedBox(width: 20.0),
        Column(
          children: <Widget>[
            Text(
              text != 'Current' ? 'Per Mil.' : 'Recovered',
              style: globalTile,
            ),
            SizedBox(height: 10.0),
            text != 'Current' ? Text(permil) : Text(recovered),
          ],
        )
      ],
    );
  }
}