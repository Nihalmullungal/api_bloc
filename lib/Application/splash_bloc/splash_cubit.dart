import 'dart:async';

import 'package:bloc_app/Application/splash_bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(InitialState()) {
    emit(LoadingState());
    Future.delayed(const Duration(seconds: 5), () async {
      final SharedPreferences _shared = await SharedPreferences.getInstance();
      final login = await _shared.getBool("Login");
      emit(LoadedState(loginState: login));
    });
  }
}
