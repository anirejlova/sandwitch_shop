import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandwitch Shop App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Sandwitch Counter')),
        body: 
        /* Center(
          child: Container(
            alignment: Alignment.center,
            color: Colors.amber,
            width: 300,
            height: 200,
            child: OrderItemDisplay(5, "Footlong"),
          ),
        ), */
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.red,
              width: 100,
              height: 100,
              child: OrderItemDisplay(2, "Club"),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.green,
              width: 100,
              height: 100,
              child: OrderItemDisplay(3, "Veggie"),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.blue,
              width: 100,
              height: 100,
              child: OrderItemDisplay(1, "Turkey"),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final String itemType;
  final int quantity;

  const OrderItemDisplay(this.quantity, this.itemType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text("$quantity $itemType sandwitch(es): ${'🥪' * quantity}");
  }
}
