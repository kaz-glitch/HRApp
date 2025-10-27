import 'package:flutter/material.dart';
import 'attendance_screen.dart'; // صفحة الحضور السابقة

class MonthlyAttendanceScreen extends StatelessWidget {
  const MonthlyAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // الألوان الأساسية المستخدمة
    const Color backgroundColor = Color(0xFFE8DAB2);
    const Color headerColor = Color(0xFF1F4E5F);
    const Color workDayColor = Color(0xFFA9C97A);
    const Color holidayColor = Color(0xFFF2CE63);
    const Color absentDayColor = Color(0xFFB4D6C1);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: headerColor,
        elevation: 0,
        leadingWidth: 40, // لضبط موقع السهم أقصى اليسار
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AttendanceScreen()),
              );
            },
          ),
        ),
        title: const Text(
          'سجل الحضور الشهري',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // البطاقة الرئيسية
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'سجل الحضور',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: headerColor,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // القائمة المنسدلة لاختيار الشهر
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'أغسطس-2025',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // عناوين الأيام
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text('السبت'),
                      Text('الجمعة'),
                      Text('الخميس'),
                      Text('الأربعاء'),
                      Text('الثلاثاء'),
                      Text('الاثنين'),
                      Text('الأحد'),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // شبكة الأيام (30 يوم)
                  GridView.count(
                    crossAxisCount: 7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(30, (index) {
                      int day = index + 1;

                      // تحديد اللون حسب اليوم
                      Color dayColor;
                      if ([3, 10, 17, 24].contains(day)) {
                        dayColor = holidayColor; // عطلة
                      } else if ([5, 12].contains(day)) {
                        dayColor = absentDayColor; // غياب
                      } else {
                        dayColor = workDayColor; // عمل
                      }

                      return Container(
                        decoration: BoxDecoration(
                          color: dayColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '$day',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // الإحصائيات في الأسفل
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummaryCard('أيام العمل', '20', workDayColor),
                _buildSummaryCard('أيام العطل', '8', holidayColor),
                _buildSummaryCard('أيام الغير معتمدة', '0', absentDayColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت صغيرة لبطاقات الإحصائيات
  Widget _buildSummaryCard(String title, String value, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}