import 'package:flutter/material.dart';
import 'login_page.dart'; // <<< مهم جداً — استدعاء صفحة تسجيل الدخول

class LoginSelectionPage extends StatelessWidget {
  const LoginSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A4A4A), // الخلفية الرمادية الخارجية
      body: Center(
        child: Container(
          width: 380,
          height: 780,
          padding: const EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
            color: const Color(0xFFE8DDBF), // البيج
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),

              // الشعار
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFF0F3E4A),
                    width: 6,
                  ),
                ),
                child: const Icon(
                  Icons.bookmark_rounded,
                  size: 70,
                  color: Color(0xFF0F3E4A),
                ),
              ),

              const SizedBox(height: 40),

              // البطاقة البيضاء
              Container(
                width: 320,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFF0E3C4D),
                      offset: Offset(0, 6),
                      blurRadius: 3,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 60,
                      color: Color(0xFF0E3C4D),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0E3C4D),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // زر تسجيل دخول كشركة
                    _yellowButton("تسجيل الدخول كشركة", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                      );
                    }),

                    const SizedBox(height: 20),

                    // زر تسجيل دخول كموظف
                    _yellowButton("تسجيل دخول كموظف", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // زر التصميم الأصفر
  Widget _yellowButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        height: 55,
        decoration: BoxDecoration(
          color: Color(0xFFF5D063),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF0E3C4D),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Color(0xFF0E3C4D),
            ),
          ],
        ),
      ),
    );
  }
}
