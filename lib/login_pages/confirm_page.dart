import 'package:flutter/material.dart';
import 'login_page.dart'; // ← مهم جداً

class ConfirmPage extends StatelessWidget {
  const ConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF2B5659);

    return Scaffold(
      backgroundColor: const Color(0xFF3E3E3E),
      body: SafeArea(
        child: Center(
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 8,
            child: SizedBox(
              width: 360,
              height: 260,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                child: Column(
                  children: [
                    const SizedBox(height: 6),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F3EE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(Icons.verified, color: Color(0xFF7FBF99), size: 40),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'سيتم مراجعة المعلومات وارسال المخطط',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),

                    const SizedBox(height: 18),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                          (route) => false, // يحذف كل الصفحات القديمة
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: teal,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'العودة',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
