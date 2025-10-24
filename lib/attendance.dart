import 'package:flutter/material.dart';
import 'manger_home.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  DateTime? selectedDate;
  TextEditingController searchController = TextEditingController();

  List<Map<String, String>> employees = [
    {"name": "اسم الموظف", "attendance": "08:00", "leave": "17:00", "note": "ملاحظة عادية"},
    {"name": "اسم الموظف", "attendance": "08:05", "leave": "16:50", "note": "تأخير بسيط"},
    {"name": "اسم الموظف", "attendance": "07:55", "leave": "17:05", "note": "ممتاز"},
  ];

  List<Map<String, String>> filteredEmployees = [];

  @override
  void initState() {
    super.initState();
    filteredEmployees = List.from(employees);
  }

  void filterSearch(String query) {
    setState(() {
      filteredEmployees = employees
          .where((e) => e["name"]!.contains(query))
          .toList();
    });
  }

  void pickDate() async {
    DateTime now = DateTime.now();
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تم تصدير البيانات بنجاح ✅")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF123B5A),
        title: const Text("سجل الحضور و الانصراف",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _InfoCard(title: "إجمالي الموظفين", value: "03"),
                _InfoCard(title: "الغياب", value: "00"),
                _InfoCard(title: "الحضور", value: "03"),
              ],
            ),
            const SizedBox(height: 20),

            // حقل اختيار التاريخ والبحث
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: filterSearch,
                    decoration: InputDecoration(
                      hintText: "ابحث عن موظف...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: pickDate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3CF60),
                  ),
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  label: Text(
                    selectedDate == null
                        ? "اختر التاريخ"
                        : "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),

            // الجدول
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: filteredEmployees.length,
                  itemBuilder: (context, index) {
                    var emp = filteredEmployees[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(emp["name"]!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        subtitle: Text(
                            "الحضور: ${emp["attendance"]} | الانصراف: ${emp["leave"]}\nالملاحظات: ${emp["note"]}"),
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

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  const _InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 3)],
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xFF123B5A))),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}