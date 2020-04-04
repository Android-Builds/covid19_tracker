import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/pages/globalstats.dart';
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
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) => GlobalStats())),
      child: Container(
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
              width: 100,
              child: Divider(
                thickness: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      latest.cases != null ? Text(
                        'Confirmed: ' + latest.cases.toString(),
                      ):  Text('0'),
                      SizedBox(height: 20.0),
                      latest.deaths != null ? Text(
                        'Deaths: ' + latest.deaths.toString(),              
                      ):  Text('0'),
                      SizedBox(height: 20.0),
                      latest.recovered != null ? Text(
                        'Recovered: ' + latest.recovered.toString(),
                      ):  Text('0'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      latest.cases != null ? Text(
                        'Active: ' + latest.active.toString(),
                      ):  Text('0'),
                      SizedBox(height: 20.0),
                      latest.deaths != null ? Text(
                        'Affected - \nCountries: ' + latest.affectedCountries.toString(),                
                      ):  Text('0'),                
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}