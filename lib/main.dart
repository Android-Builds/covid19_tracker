import 'package:covid19_tracker/blocs/bloc/splash_bloc.dart';
import 'package:covid19_tracker/pages/splash_screen.dart';
import 'package:covid19_tracker/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:covid19_tracker/pages/splashscreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/scrollbehavior.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      theme: lightTheme,
      darkTheme: darkTheme,
      home: BlocProvider(
        create: (context) => SplashBloc(),
        child: SplashScreenPage(),
      ),
    );
  }
}
