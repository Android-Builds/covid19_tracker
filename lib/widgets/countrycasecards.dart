import 'package:covid19_tracker/widgets/themes.dart';
import 'package:flutter/material.dart';

class CountryCaseCards extends StatelessWidget {
  const CountryCaseCards({
    Key key,
    @required this.text, this.case1, 
    this.case2, this.case3}) : super(key: key);

  final String text, case1, case2, case3;

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
                text,
                style: detailCaseStyles,
              ),
              SizedBox(width: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total',
                    style: caseStyles,
                  ),
                  SizedBox(height: 20.0),
                  Text(case1)
                ],
              ),
              text != 'Tests' ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Today',
                    style: caseStyles,
                  ),
                  SizedBox(height: 20.0),
                  Text(case2)
                ],
              ) : Container(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Per Mil.',
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