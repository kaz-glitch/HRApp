import 'package:flutter/material.dart';
import 'manger_home.dart';

class SalaryPage extends StatefulWidget {
  const SalaryPage({super.key});

  @override
  State<SalaryPage> createState() => _SalaryPageState();
}

class _SalaryPageState extends State<SalaryPage> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  // قائمة الرواتب
  final List<Map<String, dynamic>> salaries = [
    {"name": "محمد", "dept": "المبيعات", "job": "موظف مبيعات", "salary": 5000.0, "deduction": 200.0},
    {"name": "سارة", "dept": "المحاسبة", "job": "محاسبة", "salary": 5200.0, "deduction": 0.0},
    {"name": "عبدالله", "dept": "الدعم الفني", "job": "فني دعم", "salary": 4800.0, "deduction": 100.0},
  ];

  void exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تم تصدير كشف الرواتب بنجاح ✅")),
    );
  }

  void pickMonthYear() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        int tempMonth = selectedMonth;
        int tempYear = selectedYear;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              height: 300.0,
              child: Column(
                children: [
                  const Text(
                    "اختر الشهر والسنة",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton<int>(
                        value: tempMonth,
                        items: List.generate(
                          12,
                          (i) => DropdownMenuItem(
                            value: i + 1,
                            child: Text("شهر ${i + 1}"),
                          ),
                        ),
                        onChanged: (v) => setModalState(() => tempMonth = v ?? tempMonth),
                      ),
                      DropdownButton<int>(
                        value: tempYear,
                        items: List.generate(
                          5,
                          (i) => DropdownMenuItem(
                            value: DateTime.now().year - i,
                            child: Text("سنة ${DateTime.now().year - i}"),
                          ),
                        ),
                        onChanged: (v) => setModalState(() => tempYear = v ?? tempYear),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF80B6A1),
                      minimumSize: const Size(double.infinity, 50.0),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedMonth = tempMonth;
                        selectedYear = tempYear;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "تم",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF123B5A),
        title: const Text(
          "كشف الرواتب",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // اختيار الشهر والسنة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الشهر: $selectedMonth / السنة: $selectedYear",
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3CF60),
                  ),
                  icon: const Icon(Icons.calendar_month, color: Colors.white),
                  label: const Text("اختيار", style: TextStyle(color: Colors.white)),
                  onPressed: pickMonthYear,
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // الجدول
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView.builder(
                  itemCount: salaries.length,
                  itemBuilder: (context, index) {
                    var emp = salaries[index];
                    // نحول كل القيم إلى double لتفادي أي خطأ
                    final double salary = (emp["salary"] as num).toDouble();
                    final double deduction = (emp["deduction"] as num).toDouble();
                    final double net = salary - deduction;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                      child: ListTile(
                        title: Text(
                          "${emp["name"]} - ${emp["dept"]}",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        subtitle: Text(
                          "الوظيفة: ${emp["job"]}\nالراتب: $salary ريال | الخصم: $deduction ريال | الصافي: $net ريال",
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10.0),

            ElevatedButton(
              onPressed: exportData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF80B6A1),
                minimumSize: const Size(double.infinity, 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                "تصدير",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
