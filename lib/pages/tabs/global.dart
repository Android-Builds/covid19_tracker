import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/widgets/globalcount.dart';
import 'package:covid19_tracker/widgets/globalstats.dart';
import 'package:covid19_tracker/widgets/piechart.dart';
import 'package:covid19_tracker/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../about.dart';

class GlobalPage extends StatefulWidget {
  GlobalPage({
    Key key,
    @required this.latest,
  }) : super(key: key);
  final Latest latest;
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  @override
  void initState() {
    super.initState();
  }

  Info india = new Info();

  obs(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                onTap: () {
                  Navigator.pop(context);
                  final RenderBox box = context.findRenderObject();
                  Share.share(
                      'Track the cases of covid-19 cases with real time sata. Covid-19 Tracker \n\nhttps://drive.google.com/file/d/1P7uFJyPRP92cjnNLtHo7Q2l7d3AWqLEt/view?usp=drivesdk',
                      subject: 'Share the app',
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutPage()));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: getIconTheme(context),
        title: Text(
          'Global',
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
            onPressed: () => obs(context),
            icon: Icon(Icons.info),
            splashColor: Colors.transparent,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GlobalCount(latest: widget.latest),
              SizedBox(height: 10.0),
              PieChart(latest: widget.latest),
              GlobalStats(),
            ],
          ),
        ),
      ),
    );
  }
}
