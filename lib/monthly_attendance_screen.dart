
// monthly_attendance_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonthlyAttendanceScreen extends StatefulWidget {
  const MonthlyAttendanceScreen({super.key});

  @override
  State<MonthlyAttendanceScreen> createState() => _MonthlyAttendanceScreenState();
}

class _MonthlyAttendanceScreenState extends State<MonthlyAttendanceScreen> {
  static const Color darkBlue = Color(0xFF2E4A56);
  static const Color beige = Color(0xFFE8DFC1);

  // Mock monthly summary
  final List<_DayEntry> days = List.generate(30, (i) {
    final date = DateTime(2025, 10, i + 1);
    final weekdayNames = ['الاثنين','الثلاثاء','الأربعاء','الخميس','الجمعة','السبت','الأحد'];
    final wd = weekdayNames[date.weekday - 1];
    return _DayEntry(
      dayName: wd,
      date: date,
      checkIn: i % 6 == 2 ? '8:48' : '8:00',
      checkOut: i % 5 == 1 ? '11:45' : '12:00',
      late: i % 6 == 2,
    );
  });

  String _fmtDate(DateTime d) => '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: beige,
        appBar: AppBar(
          backgroundColor: darkBlue,
          leading: IconButton(
            icon: const Icon(Icons.chevron_right, color: Colors.white),
            onPressed: () => Navigator.pop(context),
            tooltip: 'رجوع',
          ),
          title: Text('سجل الحضور الشهري', style: GoogleFonts.cairo(fontWeight: FontWeight.w800)),
          centerTitle: true,
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: days.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final d = days[i];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0,2))],
              ),
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(child: Text(d.dayName, style: GoogleFonts.cairo(fontWeight: FontWeight.w700))),
                  Expanded(child: Text(_fmtDate(d.date), style: GoogleFonts.cairo())),
                  Expanded(child: Text(d.checkIn, style: GoogleFonts.cairo(color: d.late ? const Color(0xFFE0626A) : Colors.black87, fontWeight: FontWeight.w700))),
                  Expanded(child: Text(d.checkOut, style: GoogleFonts.cairo(fontWeight: FontWeight.w700))),
                  if (d.late)
                    Container(
                      margin: const EdgeInsetsDirectional.only(start: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFFE0626A), borderRadius: BorderRadius.circular(16)),
                      child: Text('متأخر', style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DayEntry {
  final String dayName;
  final DateTime date;
  final String checkIn;
  final String checkOut;
  final bool late;
  _DayEntry({required this.dayName, required this.date, required this.checkIn, required this.checkOut, required this.late});
}
