import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MonthlyAttendanceScreen extends StatefulWidget {
  const MonthlyAttendanceScreen({super.key});

  @override
  State<MonthlyAttendanceScreen> createState() => _MonthlyAttendanceScreenState();
}

class _MonthlyAttendanceScreenState extends State<MonthlyAttendanceScreen> {
  String selectedMonth = 'أغسطس 2025';

  // بيانات وهمية للحضور حسب اليوم
  final Map<int, String> attendanceStatus = {
    1: 'work',
    2: 'work',
    3: 'work',
    4: 'holiday',
    5: 'work',
    6: 'work',
    7: 'work',
    8: 'holiday',
    9: 'work',
    10: 'work',
    11: 'holiday',
    12: 'work',
    13: 'work',
    14: 'unapproved',
    15: 'work',
    16: 'work',
    17: 'work',
    18: 'holiday',
    19: 'work',
    20: 'work',
    21: 'work',
    22: 'holiday',
    23: 'work',
    24: 'work',
    25: 'work',
    26: 'holiday',
    27: 'work',
    28: 'work',
    29: 'work',
    30: 'holiday',
    31: 'work',
  };

  final List<String> weekdays = ['الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت'];

  Color getColor(String status) {
    switch (status) {
      case 'work':
        return Colors.green[600]!;
      case 'holiday':
        return Colors.yellow[700]!;
      case 'unapproved':
        return Colors.grey[500]!;
      default:
        return Colors.transparent;
    }
  }

  int getCount(String type) {
    return attendanceStatus.values.where((v) => v == type).length;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFE8DFC1),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E4A56),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('سجل الحضور الشهري', style: GoogleFonts.cairo()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // عنوان و فلتر الشهر
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('سجل الحضور', style: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: selectedMonth,
                    items: ['أغسطس 2025', 'سبتمبر 2025', 'أكتوبر 2025']
                        .map((month) => DropdownMenuItem(value: month, child: Text(month, style: GoogleFonts.cairo())))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMonth = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // أيام الأسبوع
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: weekdays
                    .map((day) => Text(day, style: GoogleFonts.cairo(fontWeight: FontWeight.bold)))
                    .toList(),
              ),
              const SizedBox(height: 8),

              // شبكة الأيام
              Expanded(
                child: GridView.builder(
                  itemCount: 31,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final day = index + 1;
                    final status = attendanceStatus[day] ?? 'unapproved';
                    final color = getColor(status);
                    final date = DateTime(2025, 8, day);
                    final formatted = DateFormat('d MMMM', 'ar').format(date);

                    return Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        formatted,
                        style: GoogleFonts.cairo(fontSize: 13, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),

              // ملخص الحضور
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryBox('أيام العمل', getCount('work'), Colors.green[700]!),
                  _buildSummaryBox('أيام العطل', getCount('holiday'), Colors.yellow[800]!),
                  _buildSummaryBox('أيام الغير معتمدة', getCount('unapproved'), Colors.grey[700]!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryBox(String label, int count, Color color) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text('$count', style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
