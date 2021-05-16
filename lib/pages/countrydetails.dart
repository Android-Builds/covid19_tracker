import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/widgets/contpiechart.dart';
import 'package:covid19_tracker/widgets/countrycasecards.dart';
import 'package:covid19_tracker/widgets/countrystats.dart';
import 'package:covid19_tracker/widgets/themes.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatefulWidget {
  CountryDetails({this.info});
  final Info info;
  @override
  _CountryDetailsState createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.info.country,
            style: TextStyle(color: getColor(context)),
          ),
          iconTheme: getIconTheme(context),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CountryCaseCards(
                text: 'Cases',
                case1: '${widget.info.cases}',
                case2: '${widget.info.todayCases}',
                case3: widget.info.casesPerOneMillion,
              ),
              CountryCaseCards(
                text: 'Deaths',
                case1: '${widget.info.deaths}',
                case2: '${widget.info.todayDeaths}',
                case3: widget.info.deathsPerOneMillion,
              ),
              CountryCaseCards(
                text: 'Tests',
                case1: widget.info.tests,
                case3: widget.info.testsPerOneMillion,
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                elevation: 10.0,
                child: Container(
                  height: 85.0,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Active',
                              style: caseStyles,
                            ),
                            SizedBox(height: 20.0),
                            Text('${widget.info.active}')
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Critical',
                              style: caseStyles,
                            ),
                            SizedBox(height: 20.0),
                            Text('${widget.info.critical}')
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Recovered',
                              style: caseStyles,
                            ),
                            SizedBox(height: 20.0),
                            Text('${widget.info.recovered}')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              CountryPieChart(info: widget.info),
              SizedBox(height: 20.0),
              CountryStats(
                country: widget.info.country,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
