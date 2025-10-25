import 'package:flutter/material.dart';
import 'forgot_password_step2.dart';

class ForgotPasswordStep1 extends StatefulWidget {
  const ForgotPasswordStep1({super.key});

  @override
  State<ForgotPasswordStep1> createState() => _ForgotPasswordStep1State();
}

class _ForgotPasswordStep1State extends State<ForgotPasswordStep1> {
  final TextEditingController _emailController = TextEditingController();

  void _showDialog({
    required String title,
    required String message,
    required IconData icon,
    required Color color,
  }) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color(0xFFF1E5C9),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 70),
              const SizedBox(height: 15),
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1D3557)),
                child: const Text('موافق'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendCode() {
    String email = _emailController.text.trim();

    // ✅ تحقق من صحة الإيميل
    bool isValidEmail = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email);

    if (email.isEmpty) {
      _showDialog(
        title: 'تنبيه',
        message: 'يرجى إدخال البريد الإلكتروني.',
        icon: Icons.warning_amber_rounded,
        color: Colors.orange,
      );
    } else if (!isValidEmail) {
      _showDialog(
        title: 'خطأ في البريد الإلكتروني',
        message: 'الرجاء إدخال بريد إلكتروني صحيح.',
        icon: Icons.error_outline,
        color: Colors.red,
      );
    } else {
      _showDialog(
        title: 'تم الإرسال',
        message: 'تم إرسال الرمز إلى بريدك الإلكتروني.',
        icon: Icons.check_circle,
        color: Colors.green,
      );

      // بعد ثانيتين يروح للصفحة الثانية
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForgotPasswordStep2()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1E5C9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'نسيت كلمة المرور',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF1E5C9),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('أدخل بريدك الإلكتروني', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: _sendCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFCC33),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text('إرسال الرمز'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
