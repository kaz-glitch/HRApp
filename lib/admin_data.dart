import 'package:flutter/material.dart';
// تأكد من أن هذا الملف يحتوي على تعريف دالة showSystemGuide
import 'system_guide_overlay_for_admin.dart'; 

// تعريف الألوان والثوابت
const Color primaryBlue = Color(0xFF334A52); // لون الخلفية الداكن
const Color backgroundColor = Color(0xFFF4EDE2); // لون الخلفية الفاتح (البيج/الكريمي)
const Color cardColor = Colors.white; // لون بطاقات المعلومات
const String kCairoFontFamily = 'Cairo'; // تعريف اسم الخط

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          // الجزء العلوي المخصص (AppBar/Header)
          SliverAppBar(
            expandedHeight: 280.0, // ارتفاع الشريط عند التوسع
            pinned: true, // يبقى الشريط مرئياً عند التمرير
            backgroundColor: primaryBlue,
            elevation: 0,
            
            // زر الرجوع في اليسار
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 28),
              onPressed: () {
                Navigator.of(context).pop(); // منطق الرجوع
              },
            ),
            
            // أيقونة اللمبة (ميزة أو إعداد) في اليمين
            actions: [
              IconButton(
                icon: const Icon(Icons.lightbulb_outline, color: Colors.amber, size: 28),
                onPressed: () {
                  // استدعاء دالة عرض دليل النظام
                  showSystemGuide(context); 
                },
              ),
            ],
            
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              // محتوى الشريط العلوي
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50), // لترك مساحة كافية للـ AppBar Icons
                  // أيقونة المستخدم الكبيرة
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      color: primaryBlue,
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      size: 70,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // اسم المسؤول
                  const Text(
                    'اسم المسؤول',
                    style: TextStyle(
                      fontFamily: kCairoFontFamily, // **تم التأكد من وجود الخط هنا**
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ),

          // محتوى الصفحة في الـ body
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 20),

                // بطاقة "معلومات اساسية"
                _buildInfoCard(
                  title: 'معلومات اساسية',
                  data: {
                    'اسم': 'سالم محمد',
                    'رقم الهاتف': '050xxxxxxx',
                    'البريد الالكتروني': 'salem@example.com',
                    'تاريخ الميلاد': '1400/01/01 هـ',
                    'الجنسية': 'سعودي',
                  },
                ),

                const SizedBox(height: 20),

                // بطاقة "معلومات الوظيفة"
                _buildInfoCard(
                  title: 'معلومات الوظيفة',
                  data: {
                    'المسمى الوظيفي': 'مدير النظام',
                    'تاريخ التعيين': '2020/05/15 م',
                    'القسم': 'الإدارة العامة',
                    'الراتب الاساسي': '15000 ريال',
                  },
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت لبناء بطاقة المعلومات
  Widget _buildInfoCard({
    required String title,
    required Map<String, String> data,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          // عنوان البطاقة
          Text(
            title,
            style: const TextStyle(
              fontFamily: kCairoFontFamily, // **تم التأكد من وجود الخط هنا**
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
            textDirection: TextDirection.rtl,
          ),
          const Divider(height: 30, thickness: 1, color: Colors.black12),
          
          // حقول المعلومات
          ...data.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  // قيمة الحقل (محتوى وهمي)
                  Expanded(
                    child: Text(
                      entry.value,
                      style: const TextStyle(
                        fontFamily: kCairoFontFamily, // **تم التأكد من وجود الخط هنا**
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // اسم الحقل
                  Text(
                    '${entry.key}:',
                    style: const TextStyle(
                      fontFamily: kCairoFontFamily, // **تم التأكد من وجود الخط هنا**
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}