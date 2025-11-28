import 'package:flutter/material.dart';
//import 'login_screen.dart';

class ForgotPasswordStep3 extends StatefulWidget {
  const ForgotPasswordStep3({super.key});

  @override
  State<ForgotPasswordStep3> createState() => _ForgotPasswordStep3State();
}

class _ForgotPasswordStep3State extends State<ForgotPasswordStep3> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _resetPassword() {
    String newPass = _newPasswordController.text;
    String confirm = _confirmPasswordController.text;

    if (newPass.isEmpty || confirm.isEmpty) {
      _showDialog('خطأ في الإدخال', 'يرجى إدخال جميع الحقول.', false);
    } else if (newPass != confirm) {
      _showDialog('كلمة المرور غير متطابقة', 'تأكد من كتابة كلمتي المرور بشكل متطابق.', false);
    } else {
      _showDialog('تم التغيير', 'تمت إعادة كلمة المرور بنجاح.', true);
    }
  }

  void _showDialog(String title, String message, bool success) {
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
              Icon(success ? Icons.check_circle : Icons.error_outline,
                  color: success ? Colors.green : Colors.red, size: 70),
              const SizedBox(height: 15),
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (success) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                  //  );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1D3557)),
                child: const Text('موافق'),
              ),
            ],
          ),
        ),
      ),
    );
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
          'كلمة المرور الجديدة',
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
              const Text('كلمة المرور الجديدة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'كلمة المرور الجديدة',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'تأكيد كلمة المرور الجديدة',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: _resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFCC33),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text('إعادة كلمة المرور'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
