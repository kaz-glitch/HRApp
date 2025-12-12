import 'package:flutter/material.dart';
import 'confirm2_page.dart';
import 'login_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          },
        ),
      ),

      body: Center(
        child: Container(
          width: 380,
          padding: const EdgeInsets.symmetric(vertical: 120),
          decoration: BoxDecoration(
            color: const Color(0xFFE8DDBF),
            borderRadius: BorderRadius.circular(4),
          ),

          child: Center(
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
                    "إعادة كلمة المرور",
                    style: TextStyle(
                      color: Color(0xFF0E3C4D),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "رقم الجوال",
                        style: TextStyle(
                          color: Color(0xFF0E3C4D),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // حقل رقم الجوال
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "05********",
                                  hintTextDirection: TextDirection.rtl,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                            Icon(
                              Icons.phone_android_outlined,
                              size: 22,
                              color: Colors.grey.shade800,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // زر انتقال → Confirm2Page
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
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Color(0xFF0E3C4D),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
