import 'package:bloc_app/Application/login_bloc/login_bloc.dart';
import 'package:bloc_app/Application/login_bloc/login_event.dart';
import 'package:bloc_app/Application/login_bloc/login_state.dart';
import 'package:bloc_app/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _user = TextEditingController();
    TextEditingController _pass = TextEditingController();
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _user,
              decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _pass,
              decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  sharedlogin();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      "Success",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return const HomeScreen();
                  }));
                } else if (state is LoginErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      "invalid Username and Password",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              builder: (context, state) {
                if (state is LoginInitialState) {
                  return Material(
                    elevation: 10,
                    shape: const CircleBorder(eccentricity: 1),
                    color: Colors.transparent,
                    child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context).add(LoginChecking(
                              user: _user.text, pass: _pass.text));
                        },
                        child: const Text("Login")),
                  );
                } else if (state is LoginCheckingState) {
                  return const CircularProgressIndicator();
                } else if (state is LoginErrorState) {
                  return Material(
                    elevation: 10,
                    shape: const CircleBorder(eccentricity: 1),
                    color: Colors.transparent,
                    child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context).add(LoginChecking(
                              user: _user.text, pass: _pass.text));
                        },
                        child: const Text("Login")),
                  );
                } else {
                  return Material(
                    elevation: 10,
                    shape: const CircleBorder(eccentricity: 1),
                    color: Colors.transparent,
                    child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context).add(LoginChecking(
                              user: _user.text, pass: _pass.text));
                        },
                        child: const Text("Login")),
                  );
                }
              },
            )
          ],
        ),
      )),
    );
  }

  Future<void> sharedlogin() async {
    final SharedPreferences _shared = await SharedPreferences.getInstance();
    _shared.setBool("Login", true);
  }
}
