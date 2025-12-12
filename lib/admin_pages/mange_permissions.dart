import 'package:flutter/material.dart';

// تعريف الألوان والثوابت
const Color primaryBlue = Color(0xFF334A52); // لون الشريط العلوي
const Color backgroundColor = Color(0xFFF4EDE2); // لون الخلفية (بيج فاتح)
const Color greenCheckColor = Color(0xFF7CAF4D); // لون علامات الصح (الموافقة)
const Color cardColor = Colors.white; // لون البطاقة البيضاء

class PermissionsManagementScreen extends StatefulWidget {
  const PermissionsManagementScreen({super.key});

  @override
  State<PermissionsManagementScreen> createState() => _PermissionsManagementScreenState();
}

// كلاس لحالة الشاشة
class _PermissionsManagementScreenState extends State<PermissionsManagementScreen> {
  // بيانات وهمية لتمثيل حالة الصلاحيات
  final List<bool> _permissionsStatus = List<bool>.generate(10, (index) => index.isEven);
  final int _totalItems = 10; // عدد العناصر الكلي

  // ويدجت لبناء عنصر قائمة المستخدم
  Widget _buildUserPermissionItem(BuildContext context, int index) {
    return Padding(
      // تم تعديل البادينج ليتناسب مع البطاقة
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
                child: Text('اسم الموظف', style: TextStyle(color: Colors.black87), textAlign: TextAlign.right, textDirection: TextDirection.rtl, overflow: TextOverflow.ellipsis),
              ),
              // حقل الايميل
              const Expanded(
                flex: 3,
                child: Text('Example@outlook.com', style: TextStyle(color: Colors.black87), textAlign: TextAlign.right, overflow: TextOverflow.ellipsis),
              ),
              // حقل القسم
              const Expanded(
                flex: 2,
                child: Text('قسم', style: TextStyle(color: Colors.black87), textAlign: TextAlign.right, textDirection: TextDirection.rtl),
              ),
              // مربع الموافقة (Checkbox)
              Expanded(
                flex: 2,
                child: Center(
                  child: Checkbox(
                    value: _permissionsStatus[index],
                    onChanged: (bool? newValue) {
                      setState(() {
                        _permissionsStatus[index] = newValue!;
                        // TODO: منطق حفظ حالة الصلاحية الجديدة في الـ Backend
                      });
                    },
                    activeColor: greenCheckColor,
                    checkColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          // خط فاصل سفلي - يظهر فقط إذا لم يكن العنصر الأخير
          if (index < _totalItems - 1)
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
            Navigator.of(context).pop();
          },
        ),
        
        // عنوان الصفحة
        title: const Text(
          'ادارة الصلاحيات',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
      ),
      
      // محتوى الصفحة
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 20), // مسافة علوية
            
            // **البطاقة البيضاء الكبيرة للقائمة**
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                  children: [
                    // جدول / قائمة الرؤوس (Header Row)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textDirection: TextDirection.rtl,
                        children: const [
                          Expanded(flex: 3, child: Text('الاسم', style: TextStyle(fontWeight: FontWeight.bold, color: primaryBlue, fontSize: 16), textAlign: TextAlign.right)),
                          Expanded(flex: 3, child: Text('الايميل', style: TextStyle(fontWeight: FontWeight.bold, color: primaryBlue, fontSize: 16), textAlign: TextAlign.right)),
                          Expanded(flex: 2, child: Text('القسم', style: TextStyle(fontWeight: FontWeight.bold, color: primaryBlue, fontSize: 16), textAlign: TextAlign.right)),
                          Expanded(flex: 2, child: Text('موافقة', style: TextStyle(fontWeight: FontWeight.bold, color: primaryBlue, fontSize: 16), textAlign: TextAlign.center)), 
                        ],
                      ),
                    ),
                    // خط فاصل تحت الرؤوس
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Container(height: 2, color: Colors.black54),
                    ),

                    // قائمة المستخدمين (Permissions List)
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _permissionsStatus.length, 
                        itemBuilder: (context, index) {
                          return _buildUserPermissionItem(context, index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20), // مسافة سفلية
          ],
        ),
      ),
    );
  }
}