import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'manger_home.dart';
import 'dart:ui' as ui;


class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  DateTime selectedDate = DateTime.now();
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _records = List.generate(
    8,
    (i) => {
      'name': 'اسم الموظف ${i + 1}',
      'arrival': null,
      'departure': null,
      'notes': 'لا ملاحظات',
    },
  );

  List<Map<String, dynamic>> get filteredRecords {
    return _records
        .where((r) => r['name'].toString().contains(searchQuery))
        .toList();
  }

  int get totalEmployees => _records.length;
  int get totalPresent => _records.where((r) => r['arrival'] != null).length;
  int get totalAbsent => totalEmployees - totalPresent;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('ar', 'SA'),
      builder: (context, child) {
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  void _markArrival(Map<String, dynamic> emp) {
    setState(() => emp['arrival'] = TimeOfDay.now());
  }

  void _markDeparture(Map<String, dynamic> emp) {
    setState(() => emp['departure'] = TimeOfDay.now());
  }

  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تم حفظ سجل الحضور ✅")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF2E2E33),
        appBar: AppBar(
          backgroundColor: const Color(0xFF12384F),
          title: const Text(
            'سجل الحضور والانصراف',
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
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 420),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D0BA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 18),
                    // ======= الإحصائيات =======
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _statCard('الحضور', totalPresent.toString()),
                          _statCard('الغياب', totalAbsent.toString()),
                          _statCard('إجمالي الموظفين', totalEmployees.toString()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    // ======= البحث + التاريخ =======
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '... البحث عن موظف',
                                ),
                                onChanged: (v) =>
                                    setState(() => searchQuery = v),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: _pickDate,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF8D6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_month, size: 20),
                                  const SizedBox(width: 8),
                                  Text(DateFormat('yyyy-MM-dd')
                                      .format(selectedDate)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // ======= الجدول =======
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children:
                              filteredRecords.map((r) => _recordRow(r)).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // ======= زر الحفظ =======
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF86B399),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: _exportData,
                          child: const Text(
                            'حفظ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
          ],
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(title,
                style:
                    const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget _recordRow(Map<String, dynamic> emp) {
    String arrival = emp['arrival'] == null
        ? '00:00'
        : (emp['arrival'] as TimeOfDay).format(context);
    String departure = emp['departure'] == null
        ? '00:00'
        : (emp['departure'] as TimeOfDay).format(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(emp['name'])),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () => _markArrival(emp),
              child: Column(
                children: [
                  Text(arrival),
                  const SizedBox(height: 4),
                  const Text('الحضور',
                      style:
                          TextStyle(fontSize: 11, color: Colors.black54)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () => _markDeparture(emp),
              child: Column(
                children: [
                  Text(departure),
                  const SizedBox(height: 4),
                  const Text('الانصراف',
                      style:
                          TextStyle(fontSize: 11, color: Colors.black54)),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child:
                  Text(emp['notes'], style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
