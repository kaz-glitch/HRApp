import 'package:flutter/material.dart';
import 'salary.dart';
import 'leave_management.dart';
import 'attendance.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF123B5A),
        title: const Text('اسم الشركة', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: const Icon(Icons.check_circle, color: Colors.white),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.person, color: Colors.white),
          )
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
            buildMenuButton(
              context,
              title: 'سجل الحضور و الانصراف',
              color: const Color(0xFFF3CF60),
              icon: Icons.access_time,
              page: const AttendancePage(),
            ),
            const SizedBox(height: 15),
            buildMenuButton(
              context,
              title: 'إدارة الإجازات',
              color: const Color(0xFFB9C87D),
              icon: Icons.calendar_month,
              page: const LeaveManagementScreen(),
            ),
            const SizedBox(height: 15),
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

  Widget buildMenuButton(BuildContext context,
      {required String title,
      required Color color,
      required IconData icon,
      required Widget page}) {
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
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          Icon(icon, color: Colors.white, size: 26),
        ],
      ),
    );
  }
}
