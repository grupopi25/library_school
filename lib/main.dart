import 'package:flutter/material.dart';
import 'package:library_school/admin/navbar_admin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const primaryColor = Color(0x7EE2E8F0);

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library School',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      ),
      home: NavbarAdmin(),
    );
  }
}