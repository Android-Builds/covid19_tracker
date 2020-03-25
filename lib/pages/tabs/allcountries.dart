import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/pages/countrystats.dart';
import 'package:flutter/material.dart';

class AllCountries extends StatefulWidget {
  AllCountries({this.info});
  final List<Info> info;
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.info.length,
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => 
              CountryStats(country: widget.info[index].country))),
              child: Container(
                height: 140.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black45,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.info[index].country,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.network(
                            widget.info[index].flag,
                            height: 30,
                            width: 45,
                            fit: BoxFit.fill,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text('Confirmed: ' + widget.info[index].cases),
                              SizedBox(height:10.0),
                              Text('Deaths: ' + widget.info[index].deaths),
                              SizedBox(height:10.0),
                              Text('Recovered: ' + widget.info[index].recovered)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text('Active: ' + widget.info[index].active),
                              SizedBox(height:10.0),
                              Text('Critical: ' + widget.info[index].critical),
                              SizedBox(height:10.0),
                              Text('Today  Cases: ' + widget.info[index].todayCases),
                              SizedBox(height: 10.0),
                              Text('Today Deaths: ' + widget.info[index].todayDeaths),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        );
      },
    );
  }
}