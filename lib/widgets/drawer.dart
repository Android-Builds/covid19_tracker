import 'package:covid19_tracker/pages/about.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 220.0,
            child: DrawerHeader(
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/corona.png',
                      scale: 0.8,
                    ),
                  ),
                  Positioned(
                    left: 5.0,
                    child: Text('Covid-19 Tracker'),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () {
              Navigator.pop(context);
            },
          ),          
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutPage()));
            },
          ),
        ],
      ),
    );
  }
}