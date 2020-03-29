import 'package:covid19_tracker/widgets/telegram_icons.dart';
import 'package:covid19_tracker/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/corona.png'
              ),
              SizedBox(height: 30.0),
              Text(
                'Covid-19 Tracker',
                style: TextStyle(
                  fontSize: 30.0,
                  color: getColor(context),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                  'sudo.dev',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
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
                    onPressed: () async {
                      await FlutterEmailSender.send(email);
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.mail),
                    )
                  ),
                  FlatButton(
                    onPressed: () async {
                      _launchURL('https://t.me/xyron');;
                    },
                    child: CircleAvatar(
                      child: Icon(Telegram.telegram),
                    )
                  ),                  
                ],
              ),
            ],
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