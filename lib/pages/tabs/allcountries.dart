import 'package:covid19_tracker/models/info.dart';
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
            child: Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black45,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.info[index].country,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                          ),
                        ),
                        Text(widget.info[index].province),
                      ],
                    ),
                  ),
                  Text(widget.info[index].confirmed),
                  SizedBox(height:10.0),
                  Text(widget.info[index].deaths),
                  SizedBox(height:10.0),
                  Text(widget.info[index].recovered)
                ],
              ),
            ),
          )
        );
      },
    );
  }
}