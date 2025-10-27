// attendance_screen.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'monthly_attendance_screen.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  // لوحة ألوان موحدة
  static const Color darkBlue = Color(0xFF2E4A56);
  static const Color beige    = Color(0xFFE8DFC1);
  static const Color mint     = Color(0xFFA7C7A1); // حضور
  static const Color olive    = Color(0xFF8BA392); // انصراف (أغمق قليلاً)
  static const Color navy     = Color(0xFF1F3B46); // السجل الشهري
  static const Color yellow   = Color(0xFFE7C46D); // إنذارات التأخير
  static const Color greenLt  = Color(0xFFA7C7A1); // البصمات غير المسجلة

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.cairoTextTheme(Theme.of(context).textTheme);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: beige,
        appBar: AppBar(
          backgroundColor: darkBlue,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.maybePop(context),
          ),
          title: Text(
            'تسجيل الحضور',
            style: textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            children: [
              // البطاقات الكبيرة (يمين: الحضور | يسار: الانصراف)
              Row(
                children: [
                  Expanded(
                    child: _LargeStampCard(
                      color: mint,
                      title: 'بصمة الحضور',
                      date: '2025-10-30',
                      timeLabel: 'الحضور',
                      time: '8:00AM',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _LargeStampCard(
                      color: olive,
                      title: 'بصمة الانصراف',
                      date: '2025-10-30',
                      timeLabel: 'الانصراف',
                      time: '12:00AM',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // البطاقات الصغيرة (السجل الشهري – إنذارات التأخير – البصمات غير المسجلة)
              Row(
                children: [
                  Expanded(
                    child: _SmallStatCard(
                      bg: navy,
                      number: null,
                      title: 'سجل الحضور\nالشهري',
                      titleColor: Colors.white,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const MonthlyAttendanceScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SmallStatCard(
                      bg: yellow,
                      number: '1',
                      title: 'إنذارات التأخير',
                      titleColor: Colors.white,
                      onTap: null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SmallStatCard(
                      bg: greenLt,
                      number: '0',
                      title: 'البصمات غير\nمسجلة',
                      titleColor: Colors.white,
                      onTap: null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // شريط عنوان الجدول مع زر تحميل يسار
              _DailyHeaderBar(
                title: 'سجل الحضور اليومي',
                onDownload: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('سيتم تصدير السجل لاحقًا.', style: GoogleFonts.cairo()),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // جدول اليوم
              _DailyTable(
                rows: const [
                  _DailyRow('الأحد',    '2025-12-01', '8:00', '12:00'),
                  _DailyRow('الإثنين',  '2025-10-13', '7:50', '12:01'),
                  _DailyRow('الثلاثاء', '2025-11-08', '8:50', '12:00', lateBadge: true),
                  _DailyRow('الأربعاء', '2025-10-02', '7:57', '11:40'),
                  _DailyRow('الخميس',  '2025-10-02', '7:57', '11:40'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// بطاقة كبيرة للحضور/الانصراف مع أيقونة البصمة أسفل-يسار
class _LargeStampCard extends StatelessWidget {
  const _LargeStampCard({
    required this.color,
    required this.title,
    required this.date,
    required this.timeLabel,
    required this.time,
  });

  final Color color;
  final String title;
  final String date;
  final String timeLabel;
  final String time;

  @override
  Widget build(BuildContext context) {
    // ← اسم المتغير صحيح بحرف W كبير
    final double cardWidth = math.max(MediaQuery.of(context).size.width / 2 - 24, 160);

    return Container(
      width: cardWidth,
      height: 160,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          // ظل سفلي بسيط مثل التصميم
          BoxShadow(color: Color(0x33000000), blurRadius: 10, offset: Offset(0, 6)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // النصوص
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                date,
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const SizedBox(width: 48), // حجز مساحة لأيقونة البصمة يسار
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        timeLabel,
                        style: GoogleFonts.cairo(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        time,
                        style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // أيقونة البصمة أسفل-يسار
          Positioned(
            left: 8,
            bottom: 8,
            child: Icon(
              Icons.fingerprint,
              size: 40,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}

/// بطاقة صغيرة (بدون أي أيقونات إضافية) مع رقم/عنوان بنص أبيض
class _SmallStatCard extends StatelessWidget {
  const _SmallStatCard({
    required this.bg,
    required this.title,
    this.number,
    this.titleColor,
    this.onTap,
  });

  final Color bg;
  final String title;
  final String? number;
  final Color? titleColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      constraints: const BoxConstraints(minHeight: 92),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x33000000), blurRadius: 10, offset: Offset(0, 6)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (number != null)
            Text(
              number!,
              style: GoogleFonts.cairo(
                color: titleColor ?? Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 22,
                height: 1.0,
              ),
            ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              color: titleColor ?? Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15,
              height: 1.25,
            ),
          ),
        ],
      ),
    );

    return onTap == null
        ? content
        : InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: content,
          );
  }
}

/// شريط عنوان الجدول مع زر تنزيل أصفر على اليسار
class _DailyHeaderBar extends StatelessWidget {
  const _DailyHeaderBar({
    required this.title,
    required this.onDownload,
  });

  final String title;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x33000000), blurRadius: 10, offset: Offset(0, 6)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.cairo(
                  color: AttendanceScreen.darkBlue,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Material(
            color: AttendanceScreen.yellow,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onDownload,
              child: const SizedBox(
                width: 44,
                height: 44,
                child: Icon(Icons.download, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// جدول “سجل الحضور اليومي”
class _DailyTable extends StatelessWidget {
  const _DailyTable({required this.rows});
  final List<_DailyRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Color(0x33000000), blurRadius: 10, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        children: [
          _tableHeader(),
          const Divider(height: 1),
          for (final r in rows) _tableRow(r),
        ],
      ),
    );
  }

  Widget _tableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          _cell('اليوم', flex: 2, header: true),
          _cell('التاريخ', flex: 3, header: true),
          _cell('وقت الوصول', flex: 2, header: true),
          _cell('وقت الانصراف', flex: 2, header: true),
        ],
      ),
    );
  }

  Widget _tableRow(_DailyRow r) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              _cell(r.day,   flex: 2),
              _cell(r.date,  flex: 3),
              _cell(
                r.arrive,
                flex: 2,
                trailing: r.lateBadge
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0626A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'متأخر',
                          style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )
                    : null,
              ),
              _cell(r.leave, flex: 2),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }

  Widget _cell(String text, {int flex = 1, bool header = false, Widget? trailing}) {
    return Expanded(
      flex: flex,
      child: Row(
        children: [
          Text(
            text,
            style: GoogleFonts.cairo(
              fontWeight: header ? FontWeight.w800 : FontWeight.w600,
              color: header ? AttendanceScreen.darkBlue : Colors.black87,
              fontSize: header ? 15.5 : 14.5,
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing,
          ],
        ],
      ),
    );
  }
}

class _DailyRow {
  const _DailyRow(this.day, this.date, this.arrive, this.leave, {this.lateBadge = false});
  final String day;
  final String date;
  final String arrive;
  final String leave;
  final bool lateBadge;
}