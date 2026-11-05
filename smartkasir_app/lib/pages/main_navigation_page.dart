import 'package:flutter/material.dart';

import 'dashboard_page.dart';

/// Kerangka utama aplikasi dengan navigasi 4 tab di bagian bawah.
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  static const Color _biruNavy = Color(0xFF1E3A8A);

  /// Halaman untuk tiap tab, urutannya harus sama dengan [_navItems].
  static const List<Widget> _pages = [
    DashboardPage(), // 0: Beranda (katalog kasir)
    _HalamanSementara('Menu 2: Transaksi Kasir POS (Modul M14)'), // 1: Kasir
    _HalamanSementara(
      'Menu 3: Riwayat Penjualan & Laporan (Modul M12)',
    ), // 2: Riwayat
    _HalamanSementara(
      'Menu 4: Profil Toko & Pengaturan (Modul M12)',
    ), // 3: Toko
  ];

  /// Item navigasi bawah: ikon outline saat pasif, solid saat aktif.
  static const List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.storefront_outlined),
      activeIcon: Icon(Icons.storefront),
      label: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      activeIcon: Icon(Icons.shopping_cart),
      label: 'Kasir',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.receipt_long_outlined),
      activeIcon: Icon(Icons.receipt_long),
      label: 'Riwayat',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.store_outlined),
      activeIcon: Icon(Icons.store),
      label: 'Toko',
    ),
  ];

  /// Indeks tab yang sedang aktif (0 = Beranda).
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      // Bayangan halus ke atas, memisahkan navigasi dari konten.
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed, // 4 tab tidak bergeser
        backgroundColor: Colors.white,
        selectedItemColor: _biruNavy,
        unselectedItemColor: Colors.grey.shade500,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: _navItems,
      ),
    );
  }
}

/// Placeholder untuk halaman yang belum dibuat.
class _HalamanSementara extends StatelessWidget {
  const _HalamanSementara(this.teks);

  final String teks;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(teks, style: const TextStyle(fontSize: 16)));
  }
}
