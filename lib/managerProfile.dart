import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'system_guide_overlay.dart';
import 'request_ticket.dart';

/// صفحة حساب المدير
class ManagerProfilePage extends StatelessWidget {
  const ManagerProfilePage({super.key});

  static const Color darkBlue = Color(0xFF2E4A56);
  static const Color beige = Color(0xFFE8DFC1);
  static const Color yellowBtn = Color(0xFFE7C46D);
  static const Color greenBtn = Color(0xFF86B29A);
  static const double _radius = 18;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: beige,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),

              // ======= الهيدر =======
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Container(
                  height: 220,
                  color: darkBlue,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 12,
                        top: 12,
                        child: IconButton(
                          onPressed: () => Navigator.of(context).maybePop(),
                          icon: const Icon(Icons.chevron_right,
                              color: Colors.white, size: 32),
                          tooltip: 'رجوع',
                        ),
                      ),
                      Positioned(
                        right: 16,
                        top: 16,
                        child: IconButton(
                          icon: const Icon(Icons.lightbulb,
                              color: Colors.amberAccent, size: 28),
                          tooltip: 'دليل النظام',
                          onPressed: () => showSystemGuide(context),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              color: Colors.white
                            ),
                            child: const Icon(Icons.person,
                                color: Colors.white, size: 70),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'اسم المدير',
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              SectionCard(
                title: 'معلومات أساسية',
                labels: const [
                  'اسم المدير:',
                  'رقم الهاتف:',
                  'البريد الالكتروني:',
                  'تاريخ الميلاد:',
                  'الجنسية:',
                ],
              ),
              const SizedBox(height: 16),
              SectionCard(
                title: 'معلومات وظيفية',
                labels: const [
                  'المسمى الوظيفي:',
                  'تاريخ التعيين:',
                  'القسم:',
                  'الراتب الاساسي:',
                  'صلاحيات المدير:',
                ],
              ),

              const SizedBox(height: 18),

              Row(
                textDirection: TextDirection.ltr,
                children: [
                  Expanded(
                    child: _ActionButton(
                      color: yellowBtn,
                      text: 'تعديل بيانات',
                      icon: Icons.edit,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const RequestTicketPage(
                              title: 'تعديل البيانات',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      color: greenBtn,
                      text: 'تغيير كلمة المرور',
                      icon: Icons.lock,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const RequestTicketPage(
                              title: 'تغيير كلمة المرور',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======= نفس الـ SectionCard و LabelRow و _ActionButton كما هي =======
class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.title, required this.labels});

  final String title;
  final List<String> labels;
  static const Color darkBlue = ManagerProfilePage.darkBlue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ManagerProfilePage._radius),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              title,
              style: GoogleFonts.cairo(
                color: darkBlue,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 8),
          for (final label in labels) ...[
            LabelRow(text: label),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class LabelRow extends StatelessWidget {
  const LabelRow({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: GoogleFonts.cairo(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          height: 1.25,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.color, required this.text, required this.icon, this.onPressed});

  final Color color;
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        text,
        style: GoogleFonts.cairo(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 15.5,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ManagerProfilePage._radius - 2),
        ),
        elevation: 3,
      ),
    );
  }
}
