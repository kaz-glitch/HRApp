import 'package:flutter/material.dart';
import 'attendance.dart';
import 'messages_page.dart';
import 'leave_request.dart';
import 'salary_screen.dart';
import 'employee_profile_page.dart';

class EmployeeHomePage extends StatelessWidget {
  const EmployeeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Color(0xFF1D566E);
    const Color backColor = Color(0xFFE8DDB5);

    return Scaffold(
      backgroundColor: backColor,
      body: SafeArea(
        child: Column(
          children: [
            // =================== الهيدر ===================
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              color: mainColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "اسم الشركة",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: mainColor, size: 28),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =================== البوكسات ===================
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // صف 1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _homeBox(
                          text: "أفضل خمسة موظفين",
                          icon: Icons.emoji_events,
                          color: const Color(0xFFC3DBD1),
                        ),
                        _homeBox(
                          text: "طلب إجازة",
                          icon: Icons.event_available,
                          color: const Color(0xFFFFE08C),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LeaveRequestPage()),
                            );
                          },
                        ),
                        _homeBox(
                          text: "تسجيل الحضور والانصراف",
                          icon: Icons.access_time,
                          color: const Color(0xFFE8E1CC),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AttendancePage()),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // صف 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _homeBox(
                          text: "مراسلة",
                          icon: Icons.message,
                          color: const Color(0xFFAED8CC),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const MessagesPage()),
                            );
                          },
                        ),
                        _homeBox(
                          text: "كشف الراتب",
                          icon: Icons.receipt_long,
                          color: mainColor,
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SalaryScreen()),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // =================== الإشعارات ===================
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          "الإشعارات",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    _notifBox("طلب إجازة من الموظف تركي"),
                    const SizedBox(height: 10),

                    _notifBox("تنبيه: تأخر 4 موظفين اليوم"),
                    const SizedBox(height: 10),

                    _notifBox("يوجد 2 طلبات معلقة تحتاج موافقة"),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =================== تصميم البوكس ===================
  Widget _homeBox({
    required String text,
    required IconData icon,
    required Color color,
    Color iconColor = Colors.black87,
    Color textColor = Colors.black87,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 115,
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: iconColor),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =================== الإشعار مع حركة التنبيه ===================
  Widget _notifBox(String text) {
    return Container(
      width: 330,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          // أيقونة الجرس داخل دائرة مثل الصورة
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFF009E73),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications,
              size: 16,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

