import 'package:flutter/material.dart';
import '../widgets/app_background.dart';
import 'owner_orders.dart';
import 'owner_reports.dart';
import '../widgets/dashboard_card.dart';
import 'login_screen.dart'; // Import your login screen

class OwnerDashboard extends StatelessWidget {
  const OwnerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner Dashboard'),
        backgroundColor: Colors.purple[800],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to login page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
        ),
      ),
      body: AppBackground(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Cards Row
            Row(
              children: [
                Expanded(child: DashboardCard(title: 'Total Orders', value: '120')),
                const SizedBox(width: 12),
                Expanded(child: DashboardCard(title: 'Delivered Orders', value: '90')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: DashboardCard(title: 'Pending Payments', value: '30')),
                const SizedBox(width: 12),
                Expanded(child: DashboardCard(title: 'Today Orders', value: '15')),
              ],
            ),

            const SizedBox(height: 30),

            // Buttons Row
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OwnerOrders()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.purple[100],
                foregroundColor: Colors.purple[800],
              ),
              child: const Text('View Orders'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OwnerReports()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.purple[100],
                foregroundColor: Colors.purple[800],
              ),
              child: const Text('Reports'),
            ),
          ],
        ),
      ),
    );
  }
}
