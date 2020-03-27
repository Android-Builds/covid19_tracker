import 'package:covid19_tracker/models/info.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class GlobalPage extends StatefulWidget {
  GlobalPage({Key key, this.title, this.latest}) : super(key: key);
  final String title;
  final Latest latest;
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 140,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Confirmed: ' + widget.latest.cases.toString(),
                      style: TextStyle(
                        fontSize: 18.0
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Text(
                      'Deaths: ' + widget.latest.deaths.toString(),
                      style: TextStyle(
                        fontSize: 18.0
                      )                  
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Text(
                  'Recovered: ' + widget.latest.recovered.toString(),
                  style: TextStyle(
                    fontSize: 18.0
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: SvgPicture.asset(
              'assets/india.svg'
            )
          )
        ],
      ),
    );
  }
}