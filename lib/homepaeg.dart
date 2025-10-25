import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'employee_profile.dart';
import 'leave_request.dart';
import 'top_employees_screen.dart';

/// ====== نموذج إشعار + مصدر وهمي داخل نفس الملف (بدون ملفات خارجية) ======
class NotificationItem {
  final String text;
  final DateTime createdAt;
  NotificationItem(this.text, this.createdAt);
}

/// مصدر بيانات وهمي للإشعارات (محاكاة لقاعدة بيانات مستقبلًا)
class _FakeNotificationsRepo {
  Future<List<NotificationItem>> fetch() async {
    await Future.delayed(const Duration(milliseconds: 350)); // محاكاة تحميل
    return List.generate(
      18,
      (i) => NotificationItem(
        'إشعار رقم ${i + 1} — نص تجريبي طويل قليلًا لعرض القص والتمرير داخل القائمة.',
        DateTime.now().subtract(Duration(minutes: 3 * i)),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // الألوان
  static const Color darkBlue = Color(0xFF2E4A56);
  static const Color greenCard = Color(0xFFA7C7A1);
  static const Color yellowCard = Color(0xFFE7C46D);
  static const Color oliveCard = Color(0xFFBFC977);

  // مصدر الإشعارات الوهمي (داخلي)
  _FakeNotificationsRepo get _repo => _FakeNotificationsRepo();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFE8DFC1),
        appBar: AppBar(
          backgroundColor: darkBlue,
          elevation: 0,
          // أيقونة حساب الموظف (يسار بصريًا في RTL)
          leadingWidth: 72,
          leading: Padding(
            padding: const EdgeInsetsDirectional.only(start: 12.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const EmployeeProfilePage()),
                );
              },
              child: _roundIcon(
                icon: Icons.person,
                size: 28,
                bg: Colors.white.withOpacity(0.15),
                fg: Colors.white,
              ),
            ),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _roundIcon(
                    icon: Icons.assignment_turned_in,
                    size: 26,
                    bg: Colors.white.withOpacity(0.15),
                    fg: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'اسم الشركة',
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // شبكة البطاقات 2×2
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  // ✅ تسجيل الحضور والانصراف (يمين)
                  const _HomeCard(
                    label: 'تسجيل الحضور والانصراف',
                    color: greenCard,
                    icon: Icons.access_time,
                  ),
                  // ✅ طلب إجازة (يسار)
                  _HomeCard(
                    label: 'طلب إجازة',
                    color: yellowCard,
                    icon: Icons.calendar_month,
                    onTap: (ctx) {
                      Navigator.of(ctx).push(
                        MaterialPageRoute(builder: (_) => const LeaveRequestPage()),
                      );
                    },
                  ),
                  // الصف الثاني
                  const _HomeCard(
                    label: 'أفضل خمسة موظفين',
                    color: oliveCard,
                    icon: Icons.emoji_events,
                  ),
                  const _HomeCard(
                    label: 'كشف الراتب',
                    color: darkBlue,
                    icon: Icons.receipt_long,
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Divider(thickness: 1.2, color: Color(0x332E4A56)),
              const SizedBox(height: 12),

              // عنوان الإشعارات
              Row(
                children: [
                  const Icon(Icons.notifications, color: darkBlue, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    'الإشعارات',
                    style: GoogleFonts.cairo(
                      color: darkBlue,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ✅ قائمة الإشعارات قابلة للتمرير (مصدر وهمي داخلي)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FutureBuilder<List<NotificationItem>>(
                    future: _repo.fetch(),
                    builder: (context, snap) {
                      if (snap.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snap.hasError) {
                        return Center(
                          child: Text('حدث خطأ في تحميل الإشعارات', style: GoogleFonts.cairo()),
                        );
                      }
                      final items = snap.data ?? [];
                      if (items.isEmpty) {
                        return Center(
                          child: Text('لا توجد إشعارات حاليًا', style: GoogleFonts.cairo()),
                        );
                      }
                      return Scrollbar(
                        thumbVisibility: true,
                        radius: const Radius.circular(12),
                        child: ListView.separated(
                          itemCount: items.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, i) => _NotificationTile(text: items[i].text),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // أيقونة دائرية للاستخدام في AppBar
  Widget _roundIcon({
    required IconData icon,
    required double size,
    required Color bg,
    required Color fg,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Icon(icon, size: size, color: fg),
    );
  }
}

/// بطاقة في الشبكة 2×2
class _HomeCard extends StatelessWidget {
  const _HomeCard({
    required this.label,
    required this.color,
    required this.icon,
    this.onTap,
  });

  final String label;
  final Color color;
  final IconData icon;
  final void Function(BuildContext context)? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(18),
      elevation: 4,
      shadowColor: Colors.black12,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => onTap?.call(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 56, color: Colors.white.withOpacity(0.95)),
              const SizedBox(height: 16),
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 16.5,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// عنصر إشعار
class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: 15.5,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF2E4A56),
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
