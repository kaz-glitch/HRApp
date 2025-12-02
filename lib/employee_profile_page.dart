import 'package:flutter/material.dart';
import 'forgot_password_page.dart';

class EmployeeProfilePage extends StatelessWidget {
  const EmployeeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xFF1D566E);
    const backColor = Color(0xFFE8DDB5);

    return Scaffold(
      backgroundColor: backColor,
      body: SafeArea(
        child: Column(
          children: [
            // الهيدر
            Container(
              color: mainColor,
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: mainColor),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "اسم الموظف",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // صندوق المعلومات
            _infoCard("معلومات أساسية", [
              "اسم الموظف:",
              "رقم الهاتف:",
              "البريد الإلكتروني:",
              "تاريخ الميلاد:",
              "الجنسية:",
            ]),

            const SizedBox(height: 15),

            _infoCard("معلومات الوظيفة", [
              "المسمى الوظيفي:",
              "تاريخ التعيين:",
              "القسم:",
              "الراتب الأساسي:",
            ]),

            const SizedBox(height: 25),

            // الأزرار
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionButton("تعديل بيانات", Colors.amber, Colors.black),
                _actionButton(
                  "تغيير كلمة المرور",
                  Colors.green.shade300,
                  Colors.black,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // صندوق البيانات
  Widget _infoCard(String title, List<String> fields) {
    return Container(
      width: 330,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          for (var f in fields)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(f, textAlign: TextAlign.right, style: const TextStyle(fontSize: 15)),
            ),
        ],
      ),
    );
  }

  // الأزرار
  Widget _actionButton(String text, Color color, Color textColor, {void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 42,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: Center(
          child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
