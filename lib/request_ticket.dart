import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestTicketPage extends StatefulWidget {
  const RequestTicketPage({
    super.key,
    required this.title,
    this.hintText = 'اكتب وصف الطلب:',
  });

  final String title;
  final String hintText;

  @override
  State<RequestTicketPage> createState() => _RequestTicketPageState();
}

class _RequestTicketPageState extends State<RequestTicketPage> {
  // الألوان
  static const Color darkBlue = Color(0xFF2E4A56);
  static const Color beige = Color(0xFFE8DFC1);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color inputBg = Color(0xFFF1F1F1);
  static const Color btnGreen = Color(0xFF86B29A);

  static const double radiusCard = 20;
  static const double radiusBtn = 16;

  final _formKey = GlobalKey<FormState>();
  final _descCtrl = TextEditingController();

  @override
  void dispose() {
    _descCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم إرسال الطلب بنجاح ✅', style: GoogleFonts.cairo()),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.of(context).maybePop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: beige,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 28),
          child: Column(
            children: [
              // ======= الهيدر =======
              Container(
                height: 120,
                decoration: const BoxDecoration(
                  color: darkBlue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // سهم الرجوع — في الزاوية اليسرى
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
                    // عنوان الصفحة في الوسط
                    Center(
                      child: Text(
                        widget.title,
                        style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // ======= البطاقة =======
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cardWhite,
                          borderRadius: BorderRadius.circular(radiusCard),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              widget.hintText,
                              style: GoogleFonts.cairo(
                                color: darkBlue,
                                fontWeight: FontWeight.w800,
                                fontSize: 19,
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _descCtrl,
                              minLines: 8,
                              maxLines: 12,
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                hintText: 'اكتب التفاصيل هنا...',
                                hintStyle:
                                    GoogleFonts.cairo(color: Colors.black38),
                                filled: true,
                                fillColor: inputBg,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: darkBlue, width: 1.5),
                                ),
                              ),
                              validator: (v) {
                                final text = (v ?? '').trim();
                                if (text.isEmpty) return 'هذا الحقل مطلوب';
                                if (text.length < 10) {
                                  return 'يرجى كتابة وصف لا يقل عن 10 أحرف';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ======= زر الإرسال =======
                      SizedBox(
                        width: 220,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: btnGreen,
                            foregroundColor: Colors.white,
                            elevation: 4,
                            padding:
                                const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(radiusBtn),
                            ),
                          ),
                          child: Text(
                            'ارسال',
                            style: GoogleFonts.cairo(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
