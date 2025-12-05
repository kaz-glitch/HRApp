import 'package:flutter/material.dart';
import 'attendance_screen.dart';
import 'leave_request.dart';
import 'messages_page.dart';
import 'top_employees_screen.dart';
import 'salary_screen.dart';
import 'employee_profile_page.dart';

class EmployeeHomePage extends StatelessWidget {
  const EmployeeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9CBA5),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // ------------------ HEADER ------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: const BoxDecoration(
                color: Color(0xFF0E3C4D),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween
,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.check_circle_outline,
                          color: Colors.white, size: 35),
                      SizedBox(width: 10),
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
                        MaterialPageRoute(builder: (_) => const EmployeeProfilePage()),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person,
                          color: Color(0xFF0E3C4D), size: 28),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ------------------ GRID MENU (3 rows × 2 items) ------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,

                children: [
                  _menuBox(
                    title: "تسجيل الحضور",
                    icon: Icons.access_time,
                    color: const Color(0xFFC5E1C5),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AttendanceScreen()),
                    ),
                  ),

                  _menuBox(
                    title: "طلب إجازة",
                    icon: Icons.calendar_month,
                    color: const Color(0xFFF7E48B),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LeaveRequestPage()),
                    ),
                  ),

                  _menuBox(
                    title: "أفضل الموظفين",
                    icon: Icons.emoji_events,
                    color: const Color(0xFFD6E9A8),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TopEmployeesScreen()),
                    ),
                  ),

                  _menuBox(
                    title: "كشف الراتب",
                    icon: Icons.receipt_long,
                    color: const Color(0xFF1D3F5E),
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SalaryScreen()),
                    ),
                  ),

                 

                  _menuBox(
                    title: "مراسلة",
                    icon: Icons.message,
                    color: const Color(0xFFC3E6D2),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MessagesPage()),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ------------------ NOTIFICATIONS TITLE ------------------
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.notifications_active,
                      color: Color(0xFF0E3C4D), size: 26),
                  SizedBox(width: 10),
                  Text(
                    "الاشعارات",
                    style: TextStyle(
                      color: Color(0xFF0E3C4D),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ------------------ NOTIFICATIONS LIST ------------------
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) {
                return _notificationItem("اشعار رقم ${index + 1}");
              },
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------------------
  // MENU BOX
  Widget _menuBox({
    required String title,
    required IconData icon,
    required Color color,
    Color iconColor = Colors.black,
    Color textColor = Colors.black,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(12),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: iconColor),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------------------
  // NOTIFICATION ITEM
  Widget _notificationItem(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black87, fontSize: 14),
      ),
    );
  }
}
