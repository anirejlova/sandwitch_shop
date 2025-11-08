import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwitch Shop App',
      home: OrderScreen(maxQuantity: 5),
    );
  }
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;
  final List<String> _notes = []; // per-sandwich notes
  final TextEditingController _noteController = TextEditingController();

  void _increaseQuantity() {
    if (_quantity < widget.maxQuantity) {
      setState(() {
        // attach current note text to the new sandwich and clear input
        _notes.add(_noteController.text);
        _noteController.clear();
        _quantity++;
      });
    }
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
      setState(() {
        // remove the last sandwich and its note
        if (_notes.isNotEmpty) _notes.removeLast();
        _quantity--;
      });
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandwich Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OrderItemList(
              itemType: 'Footlong',
              quantity: _quantity,
              notes: _notes,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Order note',
                  hintText: 'e.g., no onions, extra pickles',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: SizedBox(
                width:
                    double.infinity, // make the Row take full available width
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100.0,
                      child: StyledButton(
                        onPressed: _quantity < widget.maxQuantity
                            ? _increaseQuantity
                            : null,
                        label: 'Add',
                      ),
                    ),
                    SizedBox(
                      width: 100.0,
                      child: StyledButton(
                        onPressed: _quantity > 0 ? _decreaseQuantity : null,
                        label: 'Remove',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StyledButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  const StyledButton({
    required this.label,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: Text(label),
    );
  }
}

class OrderItemList extends StatelessWidget {
  final String itemType;
  final List<String> notes;
  final int quantity;

  const OrderItemList({
    required this.itemType,
    required this.quantity,
    required this.notes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Build a compact summary plus a per-item static notes list
    final emojis = List.filled(quantity, '🥪').join();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$quantity $itemType sandwitch(es): $emojis',
            textAlign: TextAlign.center),
        const SizedBox(height: 8),
        if (notes.isEmpty)
          const Text('(no notes)', textAlign: TextAlign.center)
        else
          ...List.generate(notes.length, (i) {
            final note = notes[i];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('🥪', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      note.isNotEmpty ? note : '(no note)',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          }),
      ],
    );
  }
}

// class OrderItemDisplay extends StatelessWidget {
//   final String itemType;
//   final int quantity;
//   final String note;

//   const OrderItemDisplay(
//     this.quantity,
//     this.itemType, {
//     this.note = '',
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final emoji = '🥪' * quantity;
//     final noteText = note.isNotEmpty ? note : '(no note)',;
//     return Text("$quantity $itemType sandwitch(es): $emoji$noteText",
//         textAlign: TextAlign.center);
//   }
// }
