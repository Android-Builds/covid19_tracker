import 'package:covid19_tracker/models/indiastatewise.dart';
import 'package:covid19_tracker/models/info.dart';
import 'package:flutter/material.dart';

class IndiaWidget extends StatelessWidget {
  const IndiaWidget({
    Key key,
    @required this.india,
  }) : super(key: key);

  final Info india;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.black45
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      'India',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    width: 100,
                    child: Divider(
                      thickness: 2.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            india.cases != null
                                ? Text('Confirmed: ' + '${india.cases}')
                                : Text('0'),
                            SizedBox(height: 10.0),
                            india.deaths != null
                                ? Text('Deaths: ' + '$india.deaths}')
                                : Text('0'),
                            SizedBox(height: 10.0),
                            india.recovered != null
                                ? Text('Recovered: ' + '${india.recovered}')
                                : Text('0')
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            india.active != null
                                ? Text('Active: ' + '${india.active}')
                                : Text('0'),
                            SizedBox(height: 10.0),
                            india.critical != null
                                ? Text('Critical: ' + '${india.critical}')
                                : Text('0'),
                            SizedBox(height: 10.0),
                            india.todayCases != null
                                ? Text('Cases Today: ' + '${india.todayCases}')
                                : Text('0'),
                            SizedBox(height: 10.0),
                            india.todayDeaths != null
                                ? Text(
                                    'Deaths Today: ' + '${india.todayDeaths}')
                                : Text('0'),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'State Wise',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ),
          SizedBox(
            width: 90.0,
            child: Divider(
              thickness: 2,
            ),
          ),
          Flexible(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: indiastates.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          indiastates[index].state,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(width: 20.0),
                        Text(
                          indiastates[index].cases.toString(),
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
