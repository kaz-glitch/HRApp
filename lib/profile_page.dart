import 'package:flutter/material.dart';
import 'forgot_password_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A4A4A),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE8DDBF), size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Center(
        child: Container(
          width: 380,
          height: 780,
          decoration: BoxDecoration(
            color: const Color(0xFFE8DDBF),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              // صورة البروفايل
              const CircleAvatar(
                radius: 60,
                backgroundColor: Color(0xFF0E3C4D),
                child: Icon(Icons.person, size: 75, color: Colors.white),
              ),

              const SizedBox(height: 12),

              const Text(
                "اسم المدير",
                style: TextStyle(
                  color: Color(0xFF0E3C4D),
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // مربع معلومات أساسية
                      _infoBox(
                        title: "معلومات اساسية",
                        items: [
                          "اسم المدير:",
                          "رقم الهاتف:",
                          "البريد الإلكتروني:",
                          "تاريخ الميلاد:",
                          "الجنسية:",
                        ],
                      ),

                      const SizedBox(height: 20),

                      // مربع معلومات وظيفية
                      _infoBox(
                        title: "معلومات الوظيفة",
                        items: [
                          "المنصب:",
                          "تاريخ التعيين:",
                          "القسم:",
                          "الراتب الأساسي:",
                        ],
                      ),

                      const SizedBox(height: 40),

                      // الأزرار
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // زر تعديل بيانات
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 130,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5D063),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  "تعديل بيانات",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF0E3C4D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 15),

                          // زر تغيير كلمة المرور
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: Container(
                              width: 130,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFF7DB5A0),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  "تغيير كلمة المرور",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF0E3C4D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // مربع المعلومات
  Widget _infoBox({required String title, required List<String> items}) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF0E3C4D),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 10),

          for (var item in items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                item,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
        ],
      ),
    );
  }
}
