import 'package:covid19_tracker/blocs/bloc/splash_bloc.dart';
import 'package:covid19_tracker/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    BlocProvider.of<SplashBloc>(context).add(SplashScreenEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, state) {
        if ((state is SplashScreenInitial) || (state is SplashScreenLoading))
          return splashWidget();
        else if (state is SplashScreenLoaded)
          return HomePage(
            info: state.info,
            latest: state.latest,
            globalStats: state.globalStats,
          );
        else
          return errorWidget();
      },
    );
  }

  Widget splashWidget() => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/corona.png'),
              SizedBox(
                height: 50.0,
              ),
              Text(
                'Covid-19 Tracker',
                style: TextStyle(fontSize: 15.0),
              ),
            ],
          ),
        ),
      );

  Widget errorWidget() => Scaffold(
        body: Center(
          child: Text('Error Fetching Data'),
        ),
      );
}
