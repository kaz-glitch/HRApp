import 'package:flutter/material.dart';
import 'attendance_screen.dart';
import 'leave_request.dart';
import 'messages_page.dart';
import 'top_employees_screen.dart';
import 'salary_screen.dart';
import 'profile_page.dart';
import 'leave_management.dart';

class ManagerHomePage extends StatelessWidget {
  const ManagerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E9D8),

      body: SafeArea(
        child: Column(
          children: [
            // ======= الهيدر =======
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: const BoxDecoration(color: Color(0xFF0E3C4D)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.check_box_outlined,
                          color: Colors.white, size: 26),
                      SizedBox(width: 6),
                      Text(
                        "اسم الشركة",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProfilePage()),
                      );
                    },
                    child: const Icon(Icons.person,
                        color: Colors.white, size: 30),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ====== شبكة مصغرة (3 أعمدة) ======
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.82,
                  ),
                  children: [
                    _miniButton(
                      context,
                      icon: Icons.access_time,
                      label: "تسجيل الحضور والانصراف",
                      color: const Color(0xFFA8C4A4),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AttendanceScreen(),
                          ),
                        );
                      },
                    ),

                    _miniButton(
                      context,
                      icon: Icons.calendar_month,
                      label: "طلب إجازة",
                      color: const Color(0xFFF5D063),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LeaveRequestPage(),
                          ),
                        );
                      },
                    ),

                    _miniButton(
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

                    _miniButton(
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

                    _miniButton(
                      context,
                      icon: Icons.list_alt,
                      label: "إدارة الإجازات",
                      color: const Color(0xFF7F9A8C),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const VacationManagementPage(),
                          ),
                        );
                      },
                    ),

                    _miniButton(
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

            const SizedBox(height: 8),

            // ====== الإشعارات ======
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "الإشعارات",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0E3C4D),
                      ),
                    ),

                    const SizedBox(height: 8),

                    _notifBubble("طلب إجازة من الموظف تركي"),
                    const SizedBox(height: 6),

                    _notifBubble("تنبيه: تأخر 4 موظفين اليوم"),
                    const SizedBox(height: 6),

                    _notifBubble("يوجد 2 طلبات معلّقة تحتاج موافقة"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========= زر صغير =========
  Widget _miniButton(
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
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: iconColor),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========= فقاعة إشعار =========
  Widget _notifBubble(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.notifications, size: 16, color: Colors.teal),
        ],
      ),
    );
  }
}
