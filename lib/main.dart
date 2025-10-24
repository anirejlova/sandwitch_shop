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
        // The bit that you need to update starts from here
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const OrderItemDisplay(5, 'Footlong'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => print('Add button pressed!'),
                    child: const Text('Add'),
                  ),
                  ElevatedButton(
                    onPressed: () => print('Remove button pressed!'),
                    child: const Text('Remove'),
                  ),
                ],
              ),
            ],
          ),
        ),
        // The bit that you need to update ends here
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
