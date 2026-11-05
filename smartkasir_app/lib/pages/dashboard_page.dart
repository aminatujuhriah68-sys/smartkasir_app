import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/produk.dart';

/// Halaman beranda kasir: ringkasan omzet, filter kategori, dan katalog produk.
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // --- Konfigurasi tampilan ---
  static const Color _biruNavy = Color(0xFF1E3A8A);
  static const double _tinggiGambar = 125;

  /// Opsi filter kategori (indeks 0 = tampilkan semua).
  static const List<String> _kategoriList = [
    'Semua',
    'Makanan',
    'Minuman',
    'Snack',
  ];

  final NumberFormat _formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  // --- State ---
  int _kategoriTerpilih = 0;

  // --- Logika bisnis ---

  /// Contoh: 18000.0 -> "Rp 18.000".
  String _formatRupiah(double nominal) => _formatCurrency.format(nominal);

  /// Daftar produk yang tampil sesuai kategori terpilih.
  List<Produk> get _produkTampil {
    if (_kategoriTerpilih == 0) return daftarProdukDummy;

    final kategori = _kategoriList[_kategoriTerpilih];
    return daftarProdukDummy.where((p) => p.kategori == kategori).toList();
  }

  // --- Build utama ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildBannerOmzet(),
          _buildFilterKategori(),
          const SizedBox(height: 8),
          Expanded(child: _buildKatalog()),
        ],
      ),
    );
  }

  // --- App bar ---

  AppBar _buildAppBar() {
    return AppBar(
      title: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.point_of_sale, color: Colors.amber, size: 24),
          SizedBox(width: 8),
          Text(
            'SmartKasir',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: 'Notifikasi Penjualan',
          icon: const Icon(Icons.notifications_none),
          onPressed: () {}, // TODO: aksi notifikasi
        ),
      ],
    );
  }

  // --- Blok 1: banner omzet hari ini ---

  Widget _buildBannerOmzet() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_biruNavy, Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Penjualan Hari Ini',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                _formatRupiah(845000),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          _buildKapsulTransaksi(),
        ],
      ),
    );
  }

  Widget _buildKapsulTransaksi() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.receipt_long, color: Colors.white, size: 16),
          SizedBox(width: 4),
          Text(
            '34 Transaksi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // --- Blok 2: filter kategori (chip horizontal) ---

  Widget _buildFilterKategori() {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _kategoriList.length,
        itemBuilder: (context, index) {
          final isSelected = _kategoriTerpilih == index;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(_kategoriList[index]),
              selected: isSelected,
              selectedColor: _biruNavy,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
              onSelected: (_) => setState(() => _kategoriTerpilih = index),
            ),
          );
        },
      ),
    );
  }

  // --- Blok 3: katalog produk (grid 2 kolom) ---

  Widget _buildKatalog() {
    final produkList = _produkTampil;

    if (produkList.isEmpty) {
      return const Center(child: Text('Tidak ada produk pada kategori ini'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.90,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: produkList.length,
      itemBuilder: (context, index) => _buildKartuProduk(produkList[index]),
    );
  }

  Widget _buildKartuProduk(Produk produk) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildFotoProduk(produk), _buildInfoProduk(produk)],
      ),
    );
  }

  /// Foto produk dengan badge promo (jika ada diskon) di pojok kiri atas.
  Widget _buildFotoProduk(Produk produk) {
    return Stack(
      children: [
        Image.network(
          produk.gambarUrl,
          height: _tinggiGambar,
          width: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: _tinggiGambar,
              color: Colors.grey.shade200,
              child: const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            height: _tinggiGambar,
            color: Colors.grey.shade300,
            child: const Center(
              child: Icon(Icons.broken_image, color: Colors.grey, size: 36),
            ),
          ),
        ),
        if (produk.diskonPersen > 0)
          Positioned(
            top: 6,
            left: 6,
            child: _buildBadgePromo(produk.diskonPersen),
          ),
      ],
    );
  }

  Widget _buildBadgePromo(int diskonPersen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.red.shade700,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'PROMO $diskonPersen%',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Nama, badge stok, harga, dan tombol tambah.
  Widget _buildInfoProduk(Produk produk) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            produk.nama,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 3),
          _buildBadgeStok(produk.stok),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatRupiah(produk.harga),
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              _buildTombolTambah(produk),
            ],
          ),
        ],
      ),
    );
  }

  /// Badge indikator stok: merah (habis), kuning (<= 5), hijau (aman).
  Widget _buildBadgeStok(int stok) {
    final MaterialColor warna;
    final String label;

    if (stok == 0) {
      warna = Colors.red;
      label = 'Habis';
    } else if (stok <= 5) {
      warna = Colors.amber;
      label = 'Sisa $stok';
    } else {
      warna = Colors.green;
      label = 'Stok $stok';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: warna.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: warna.shade900,
        ),
      ),
    );
  }

  /// Tombol (+) tambah ke keranjang; dinonaktifkan jika stok habis.
  Widget _buildTombolTambah(Produk produk) {
    final habis = produk.stok == 0;

    return InkWell(
      onTap: habis ? null : () {}, // TODO: tambah ke keranjang
      borderRadius: BorderRadius.circular(15),
      child: CircleAvatar(
        radius: 14,
        backgroundColor: habis ? Colors.grey.shade300 : _biruNavy,
        child: const Icon(Icons.add, color: Colors.white, size: 16),
      ),
    );
  }
}
