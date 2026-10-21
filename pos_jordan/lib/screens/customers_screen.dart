import 'package:flutter/material.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCustomerTile('John Meangi', '+256 700 123 456', 'UGX 45,000'),
          _buildCustomerTile('Sarah Nakato', '+256 772 987 654', 'UGX 120,000'),
          _buildCustomerTile('New Customer', '+256 000 000 000', 'UGX 0'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF57C00),
        onPressed: () {},
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }

  Widget _buildCustomerTile(String name, String phone, String spent) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFFFE0B2), // Light Orange
          child: Text(
            name[0], 
            style: const TextStyle(color: Color(0xFFF57C00), fontWeight: FontWeight.bold)
          ),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(phone),
        trailing: Text(
          'Spent: $spent',
          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
    );
  }
}