import 'package:flutter/material.dart';
import 'new_message_page.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

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

          // Tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: const Color(0xFFE8DDBF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _tab("الكل", true),
                _tab("المدير", false),
                _tab("الفريق", false),
              ],
            ),
          ),

          // List
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              color: const Color(0xFFE8DDBF),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return _messageTile();
                },
              ),
            ),
          ),

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

  // عنصر القائمة
  Widget _messageTile() {
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
            children: const [
              Text("اسم الموظف",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("رسالة جديدة",
                  style: TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),

          const Spacer(),
          const Text("9:33 م",
              style: TextStyle(color: Colors.black54, fontSize: 14)),
        ],
      ),
    );
  }

  // التاب
  Widget _tab(String title, bool active) {
    return Container(
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
    );
  }
}
