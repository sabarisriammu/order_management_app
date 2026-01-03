import 'package:flutter/material.dart';
import '../widgets/dashboard_card.dart';
import 'payment_screen.dart';

class StaffDashboard extends StatelessWidget {
  const StaffDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staff Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(child: DashboardCard(title: 'Delivered Orders', value: '90')),
                SizedBox(width: 12),
                Expanded(child: DashboardCard(title: 'Pending Payments', value: '15')),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentScreen()),
                );
              },
              child: const Text('Open Payment Entry'),
            ),
          ],
        ),
      ),
    );
  }
}
