import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool isCheckedIn = false;
  bool isCheckedOut = false;
  DateTime? checkInTime;
  DateTime? checkOutTime;

  void handleCheckIn() {
    setState(() {
      isCheckedIn = true;
      checkInTime = DateTime.now();
    });
  }

  void handleCheckOut() {
    setState(() {
      isCheckedOut = true;
      checkOutTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFE8DFC1),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E4A56),
          title: Text('تسجيل الحضور والانصراف', style: GoogleFonts.cairo()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'مرحبًا، أحمد الزهراني',
                style: GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              _buildStatusRow('الحالة:', isCheckedIn ? '✅ تم تسجيل الحضور' : '⏳ لم يتم الحضور بعد'),
              _buildStatusRow('وقت الحضور:', checkInTime != null ? checkInTime!.toLocal().toString().substring(0, 16) : '—'),
              const SizedBox(height: 12),
              _buildStatusRow('الانصراف:', isCheckedOut ? '✅ تم تسجيل الانصراف' : '⏳ لم يتم الانصراف بعد'),
              _buildStatusRow('وقت الانصراف:', checkOutTime != null ? checkOutTime!.toLocal().toString().substring(0, 16) : '—'),

              const SizedBox(height: 32),

              if (!isCheckedIn)
                ElevatedButton.icon(
                  onPressed: handleCheckIn,
                  icon: const Icon(Icons.login),
                  label: Text('تسجيل الحضور', style: GoogleFonts.cairo(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),

              if (isCheckedIn && !isCheckedOut)
                ElevatedButton.icon(
                  onPressed: handleCheckOut,
                  icon: const Icon(Icons.logout),
                  label: Text('تسجيل الانصراف', style: GoogleFonts.cairo(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'هذه البيانات تجريبية فقط. سيتم ربطها بقاعدة البيانات لاحقًا.',
                  style: GoogleFonts.cairo(fontSize: 14, color: Colors.brown[700]),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.cairo(fontSize: 16.5, fontWeight: FontWeight.w600)),
          Text(value, style: GoogleFonts.cairo(fontSize: 16.5)),
        ],
      ),
    );
  }
}
