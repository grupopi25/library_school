import 'package:flutter/material.dart';
import 'package:library_school/admin/navbar_admin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const primaryColor = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library School',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto', 
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
        ),
        iconTheme: const IconThemeData(
          size: 24,
        ),
      ),  

      home: const NavbarAdmin(),
    );
  }
}