import 'package:flutter/material.dart';
import 'customers_screen.dart';
import 'inventory_screen.dart';
import 'new_sale_screen.dart';
import 'reports_screen.dart';
import 'placeholder_screen.dart';
import '../services/database_service.dart';

// 1. Changed to StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Get live data from our fake database
    final db = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good Morning,', style: TextStyle(fontSize: 14, color: Colors.grey)),
            Text('My Store', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live Total Sales Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF57C00), 
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF57C00).withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Today's Sales", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 10),
                  Text("UGX ${db.todaySales.toStringAsFixed(0)}", 
                    style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // Action Grid
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionCard(context, Icons.add_shopping_cart, 'New Sale', Colors.orange, onTap: () async {
                  // 2. We use 'await' here to wait for the New Sale screen to close
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => const NewSaleScreen()));
                  // 3. When it closes, we call setState to refresh the numbers!
                  setState(() {});
                }),
                _buildActionCard(context, Icons.inventory_2_outlined, 'Inventory', Colors.amber, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const InventoryScreen()));
                }),
                _buildActionCard(context, Icons.people_outline, 'Customers', Colors.deepOrangeAccent, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomersScreen()));
                }),
                _buildActionCard(context, Icons.bar_chart, 'Reports', Colors.orangeAccent, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportsScreen()));
                }),
              ],
            ),
            
            const SizedBox(height: 30),
            const Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            
            // Live Recent Transactions List
            db.transactions.isEmpty 
              ? const Center(child: Text('No transactions yet.', style: TextStyle(color: Colors.grey)))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: db.transactions.length,
                  itemBuilder: (context, index) {
                    final tx = db.transactions[index];
                    return Card(
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFFFE0B2),
                          child: Icon(Icons.receipt, color: Color(0xFFF57C00)),
                        ),
                        title: Text('UGX ${tx['amount'].toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${tx['method']} • ${tx['time']}'),
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFF57C00),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PlaceholderScreen(title: 'Sales History')));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PlaceholderScreen(title: 'Settings')));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.point_of_sale), label: 'Sales'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, IconData icon, String label, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ]
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}