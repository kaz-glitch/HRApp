import 'package:flutter/material.dart';
import 'forgot_step3.dart';

class ForgotPasswordStep2 extends StatefulWidget {
  const ForgotPasswordStep2({super.key});

  @override
  State<ForgotPasswordStep2> createState() => _ForgotPasswordStep2State();
}

class _ForgotPasswordStep2State extends State<ForgotPasswordStep2> {
  final TextEditingController _codeController = TextEditingController();

  void _checkCode() {
    if (_codeController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('خطأ'),
          content: Text('يرجى إدخال الرمز.'),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ForgotPasswordStep3()),
      );
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
          'إدخال الرمز',
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
              const Text('أدخل الرمز المرسل إلى بريدك', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'الرمز',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: _checkCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFCC33),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text('التالي'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
