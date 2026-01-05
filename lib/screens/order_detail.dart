import 'package:flutter/material.dart';
import '../widgets/app_background.dart';

class OrderDetailPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      body: AppBackground(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Customer: ${order["customer"]}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Product: ${order["product"]}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Quantity: ${order["qty"]}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Delivery Date: ${order["deliveryDate"]}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // TODO: Mark as In Production logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Marked as In Production')),
                    );
                  },
                  child: const Text("Mark In Production"),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Mark as Delivered logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Marked as Delivered')),
                    );
                  },
                  child: const Text("Mark Delivered"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
