import 'package:flutter/material.dart';
import 'confirm2_page.dart'; // ← مهم جداً

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A4A4A),

      // زر الرجوع
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE8DDBF), size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Center(
        child: Container(
          width: 380,
          height: 780,
          padding: const EdgeInsets.only(top: 150),
          decoration: BoxDecoration(
            color: const Color(0xFFE8DDBF),
            borderRadius: BorderRadius.circular(4),
          ),

          child: Container(
            width: 330,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "كلمة المرور الجديدة",
                  style: TextStyle(
                    color: Color(0xFF0E3C4D),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                _passwordField("كلمة المرور الجديدة"),
                const SizedBox(height: 10),
                _passwordField("التأكد من كلمة المرور الجديدة"),

                const SizedBox(height: 25),

                // ========== زر التأكيد → Confirm2Page ==========
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const Confirm2Page(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5D063),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "إعادة كلمة المرور",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF0E3C4D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward_ios, size: 20, color: Color(0xFF0E3C4D)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ويدجت لحقل إدخال كلمة المرور
  Widget _passwordField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF0E3C4D),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),

        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintTextDirection: TextDirection.rtl,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
              Icon(Icons.lock_outline, size: 22, color: Colors.grey.shade800),
            ],
          ),
        ),
      ],
    );
  }
}
