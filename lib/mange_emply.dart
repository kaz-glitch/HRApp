import 'package:flutter/material.dart';
import 'edit.dart';
import 'add_emply.dart';
// تعريف الألوان والثوابت
const Color primaryBlue = Color(0xFF334A52); // لون الشريط العلوي
const Color backgroundColor = Color(0xFFF4EDE2); // لون الخلفية (بيج فاتح)
const Color greenButtonColor = Color(0xFF7CAF4D); // لون زر "تحرير" و "إضافة موظف"
const Color cardColor = Colors.white; // لون البطاقة البيضاء
const String kCairoFontFamily = 'Cairo'; // تعريف اسم الخط

class UsersManagementScreen extends StatelessWidget {
  const UsersManagementScreen({super.key});

  // ويدجت لبناء عنصر قائمة المستخدم - تم تعديلها لتستقبل index
  Widget _buildUserListItem(BuildContext context, int index, int totalCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), 
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: [
              // حقل الاسم
              const Expanded(
                flex: 3,
                child: Text(
                  'اسم الموظف', 
                  style: TextStyle(color: Colors.black87, fontFamily: kCairoFontFamily), // **تم التعديل هنا**
                  textAlign: TextAlign.right, 
                  textDirection: TextDirection.rtl, 
                  overflow: TextOverflow.ellipsis
                ),
              ),
              // حقل الايميل
              const Expanded(
                flex: 3,
                child: Text(
                  'Example@outlook.com', 
                  style: TextStyle(color: Colors.black87, fontFamily: kCairoFontFamily), // **تم التعديل هنا**
                  textAlign: TextAlign.right, 
                  overflow: TextOverflow.ellipsis
                ),
              ),
              // حقل القسم
              const Expanded(
                flex: 2,
                child: Text(
                  'قسم', 
                  style: TextStyle(color: Colors.black87, fontFamily: kCairoFontFamily), // **تم التعديل هنا**
                  textAlign: TextAlign.right, 
                  textDirection: TextDirection.rtl
                ),
              ),
              // زر "تحرير"
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EditEmployeeScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenButtonColor.withOpacity(0.8),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'تحرير', 
                        style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: kCairoFontFamily) // **تم التعديل هنا**
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // خط فاصل سفلي - تم تعديل الشرط هنا
          if (index < totalCount - 1)
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Divider(height: 1, color: Colors.black12),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const int userCount = 10; // تعريف عدد العناصر ليكون واضحاً

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        toolbarHeight: 100,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 28), onPressed: () {Navigator.of(context).pop();}),
        title: const Text(
          'إدارة المستخدمين', 
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: kCairoFontFamily), // **تم التعديل هنا**
          textDirection: TextDirection.rtl
        ),
        centerTitle: true,
      ),
      
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // زر "إضافة موظف"
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const AddEmployeeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: greenButtonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 3),
                    icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
                    label: const Text(
                      'إضافة موظف', 
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: kCairoFontFamily), // **تم التعديل هنا**
                      textDirection: TextDirection.rtl
                    ),
                  ),
                ),
              ),
            ),
            
            // البطاقة البيضاء الكبيرة للقائمة
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 5))],
                ),
                child: Column(
                  children: [
                    // جدول / قائمة الرؤوس (Header Row)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textDirection: TextDirection.rtl,
                        children: const [
                          Expanded(flex: 3, child: Text('الاسم', style: TextStyle(fontWeight: FontWeight.bold, color: primaryBlue, fontSize: 16, fontFamily: kCairoFontFamily), textAlign: TextAlign.right)), // **تم التعديل هنا**
                          Expanded(flex: 3, child: Text('الايميل', style: TextStyle(fontWeight: FontWeight.bold, color: primaryBlue, fontSize: 16, fontFamily: kCairoFontFamily), textAlign: TextAlign.right)), // **تم التعديل هنا**
                          Expanded(flex: 2, child: Text('القسم', style: TextStyle(fontWeight: FontWeight.bold, color: primaryBlue, fontSize: 16, fontFamily: kCairoFontFamily), textAlign: TextAlign.right)), // **تم التعديل هنا**
                          Expanded(flex: 2, child: SizedBox()),
                        ],
                      ),
                    ),
                    // خط فاصل تحت الرؤوس
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Container(height: 2, color: Colors.black54),
                    ),

                    // قائمة المستخدمين (User List)
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero, 
                        itemCount: userCount, 
                        itemBuilder: (context, index) {
                          // **استدعاء الدالة مع تمرير index و userCount**
                          return _buildUserListItem(context, index, userCount);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}