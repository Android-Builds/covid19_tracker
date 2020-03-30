import 'package:covid19_tracker/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MediaQuery.of(context).platformBrightness 
          == Brightness.dark ? Theme.of(context).backgroundColor : Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'About',
            style: TextStyle(
              color: getColor(context)
            ),
          ),
          iconTheme: IconThemeData(
            color: getColor(context)
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/corona.png'
                ),
                SizedBox(height: 30.0),
                Text(
                  'Covid-19 Tracker',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: getColor(context),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                    'By: Debjit chakraborty',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'sudo.dev',
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
                SizedBox(
                  height: 40.0,
                  width: 100.0,
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1.2,
                  ),
                 ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      splashColor: Colors.transparent,
                      onPressed: () async {
                        await FlutterEmailSender.send(email);
                      },
                      child: CircleAvatar(
                        child: Icon(Icons.mail),
                      )
                    ),
                    FlatButton(
                      splashColor: Colors.transparent,
                      onPressed: () async {
                        _launchURL('https://t.me/xyron');
                      },
                      child: CircleAvatar(
                        child: Icon(FontAwesome5Brands.telegram_plane),
                      )
                    ),
                    FlatButton(
                      splashColor: Colors.transparent,
                      onPressed: () async {
                        _launchURL('https://github.com/xayron');
                      },
                      child: CircleAvatar(
                        child: Icon(FontAwesome.github),
                      )
                    ),                 
                  ],
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 250.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.grey[800] : Colors.grey[300]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Credits and thanks to',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                            width: 200.0,
                            child: Divider(
                              color: getColor(context),
                            ),
                          ),
                          Text(
                            '* App icon: icons8.com',
                            style: getaboutstyle(context),
                          ),
                          Text(
                            '* API(s) : \n1. github.com/novelcovid/api' 
                              '\n2. github.com/covid19india/api',
                            style: getaboutstyle(context),
                          ),
                          Text(
                            '* The authors of the plugins used',
                            style: getaboutstyle(context),
                          ),
                          Text(
                            '* All google, stackoverflow, medium \narticles and youtube videos I referred to',
                            style: getaboutstyle(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final Email email = Email(
    body: 'Email body',
    subject: 'Email subject',
    recipients: ['zxyron0@gmail.com'],
    //isHTML: false,
  );
  
}

getaboutstyle(context){
  return TextStyle(
    color: getColor(context)
  );
}