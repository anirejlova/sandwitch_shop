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

class OrderItem {
  final String type;
  final String note;
  OrderItem({required this.type, required this.note});
}

class _OrderScreenState extends State<OrderScreen> {
  final List<OrderItem> _items = [];
  String _selectedSize = 'Footlong';
  final TextEditingController _noteController = TextEditingController();

  int get _quantity => _items.length;

  void _increaseQuantity() {
    if (_quantity < widget.maxQuantity) {
      setState(() {
        _items.add(OrderItem(type: _selectedSize, note: _noteController.text));
        _noteController.clear();
      });
    }
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
      setState(() {
        _items.removeLast();
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
            // Size selector row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Size:'),
                  const SizedBox(width: 12),
                  DropdownButton<String>(
                    value: _selectedSize,
                    items: const [
                      DropdownMenuItem(
                          value: 'Footlong', child: Text('Footlong')),
                      DropdownMenuItem(
                          value: 'Six-inch', child: Text('Six-inch')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedSize = val);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Combined summary + per-item list
            OrderItemList(
              items: _items,
            ),

            const SizedBox(height: 12),

            // Note input used when adding a new sandwich
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
  final List<OrderItem> items;

  const OrderItemList({
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final quantity = items.length;
    final emojis = List.filled(quantity, '🥪').join();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$quantity sandwich(es): $emojis', textAlign: TextAlign.center),
        const SizedBox(height: 8),
        if (items.isEmpty)
          const Text('(no notes)', textAlign: TextAlign.center)
        else
          ...List.generate(items.length, (i) {
            final item = items[i];
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
                      '${item.type}: ${item.note.isNotEmpty ? item.note : '(no note)'}',
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
