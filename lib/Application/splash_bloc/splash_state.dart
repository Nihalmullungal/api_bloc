abstract class SplashState {}

class InitialState extends SplashState {}

class LoadedState extends SplashState {
  final loginState;
  LoadedState({required this.loginState});
}

class LoadingState extends SplashState {}
