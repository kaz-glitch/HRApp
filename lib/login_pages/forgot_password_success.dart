import 'package:flutter/material.dart';
import 'login_page.dart';

class ForgotPasswordSuccess extends StatelessWidget {
  const ForgotPasswordSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5EEDC),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.check, color: Colors.white, size: 40),
                ),
                const SizedBox(height: 20),
                const Text(
                  'تمت إعادة كلمة المرور بنجاح',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'الانتقال إلى تسجيل الدخول',
                    style: TextStyle(color: Colors.white),
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
