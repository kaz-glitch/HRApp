import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class TopEmployeesScreen extends StatefulWidget {
  const TopEmployeesScreen({super.key});

  @override
  State<TopEmployeesScreen> createState() => _TopEmployeesScreenState();
}

class _TopEmployeesScreenState extends State<TopEmployeesScreen> {
  final supabase = Supabase.instance.client;
  List<dynamic> topEmployees = [];
  bool isLoading = true;
  String errorMessage = '';

  Future<void> fetchTopEmployees() async {
    try {
      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);
      final endOfMonth = DateTime(now.year, now.month + 1, 0);

      final response = await supabase
          .from('attendance_logs')
          .select('user_id, name, check_in_time')
          .gte('check_in_time', startOfMonth.toIso8601String())
          .lte('check_in_time', endOfMonth.toIso8601String());

      final Map<String, Map<String, dynamic>> attendanceMap = {};

      for (var record in response) {
        final userId = record['user_id'];
        final name = record['name'];
        final date = DateFormat('yyyy-MM-dd').format(DateTime.parse(record['check_in_time']));

        if (!attendanceMap.containsKey(userId)) {
          attendanceMap[userId] = {
            'name': name,
            'dates': <String>{date},
          };
        } else {
          attendanceMap[userId]!['dates'].add(date);
        }
      }

      final List<Map<String, dynamic>> sortedList = attendanceMap.entries.map((entry) {
        return {
          'user_id': entry.key,
          'name': entry.value['name'],
          'attendance_days': (entry.value['dates'] as Set<String>).length,
        };
      }).toList()
        ..sort((a, b) => b['attendance_days'].compareTo(a['attendance_days']));

      setState(() {
        topEmployees = sortedList.take(5).toList();
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'حدث خطأ أثناء جلب البيانات';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTopEmployees();
  }

  Widget buildEmployeeCard(int index, Map<String, dynamic> employee) {
    final medal = switch (index) {
      0 => '🥇',
      1 => '🥈',
      2 => '🥉',
      _ => '🏅',
    };

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF2E4A56),
          child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
        ),
        title: Text(
          '$medal ${employee['name']}',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          '✅ عدد أيام الحضور: ${employee['attendance_days']}',
          style: GoogleFonts.cairo(fontSize: 15, color: Colors.green[700]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFE8DFC1),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E4A56),
          title: Text('أفضل الموظفين لهذا الشهر', style: GoogleFonts.cairo()),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage, style: GoogleFonts.cairo()))
                : ListView.builder(
                    itemCount: topEmployees.length,
                    itemBuilder: (context, index) {
                      final employee = topEmployees[index];
                      return buildEmployeeCard(index, employee);
                    },
                  ),
      ),
    );
  }
}
