import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:employee/login_pages/login_selection.dart';

void main() {
  runApp(const EmployeeDashboardApp());
}

class EmployeeDashboardApp extends StatelessWidget {
  const EmployeeDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      debugShowCheckedModeBanner: false,
      title: 'HR App',
      
      theme: ThemeData(
        useMaterial3: false,
        textTheme: GoogleFonts.cairoTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFE8DFC1),
      ),

      // 👇👇 هنا يتم عرض صفحة الاختيار الجديدة مباشرة
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: LoginSelectionPage(),
      ),
    );
  }
}