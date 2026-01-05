import 'package:flutter/material.dart';
import '../widgets/app_background.dart';
import '../widgets/dashboard_card.dart';
import 'payment_screen.dart';
import 'manager_dashboard2.dart' as role_login;

class StaffDashboard extends StatelessWidget {
  const StaffDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Dashboard'),
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
      ),
      body: AppBackground(
        width: MediaQuery.of(context).size.width * 0.95,
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
