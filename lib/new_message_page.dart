import 'package:flutter/material.dart';
import 'sent_popup.dart';

class NewMessagePage extends StatefulWidget {
  const NewMessagePage({super.key});

  @override
  State<NewMessagePage> createState() => _NewMessagePageState();
}

class _NewMessagePageState extends State<NewMessagePage> {
  String sendTo = "all";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A4A4A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0E3C4D),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "رسالة جديدة",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Container(
        color: const Color(0xFFE8DDBF),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "إرسال إلى:",
              style: TextStyle(
                color: Color(0xFF0E3C4D),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Row(
              children: [
                _radioOption("مدير قسم", "manager"),
                _radioOption("موظف", "employee"),
                _radioOption("الكل", "all"),
              ],
            ),

            const SizedBox(height: 10),

            // مربع كتابة الرسالة
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: const TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "اكتب رسالتك...",
                    hintTextDirection: TextDirection.rtl,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // زر الإرسال
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => const SentPopup(),
                );
              },
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xFF8CB9A8),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "إرسال",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // خيارات الراديو
  Widget _radioOption(String text, String value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: sendTo,
          onChanged: (v) {
            setState(() => sendTo = v.toString());
          },
        ),
        Text(text),
      ],
    );
  }
}
