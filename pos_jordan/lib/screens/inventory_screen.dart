import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInventoryCard('Coca Cola 500ml', 'Stock: 40', 'Reorder: 10'),
          _buildInventoryCard('Chips (Large)', 'Stock: 15', 'Reorder: 5', isLowStock: true),
          _buildInventoryCard('Bread', 'Stock: 30', 'Reorder: 10'),
          _buildInventoryCard('Water 500ml', 'Stock: 100', 'Reorder: 20'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF57C00),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildInventoryCard(String title, String stock, String reorder, {bool isLowStock = false}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isLowStock ? Colors.red.withOpacity(0.1) : const Color(0xFFFFE0B2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.inventory_2, 
            color: isLowStock ? Colors.red : const Color(0xFFF57C00)
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$stock | $reorder', 
          style: TextStyle(color: isLowStock ? Colors.red : Colors.grey, fontWeight: isLowStock ? FontWeight.bold : FontWeight.normal)
        ),
        trailing: const Icon(Icons.edit, size: 20, color: Colors.grey),
      ),
    );
  }
}