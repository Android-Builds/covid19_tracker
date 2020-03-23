import 'package:covid19_tracker/models/info.dart';
import 'package:flutter/material.dart';

class GlobalPage extends StatefulWidget {
  GlobalPage({Key key, this.title, this.latest, this.countriess, this.info}) 
  : super(key: key);

  final String title;
  final Latest latest;
  final List<Info> info;
  final List<Country> countriess;

  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {

  List<Info> info = new List<Info>();

  getinfo(String con) {
    // getInfo(con).then((_info) {
    //   setState(() {
    //     info = _info;
    //     print(info.length);
    //     print(info[_info.length-1].confirmed);
    //   });
    // });
  }

  @override
  void initState() {
    super.initState();
    // getlatest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Text('Confirmed: ' + widget.latest.confirmed.toString()) ,
                SizedBox(height: 20.0),
                Text('Deaths: ' + widget.latest.deaths.toString()),
                SizedBox(height: 20.0),
                Text('Recovered: ' + widget.latest.recovered.toString()),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
    );
  }
}