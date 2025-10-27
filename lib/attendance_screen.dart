import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'monthly_attendance_screen.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});
  static const Color darkBlue = Color(0xFF2E4A56);
  static const Color beige = Color(0xFFE8DFC1);
  static const Color mint = Color(0xFFA7C7A1);   // الحضور
  static const Color olive = Color(0xFFBFC977);  // الانصراف
  static const Color yellow = Color(0xFFE7C46D);
  static const Color navy = Color(0xFF1F3B46);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // حالة عمل افتراضية (دوام 8–12)
  final DateTime _today = DateTime.now();
  final String _shiftLabel = '08:00 - 12:00';

  // مؤقّت العمل (محاكاة)
  Timer? _ticker;
  Duration _elapsed = Duration.zero;
  bool _isRunning = false;

  // محاكاة فحص الموقع وبصمة الوجه (دائمًا ناجحان إلا إذا غيّرت القيم يدويًا)
  Future<bool> _mockIsInsideWorkArea() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true; // غيّرها إلى false لاختبار رسالة "الهاتف بعيد عن موقع العمل"
  }

  Future<bool> _mockFaceAuth() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true; // غيّرها إلى false لاختبار فشل البصمة
  }

  void _startTimer() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed += const Duration(seconds: 1));
    });
    setState(() => _isRunning = true);
  }

  void _stopTimer() {
    _ticker?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  String _fmt(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  // يفتح أوفرلاي الحضور/الانصراف
  void _openStampModal({required bool isCheckIn}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'modal',
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (ctx, a1, a2) {
        return SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: _StampOverlay(
              dateTitle:
                  '${_weekDayAr(_today.weekday)} - ${_today.year} ${_monthAr(_today.month)} ${_today.day}',
              shiftLabel: _shiftLabel,
              isCheckIn: isCheckIn,
              // الحالة الحالية للمؤقّت تُرسل للأوفرلاي لكي يرسم الدائرة خضراء عند الانصراف
              isRunning: _isRunning,
              elapsed: _elapsed,
              onCheckIn: () async {
                final inside = await _mockIsInsideWorkArea();
                if (!inside) return const _StampResult.outOfZone();
                final ok = await _mockFaceAuth();
                if (!ok) return const _StampResult.failed();
                _startTimer();
                return const _StampResult.success();
              },
              onCheckOut: () async {
                final inside = await _mockIsInsideWorkArea();
                if (!inside) return const _StampResult.outOfZone();
                final ok = await _mockFaceAuth();
                if (!ok) return const _StampResult.failed();
                _stopTimer();
                return const _StampResult.success();
              },
            ),
          ),
        );
      },
      transitionBuilder: (ctx, anim, _, child) {
        return FadeTransition(opacity: anim, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // تثبيت تكبير النص لتفادي overflow
    final clamped = MediaQuery.of(context)
        .copyWith(textScaler: MediaQuery.of(context).textScaler.clamp(maxScaleFactor: 1.0));

    return MediaQuery(
      data: clamped,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AttendanceScreen.beige,
          appBar: AppBar(
            backgroundColor: AttendanceScreen.darkBlue,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              tooltip: 'رجوع',
            ),
            title: Text('تسجيل الحضور',
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                )),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              children: [
                // البطاقات الكبيرة (انصراف يسار – حضور يمين)
                Row(
                  children: [
                    Expanded(
                      child: _LargeStampCard(
                        color: AttendanceScreen.olive,
                        title: 'بصمة الانصراف',
                        date: '2025-10-30',
                        timeLabel: 'الانصراف',
                        time: '12:00AM',
                        onTap: () => _openStampModal(isCheckIn: false),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _LargeStampCard(
                        color: AttendanceScreen.mint,
                        title: 'بصمة الحضور',
                        date: '2025-10-30',
                        timeLabel: 'الحضور',
                        time: '8:00AM',
                        onTap: () => _openStampModal(isCheckIn: true),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // البطاقات الصغيرة
                Row(
                  children: [
                    Expanded(
                      child: _SmallCard(
                        bg: AttendanceScreen.navy,
                        title: 'سجل الحضور\nالشهري',
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const MonthlyAttendanceScreen()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: _SmallCard(
                        bg: AttendanceScreen.yellow,
                        title: '1\nإنذارات التأخير',
                        textColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: _SmallCard(
                        bg: AttendanceScreen.olive,
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

  String _weekDayAr(int w) {
    const m = {
      1: 'الإثنين',
      2: 'الثلاثاء',
      3: 'الأربعاء',
      4: 'الخميس',
      5: 'الجمعة',
      6: 'السبت',
      7: 'الأحد',
    };
    return m[w] ?? '';
  }

  String _monthAr(int m) {
    const names = [
      '',
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
    ];
    return names[m];
  }
}

/// نتيجة زر التحضير/الانصراف (للتحكم برسالة الخطأ والزر)
class _StampResult {
  final bool ok;
  final bool outOfZone;
  final bool failedAuth;
  const _StampResult._(this.ok, this.outOfZone, this.failedAuth);
  const _StampResult.success() : this._(true, false, false);
  const _StampResult.outOfZone() : this._(false, true, false);
  const _StampResult.failed() : this._(false, false, true);
}

/// أوفرلاي البصمة
class _StampOverlay extends StatefulWidget {
  const _StampOverlay({
    required this.dateTitle,
    required this.shiftLabel,
    required this.isCheckIn,
    required this.isRunning,
    required this.elapsed,
    required this.onCheckIn,
    required this.onCheckOut,
  });

  final String dateTitle;
  final String shiftLabel;
  final bool isCheckIn;
  final bool isRunning;
  final Duration elapsed;
  final Future<_StampResult> Function() onCheckIn;
  final Future<_StampResult> Function() onCheckOut;

  @override
  State<_StampOverlay> createState() => _StampOverlayState();
}

class _StampOverlayState extends State<_StampOverlay> {
  String? _errorText; // null يعني لا يوجد خطأ
  bool _processing = false;
  Duration _localElapsed = Duration.zero;
  Timer? _localTicker;

  @override
  void initState() {
    super.initState();
    // ننسخ الزمن الحالي من الشاشة الأساسية
    _localElapsed = widget.elapsed;
    if (widget.isRunning) {
      _localTicker = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() => _localElapsed += const Duration(seconds: 1));
      });
    }
  }

  @override
  void dispose() {
    _localTicker?.cancel();
    super.dispose();
  }

  String _fmt(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final circleColor = (!widget.isCheckIn && !widget.isRunning)
        ? Colors.grey.withOpacity(.35)
        : (widget.isCheckIn
            ? Colors.white.withOpacity(.35)
            : Colors.green.withOpacity(.8));

    return Material(
      color: Colors.black54,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 460,
            maxHeight: size.height * .9,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              color: AttendanceScreen.darkBlue,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // شريط علوي
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Colors.white),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              widget.dateTitle,
                              style: GoogleFonts.cairo(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 48), // موازنة لزر الإغلاق
                      ],
                    ),
                  ),

                  // دائرة الوقت
                  SizedBox(
                    height: 220,
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: circleColor, width: 10),
                            ),
                          ),
                          Text(
                            _fmt(_localElapsed),
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // فترة العمل
                  Text('فترة العمل',
                      style: GoogleFonts.cairo(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 6),
                  Text(widget.shiftLabel,
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      )),
                  const SizedBox(height: 16),

                  // البطاقة البيضاء السفلية
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F3F5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('دوام منتظم',
                                          style: GoogleFonts.cairo(
                                              color: AttendanceScreen.darkBlue,
                                              fontWeight: FontWeight.w700)),
                                      Text(
                                        _fmt(Duration.zero),
                                        style: GoogleFonts.cairo(
                                            color: AttendanceScreen.darkBlue,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('تأخر في الحضور',
                                          style: GoogleFonts.cairo(
                                              color: AttendanceScreen.darkBlue,
                                              fontWeight: FontWeight.w700)),
                                      Text(
                                        _fmt(Duration.zero),
                                        style: GoogleFonts.cairo(
                                            color: AttendanceScreen.darkBlue,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1),

                          const SizedBox(height: 14),

                          // زر تحضير/انصراف
                          _ActionButton(
                            label: widget.isCheckIn ? 'تحضير' : 'انصراف',
                            icon: widget.isCheckIn ? Icons.login : Icons.logout,
                            enabled: !_processing,
                            faded: _errorText != null,
                            onTap: () async {
                              setState(() {
                                _processing = true;
                                _errorText = null;
                              });
                              final result = widget.isCheckIn
                                  ? await widget.onCheckIn()
                                  : await widget.onCheckOut();

                              if (!mounted) return;
                              setState(() => _processing = false);

                              if (result.outOfZone) {
                                setState(() => _errorText = 'الهاتف بعيد عن موقع العمل');
                                return;
                              }
                              if (result.failedAuth) {
                                setState(() => _errorText = 'فشلت بصمة الوجه، حاول مرة أخرى');
                                return;
                              }
                              // نجاح: أغلق النافذة
                              Navigator.pop(context);
                            },
                          ),

                          if (_errorText != null) ...[
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.close, color: Colors.red.shade400),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      _errorText!,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.cairo(
                                        color: Colors.red.shade400,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// بطاقة كبيرة (مع onTap)
class _LargeStampCard extends StatelessWidget {
  const _LargeStampCard({
    required this.color,
    required this.title,
    required this.date,
    required this.timeLabel,
    required this.time,
    this.onTap,
  });

  final Color color;
  final String title;
  final String date;
  final String timeLabel;
  final String time;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final double cardWidth =
        math.max(MediaQuery.of(context).size.width / 2 - 24, 160);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: 180,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 6)),
          ],
        ),
        child: Stack(
          children: [
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
            // أيقونة البصمة أسفل يمين
            Positioned(
              right: 14,
              bottom: 12,
              child: Icon(Icons.fingerprint,
                  size: 44, color: Colors.white.withOpacity(0.92)),
            ),
            // الوقت أسفل يسار
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
      ),
    );
  }
}

// بطاقة صغيرة عامة
class _SmallCard extends StatelessWidget {
  const _SmallCard({
    required this.bg,
    required this.title,
    this.textColor = Colors.white,
    this.onTap,
  });

  final Color bg;
  final String title;
  final Color textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      constraints: const BoxConstraints(minHeight: 102),
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
          style: GoogleFonts.cairo(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: 16,
            height: 1.2,
          ),
        ),
      ),
    );

    return onTap == null
        ? content
        : InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: content,
          );
  }
}

// الهيدر الأبيض "سجل الحضور اليومي"
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
          const SizedBox(width: 44),
        ],
      ),
    );
  }
}

// جدول مبسط (ثابت)
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
          _row('الإثنين', '2025-10-13', '7:50', '12:01'),
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

/// زر كبير (مربع) داخل بطاقة الأوفرلاي
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.enabled,
    required this.faded,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool enabled;
  final bool faded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final box = Container(
      width: 170,
      height: 170,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(faded ? .6 : 1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: const Color(0xFFC9CF8B),
            child: Icon(icon, color: AttendanceScreen.navy, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: GoogleFonts.cairo(
              color: AttendanceScreen.navy,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );

    if (!enabled) return box;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: box,
    );
  }
}