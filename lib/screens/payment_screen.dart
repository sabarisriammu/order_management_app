import 'package:flutter/material.dart';
import '../widgets/app_background.dart';

class PaymentScreen extends StatefulWidget {
  final String? orderId;
  final String? customerName;

  const PaymentScreen({super.key, this.orderId, this.customerName});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _orderIdCtrl;
  late TextEditingController _customerCtrl;
  final TextEditingController _totalCtrl = TextEditingController();
  final TextEditingController _paidCtrl = TextEditingController();
  DateTime? _paymentDate;
  String _mode = 'Cash';

  @override
  void initState() {
    super.initState();
    _orderIdCtrl = TextEditingController(text: widget.orderId ?? '1023');
    _customerCtrl = TextEditingController(text: widget.customerName ?? '');
    _paidCtrl.addListener(_recompute);
    _totalCtrl.text = '0';
  }

  @override
  void dispose() {
    _orderIdCtrl.dispose();
    _customerCtrl.dispose();
    _totalCtrl.dispose();
    _paidCtrl.dispose();
    super.dispose();
  }

  double get _balance {
    final total = double.tryParse(_totalCtrl.text) ?? 0.0;
    final paid = double.tryParse(_paidCtrl.text) ?? 0.0;
    return (total - paid).clamp(0.0, double.infinity);
  }

  void _recompute() => setState(() {});

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (d != null) setState(() => _paymentDate = d);
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    // TODO: persist payment
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment saved')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Entry'),
      ),
      body: AppBackground(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _orderIdCtrl,
                  decoration: const InputDecoration(labelText: 'Order ID'),
                  readOnly: true,
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: _customerCtrl,
                  decoration: const InputDecoration(labelText: 'Customer Name'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Enter customer' : null,
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: _totalCtrl,
                  decoration: const InputDecoration(labelText: 'Total Amount'),
                  keyboardType: TextInputType.number,
                  validator: (v) => (v == null || double.tryParse(v) == null) ? 'Enter total' : null,
                  onChanged: (_) => _recompute(),
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: _paidCtrl,
                  decoration: const InputDecoration(labelText: 'Paid Amount'),
                  keyboardType: TextInputType.number,
                  validator: (v) => (v == null || double.tryParse(v) == null) ? 'Enter paid' : null,
                ),
                const SizedBox(height: 12),
                Text('Balance: ${_balance.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _mode,
                        items: const [
                          DropdownMenuItem(value: 'Cash', child: Text('Cash')),
                          DropdownMenuItem(value: 'UPI', child: Text('UPI')),
                          DropdownMenuItem(value: 'Bank', child: Text('Bank')),
                        ],
                        onChanged: (v) => setState(() => _mode = v ?? 'Cash'),
                        decoration: const InputDecoration(labelText: 'Payment Mode'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(onPressed: _pickDate, child: Text(_paymentDate == null ? 'Payment Date' : _paymentDate!.toString().split(' ').first)),
                  ],
                ),
                const SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    onPressed: _save,
                    child: const Text('SAVE PAYMENT'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
