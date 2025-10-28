import 'package:flutter/material.dart';
import 'attendance_screen.dart'; // صفحة العودة

class MonthlyAttendanceScreen extends StatelessWidget {
  const MonthlyAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ألوان مخصصة
    const Color backgroundColor = Color(0xFFE8DAB2);
    const Color headerColor = Color(0xFF1F4E5F);
    const Color workDayColor = Color(0xFFA9C97A);
    const Color holidayColor = Color(0xFFF2CE63);
    const Color absentColor = Color(0xFFB4D6C1);

    // قائمة الأيام (محاكاة)
    final List<int> days = List.generate(30, (index) => index + 1);
    // تصنيف الأيام (تجريبي)
    final List<Color> dayColors = days.map((day) {
      if ([3, 10, 17, 24].contains(day)) return holidayColor; // عطلة
      if ([0].contains(day)) return absentColor; // غياب
      return workDayColor; // يوم عمل
    }).toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: headerColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            // رجوع إلى صفحة الحضور
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AttendanceScreen()),
            );
          },
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

      // محتوى الصفحة
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // بطاقة سجل الحضور
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'سجل الحضور',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // القائمة المنسدلة للشهر
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: 'أغسطس-2025',
                        items: const [
                          DropdownMenuItem(
                            value: 'أغسطس-2025',
                            child: Text('أغسطس-2025', style: TextStyle(fontFamily: 'Cairo')),
                          ),
                          DropdownMenuItem(
                            value: 'يوليو-2025',
                            child: Text('يوليو-2025', style: TextStyle(fontFamily: 'Cairo')),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // صف أسماء الأيام
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text('الثلاثاء', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                      Text('الأربعاء', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                      Text('الخميس', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                      Text('الجمعة', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                      Text('السبت', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // الشبكة (الأيام)
                  GridView.count(
                    crossAxisCount: 7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(days.length, (index) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: dayColors[index],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${days[index]}',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // الإحصائيات السفلية
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('أيام العمل', '20', workDayColor),
                _buildStatCard('أيام العطل', '8', holidayColor),
                _buildStatCard('أيام الغير معتمدة', '0', absentColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت لبطاقات الإحصاءات
  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}