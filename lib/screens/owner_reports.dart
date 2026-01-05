import 'package:flutter/material.dart';
import '../widgets/app_background.dart';

class OwnerReports extends StatefulWidget {
  const OwnerReports({super.key});

  @override
  State<OwnerReports> createState() => _OwnerReportsState();
}

class _OwnerReportsState extends State<OwnerReports> {
  DateTime? _from;
  DateTime? _to;
  String _customer = '';

  final List<Map<String, dynamic>> _all = const [
    {'customer': 'Ravi', 'date': '2026-01-01', 'amount': 500},
    {'customer': 'Meera', 'date': '2025-12-30', 'amount': 200},
    {'customer': 'Asha', 'date': '2026-01-02', 'amount': 800},
  ];

  List<Map<String, dynamic>> get _filtered {
    return _all.where((r) {
      if (_customer.isNotEmpty && !r['customer'].toLowerCase().contains(_customer.toLowerCase())) {
        return false;
      }
      if (_from != null) {
        final d = DateTime.parse(r['date']);
        if (d.isBefore(_from!)) return false;
      }
      if (_to != null) {
        final d = DateTime.parse(r['date']);
        if (d.isAfter(_to!)) return false;
      }
      return true;
    }).toList();
  }

  Future<void> _pickFrom() async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (d != null) setState(() => _from = d);
  }

  Future<void> _pickTo() async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (d != null) setState(() => _to = d);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: AppBackground(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Customer'),
                    onChanged: (v) => setState(() => _customer = v),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(onPressed: _pickFrom, child: Text(_from == null ? 'From' : _from!.toString().split(' ').first)),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _pickTo, child: Text(_to == null ? 'To' : _to!.toString().split(' ').first)),
              ],
            ),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.builder(
                itemCount: _filtered.length,
                itemBuilder: (context, i) {
                  final r = _filtered[i];
                  return ListTile(
                    title: Text(r['customer']),
                    subtitle: Text(r['date']),
                    trailing: Text('${r['amount']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
