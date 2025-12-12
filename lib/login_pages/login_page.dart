import 'package:flutter/material.dart';
import 'register_company.dart';
import 'forgot_password_page.dart';
import 'package:employee/emp_pages/emp_home.dart';
import 'package:employee/manager_pages/manager_home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF4A4A4A),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 380,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              color: const Color(0xFFE8DDBF),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),

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

                const SizedBox(height: 30),

                // البطاقة
                Container(
                  width: 320,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Center(
                        child: Icon(
                          Icons.person_outline,
                          size: 60,
                          color: Color(0xFF0E3C4D),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0E3C4D),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // الإيميل
                      const Text(
                        "الإيميل",
                        style: TextStyle(color: Colors.green, fontSize: 13),
                      ),
                      _inputField(
                        Icons.person_outline,
                        "example@example.com",
                        controller: emailController,
                      ),

                      const SizedBox(height: 10),

                      // كلمة المرور
                      const Text(
                        "كلمة المرور",
                        style: TextStyle(color: Colors.green, fontSize: 13),
                      ),
                      _inputField(
                        Icons.lock_outline,
                        "كلمة المرور",
                        isPassword: true,
                        controller: passController,
                      ),

                      const SizedBox(height: 5),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
                            );
                          },
                          child: Text(
                            "نسيت كلمة المرور؟",
                            style: TextStyle(
                              color: Colors.orange.shade700,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // زر تسجيل الدخول
                      _yellowButton("تسجيل الدخول", () {
                        String email = emailController.text.trim();
                        String pass = passController.text.trim();

                        // تسجيل دخول المدير
                        if (email == "manager@test.com" && pass == "123456") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const ManagerHomePage()),
                          );
                        }

                        // تسجيل دخول الموظف
                        else if (email == "emp@test.com" && pass == "123456") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const EmployeeHomePage()),
                          );
                        }

                        // خطأ
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("بيانات الدخول غير صحيحة"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }),

                      const SizedBox(height: 20),

                      // زر سجل كمستخدم جديد
                      _yellowButton("سجل كمستخدم جديد", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterCompanyPage(),
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
      ),
    );
  }

  // حقل الإدخال
  Widget _inputField(IconData icon, String hint,
      {bool isPassword = false, required TextEditingController controller}) {
    return Container(
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
              controller: controller,
              obscureText: isPassword,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(icon, size: 22, color: Colors.grey.shade800),
        ],
      ),
    );
  }

  // زر أصفر
  Widget _yellowButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xFFF5D063),
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
            const Icon(Icons.arrow_forward_ios, size: 20, color: Color(0xFF0E3C4D)),
          ],
        ),
      ),
    );
  }
}
