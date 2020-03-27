
import 'package:covid19_tracker/models/info.dart';
import 'package:flutter/material.dart';

class GlobalCount extends StatelessWidget {
  const GlobalCount({
    Key key,
    @required this.latest,
  }) : super(key: key);

  final Latest latest;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: MediaQuery.of(context).platformBrightness == 
        Brightness.dark ? Colors.black45 : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Global Data',
              style: TextStyle(
                fontSize: 18.0
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
          SizedBox(height: 10.0),
          Text(
            'Confirmed: ' + latest.cases.toString(),
            style: TextStyle(
              fontSize: 15.0
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Deaths: ' + latest.deaths.toString(),
            style: TextStyle(
              fontSize: 15.0
            )                  
          ),
          SizedBox(height: 20.0),
          Text(
            'Recovered: ' + latest.recovered.toString(),
            style: TextStyle(
              fontSize: 15.0
            ),
          ),
        ],
      ),
    );
  }
}