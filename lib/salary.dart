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

  List<Map<String, dynamic>> salaries = [
    {"name": "محمد", "dept": "المبيعات", "job": "موظف مبيعات", "salary": 5000, "deduction": 200},
    {"name": "سارة", "dept": "المحاسبة", "job": "محاسبة", "salary": 5200, "deduction": 0},
    {"name": "عبدالله", "dept": "الدعم الفني", "job": "فني دعم", "salary": 4800, "deduction": 100},
  ];

  void exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تم تصدير كشف الرواتب بنجاح ✅")),
    );
  }

  void pickMonthYear() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        int tempMonth = selectedMonth;
        int tempYear = selectedYear;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: 300,
              child: Column(
                children: [
                  const Text("اختر الشهر والسنة",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
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
                        onChanged: (v) =>
                            setModalState(() => tempMonth = v ?? tempMonth),
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
                        onChanged: (v) =>
                            setModalState(() => tempYear = v ?? tempYear),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF80B6A1),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedMonth = tempMonth;
                        selectedYear = tempYear;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("تم", style: TextStyle(color: Colors.white, fontSize: 18)),
                  )
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
        title: const Text("كشف الرواتب",
            style: TextStyle(color: Colors.white)),
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // اختيار الشهر والسنة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("الشهر: $selectedMonth / السنة: $selectedYear",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
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
            const SizedBox(height: 20),

            // الجدول
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: salaries.length,
                  itemBuilder: (context, index) {
                    var emp = salaries[index];
                    double net = emp["salary"] - emp["deduction"];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      child: ListTile(
                        title: Text("${emp["name"]} - ${emp["dept"]}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        subtitle: Text(
                            "الوظيفة: ${emp["job"]}\nالراتب: ${emp["salary"]} ريال | الخصم: ${emp["deduction"]} ريال | الصافي: $net ريال"),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: exportData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF80B6A1),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                "تصدير",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}