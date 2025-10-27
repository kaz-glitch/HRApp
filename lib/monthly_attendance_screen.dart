import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonthlyAttendanceListScreen extends StatelessWidget {
  const MonthlyAttendanceListScreen({super.key});

  final List<Map<String, dynamic>> attendanceData = const [
    {'date': '2025-08-01', 'status': 'حضور'},
    {'date': '2025-08-02', 'status': 'غياب'},
    {'date': '2025-08-03', 'status': 'إجازة'},
    {'date': '2025-08-04', 'status': 'حضور'},
    {'date': '2025-08-05', 'status': 'حضور'},
    {'date': '2025-08-06', 'status': 'إجازة'},
    {'date': '2025-08-07', 'status': 'حضور'},
    {'date': '2025-08-08', 'status': 'حضور'},
    {'date': '2025-08-09', 'status': 'إجازة'},
    {'date': '2025-08-10', 'status': 'غياب'},
    // أكملي باقي الأيام حسب الحاجة
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'حضور':
        return Colors.green;
      case 'غياب':
        return Colors.red;
      case 'إجازة':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final workDays = attendanceData.where((e) => e['status'] == 'حضور').length;
    final offDays = attendanceData.where((e) => e['status'] == 'إجازة').length;
    final unapprovedDays = attendanceData.where((e) => e['status'] == 'غياب').length;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFE8DFC1),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E4A56),
          title: Text('سجل الحضور الشهري', style: GoogleFonts.cairo()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: attendanceData.length,
                  itemBuilder: (context, index) {
                    final item = attendanceData[index];
                    final color = getStatusColor(item['status']);

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: color,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          item['date'],
                          style: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item['status'],
                            style: GoogleFonts.cairo(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryBox('أيام العمل', workDays, Colors.green),
                  _buildSummaryBox('أيام العطل', offDays, Colors.orange),
                  _buildSummaryBox('أيام الغير معتمدة', unapprovedDays, Colors.red),
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
        Text(label, style: GoogleFonts.cairo(fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text('$count', style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}