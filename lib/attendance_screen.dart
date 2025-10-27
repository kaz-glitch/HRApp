import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'monthly_attendance_screen.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  // ألوان
  static const Color darkBlue = Color(0xFF2E4A56);
  static const Color beige = Color(0xFFE8DFC1);
  static const Color mint = Color(0xFFA7C7A1);
  static const Color olive = Color(0xFFBFC977);
  static const Color yellow = Color(0xFFE7C46D);
  static const Color navy = Color(0xFF1F3B46);

  @override
  Widget build(BuildContext context) {
    // نحدّ من تكبير النص ليبقى التخطيط ثابتًا ولا يحدث Overflow عند تكبير الخط من إعدادات الجهاز
    final clampedMediaQuery = MediaQuery.of(context).copyWith(
      textScaler: MediaQuery.of(context).textScaler.clamp(maxScaleFactor: 1.0),
    );

    return MediaQuery(
      data: clampedMediaQuery,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: beige,
          appBar: AppBar(
            backgroundColor: darkBlue,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              tooltip: 'رجوع',
            ),
            title: Text(
              'تسجيل الحضور',
              style: GoogleFonts.cairo(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              children: [
                // البطاقات الكبيرة
                Row(
                  children: [
                    Expanded(
                      child: _LargeStampCard(
                        color: olive,
                        title: 'بصمة الانصراف',
                        date: '2025-10-30',
                        timeLabel: 'الانصراف',
                        time: '12:00AM',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _LargeStampCard(
                        color: mint,
                        title: 'بصمة الحضور',
                        date: '2025-10-30',
                        timeLabel: 'الحضور',
                        time: '8:00AM',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // البطاقات الصغيرة: يسار "السجل الشهري" - وسط "إنذارات" - يمين "غير مسجلة"
                Row(
                  children: [
                    Expanded(
                      child: _SmallCard(
                        bg: navy,
                        title: 'سجل الحضور\nالشهري',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SmallCard(
                        bg: yellow,
                        title: '1\nإنذارات التأخير',
                        textColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SmallCard(
                        bg: olive,
                        title: '0\nالبصمات غير\nمسجلة',
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),
                const _DailyHeaderBar(),
                const SizedBox(height: 12),
                const _DailyTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// بطاقة البصمة الكبيرة
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
    final double cardWidth =
        math.max(MediaQuery.of(context).size.width / 2 - 24, 160);

    return Container(
      width: cardWidth,
      height: 180, // زيدنا الارتفاع لتجنّب أي Overflow
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 6)),
        ],
      ),
      child: Stack(
        children: [
          // النصوص العلوية
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    )),
                const SizedBox(height: 10),
                Text(date,
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
          ),

          // بصمة أسفل اليمين (كما طلبت)
          Positioned(
            right: 14,
            bottom: 12,
            child: Icon(Icons.fingerprint,
                size: 44, color: Colors.white.withOpacity(0.92)),
          ),

          // الوقت أسفل اليسار
          Positioned(
            left: 18,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(timeLabel,
                    style: GoogleFonts.cairo(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
                Text(time,
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// بطاقة صغيرة
class _SmallCard extends StatelessWidget {
  const _SmallCard({
    required this.bg,
    required this.title,
    this.textColor = Colors.white,
  });

  final Color bg;
  final String title;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 102), // أعلى قليلًا لتفادي الشريط
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 6)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          softWrap: true,
          style: GoogleFonts.cairo(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: 16,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}

// الهيدر الأبيض مع زر التحميل على اليسار
class _DailyHeaderBar extends StatelessWidget {
  const _DailyHeaderBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 6)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Material(
            color: AttendanceScreen.yellow,
            borderRadius: BorderRadius.circular(12),
            child: const SizedBox(
              width: 44,
              height: 44,
              child: Icon(Icons.download, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Center(
              child: Text(
                'سجل الحضور اليومي',
                style: GoogleFonts.cairo(
                  color: AttendanceScreen.darkBlue,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 44), // موازن بصري للزر الأصفر
        ],
      ),
    );
  }
}

// جدول اليومي
class _DailyTable extends StatelessWidget {
  const _DailyTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          _header(),
          const Divider(height: 1),
          _row('الأحد', '2025-12-01', '8:00', '12:00'),
          _row('الاثنين', '2025-10-13', '7:50', '12:01'),
          _row('الثلاثاء', '2025-11-08', '8:50', '12:00'),
          _row('الأربعاء', '2025-10-02', '7:57', '11:40'),
          _row('الخميس', '2025-10-02', '7:57', '11:40'),
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: const [
          _Cell('اليوم', header: true),
          _Cell('التاريخ', header: true),
          _Cell('وقت الوصول', header: true),
          _Cell('وقت الانصراف', header: true),
        ],
      ),
    );
  }

  Widget _row(String d, String dt, String a, String l) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          _Cell(d),
          _Cell(dt),
          _Cell(a),
          _Cell(l),
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell(this.text, {this.header = false});
  final String text;
  final bool header;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.cairo(
          fontWeight: header ? FontWeight.w800 : FontWeight.w600,
          fontSize: header ? 15.5 : 14.5,
          color: header ? AttendanceScreen.darkBlue : Colors.black87,
        ),
      ),
    );
  }
}