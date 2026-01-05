import 'package:flutter/material.dart';
import '../widgets/app_background.dart'; // Your custom background widget
import 'manager_dashboard2.dart' as role_login; // Use role-selection LoginScreen

// --- Order Model ---
class OrderItem {
  String customer;
  String product;
  int qty;
  String status; // New / In Production / Delivered
  DateTime date;

  OrderItem({
    required this.customer,
    required this.product,
    required this.qty,
    required this.status,
    required this.date,
  });
}

// --- Manager Dashboard ---
class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({super.key});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<OrderItem> _orders = [
    OrderItem(
      customer: 'Asha',
      product: 'Widgets',
      qty: 10,
      status: 'New',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    OrderItem(
      customer: 'Ravi',
      product: 'Gadgets',
      qty: 2,
      status: 'In Production',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    OrderItem(
      customer: 'Meera',
      product: 'Accessories',
      qty: 5,
      status: 'Delivered',
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  List<OrderItem> _filtered(String status) {
    return _orders.where((o) => o.status == status).toList();
  }

  void _openDetail(OrderItem item) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderDetailPage(
          order: item,
          onUpdate: () => setState(() {}),
        ),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the role-selection login screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const role_login.LoginScreen()),
            );
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'New'),
            Tab(text: 'In Production'),
            Tab(text: 'Delivered'),
          ],
        ),
      ),
      body: AppBackground(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildList(_filtered('New')),
                  _buildList(_filtered('In Production')),
                  _buildList(_filtered('Delivered')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<OrderItem> items) {
    if (items.isEmpty) {
      return const Center(child: Text('No orders'));
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, idx) {
        final o = items[idx];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: ListTile(
            title: Text(o.customer),
            subtitle: Text('${o.product} • Qty: ${o.qty}'),
            trailing: Text(o.status),
            onTap: () => _openDetail(o),
          ),
        );
      },
    );
  }
}

// --- Order Detail Page ---
class OrderDetailPage extends StatelessWidget {
  final OrderItem order;
  final VoidCallback onUpdate;

  const OrderDetailPage({super.key, required this.order, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
        leading: IconButton(
  icon: const Icon(Icons.arrow_back),
  onPressed: () {
    // Go back to the original LoginScreen in the navigation stack
    Navigator.of(context).pop();
  },
),

      ),
      body: AppBackground(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer: ${order.customer}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Product: ${order.product}'),
            const SizedBox(height: 8),
            Text('Qty: ${order.qty}'),
            const SizedBox(height: 8),
            Text('Delivery Date: ${order.date.toLocal().toString().split(' ').first}'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: order.status == 'In Production'
                        ? null
                        : () {
                            order.status = 'In Production';
                            onUpdate();
                            Navigator.pop(context);
                          },
                    child: const Text('Mark In Production'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: order.status == 'Delivered'
                        ? null
                        : () {
                            order.status = 'Delivered';
                            onUpdate();
                            Navigator.pop(context);
                          },
                    child: const Text('Mark Delivered'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// --- Simple Login Page ---
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Login as Manager'),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ManagerDashboard()),
            );
          },
        ),
      ),
    );
  }
}
