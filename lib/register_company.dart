import 'package:flutter/material.dart';
import 'login_page.dart';       // ← مهم جداً للرجوع للصفحة الرئيسية
import 'otp_page.dart';        // صفحة OTP

class RegisterCompanyPage extends StatelessWidget {
  const RegisterCompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A4A4A),

      // ---------------- زر الرجوع الرئيسي ----------------
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFE8DDBF),
            size: 30,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
            );
          },
        ),
      ),
      // --------------------------------------------------

      body: Center(
        child: Container(
          width: 380,
          height: 780,
          padding: const EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
            color: const Color(0xFFE8DDBF),
            borderRadius: BorderRadius.circular(4),
          ),

          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
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
                        child: Text(
                          "المعلومات",
                          style: TextStyle(
                            color: Color(0xFF0E3C4D),
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      _label("اسم الشركة"),
                      _inputField(Icons.business, "اسم الشركة"),

                      const SizedBox(height: 10),

                      _label("السجل التجاري"),
                      _inputField(Icons.confirmation_number, "السجل التجاري"),

                      const SizedBox(height: 10),

                      _label("موقع الشركة"),
                      _inputField(Icons.location_on_outlined, "الخرج، حي فلان، شارع فلان"),

                      const SizedBox(height: 10),

                      _label("رقم الجوال"),
                      _inputField(Icons.phone, "05********"),

                      const SizedBox(height: 10),

                      _label("الإيميل"),
                      _inputField(Icons.email_outlined, "example@example.com"),

                      const SizedBox(height: 10),

                      _label("كلمة المرور"),
                      _inputField(Icons.lock_outline, "كلمة المرور", isPassword: true),

                      const SizedBox(height: 10),

                      _label("تأكيد كلمة المرور"),
                      _inputField(Icons.lock_outline, "تأكيد كلمة المرور", isPassword: true),

                      const SizedBox(height: 25),

                      _yellowButton(
                        "تسجيل شركة",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Directionality(
                                textDirection: TextDirection.rtl,
                                child: OtpPage(),
                              ),
                            ),
                          );
                        },
                      ),
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

  // -------------------- Widgets --------------------

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF0E3C4D),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _inputField(IconData icon, String hint, {bool isPassword = false}) {
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
              obscureText: isPassword,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                hintTextDirection: TextDirection.rtl,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          Icon(icon, size: 22, color: Colors.grey.shade800),
        ],
      ),
    );
  }

  Widget _yellowButton(String text, {required VoidCallback onTap}) {
    return InkWell(
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
