import 'package:flutter/material.dart';
import '../services/database_service.dart';
import 'payment_screen.dart';

class NewSaleScreen extends StatefulWidget {
  const NewSaleScreen({super.key});

  @override
  State<NewSaleScreen> createState() => _NewSaleScreenState();
}

class _NewSaleScreenState extends State<NewSaleScreen> {
  // Using a Map to track { "Product Name": Quantity }
  Map<String, int> cart = {};
  double total = 0.0;

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      String name = product['name'];
      if (cart.containsKey(name)) {
        cart[name] = cart[name]! + 1;
      } else {
        cart[name] = 1;
      }
      total += product['price'];
    });
  }

  void removeFromCart(Map<String, dynamic> product) {
    setState(() {
      String name = product['name'];
      if (cart.containsKey(name)) {
        if (cart[name]! > 1) {
          cart[name] = cart[name]! - 1;
        } else {
          cart.remove(name);
        }
        total -= product['price'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get live inventory from our fake database
    final availableProducts = DatabaseService().inventory;

    return Scaffold(
      appBar: AppBar(title: const Text('New Sale')),
      body: Row(
        children: [
          // LEFT SIDE: Products
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: availableProducts.length,
              itemBuilder: (context, index) {
                final product = availableProducts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('UGX ${product['price'].toStringAsFixed(0)} | Stock: ${product['stock']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_circle, color: Color(0xFFF57C00)),
                      onPressed: () => addToCart(product),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // RIGHT SIDE: Cart
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: cart.isEmpty
                        ? const Center(child: Text('Cart is empty.'))
                        : ListView.builder(
                            itemCount: cart.length,
                            itemBuilder: (context, index) {
                              String productName = cart.keys.elementAt(index);
                              int qty = cart.values.elementAt(index);
                              // Find the price for this product
                              double price = availableProducts.firstWhere((p) => p['name'] == productName)['price'];

                              return ListTile(
                                title: Text(productName),
                                subtitle: Text('Qty: $qty | UGX ${(price * qty).toStringAsFixed(0)}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline),
                                      onPressed: () => removeFromCart({'name': productName, 'price': price}),
                                    ),
                                    Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      onPressed: () => addToCart({'name': productName, 'price': price}),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                  
                  // Checkout Bottom Bar
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: const Color(0xFFFFF8E1),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total:', style: TextStyle(fontSize: 18)),
                            Text('UGX ${total.toStringAsFixed(0)}', 
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFF57C00))
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: cart.isEmpty ? null : () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => PaymentScreen(totalAmount: total, cartItems: cart)
                              ));
                            },
                            child: const Text('Proceed to Payment'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}