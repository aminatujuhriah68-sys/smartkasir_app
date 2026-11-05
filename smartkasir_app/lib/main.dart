import 'package:flutter/material.dart';

import 'pages/splash_screen_page.dart';

/// Titik masuk aplikasi.
void main() {
  runApp(const SmartKasirApp());
}

/// Widget root aplikasi SmartKasir.
class SmartKasirApp extends StatelessWidget {
  const SmartKasirApp({super.key});

  /// Biru navy, warna utama aplikasi kasir.
  static const Color _biruNavy = Color(0xFF1E3A8A);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartKasir',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
          backgroundColor: _biruNavy,
          foregroundColor: Colors.white,
        ),
      ),
      home: const SplashScreenPage(),
    );
  }
}
