// lib/salary_screen.dart
import 'package:flutter/material.dart';
import 'homepaeg.dart'; // تأكدي أن هذا الملف موجود، أو غيّري المسار إلى المكان الصحيح

/// صفحة كشف الراتب.
/// ملاحظة: لو لم تكن قد أضفت خط Cairo في pubspec.yaml، ضيفيه لتحسين العرض:
/// fonts:
///   - family: Cairo
///     fonts:
///       - asset: fonts/Cairo-Regular.ttf
///       - asset: fonts/Cairo-Bold.ttf
class SalaryScreen extends StatefulWidget {
  const SalaryScreen({super.key});

  @override
  State<SalaryScreen> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
  // ألوان مطابقة للمطلوب
  static const Color backgroundColor = Color(0xFFE8DAB2); // بيج فاتح
  static const Color headerColor = Color(0xFF1F4E5F); // أزرق غامق
  static const Color downloadButtonColor = Color(0xFFB4D6C1); // أخضر فاتح
  static const Color reasonBadgeColor = Color(0xFFE57373); // وردي للسبب

  // سنة مبدئية في الـ Dropdown
  int selectedYear = 2025;

  // بيانات تجريبية للجدول — استبدليها بالبيانات الحقيقية لاحقًا
  final List<Map<String, dynamic>> _rows = [
    {'month': 'يناير', 'salary': '10,000', 'allowances': '0.00', 'deduction': '0.00', 'reason': '---'},
    {'month': 'فبراير', 'salary': '8,000', 'allowances': '0.00', 'deduction': '2,000', 'reason': 'السبب'},
    {'month': 'مارس', 'salary': '10,000', 'allowances': '0.00', 'deduction': '0.00', 'reason': '---'},
    {'month': 'أبريل', 'salary': '10,000', 'allowances': '0.00', 'deduction': '0.00', 'reason': '---'},
    {'month': 'مايو', 'salary': '8,000', 'allowances': '0.00', 'deduction': '2,000', 'reason': 'السبب'},
    {'month': 'يونيو', 'salary': '10,000', 'allowances': '0.00', 'deduction': '0.00', 'reason': '---'},
    {'month': 'يوليو', 'salary': '10,000', 'allowances': '2.00', 'deduction': '0.00', 'reason': '---'},
    {'month': 'أغسطس', 'salary': '10,000', 'allowances': '0.00', 'deduction': '0.00', 'reason': '---'},
    {'month': 'سبتمبر', 'salary': '10,000', 'allowances': '0.00', 'deduction': '0.00', 'reason': '---'},
    {'month': 'أكتوبر', 'salary': '10,000', 'allowances': '0.00', 'deduction': '1,000', 'reason': '---'},
    {'month': 'نوفمبر', 'salary': '10,000', 'allowances': '0.00', 'deduction': '0.00', 'reason': '---'},
    {'month': 'ديسمبر', 'salary': '10,000', 'allowances': '1,500', 'deduction': '0.00', 'reason': '---'},
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality( // للتأكد من اتجاه النص من اليمين لليسار
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: headerColor,
          elevation: 0,
          leadingWidth: 40, // يضع السهم في أقصى اليسار
          leading: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                // عند الضغط يرجع إلى صفحة الملف الشخصي (profile_screen.dart)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
          ),
          title: const Text(
            'كشف الراتب',
            style: TextStyle(
              fontFamily: 'Cairo', // يُنصح بإضافة خط Cairo في pubspec.yaml
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),

        // المحتوى داخل SingleChildScrollView كما طُلِب
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            children: [
              // صف الزر وDropdown (زر التحميل + اختيار السنة)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black26.withOpacity(0.06), blurRadius: 8, offset: const Offset(2, 4))],
                ),
                child: Row(
                  children: [
                    // زر التحميل بالمظهر المطلوب (مربع أخضر صغير مع أيقونة)
                    Container(
                      width: 56,
                      height: 40,
                      decoration: BoxDecoration(
                        color: downloadButtonColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.download, color: Colors.white),
                        onPressed: () {
                          // منطق التحميل (يمكن ربطه لاحقًا بصيغة PDF أو CSV)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Download tapped')),
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Spacer بين الزر والDropdown
                    const Spacer(),

                    // Dropdown اختيار السنة داخل حاوية بحدود وظل خفيف
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: selectedYear,
                          items: [2025, 2024, 2023].map((y) {
                            return DropdownMenuItem<int>(
                              value: y,
                              child: Text('$y', style: const TextStyle(fontFamily: 'Cairo', fontSize: 16)),
                            );
                          }).toList(),
                          onChanged: (v) {
                            setState(() {
                              selectedYear = v ?? selectedYear;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // البطاقة البيضاء الكبيرة التي تحتوي الجدول (حواف دائرية + ظل)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black26.withOpacity(0.06), blurRadius: 12, offset: const Offset(3, 6))],
                ),
                child: Column(
                  children: [
                    // ترويسة الجدول (عناوين الأعمدة)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: Row(
                        children: const [
                          Expanded(flex: 2, child: Text('الشهر', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold))),
                          Expanded(flex: 2, child: Text('الراتب', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold))),
                          Expanded(flex: 2, child: Text('البدلات', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold))),
                          Expanded(flex: 2, child: Text('الخصم', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold))),
                          Expanded(flex: 2, child: Text('السبب', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),

                    // صفوف البيانات داخل ListView (مقيدة الارتفاع أو shrinkWrap)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), // لأن الـ SingleChildScrollView يسيطر على التمرير
                      itemCount: _rows.length,
                      separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade300),
                      itemBuilder: (context, index) {
                        final row = _rows[index];
                        final bool hasDeduction = row['deduction'] != '0.00' && row['deduction'] != '0' && row['deduction'] != 0;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          child: Row(
                            children: [
                              // عمود الشهر
                              Expanded(
                                flex: 2,
                                child: Text(row['month'], style: const TextStyle(fontFamily: 'Cairo')),
                              ),

                              // عمود الراتب
                              Expanded(
                                flex: 2,
                                child: Text(row['salary'], style: const TextStyle(fontFamily: 'Cairo')),
                              ),

                              // عمود البدلات
                              Expanded(
                                flex: 2,
                                child: Text(row['allowances'], style: const TextStyle(fontFamily: 'Cairo')),
                              ),

                              // عمود الخصم
                              Expanded(
                                flex: 2,
                                child: Text(row['deduction'], style: const TextStyle(fontFamily: 'Cairo')),
                              ),

                              // عمود السبب (إما زر وردي أو ---)
                              Expanded(
                                flex: 2,
                                child: hasDeduction
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: reasonBadgeColor,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: const Text(
                                          'السبب',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : const Text('---', style: TextStyle(fontFamily: 'Cairo')),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}