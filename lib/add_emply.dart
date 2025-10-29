import 'package:flutter/material.dart';

// تعريف الألوان المشتركة (كما في الشاشات السابقة)
const Color primaryBlue = Color(0xFF334A52); // لون الشريط العلوي
const Color backgroundColor = Color(0xFFF4EDE2); // لون الخلفية (البيج الفاتح)
const Color greenButtonColor = Color(0xFF7CAF4D); // لون زر "إضافة"
const Color cardColor = Colors.white; // لون خلفية البطاقة
// تعريف اسم خط القاهرة لسهولة استخدامه
const String kCairoFontFamily = 'Cairo'; 

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  // ويدجت مساعدة لبناء حقل الإدخال مع التسمية
  Widget _buildInputField({
    required String label,
    required String hintText,
    required TextInputType keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: kCairoFontFamily, // **تم التعديل هنا**
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: greenButtonColor, // لون التسمية أخضر
          ),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 8),
        TextFormField(
          textAlign: TextAlign.right,
          keyboardType: keyboardType,
          // لا يوجد initialValue لأن هذا نموذج إضافة
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontFamily: kCairoFontFamily), // **تم التعديل هنا**
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey, width: 1.0), // حدود رمادية خفيفة
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: primaryBlue, width: 1.5),
            ),
          ),
          style: const TextStyle(fontFamily: kCairoFontFamily), // **تم التعديل هنا**
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      
      // الشريط العلوي (AppBar)
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        toolbarHeight: 80,
        
        // زر الرجوع
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 28),
          onPressed: () {
            Navigator.of(context).pop(); // الرجوع إلى شاشة إدارة المستخدمين
          },
        ),
        
        // عنوان الصفحة
        title: const Text(
          'اضافة موظفين',
          style: TextStyle(
            fontFamily: kCairoFontFamily, // **تم التعديل هنا**
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
           
          ),
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true, // توسيط العنوان
      ),
      
      // محتوى الصفحة
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // بطاقة النموذج
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    
                    // حقل الاسم
                    _buildInputField(
                      label: 'أسم',
                      hintText: 'اسم الموظف',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 25),

                    // حقل الإيميل
                    _buildInputField(
                      label: 'الايميل',
                      hintText: 'example@outlook.com',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 25),

                    // حقل القسم
                    _buildInputField(
                      label: 'القسم',
                      hintText: 'قسم',
                      keyboardType: TextInputType.text,
                    ),
                    // [يمكن إضافة حقول أخرى مثل كلمة المرور]

                    const SizedBox(height: 50),

                    // زر "إضافة"
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: منطق إرسال بيانات الموظف الجديد إلى الـ Backend
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'تمت إضافة الموظف بنجاح (وهمي)', 
                                textDirection: TextDirection.rtl, 
                                style: TextStyle(fontFamily: kCairoFontFamily), // **تم التعديل هنا**
                              ),
                            ),
                          );
                          // Navigator.of(context).pop(); // قد ترغب في العودة بعد الإضافة
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: greenButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          shadowColor: greenButtonColor.withOpacity(0.5),
                        ),
                        child: const Text(
                          'اضافة',
                          style: TextStyle(
                            fontFamily: kCairoFontFamily, // **تم التعديل هنا**
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}