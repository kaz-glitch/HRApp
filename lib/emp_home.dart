import 'package:flutter/material.dart';
import 'employee_profile_page.dart';

class EmployeeHomePage extends StatelessWidget {
  const EmployeeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xFF1D566E);
    const backColor = Color(0xFFE8DDB5);

    return Scaffold(
      backgroundColor: backColor,
      body: SafeArea(
        child: Column(
          children: [
            // ====== الهيدر ======
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              color: mainColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "اسم الشركة",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  // زر البروفايل
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EmployeeProfilePage()),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: mainColor, size: 28),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ====== الخيارات الرئيسية ======
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // صف أول
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _homeBox(Icons.access_time, "تسجيل الحضور و الانصراف", Color(0xFFC3DBD1)),
                        _homeBox(Icons.message, "مراسلة", Color(0xFFAED8CC)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // صف ثاني
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _homeBox(Icons.event, "طلب إجازة", Color(0xFFFFE08C)),
                        _homeBox(Icons.receipt_long, "كشف الراتب", Color(0xFF1D566E), iconColor: Colors.white, textColor: Colors.white),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // ====== الإشعارات ======
                    const Text(
                      "الاشعارات",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),

                    _notifBox(),
                    const SizedBox(height: 10),
                    _notifBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // مربعات الخيارات
  Widget _homeBox(IconData icon, String text, Color boxColor,
      {Color iconColor = Colors.black87, Color textColor = Colors.black87}) {
    return Container(
      width: 150,
      height: 140,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: iconColor),
          const SizedBox(height: 12),
          Text(text, textAlign: TextAlign.center, style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // صندوق الإشعار
  Widget _notifBox() {
    return Container(
      width: 330,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: const Align(
        alignment: Alignment.centerRight,
        child: Text("اشعار اشعار اشعار اشعار اشعار اشعار"),
      ),
    );
  }
}

