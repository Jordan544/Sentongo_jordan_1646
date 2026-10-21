import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Golden Icon
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFB300).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  )
                ]
              ),
              child: const Icon(Icons.storefront, size: 80, color: Color(0xFFF57C00)),
            ),
            const SizedBox(height: 30),
            const Text(
              'Golden POS',
              style: TextStyle(
                fontSize: 32, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121)
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Manage your business anytime, anywhere',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text('Get Started'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}