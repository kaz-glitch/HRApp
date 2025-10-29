import 'package:adminpages_/admin_home.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

// تعريف اسم خط القاهرة لسهولة استخدامه
const String kCairoFontFamily = 'Cairo'; 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page Design',
      // يفضل وضع الخط الافتراضي هنا ليطبق على كل التطبيق
      theme: ThemeData(fontFamily: kCairoFontFamily),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // الألوان المستخدمة مستوحاة من الصورة
    const Color backgroundColor = Color(0xFFF4EDE2); // لون الخلفية الفاتح (البيج/الكريمي)
    const Color primaryColor = Color(0xFF334A52); // لون النص والأيقونات الداكن (الأزرق الداكن/التركواز)
    const Color buttonColor = Color(0xFFF7C852); // لون الزر الأصفر/الذهبي

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // الجزء العلوي الذي يحتوي على الشعار واسم الشركة
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 40, bottom: 30),
                child: Column(
                  children: <Widget>[
                    // أيقونة الكتاب/الشعار
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryColor.withOpacity(0.5), width: 2),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: const Icon( // تم تغيير Icon إلى const Icon
                        Icons.book, // استخدام أيقونة كتاب مشابهة
                        size: 60,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // اسم الشركة
                    const Text(
                      'اسم الشركة',
                      style: TextStyle(
                        fontFamily: kCairoFontFamily, // **تم التأكد من وجود الخط هنا**
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textDirection: TextDirection.rtl, // لضمان عرض النص العربي بشكل صحيح
                    ),
                  ],
                ),
              ),

              // بطاقة تسجيل الدخول (الخلفية البيضاء ذات الحواف المستديرة)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    // أيقونة المستخدم وعنوان "تسجيل الدخول"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          size: 35,
                          color: primaryColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        fontFamily: kCairoFontFamily, // **تم التأكد من وجود الخط هنا**
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 30),

                    // تسمية "الإيميل"
                    const Text(
                      'الإيميل',
                      style: TextStyle(
                        fontFamily: kCairoFontFamily, // **تم التأكد من وجود الخط هنا**
                        fontSize: 14,
                        color: Color.fromARGB(255, 158, 188, 159), // لون مختلف كما في الصورة
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 8),

                    // حقل إدخال الإيميل
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        textAlign: TextAlign.right, // لمحاذاة النص داخل الحقل لليمين
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'example@outlook.com',
                          hintStyle: TextStyle(color: Colors.grey.shade500, fontFamily: kCairoFontFamily), // **تم التأكد من وجود الخط هنا**
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Icon(Icons.person, color: Colors.grey),
                          ),
                        ),
                        style: const TextStyle(fontFamily: kCairoFontFamily), // **تم إضافة الخط لنمط الإدخال**
                      ),
                    ),

                    const SizedBox(height: 40),

                    // زر تسجيل الدخول
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                             Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const AdminHome()),
                           (Route<dynamic> route) => false, // هذه الدالة ترجع 'false' لإزالة جميع المسارات السابقة
                            );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: TextDirection.rtl, // لعرض السهم على اليسار والنص على اليمين
                          children: const <Widget>[
                            Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontFamily: kCairoFontFamily, // **تم التأكد من وجود الخط هنا**
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // لون النص داخل الزر (أسود)
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}