import 'package:covid19_tracker/models/datasearch.dart';
import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/pages/countrydetails.dart';
import 'package:covid19_tracker/pages/indiadetails.dart';
import 'package:covid19_tracker/widgets/themes.dart';
import 'package:flutter/material.dart';

class AllCountries extends StatefulWidget {
  AllCountries({
    this.info,
    this.title,
  });
  final List<Info> info;
  final title;
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: getIconTheme(context),
        title: Text(
          'Countires',
          style: TextStyle(
            color: getColor(context),
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            color: getColor(context),
            onPressed: () {
              showSearch(
                  context: context, delegate: DataSearch(info: widget.info));
            },
            icon: Icon(Icons.search),
            splashColor: Colors.transparent,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: ListView.builder(
          controller: controller,
          itemCount: widget.info.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => widget.info[index].country != 'India'
                        ? CountryDetails(info: widget.info[index])
                        : IndiaDetails(info: widget.info[index])),
              ),
              child: Card(
                elevation: 10.0,
                child: Container(
                  height: 170.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.info[index].country, style: countryName),
                        SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 22.0,
                              backgroundImage:
                                  NetworkImage(widget.info[index].flag),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Confirmed',
                                      style: caseStyles,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text('${widget.info[index].cases}'),
                                  ],
                                ),
                                SizedBox(width: 25.0),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Deaths',
                                      style: caseStyles,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text('${widget.info[index].deaths}')
                                  ],
                                ),
                                SizedBox(width: 25.0),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Recovered',
                                      style: caseStyles,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text('${widget.info[index].recovered}')
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'More info >>',
                              style: TextStyle(
                                  fontSize: 10.0,
                                  color: getTheme(context) == 'Dark'
                                      ? Colors.blue[300]
                                      : Colors.blue[900]),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
