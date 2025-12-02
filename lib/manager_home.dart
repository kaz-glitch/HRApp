import 'package:flutter/material.dart';
import 'forgot_password_page.dart';
import 'messages_page.dart'; // صفحة المراسلة
import 'top_employees_screen.dart';
import 'salary_screen.dart';
import 'profile_page.dart'; // صفحة البروفايل (يمين بالصورة)

class ManagerHomePage extends StatelessWidget {
  const ManagerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9CBA3),

      body: SafeArea(
        child: Column(
          children: [
            // ======= الهيدر =======
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: const BoxDecoration(
                color: Color(0xFF0E3C4D),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.check_box_outlined,
                          color: Colors.white, size: 30),
                      SizedBox(width: 8),
                      Text(
                        "اسم الشركة",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // أيقونة البروفايل ← تودّي لصفحة بيانات المدير
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfilePage(),
                        ),
                      );
                    },
                    child: const Icon(Icons.person,
                        color: Colors.white, size: 32),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ====== الشبكة ======
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    childAspectRatio: 0.95,
                  ),
                  children: [

                    // 1- تسجيل الحضور
                    _homeButton(
                      context,
                      icon: Icons.access_time,
                      label: "تسجيل الحضور والانصراف",
                      color: const Color(0xFFA8C4A4),
                      onTap: () {},
                    ),

                    // 2- طلب إجازة
                    _homeButton(
                      context,
                      icon: Icons.calendar_month,
                      label: "طلب إجازة",
                      color: const Color(0xFFF5D063),
                      onTap: () {},
                    ),

                    // 3- أفضل خمسة موظفين
                    _homeButton(
                      context,
                      icon: Icons.emoji_events,
                      label: "أفضل خمسة موظفين",
                      color: const Color(0xFFC8D5A6),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TopEmployeesScreen(),
                          ),
                        );
                      },
                    ),

                    // 4- كشف الراتب
                    _homeButton(
                      context,
                      icon: Icons.receipt_long,
                      label: "كشف الراتب",
                      color: const Color(0xFF0E3C4D),
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SalaryScreen(),
                          ),
                        );
                      },
                    ),

                    // 5- إدارة الإجازات
                    _homeButton(
                      context,
                      icon: Icons.list_alt,
                      label: "إدارة الإجازات",
                      color: const Color(0xFF7F9A8C),
                      onTap: () {},
                    ),

                    // 6- مراسلة
                    _homeButton(
                      context,
                      icon: Icons.chat_bubble_outline,
                      label: "مراسلة",
                      color: const Color(0xFFA4D3C2),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MessagesPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ====== آخر الصفحة – الإشعارات ======
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "الإشعارات",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0E3C4D),
                    ),
                  ),

                  const SizedBox(height: 10),

                  _notificationBox(),
                  const SizedBox(height: 10),
                  _notificationBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========= ويدجت البوكس =========
  Widget _homeButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    Color textColor = const Color(0xFF0E3C4D),
    Color iconColor = const Color(0xFF0E3C4D),
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: iconColor),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        "إشعار إشعار إشعار إشعار إشعار...",
        style: TextStyle(color: Colors.black87),
      ),
    );
  }
}
