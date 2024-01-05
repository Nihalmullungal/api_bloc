import 'package:bloc_app/Application/cart_bloc/cart_bloc.dart';
import 'package:bloc_app/Application/cart_bloc/cart_event.dart';
import 'package:bloc_app/Application/cart_bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartItemRemovedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("item Removed"),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          var data = context.read<CartBloc>().cartMap;
          return SafeArea(
            child: data.isNotEmpty
                ? Column(
                    children: data.keys.map((element) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(element.image)),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                element.name,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<CartBloc>(context)
                                      .add(CartSubEvent(product: element));
                                },
                                child: const Icon(Icons.remove)),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("${data[element]}"),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<CartBloc>(context)
                                      .add(CartButtonEvent(product: element));
                                },
                                child: const Icon(Icons.add)),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  }).toList())
                : const Center(
                    child: Text("Nothing in cart!!!"),
                  ),
          );
        },
      ),
    );
  }
}
