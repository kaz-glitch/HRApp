import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ألوان وهوية الواجهة
const Color _darkBlue = Color(0xFF2E4A56);
const Color _beige    = Color(0xFFE8DFC1);
const Color _navyCard = Color(0xFF1F3B46);
const Color _olive    = Color(0xFFBFC977);
const Color _mint     = Color(0xFFA7C7A1);
const double _panelRadius = 24;
const double _cardRadius  = 18;

/// استدعِ هذه الدالة لعرض الـ Overlay فوق أي صفحة (يفضّل من أيقونة اللمبة)
Future<void> showSystemGuide(BuildContext context) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'SystemGuideOverlay',
    barrierColor: Colors.black.withOpacity(0.45),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionDuration: const Duration(milliseconds: 280),
    transitionBuilder: (context, animation, secondary, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return Directionality(
        textDirection: TextDirection.rtl,
        child: FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1).animate(curved),
            child: const SystemGuideDialog(),
          ),
        ),
      );
    },
  );
}

/// الحاوية الرئيسية للّوحة (البانل) – قابلة للتمرير مع مقاس متجاوب
class SystemGuideDialog extends StatelessWidget {
  const SystemGuideDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final maxWidth = width > 600 ? 560.0 : width - 32; // هوامش 16 يمين ويسار

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: maxWidth,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _beige,
            borderRadius: BorderRadius.circular(_panelRadius),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 16)],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_panelRadius),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ====== الهيدر ======
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 12, left: 8, right: 8),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: Text(
                            'دليل النظام',
                            style: GoogleFonts.cairo(
                              color: _darkBlue,
                              fontWeight: FontWeight.w800,
                              fontSize: 26,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: _darkBlue, width: 2),
                                shape: BoxShape.circle,
                                boxShadow: const [
                                  BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
                                ],
                              ),
                              child: const Icon(Icons.close, color: _darkBlue, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Color(0x332E4A56), height: 20),

                  // ====== البطاقات الثلاث ======
                  const SizedBox(height: 8),
                  RoleCard(
                    bg: _navyCard,
                    leadingIcon: Icons.emoji_emotions,
                    title: 'تصفح كموظف',
                    titleColor: Colors.white,
                    textColor: Colors.white,
                    bullets: const [
                      'عرض البيانات الشخصية',
                      'تقديم طلبات الاجازة',
                      'تسجيل الحضور و الانصراف',
                      'عرض التقييم الشهري',
                      'عرض كشف راتب الموظف',
                    ],
                    trailingArrowColor: Colors.white70,
                    leadingBg: Colors.greenAccent,
                  ),
                  const SizedBox(height: 12),
                  RoleCard(
                    bg: _olive,
                    leadingIcon: Icons.view_list,
                    title: 'تصفح كمدير',
                    titleColor: const Color(0xFFF9F9F9),
                    textColor: _darkBlue.withOpacity(.95),
                    bullets: const [
                      'عرض بيانات الموظفين (كشف الرواتب، إجازات، سجل الحضور والانصراف)',
                      'الموافقة والرفض على طلبات الاجازة',
                      'عرض البيانات الشخصية',
                    ],
                    trailingArrowColor: Colors.white70,
                    leadingBg: Colors.white70,
                  ),
                  const SizedBox(height: 12),
                  RoleCard(
                    bg: _mint,
                    leadingIcon: Icons.lock,
                    title: 'تصفح كمسؤول',
                    titleColor: const Color(0xFFF9F9F9),
                    textColor: _darkBlue.withOpacity(.95),
                    bullets: const [
                      'إدارة حسابات المستخدمين (إضافة، تعديل، حذف)',
                      'تحديد الصلاحيات لكل مستخدم',
                    ],
                    trailingArrowColor: Colors.white70,
                    leadingBg: Colors.white70,
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

/// بطاقة دور (موظف/مدير/مسؤول)
class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.bg,
    required this.leadingIcon,
    required this.title,
    required this.bullets,
    this.titleColor,
    this.textColor,
    this.trailingArrowColor,
    this.leadingBg,
  });

  final Color bg;
  final IconData leadingIcon;
  final String title;
  final List<String> bullets;
  final Color? titleColor;
  final Color? textColor;
  final Color? trailingArrowColor;
  final Color? leadingBg;

  @override
  Widget build(BuildContext context) {
    final Color tColor = textColor ?? Colors.white;
    final Color ttlColor = titleColor ?? Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(_cardRadius),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // سهم يسار (في RTL يكون على اليسار بصريًا)
          Icon(Icons.arrow_right_alt, color: trailingArrowColor ?? Colors.white70, size: 28),
          const SizedBox(width: 8),
          // أيقونة دائرية
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: (leadingBg ?? Colors.white).withOpacity(.85),
              shape: BoxShape.circle,
            ),
            child: Icon(leadingIcon, color: _darkBlue, size: 20),
          ),
          const SizedBox(width: 12),
          // النصوص (عنوان + نقاط)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.cairo(
                    color: ttlColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                for (final item in bullets) ...[
                  BulletRow(item, color: tColor),
                  const SizedBox(height: 6),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// سطر بنقطة تعداد
class BulletRow extends StatelessWidget {
  const BulletRow(this.text, {super.key, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? Colors.white;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.right,
            style: GoogleFonts.cairo(
              color: c,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.3,
            ),
          ),
        ),
        Icon(Icons.check, color: c.withOpacity(.9), size: 18),
        const SizedBox(width: 6),
      ],
    );
  }
}
