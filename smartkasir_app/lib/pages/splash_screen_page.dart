import 'dart:async';

import 'package:flutter/material.dart';

import 'main_navigation_page.dart';

/// Layar pembuka: menampilkan logo dan hitung mundur, lalu pindah ke
/// [MainNavigationPage] secara otomatis.
class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  static const Color _biruNavy = Color(0xFF1E3A8A);

  /// Sisa waktu hitung mundur splash screen (detik).
  int _durasiDetik = 10; // Mengubah durasi hitung mundur menjadi 10 detik penuh
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _mulaiHitungMundur();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Hentikan timer agar tidak terjadi memory leak
    super.dispose();
  }

  // --- Logika hitung mundur & navigasi ---

  void _mulaiHitungMundur() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_durasiDetik > 1) {
        setState(() => _durasiDetik--);
        return;
      }

      // Waktu habis: hentikan timer, lalu pindah halaman.
      timer.cancel();
      if (!mounted) return;
      _keHalamanUtama();
    });
  }

  /// Mengganti splash dengan halaman utama (pushReplacement) agar pengguna
  /// tidak bisa kembali ke splash lewat tombol Back.
  void _keHalamanUtama() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigationPage()),
    );
  }

  // --- Tampilan ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _biruNavy,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(),
            const SizedBox(height: 24),
            const Text(
              'SmartKasir',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Aplikasi Kasir Point of Sale Digital',
              style: TextStyle(fontSize: 13, color: Colors.white70),
            ),
            const SizedBox(height: 36),
            _buildIndikatorLoading(),
            const SizedBox(height: 14),
            Text(
              'Menyiapkan sistem SmartKasir ($_durasiDetik detik)...',
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
            const SizedBox(height: 40),
            Text(
              'Versi 1.0.0 — Modul Pertemuan 10',
              style: TextStyle(fontSize: 11, color: Colors.blue.shade200),
            ),
          ],
        ),
      ),
    );
  }

  /// Logo kasir di dalam lingkaran putih dengan bayangan.
  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Icon(
        Icons.point_of_sale_rounded,
        size: 72,
        color: _biruNavy,
      ),
    );
  }

  /// Indikator putar loading berwarna amber (28 x 28).
  Widget _buildIndikatorLoading() {
    return const SizedBox(
      width: 28,
      height: 28,
      child: CircularProgressIndicator(color: Colors.amber, strokeWidth: 3),
    );
  }
}
