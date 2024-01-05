import 'package:bloc_app/Application/login_bloc/login_event.dart';
import 'package:bloc_app/Application/login_bloc/login_state.dart';
import 'package:bloc_app/Domain/main_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginChecking>((event, emit) async {
      emit(LoginCheckingState());
      final resp = await checkloginstatus(event.user, event.pass);
      print(resp.statusCode);
      if (resp.statusCode == 200) {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState());
      }
    });
    on<LoginSuccess>((event, emit) => emit(LoginSuccessState()));
  }
  // Future<void> checklogincr(String user, String pass) async {
  //   Future.delayed(const Duration(seconds: 5), () async {
  //     final resp = await checkloginstatus(user, pass);
  //     if (resp.statusCode >= 200 && resp.statusCode <= 300) {
  //       add(LoginSuccess());
  //     } else {}
  //   });
  // }
}
