import 'package:flutter/material.dart';

class OwnerOrders extends StatelessWidget {
  const OwnerOrders({super.key});

  final List<Map<String, dynamic>> orders = const [
    {
      'customer': 'Ravi',
      'product': 'Widget A',
      'qty': 3,
      'status': 'New',
      'date': '2026-01-01'
    },
    {
      'customer': 'Meera',
      'product': 'Gadget B',
      'qty': 1,
      'status': 'Delivered',
      'date': '2025-12-30'
    },
    {
      'customer': 'Asha',
      'product': 'Accessory C',
      'qty': 2,
      'status': 'Paid',
      'date': '2026-01-02'
    },
  ];

  Color _statusColor(String s) {
    switch (s) {
      case 'Paid':
        return Colors.green;
      case 'Delivered':
        return Colors.green;
      case 'New':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders (Read Only)')),
      body: ListView.separated(
        itemCount: orders.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final o = orders[index];
          return ListTile(
            title: Text(o['customer']),
            subtitle: Text('${o['product']} • Qty: ${o['qty']}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor(o['status']).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(o['status'], style: TextStyle(color: _statusColor(o['status']))),
                ),
                const SizedBox(height: 4),
                Text(o['date']),
              ],
            ),
          );
        },
      ),
    );
  }
}
