import 'package:flutter/material.dart';
import '../services/database_service.dart';

class PaymentScreen extends StatefulWidget {
  final double totalAmount;
  final Map<String, int> cartItems; // Maps Product Name to Quantity

  const PaymentScreen({super.key, required this.totalAmount, required this.cartItems});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = 'Cash';

  void processPayment() {
    final db = DatabaseService();
    
    // 1. Save transaction to database
    db.addTransaction('Walk-in Customer', widget.totalAmount, selectedMethod);
    
    // 2. Reduce stock in inventory
    widget.cartItems.forEach((productName, qty) {
      db.updateStock(productName, qty);
    });

    // 3. Show success message and go back to home
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: Text('Payment of UGX ${widget.totalAmount.toStringAsFixed(0)} Successful!', textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () {
              // Pop the dialog, then pop the payment screen, then pop the new sale screen
              Navigator.of(context).pop(); 
              Navigator.of(context).pop(); 
              Navigator.of(context).pop(); 
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('Total Amount', style: TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 10),
            Text('UGX ${widget.totalAmount.toStringAsFixed(0)}', 
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFFF57C00))),
            const SizedBox(height: 40),
            const Text('Select Payment Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            
            _buildPaymentOption('Cash', Icons.money),
            _buildPaymentOption('Credit/Debit Card', Icons.credit_card),
            _buildPaymentOption('Mobile Money', Icons.phone_android),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: processPayment,
                child: const Text('Pay Now', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: RadioListTile<String>(
        title: Text(title),
        secondary: Icon(icon, color: const Color(0xFFF57C00)),
        value: title,
        groupValue: selectedMethod,
        activeColor: const Color(0xFFF57C00),
        onChanged: (value) {
          setState(() {
            selectedMethod = value!;
          });
        },
      ),
    );
  }
}