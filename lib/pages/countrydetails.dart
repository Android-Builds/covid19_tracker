import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/widgets/contpiechart.dart';
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
            style: TextStyle(
              color: getColor(context)
            ),
          ),
          iconTheme: getIconTheme(context),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CountryCaseCards(text1: 'Cases', text2: 'Total', text3: 'Today', text4: 'Per Mil.', 
                case1: widget.info.cases, case2: widget.info.todayCases, case3: widget.info.casesPerOneMillion,),
              CountryCaseCards(text1: 'Deaths', text2: 'Total', text3: 'Today', text4: 'Per Mil.', 
                case1: widget.info.deaths, case2: widget.info.todayDeaths, case3: widget.info.deathsPerOneMillion,),
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
                            Text(widget.info.active)
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
                            Text(widget.info.critical)
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
                            Text(widget.info.recovered)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              CountryPieChart(info: widget.info),
              SizedBox(height: 40.0),
              CountryStats(country: widget.info.country,),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryCaseCards extends StatelessWidget {
  const CountryCaseCards({
    Key key,
    @required this.text1, this.text2, this.text3, 
    this.case1, this.case2, this.text4, this.case3,
  }) : super(key: key);

  final String text1, text2, text3, text4, case1, case2, case3;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      elevation: 10.0,
      child: Container(
        height: 85.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                text1,
                style: detailCaseStyles,
              ),
              SizedBox(width: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    text2,
                    style: caseStyles,
                  ),
                  SizedBox(height: 20.0),
                  Text(case1)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    text3,
                    style: caseStyles,
                  ),
                  SizedBox(height: 20.0),
                  Text(case2)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    text4,
                    style: caseStyles,
                  ),
                  SizedBox(height: 20.0),
                  Text(case3)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}