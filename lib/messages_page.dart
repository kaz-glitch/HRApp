import 'package:flutter/material.dart';
import 'new_message_page.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  String selectedTab = "الكل";

  final List<Map<String, String>> messages = [
    {"name": "المدير", "msg": "يرجى مراجعة التقرير"},
    {"name": "أحمد", "msg": "تم رفع الملف"},
    {"name": "سارة", "msg": "أحتاج مساعدة"},
    {"name": "المدير", "msg": "موعد اجتماع"},
    {"name": "محمد", "msg": "هل يمكنك التوضيح؟"},
  ];

  List<Map<String, String>> get filteredMessages {
    if (selectedTab == "الكل") return messages;
    if (selectedTab == "المدير") {
      return messages.where((m) => m["name"] == "المدير").toList();
    }
    return messages.where((m) => m["name"] != "المدير").toList(); // الفريق
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A4A4A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0E3C4D),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "مراسلة",
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

      body: Column(
        children: [
          // التابات
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: const Color(0xFFE8DDBF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _tab("الكل"),
                _tab("المدير"),
                _tab("الفريق"),
              ],
            ),
          ),

          // القائمة
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              color: const Color(0xFFE8DDBF),
              child: ListView.builder(
                itemCount: filteredMessages.length,
                itemBuilder: (context, index) {
                  final msg = filteredMessages[index];
                  return _messageTile(msg["name"]!, msg["msg"]!);
                },
              ),
            ),
          ),

          // زر جديد
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NewMessagePage()),
                );
              },
              child: Container(
                width: 170,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF8CB9A8),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "رسالة جديدة",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // عنصر قائمة الرسالة
  Widget _messageTile(String name, String message) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                message,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),

          const Spacer(),
          const Text(
            "9:33 م",
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // شكل التاب
  Widget _tab(String title) {
    final bool active = selectedTab == title;

    return InkWell(
      onTap: () {
        setState(() => selectedTab = title);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF8CB9A8) : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: active ? Colors.white : Colors.black87,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

