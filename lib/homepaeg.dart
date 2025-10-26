import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Screens
import 'attendance_screen.dart';
import 'leave_request.dart';
import 'top_employees_screen.dart';
import 'salary_screen.dart';
import 'employee_profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Colors
  static const Color darkBlue = Color(0xFF2E4A56);
  static const Color greenCard = Color(0xFFA7C7A1);
  static const Color yellowCard = Color(0xFFE7C46D);
  static const Color oliveCard = Color(0xFFBFC977);
  static const Color beige = Color(0xFFE8DFC1);

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.cairoTextTheme(Theme.of(context).textTheme);
    final size = MediaQuery.of(context).size;
    final notifHeight = size.height * 0.37; // مساحة ثابتة لتمرير الإشعارات داخليًا
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: beige,
        appBar: AppBar(
          backgroundColor: darkBlue,
          elevation: 0,
          title: Text('اسم الشركة', style: textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
          actions: [
            IconButton(
              tooltip: 'الملف الشخصي',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const EmployeeProfilePage()));
              },
              icon: const CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
            const SizedBox(width: 8),
          ],
          leading: Padding(
            padding: const EdgeInsetsDirectional.only(start: 12),
            child: CircleAvatar(
              backgroundColor: Colors.white24,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.checklist_rtl, color: Colors.white),
                tooltip: 'شعار الشركة',
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2x2 grid
              Row(
                children: [
                  // البطاقة الخضراء — تسجيل الحضور والانصراف
                  Expanded(
                    child: _HomeCard(
                      color: greenCard,
                      icon: Icons.access_time,
                      label: 'تسجيل الحضور \nوالانصراف',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const AttendanceScreen()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _HomeCard(
                      color: yellowCard,
                      icon: Icons.event_available,
                      label: 'طلب إجازة',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const LeaveRequestPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _HomeCard(
                      color: oliveCard,
                      icon: Icons.emoji_events,
                      label: 'أفضل خمسة\nموظفين',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const TopEmployeesScreen()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _HomeCard(
                      color: darkBlue,
                      icon: Icons.receipt_long,
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      label: 'كشف الراتب',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SalaryScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(thickness: 1.2, color: Color(0x332E4A56)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.notifications, color: darkBlue),
                  const SizedBox(width: 8),
                  Text('الإشعارات', style: textTheme.titleMedium?.copyWith(color: darkBlue, fontWeight: FontWeight.w800)),
                ],
              ),
              const SizedBox(height: 12),

              // ✅ إشعارات قابلة للتمرير داخليًا
              SizedBox(
                height: notifHeight.clamp(220.0, 420.0),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: _mockNotifications.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0,2))],
                      ),
                      child: Text(_mockNotifications[i], style: textTheme.bodyMedium?.copyWith(color: Colors.black87)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  const _HomeCard({
    required this.color,
    required this.icon,
    required this.label,
    required this.onTap,
    this.textColor = Colors.white,
    this.iconColor,
  });

  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color textColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.cairo(color: textColor, fontWeight: FontWeight.w700, fontSize: 16);
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 44, color: iconColor ?? Colors.white70),
              const SizedBox(height: 10),
              Text(label, textAlign: TextAlign.center, style: style),
            ],
          ),
        ),
      ),
    );
  }
}

const List<String> _mockNotifications = [
  'إشعار 1 — نص تجريبي طويل قليلًا لعرض القصص والتمرير داخل القائمة.',
  'إشعار 2 — تم رفع طلب إجازة بانتظار موافقة المدير.',
  'إشعار 3 — تم اعتماد بصمة الحضور اليوم الساعة 8:00 AM.',
  'إشعار 4 — تم نشر كشف الراتب لشهر ديسمبر.',
  'إشعار 5 — نص إضافي لاختبار التمرير داخل منطقة الإشعارات.',
  'إشعار 6 — تذكير: حدث فريق العمل يوم الخميس.',
  'إشعار 7 — إشعار تجريبي آخر للتأكد من أن التمرير يعمل بسلاسة.',
];
