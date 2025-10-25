import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopEmployeesScreen extends StatelessWidget {
  const TopEmployeesScreen({super.key});

  // بيانات وهمية للموظفين
  List<Map<String, dynamic>> get fakeEmployees => [
        {
          'name': 'أحمد الزهراني',
          'attendance': 22,
          'rating': 4.5,
        },
        {
          'name': 'سارة المطيري',
          'attendance': 20,
          'rating': 5.0,
        },
        {
          'name': 'عبدالله الحربي',
          'attendance': 25,
          'rating': 3.8,
        },
        {
          'name': 'نورة القحطاني',
          'attendance': 18,
          'rating': 4.9,
        },
        {
          'name': 'خالد العتيبي',
          'attendance': 21,
          'rating': 4.2,
        },
      ];

  // حساب مجموع النقاط لكل موظف
  List<Map<String, dynamic>> get sortedEmployees {
    final list = fakeEmployees.map((e) {
      final score = e['attendance'] + e['rating'];
      return {
        'name': e['name'],
        'attendance': e['attendance'],
        'rating': e['rating'],
        'score': score,
      };
    }).toList();

    list.sort((a, b) => b['score'].compareTo(a['score']));
    return list;
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
        body: ListView.builder(
          itemCount: sortedEmployees.length,
          itemBuilder: (context, index) {
            final employee = sortedEmployees[index];
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
                  '✅ الحضور: ${employee['attendance']} يوم — تقييم HR: ${employee['rating']} ⭐',
                  style: GoogleFonts.cairo(fontSize: 15, color: Colors.green[700]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

