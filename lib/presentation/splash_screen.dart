import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc_app/Application/splash_bloc/splash_cubit.dart';
import 'package:bloc_app/Application/splash_bloc/splash_state.dart';
import 'package:bloc_app/presentation/home_screen.dart';
import 'package:bloc_app/presentation/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is LoadedState) {
            if (state.loginState == null || state.loginState == false) {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (ct) {
                return const LoginPage();
              }));
            } else {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const HomeScreen()));
            }
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: AnimatedTextKit(animatedTexts: [
                FadeAnimatedText(
                  "please wait",
                )
              ]),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
