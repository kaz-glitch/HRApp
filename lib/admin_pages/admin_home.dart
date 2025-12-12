import 'package:flutter/material.dart';
// **1. استيراد صفحة الإعدادات الجديدة**
import 'admin_data.dart'; 
import 'mange_emply.dart';
import 'mange_permissions.dart';
// تعريف الألوان والثوابت
const Color primaryBlue = Color(0xFF334A52); // لون الشريط العلوي والنصوص الأساسية
const Color backgroundColor = Color(0xFFF4EDE2); // لون الخلفية (بيج فاتح)
const Color yellowButtonColor = Color(0xFFF7C852); // لون زر المستخدمين
const Color greenButtonColor = Color(0xFF7CAF4D); // لون زر الصلاحيات
const Color notificationCardColor = Colors.white; // لون بطاقات الإشعارات
const String kCairoFontFamily = 'Cairo'; // تعريف اسم الخط

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  // الدالة للانتقال إلى صفحة الملف الشخصي
  void _goToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserProfileScreen()), 
    );
  }

  // ويدجت لبناء بطاقة زر الإدارة
  Widget _buildManagementButton({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 120, 
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl, // لترتيب العناصر لليمين
          children: <Widget>[
            // عنوان الزر
            Text(
              title,
              style: const TextStyle(
                fontFamily: kCairoFontFamily, // **تم التعديل هنا**
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(offset: Offset(1, 1), blurRadius: 3.0, color: Colors.black38)
                ],
              ),
              textDirection: TextDirection.rtl,
            ),
            // الأيقونة الكبيرة
            Icon(
              icon,
              size: 60,
              color: Colors.white.withOpacity(0.9),
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت لبطاقة الإشعار
  Widget _buildNotificationCard({required String text}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: notificationCardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: kCairoFontFamily, // **تم التعديل هنا**
          fontSize: 16,
          color: primaryBlue,
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      
      // شريط التطبيق (AppBar)
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        toolbarHeight: 100, // ارتفاع الشريط
        backgroundColor: primaryBlue,
        elevation: 0,
        
        // الشعار (leading)
        leading: const Padding(
          padding: EdgeInsets.only(left: 15.0,top: 5), // تم تعديل Padding لتحسين المظهر
          child: Icon(
            Icons.book,
            size: 40,
            color: Colors.white,
          ),
        ),
        
        // اسم الشركة (title)
        title: const Text(
          'اسم الشركة',
          style: TextStyle(
            fontFamily: kCairoFontFamily, // **تم التعديل هنا**
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textDirection: TextDirection.rtl,
        ),
        
        // أيقونة المستخدم (actions)
        actions: <Widget>[
          GestureDetector(
            onTap: () => _goToSettings(context), 
            child: const Padding(
              padding: EdgeInsets.only(left: 15.0,right: 15,top: 10),
              child: Icon(
                Icons.person_rounded,
                size: 40,
                color: Colors.white,
               
              ),
            ),
          ),
        ],
      ),
      
      // محتوى الصفحة (Body)
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    // زر إدارة المستخدمين
                    _buildManagementButton(
                      title: 'إدارة المستخدمين',
                      icon: Icons.groups_2_rounded,
                      color: yellowButtonColor,
                      onPressed: () {
                         Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const UsersManagementScreen(), 
                          ),
                        );
                      },
                    ),

                    // زر إدارة الصلاحيات
                    _buildManagementButton(
                      title: 'إدارة الصلاحيات',
                      icon: Icons.settings,
                      color: greenButtonColor,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PermissionsManagementScreen(), // الانتقال
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    // عنوان الإشعارات
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          Text(
                            'الاشعارات طلبات التعديل',
                            style: TextStyle(
                              fontFamily: kCairoFontFamily, // **تم التعديل هنا**
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryBlue,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.notifications_active,
                            size: 24,
                            color: primaryBlue,
                          ),
                        ],
                      ),
                    ),
                    // فاصل أفقي
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                      child: Container(
                        height: 1,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // قائمة الإشعارات
                    _buildNotificationCard(
                      text: 'اشعار اشعار اشعار اشعار اشعار اشعار اشعار',
                    ),
                    _buildNotificationCard(
                      text: 'اشعار اشعار اشعار اشعار اشعار اشعار اشعار',
                    ),
                    _buildNotificationCard(
                      text: 'اشعار اشعار اشعار اشعار اشعار اشعار اشعار',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}