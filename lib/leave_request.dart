import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'success_overlay.dart'; // استدعاء نافذة التأكيد

class LeaveRequestPage extends StatefulWidget {
  const LeaveRequestPage({super.key});

  @override
  State<LeaveRequestPage> createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  // لوحة الألوان
  static const Color darkBlue = Color(0xFF2E4A56);
  static const Color beige = Color(0xFFE8DFC1);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color inputBg = Color(0xFFF1F1F1);
  static const Color btnGreen = Color(0xFF86B29A);
  static const Color chipGreen = Color(0xFF6BC17A);
  static const Color chipRed = Color(0xFFE0626A);
  static const Color chipGray = Color(0xFFBFBFBF);

  final _formKey = GlobalKey<FormState>();
  String? leaveType;
  DateTime? startDate;
  DateTime? endDate;
  int? daysCount;
  String? attachmentName;

  // سجل تجريبي محلي
  final List<Map<String, dynamic>> leaveHistory = [
    {"type": "مرضية", "from": "2025-04-01", "to": "2025-04-04", "days": 4, "status": "قيد التنفيذ"},
    {"type": "مرضية", "from": "2025-08-09", "to": "2025-08-10", "days": 2, "status": "مرفوض"},
    {"type": "سنوية", "from": "2025-12-01", "to": "2025-12-14", "days": 14, "status": "مقبول"},
  ];

  // حساب عدد الأيام
  void _calculateDays() {
    if (startDate != null && endDate != null) {
      final diff = endDate!.difference(startDate!).inDays + 1;
      setState(() => daysCount = diff > 0 ? diff : null);
    }
  }

  // اختيار التاريخ
  Future<void> _pickDate(bool isStart) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
          if (endDate != null && endDate!.isBefore(startDate!)) endDate = null;
        } else {
          endDate = picked;
        }
        _calculateDays();
      });
    }
  }

  // إرفاق ملف (وهمي)
  void _attachFile() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
              leading: const Icon(Icons.insert_drive_file, color: darkBlue),
              title: const Text('اختيار مرفق لاحقاً'),
              onTap: () {
                setState(() => attachmentName = "مرفق.pdf"); // TODO: استبدالها بمرفق حقيقي لاحقًا
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.close, color: Colors.grey),
              title: const Text('إلغاء'),
              onTap: () => Navigator.pop(context),
            ),
          ]),
        ),
      ),
    );
  }

  // إرسال الطلب
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (startDate == null || endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('يرجى اختيار تاريخ البداية والنهاية')),
        );
        return;
      }
      if (endDate!.isBefore(startDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تاريخ النهاية يجب أن يكون بعد البداية')),
        );
        return;
      }
      setState(() {
        leaveHistory.insert(0, {
          "type": leaveType!,
          "from": startDate!.toString().split(' ')[0],
          "to": endDate!.toString().split(' ')[0],
          "days": daysCount ?? 0,
          "status": "قيد التنفيذ",
        });
      });

      // ✅ نافذة التأكيد العائمة
      await showSuccessOverlay(context, message: 'تم ارسال الطلب');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: beige,
        appBar: AppBar(
          backgroundColor: darkBlue,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'طلب إجازة',
            style: GoogleFonts.cairo(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          // السهم في يسار الشاشة (RTL)
          actions: [
            IconButton(
              icon: const Icon(Icons.chevron_right, color: Colors.white, size: 32),
              onPressed: () => Navigator.of(context).maybePop(),
              tooltip: 'رجوع',
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // بطاقة الفورم
              Container(
                decoration: BoxDecoration(
                  color: cardWhite,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
                ),
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('نوع الإجازة',
                        style: GoogleFonts.cairo(color: darkBlue, fontWeight: FontWeight.w700, fontSize: 18)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: leaveType,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: inputBg,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: ['سنوية', 'عارضة', 'مرضية', 'بدون راتب']
                          .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                          .toList(),
                      onChanged: (v) => setState(() => leaveType = v),
                      validator: (v) => v == null ? 'الرجاء اختيار نوع الإجازة' : null,
                    ),
                    const SizedBox(height: 12),
                    Row(children: [
                      Expanded(
                        child: _DateField(label: 'تاريخ البداية', date: startDate, onTap: () => _pickDate(true)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _DateField(label: 'تاريخ النهاية', date: endDate, onTap: () => _pickDate(false)),
                      ),
                    ]),
                    const SizedBox(height: 12),
                    Center(
                      child: Text('عدد الأيام: ${daysCount ?? "--"}',
                          style: GoogleFonts.cairo(color: darkBlue, fontSize: 16, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: _attachFile,
                      icon: const Icon(Icons.attach_file, color: darkBlue),
                      label: Text('ارفاق ملف',
                          style: GoogleFonts.cairo(color: darkBlue, fontWeight: FontWeight.w700)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: darkBlue),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                    if (attachmentName != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(attachmentName!,
                            style: GoogleFonts.cairo(color: Colors.grey[600], fontSize: 14)),
                      ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: btnGreen,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 3,
                        ),
                        child: Text('ارسل الطلب',
                            style: GoogleFonts.cairo(
                                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 17)),
                      ),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 24),

              // بطاقة سجل الإجازات
              Container(
                decoration: BoxDecoration(
                  color: cardWhite,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
                ),
                padding: const EdgeInsets.all(12),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _headerText('نوع الإجازة'),
                      _headerText('من'),
                      _headerText('إلى'),
                      _headerText('عدد الأيام'),
                      _headerText('الحالة'),
                    ],
                  ),
                  const Divider(),
                  ...leaveHistory.map((e) => _LeaveRow(e)).toList(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerText(String txt) => Text(
        txt,
        style: GoogleFonts.cairo(color: darkBlue, fontWeight: FontWeight.w700, fontSize: 14),
      );
}

// حقل التاريخ
class _DateField extends StatelessWidget {
  const _DateField({required this.label, required this.date, required this.onTap});
  final String label;
  final DateTime? date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(label,
              style: GoogleFonts.cairo(
                  color: _LeaveRequestPageState.darkBlue, fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 6),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: _LeaveRequestPageState.inputBg,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Icon(Icons.calendar_today, color: Colors.grey),
                Text(date == null ? '—' : date.toString().split(' ')[0],
                    style: GoogleFonts.cairo(fontSize: 15, color: _LeaveRequestPageState.darkBlue)),
              ]),
            ),
          ),
        ],
      );
}

// صف في سجل الإجازات
class _LeaveRow extends StatelessWidget {
  final Map<String, dynamic> data;
  const _LeaveRow(this.data);

  Color _statusColor(String s) {
    switch (s) {
      case 'مقبول':
        return _LeaveRequestPageState.chipGreen;
      case 'مرفوض':
        return _LeaveRequestPageState.chipRed;
      default:
        return _LeaveRequestPageState.chipGray;
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _cell(data["type"]),
            _cell(data["from"]),
            _cell(data["to"]),
            _cell(data["days"].toString()),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: _statusColor(data["status"]), borderRadius: BorderRadius.circular(12)),
              child: Text(data["status"],
                  style: GoogleFonts.cairo(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ]),
        ),
      );

  Widget _cell(String text) => Expanded(
        child: Text(text, textAlign: TextAlign.center, style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600)),
      );
}
