import 'package:flutter/material.dart';

class SalaryPage extends StatefulWidget {
  const SalaryPage({super.key});

  @override
  State<SalaryPage> createState() => _SalaryPageState();
}

class _SalaryPageState extends State<SalaryPage> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  final Map<String, dynamic> salaryData = {
    "basicSalary": 5000,
    "housingAllowance": 1500,
    "transportAllowance": 1000,
    "bonuses": 500,
    "deductions": 300,
    "netSalary": 6700,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        elevation: 0,
        title: const Text(
          "كشف الرواتب",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // يرجع للصفحة السابقة فقط بدون تحديد مدير او موظف
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // اختيار الشهر والسنة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<int>(
                  value: selectedMonth,
                  items: List.generate(
                    12,
                        (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text("شهر ${index + 1}"),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() => selectedMonth = value!);
                  },
                ),
                DropdownButton<int>(
                  value: selectedYear,
                  items: List.generate(
                    5,
                        (index) => DropdownMenuItem(
                      value: 2022 + index,
                      child: Text("سنة ${2022 + index}"),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() => selectedYear = value!);
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  salaryItem("الراتب الأساسي", salaryData["basicSalary"]),
                  salaryItem("بدل السكن", salaryData["housingAllowance"]),
                  salaryItem("بدل المواصلات", salaryData["transportAllowance"]),
                  salaryItem("المكافآت", salaryData["bonuses"]),
                  salaryItem("الخصومات", salaryData["deductions"], isNegative: true),
                  const Divider(thickness: 1.2),
                  salaryItem("صافي الراتب", salaryData["netSalary"], isBold: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget salaryItem(
      String title,
      dynamic value, {
        bool isNegative = false,
        bool isBold = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            "${isNegative ? "-" : ""} $value ريال",
            style: TextStyle(
              fontSize: 16,
              color: isNegative ? Colors.red : Colors.black,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
