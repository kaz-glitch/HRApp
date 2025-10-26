import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonthlyAttendanceScreen extends StatefulWidget {
  const MonthlyAttendanceScreen({super.key});

  @override
  State<MonthlyAttendanceScreen> createState() => _MonthlyAttendanceScreenState();
}

class _MonthlyAttendanceScreenState extends State<MonthlyAttendanceScreen> {
  final Map<DateTime, String> attendanceStatus = {
    DateTime(2025, 1, 1): 'حضور',
    DateTime(2025, 1, 2): 'غياب',
    DateTime(2025, 1, 3): 'إجازة',
    DateTime(2025, 1, 4): 'حضور',
  };

  Color _statusColor(String status) {
    switch (status) {
      case 'حضور':
        return const Color(0xFF6BC17A);
      case 'غياب':
        return const Color(0xFFE0626A);
      case 'إجازة':
        return const Color(0xFFE7C46D);
      default:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF2E4A56);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFE8DFC1),
        appBar: AppBar(
          backgroundColor: darkBlue,
          leading: IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          title: Text('سجل الحضور الشهري', style: GoogleFonts.cairo()),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, i) {
            final date = attendanceStatus.keys.elementAt(i);
            final status = attendanceStatus[date]!;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: _statusColor(status),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(status,
                        style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
                      style: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Icon(Icons.chevron_left),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemCount: attendanceStatus.length,
        ),
      ),
    );
  }
}
