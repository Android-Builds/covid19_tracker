part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashScreenInitial extends SplashState {}

class SplashScreenLoading extends SplashState {}

class SplashScreenLoaded extends SplashState {
  final Latest latest;
  final List<Info> info;
  final Stats globalStats;
  SplashScreenLoaded(
    this.latest,
    this.info,
    this.globalStats,
  );
}

class SplashScreenError extends SplashState {}
