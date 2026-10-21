// lib/services/database_service.dart

class DatabaseService {
  // A singleton pattern so we can access this from anywhere
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  // 1. Variables to track live data
  double todaySales = 0.0;
  List<Map<String, dynamic>> transactions = [];
  
  // 2. The Dummy Data for the Reports Chart
  List<double> weeklySales = [150000, 220000, 180000, 250000, 310000, 290000, 420000];

  // 3. The Inventory List
  List<Map<String, dynamic>> inventory = [
    {'name': 'Coca Cola 500ml', 'price': 2500.0, 'stock': 40},
    {'name': 'Chips (Large)', 'price': 3000.0, 'stock': 15},
    {'name': 'Bread', 'price': 5000.0, 'stock': 30},
    {'name': 'Water 500ml', 'price': 1500.0, 'stock': 100},
  ];

  // 4. Functions to update the data
  void addTransaction(String customerName, double amount, String paymentMethod) {
    todaySales += amount;
    transactions.insert(0, {
      'customer': customerName,
      'amount': amount,
      'method': paymentMethod,
      'time': DateTime.now().toString().substring(11, 16), // Just gets HH:MM
    });
  }

  void updateStock(String productName, int quantitySold) {
    for (var item in inventory) {
      if (item['name'] == productName) {
        item['stock'] -= quantitySold;
        break;
      }
    }
  }
}