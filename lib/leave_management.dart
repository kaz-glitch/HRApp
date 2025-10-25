import 'package:flutter/material.dart';

class VacationManagementPage extends StatefulWidget {
  const VacationManagementPage({super.key});

  @override
  State<VacationManagementPage> createState() => _VacationManagementPageState();
}

class _VacationManagementPageState extends State<VacationManagementPage> {
  int selectedTab = 0; // 0 = رصيد الإجازات, 1 = طلبات الإجازات, 2 = التقويم

  // بيانات تجريبية قابلة للتعديل لاحقاً
  final List<Map<String, dynamic>> vacationBalances = [
    {'name': 'اسم موظف', 'dept': 'قسم تقنية المعلومات', 'total': 30, 'used': 12},
    {'name': 'اسم موظف', 'dept': 'قسم الموارد البشرية', 'total': 30, 'used': 25},
    {'name': 'اسم موظف', 'dept': 'قسم العمليات', 'total': 30, 'used': 10},
  ];

  final List<Map<String, dynamic>> vacationRequests = [
    {
      'name': 'اسم الموظف',
      'type': 'إجازة سنوية',
      'start': '2025-10-19',
      'end': '2025-10-25',
      'days': 6,
      'status': 'مقبول'
    },
    {
      'name': 'اسم الموظف',
      'type': 'إجازة مرضية',
      'start': '2025-10-13',
      'end': '2025-10-15',
      'days': 2,
      'status': 'مرفوض'
    },
    {
      'name': 'اسم الموظف',
      'type': 'إجازة سنوية',
      'start': '2025-10-02',
      'end': '2025-10-11',
      'days': 9,
      'status': 'قيد المراجعة'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFE8DFC1),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0C3B57),
          title: const Text(
            'إدارة الإجازات',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // الإحصائيات العلوية
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatBox('طلبات معلقة', '4'),
                  _buildStatBox('إجمالي الموظفين', '30'),
                ],
              ),
              const SizedBox(height: 12),

              // أزرار التنقل بين الصفحات
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTabButton('رصيد الإجازات', 0),
                  _buildTabButton('طلبات الإجازات', 1),
                  _buildTabButton('التقويم', 2),
                ],
              ),
              const SizedBox(height: 15),

              // محتوى الصفحة
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: _buildPageContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // صندوق الإحصائيات
  Widget _buildStatBox(String title, String number) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(number,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 5),
            Text(title, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  // أزرار التبويب
  Widget _buildTabButton(String title, int index) {
    final bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green[400] : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  // محتوى الصفحة حسب التبويب
  Widget _buildPageContent() {
    if (selectedTab == 0) {
      // رصيد الإجازات
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('رصيد إجازات الموظفين',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: 'ابحث عن موظف...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: vacationBalances.length,
              itemBuilder: (context, index) {
                final v = vacationBalances[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    title: Text(v['name']),
                    subtitle: Text(v['dept']),
                    trailing: Text(
                      'الرصيد المتبقي: ${v['total'] - v['used']} يوم',
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else if (selectedTab == 1) {
      // طلبات الإجازات
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('طلبات الإجازات',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: vacationRequests.length,
              itemBuilder: (context, index) {
                final v = vacationRequests[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    title: Text(v['name']),
                    subtitle: Text(
                        '${v['type']} | من ${v['start']} إلى ${v['end']} (${v['days']} أيام)'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: v['status'] == 'مقبول'
                            ? Colors.green
                            : v['status'] == 'مرفوض'
                                ? Colors.red
                                : Colors.orange,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(v['status'],
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      // التقويم
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('تقويم الإجازات لشهر أكتوبر 2025',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 20),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: const ListTile(
              title: Text('19 - 25 أكتوبر'),
              subtitle: Text('اسم الموظف | إجازة سنوية'),
            ),
          ),
        ],
      );
    }
  }
}
