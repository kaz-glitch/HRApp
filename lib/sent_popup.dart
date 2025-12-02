import 'package:flutter/material.dart';

class SentPopup extends StatelessWidget {
  const SentPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        width: 220,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle,
                size: 45, color: Color(0xFF8CB9A8)),
            const SizedBox(height: 15),
            const Text(
              "تم الإرسال",
              style: TextStyle(
                color: Color(0xFF0E3C4D),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            IconButton(
              icon: const Icon(Icons.close, size: 25),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
