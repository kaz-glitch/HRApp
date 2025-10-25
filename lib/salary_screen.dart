import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SalaryScreen extends StatelessWidget {
  const SalaryScreen({super.key});

  // بيانات وهمية للراتب
  final Map<String, dynamic> salaryData = const {
    'employeeName': 'أحمد الزهراني',
    'baseSalary': 8000,
    'deductions': 750,
    'bonuses': 500,
    'month': 'أكتوبر 2025',
  };

  @override
  Widget build(BuildContext context) {
    final netSalary = salaryData['baseSalary'] + salaryData['bonuses'] - salaryData['deductions'];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFE8DFC1),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E4A56),
          title: Text('كشف الراتب', style: GoogleFonts.cairo()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'تفاصيل الراتب - ${salaryData['month']}',
                style: GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              _buildSalaryRow('اسم الموظف:', salaryData['employeeName']),
              const SizedBox(height: 12),
              _buildSalaryRow('الراتب الأساسي:', '${salaryData['baseSalary']} ريال'),
              _buildSalaryRow('البدلات / المكافآت:', '${salaryData['bonuses']} ريال'),
              _buildSalaryRow('الخصومات:', '${salaryData['deductions']} ريال'),
              const Divider(height: 32, thickness: 1.5),
              _buildSalaryRow('صافي الراتب:', '${netSalary.toStringAsFixed(2)} ريال',
                  isBold: true, color: Colors.green[800]),

              const Spacer(),

              // ملاحظة
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'هذه البيانات تجريبية فقط. سيتم ربطها بقاعدة البيانات لاحقًا.',
                  style: GoogleFonts.cairo(fontSize: 14, color: Colors.brown[700]),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSalaryRow(String label, String value, {bool isBold = false, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(fontSize: 16.5, fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: 16.5,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: color ?? Colors.black87,
          ),
        ),
      ],
    );
  }
}
