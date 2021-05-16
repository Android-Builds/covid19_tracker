import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/models/stats.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashScreenInitial());

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is SplashScreenEvent) {
      yield SplashScreenLoading();
      Latest latest = await getLatest();
      List<Info> info = await getInfo();
      Stats globalStats = await getGlobalStats();
      yield SplashScreenLoaded(latest, info, globalStats);
    }
  }
}
