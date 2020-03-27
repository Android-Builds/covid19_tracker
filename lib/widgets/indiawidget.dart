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
        color: MediaQuery.of(context).platformBrightness == 
        Brightness.dark ? Colors.black45 : Colors.transparent,
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
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                  width: 200,
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
                          Text('Confirmed: ' + india.cases),
                          SizedBox(height:10.0),
                          Text('Deaths: ' + india.deaths),
                          SizedBox(height:10.0),
                          Text('Recovered: ' + india.recovered)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Active: ' + india.active),
                          SizedBox(height:10.0),
                          Text('Critical: ' + india.critical),
                          SizedBox(height:10.0),
                          Text('Cases Today: ' + india.todayCases),
                          SizedBox(height: 10.0),
                          Text('Deaths Today: ' + india.todayDeaths),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'State Wise',
                style: TextStyle(
                  fontSize: 18.0
                ),
              ),
            ),
          ),
          SizedBox(
            width: 100.0,
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
                        style: TextStyle(
                          fontSize: 18.0
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        indiastates[index].cases.toString(),
                        style: TextStyle(
                          fontSize: 18.0
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}