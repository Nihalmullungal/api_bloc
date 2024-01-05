import 'package:bloc_app/Application/cart_bloc/cart_bloc.dart';
import 'package:bloc_app/Application/cart_bloc/cart_event.dart';
import 'package:bloc_app/Application/cart_bloc/cart_state.dart';
import 'package:bloc_app/Application/home_bloc/home_bloc.dart';
import 'package:bloc_app/Application/home_bloc/home_state.dart';
import 'package:bloc_app/presentation/cart_screen.dart';
import 'package:bloc_app/presentation/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Future<void> logout() async {
    final SharedPreferences _shared = await SharedPreferences.getInstance();
    _shared.setBool("Login", false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        return Stack(
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const CartScreen();
                }));
              },
              child: const Icon(Icons.shopping_cart),
            ),
            Positioned(
                right: 0,
                child: CircleAvatar(
                    radius: 10,
                    child: Text(
                        "${BlocProvider.of<CartBloc>(context).cartMap.length}")))
          ],
        );
      }),
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text("Are you sure?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              logout();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (ctx) {
                                return const LoginPage();
                              }), (route) => false);
                            },
                            child: const Text("Yes"),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("No"))
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return state is HomeLoadedState
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 236, 241, 240),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 04,
                          ),
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network(
                              state.allproducts[index].image,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                      width: 180,
                                      child: Center(
                                          child: Text(
                                        state.allproducts[index].name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                      width: 180,
                                      child: Center(
                                          child: Text(
                                        "Price : ${state.allproducts[index].price}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BlocBuilder<CartBloc, CartState>(
                                    builder: (context, state1) {
                                      return Material(
                                          elevation: 20,
                                          shape: const CircleBorder(
                                              eccentricity: 1),
                                          color: Colors.transparent,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              BlocProvider.of<CartBloc>(context)
                                                  .add(CartButtonEvent(
                                                      product: state
                                                          .allproducts[index]));
                                            },
                                            child: const Text("add to cart"),
                                          ));
                                    },
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: state.allproducts.length,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      )),
    );
  }
}
