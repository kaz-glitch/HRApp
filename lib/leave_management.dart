import 'package:flutter/material.dart';
import 'manger_home.dart';

class LeaveManagementScreen extends StatefulWidget {
  const LeaveManagementScreen({super.key});

  @override
  State<LeaveManagementScreen> createState() => _LeaveManagementScreenState();
}

class _LeaveManagementScreenState extends State<LeaveManagementScreen> {
  @override
  Widget build(BuildContext context) {
    // الألوان المستعملة - عدّلها لو حاب
    const bg = Color(0xFFF2E9D6); // بيج خفيف خلفية
    const teal = Color(0xFF0F5160); // لون العنوان الداكن

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bg,
        body: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                // --- رأس الصفحة ---
                _buildTopBar(teal),
                const SizedBox(height: 12),

                // --- بطاقتا الأرقام ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(child: _buildNumberCard('إجمالي الموظفين', '30')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildNumberCard('طلبات معلّقة', '4')),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // --- تبويبات ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: const Color(0xFFBEE0D4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelColor: teal,
                      unselectedLabelColor: Colors.black54,
                      tabs: const [
                        Tab(text: 'رصيد الإجازات'),
                        Tab(text: 'طلبات الإجازات'),
                        Tab(text: 'التقويم'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // --- محتوى التبويبات ---
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: TabBarView(
                        children: [
                          // --- Tab 1: رصيد الإجازات ---
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // بحث
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'البحث عن موظف...',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 12),
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // بطاقات الموظفين
                                _employeeBalanceCard(
                                  name: 'اسم موظف',
                                  dept: 'قسم: تقنية المعلومات',
                                  annualTotal: 30,
                                  available: 18,
                                  used: 12,
                                ),
                                const SizedBox(height: 8),
                                _employeeBalanceCard(
                                  name: 'اسم موظف',
                                  dept: 'قسم: الموارد البشرية',
                                  annualTotal: 30,
                                  available: 5,
                                  used: 25,
                                ),
                                const SizedBox(height: 8),
                                _employeeBalanceCard(
                                  name: 'اسم موظف',
                                  dept: 'قسم: المالية',
                                  annualTotal: 30,
                                  available: 10,
                                  used: 20,
                                ),
                              ],
                            ),
                          ),

                          // --- Tab 2: طلبات الإجازات ---
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF3D9),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text('المعلقة (4)'),
                                  ),
                                ),
                                const SizedBox(height: 8),

                                _leaveRequestRow(
                                  name: 'اسم الموظف',
                                  type: 'إجازة سنوية',
                                  from: '2025-12-01',
                                  to: '2025-12-06',
                                  days: 6,
                                  status: 'قبول',
                                ),
                                const SizedBox(height: 6),
                                _leaveRequestRow(
                                  name: 'اسم الموظف',
                                  type: 'إجازة مرضية',
                                  from: '2025-10-13',
                                  to: '2025-10-14',
                                  days: 2,
                                  status: 'رفض',
                                ),
                                const SizedBox(height: 6),
                                _leaveRequestRow(
                                  name: 'اسم الموظف',
                                  type: 'إجازة رسمية',
                                  from: '2025-11-08',
                                  to: '2025-11-09',
                                  days: 2,
                                  status: 'قبول',
                                ),
                              ],
                            ),
                          ),

                          // --- Tab 3: التقويم ---
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text('أكتوبر 2025',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 12),
                                Container(
                                  height: 320,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(Icons.calendar_month,
                                            size: 56, color: Colors.grey),
                                        SizedBox(height: 8),
                                        Text(
                                          'تقويم الإجازات المجدولة لشهر أكتوبر',
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ----- رأس الصفحة -----
  Widget _buildTopBar(Color teal) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 84,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: teal,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(6),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
                    color: Colors.white,
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'إدارة الإجازات',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----- بطاقة رقمية -----
  Widget _buildNumberCard(String title, String number) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(number,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  // ----- بطاقة رصيد الموظف -----
  Widget _employeeBalanceCard({
    required String name,
    required String dept,
    required int annualTotal,
    required int available,
    required int used,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(dept, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBalanceInfo('إجمالي', annualTotal.toString()),
                _buildBalanceInfo('المستخدم', used.toString()),
                _buildBalanceInfo('المتبقي', available.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceInfo(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }

  // ----- صف طلب إجازة -----
  Widget _leaveRequestRow({
    required String name,
    required String type,
    required String from,
    required String to,
    required int days,
    required String status,
  }) {
    Color statusColor;
    if (status == 'قبول') {
      statusColor = Colors.green;
    } else if (status == 'رفض') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('$type | $days يوم',
              style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('من $from إلى $to',
                  style: const TextStyle(fontSize: 13, color: Colors.black54)),
              Text(status, style: TextStyle(color: statusColor)),
            ],
          ),
        ],
      ),
    );
  }
}
