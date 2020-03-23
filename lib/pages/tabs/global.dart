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
  List<String> countries = ['China','India'];
  String dropDownValue = 'India';

  getinfo(String con) {
    // getInfo(con).then((_info) {
    //   setState(() {
    //     info = _info;
    //     print(info.length);
    //     print(info[_info.length-1].confirmed);
    //   });
    // });
  }

  setcountrieslist() {
    countries = [];
    for(int i =0; i<widget.info.length; i++) {
      if(widget.info[i].province != "") {
        countries.add(widget.info[i].province + ' (' + widget.info[i].country + ')');
      } else {
        countries.add(widget.info[i].country);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // getlatest();
    setcountrieslist();
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
                Center(
                  child: DropdownButton<String>(
                    value: dropDownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
                      color: Colors.grey
                    ),
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropDownValue = newValue;
                      });
                      getinfo(newValue);
                    },
                    items: countries
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(child: Text(value)),
                      );
                    })
                    .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}