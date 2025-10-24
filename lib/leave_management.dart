import 'package:flutter/material.dart';

class Leave {
  String employeeName;
  String type;
  String status;

  Leave({required this.employeeName, required this.type, this.status = 'قيد الانتظار'});
}

class LeaveManagementScreen extends StatefulWidget {
  const LeaveManagementScreen({super.key});

  @override
  State<LeaveManagementScreen> createState() => _LeaveManagementScreenState();
}

class _LeaveManagementScreenState extends State<LeaveManagementScreen> {
  List<Leave> leaves = [
    Leave(employeeName: 'أحمد', type: 'إجازة سنوية'),
    Leave(employeeName: 'سارة', type: 'إجازة مرضية'),
    Leave(employeeName: 'محمد', type: 'إجازة خاصة'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الإجازات'),
        backgroundColor: const Color(0xFF123B5A),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: leaves.length,
        itemBuilder: (context, index) {
          final leave = leaves[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('${leave.employeeName} - ${leave.type}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('الحالة: ${leave.status}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: leave.status == 'قيد الانتظار'
                            ? () {
                                setState(() {
                                  leave.status = 'مقبول';
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('تم قبول طلب ${leave.employeeName}'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            : null,
                        child: const Text('قبول'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: leave.status == 'قيد الانتظار'
                            ? () {
                                setState(() {
                                  leave.status = 'مرفوض';
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('تم رفض طلب ${leave.employeeName}'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            : null,
                        child: const Text('رفض'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
