import 'package:flutter/material.dart';
import 'confirm_page.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: ConfirmPage(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const bgCard = Color(0xFFF6EFD3);
    const yellowBtn = Color(0xFFF2C94C);
    const tealText = Color(0xFF2B5659);

    return Scaffold(
      backgroundColor: const Color(0xFFDDD6B6),
      body: SafeArea(
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            color: bgCard,
            elevation: 6,
            child: SizedBox(
              width: 320,
              height: 330,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 6),
                    Text(
                      'رمز OTP',
                      style: TextStyle(
                        color: tealText,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),

                    Form(
                      key: _formKey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _otpController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.left,
                                obscureText: _obscure,
                                maxLength: 6,
                                style: const TextStyle(letterSpacing: 4),
                                decoration: InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  hintText: 'OTP',
                                  hintStyle: TextStyle(color: tealText.withOpacity(0.4)),
                                ),
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty) {
                                    return 'أدخل رمز التحقق';
                                  }
                                  if (v.trim().length < 4) {
                                    return 'الرمز قصير';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () => setState(() => _obscure = !_obscure),
                              icon: Icon(
                                _obscure ? Icons.lock : Icons.lock_open,
                                color: tealText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),

                    ElevatedButton(
                      onPressed: _onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellowBtn,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('تأكيد', style: TextStyle(color: Colors.black87, fontSize: 18)),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black87),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
