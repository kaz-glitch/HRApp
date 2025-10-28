import 'package:flutter/material.dart';
import 'salary.dart';
import 'attendance.dart';
import 'managerprofile.dart';
import 'leave_management.dart'; // ✅ استدعاء صفحة إدارة الإجازات الجديدة

class MangerHome extends StatelessWidget {
  const MangerHome ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF123B5A),
        title: const Text('اسم الشركة', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: const Icon(Icons.check_circle, color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              tooltip: 'حساب المدير',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManagerProfilePage()),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF9EB9A3),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 30),

            // زر سجل الحضور والانصراف
            buildMenuButton(
              context,
              title: 'سجل الحضور و الانصراف',
              color: const Color(0xFFF3CF60),
              icon: Icons.access_time,
              page: const AttendancePage(),
            ),
            const SizedBox(height: 15),

            // زر إدارة الإجازات
            buildMenuButton(
              context,
              title: 'إدارة الإجازات',
              color: const Color(0xFFB9C87D),
              icon: Icons.calendar_month,
              // ✅ هنا التعديل
              page: const VacationManagementPage(),
            ),
            const SizedBox(height: 15),

            // زر كشف الرواتب
            buildMenuButton(
              context,
              title: 'كشف الرواتب',
              color: const Color(0xFF80B6A1),
              icon: Icons.receipt_long,
              page: const SalaryPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(
    BuildContext context, {
    required String title,
    required Color color,
    required IconData icon,
    required Widget page,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 70),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Icon(icon, color: Colors.white, size: 26),
        ],
      ),
    );
  }
}
