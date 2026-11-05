/// Model data untuk satu barang dagangan di kasir.
class Produk {
  const Produk({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.stok,
    required this.gambarUrl,
    this.diskonPersen = 0,
  });

  /// ID unik produk.
  final int id;

  /// Nama barang dagangan.
  final String nama;

  /// Kategori produk: Makanan / Minuman / Snack.
  final String kategori;

  /// Harga jual satuan dalam Rupiah.
  final double harga;

  /// Sisa persediaan unit barang di toko.
  final int stok;

  /// Tautan URL foto produk.
  final String gambarUrl;

  /// Potongan harga dalam persen (0 = tanpa diskon).
  final int diskonPersen;
}

/// Data dummy produk untuk simulasi katalog kasir tanpa database.
final List<Produk> daftarProdukDummy = [
  const Produk(
    id: 1,
    nama: 'Kopi Susu Gula Aren 250ml',
    kategori: 'Minuman',
    harga: 18000,
    stok: 24, // Aman (> 5) -> badge hijau
    gambarUrl:
        'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=300',
    diskonPersen: 20, // Menambahkan diskon promo 20% khusus produk ini
  ),
  const Produk(
    id: 2,
    nama: 'Roti Bakar Cokelat Keju',
    kategori: 'Makanan',
    harga: 15000,
    stok: 5, // Menipis (<= 5) -> badge kuning
    gambarUrl:
        'https://images.unsplash.com/photo-1584776296944-ab6fb57b0bdd?w=300',
  ),
  const Produk(
    id: 3,
    nama: 'Matcha Latte Ice',
    kategori: 'Minuman',
    harga: 22000,
    stok: 0, // Habis (== 0) -> badge merah, tombol dinonaktifkan
    gambarUrl:
        'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=300',
  ),
  const Produk(
    id: 4,
    nama: 'Nasi Goreng Banjar Spesial',
    kategori: 'Makanan',
    harga: 25000,
    stok: 12,
    diskonPersen: 10, // Ada promo -> tampilkan badge diskon
    gambarUrl:
        'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=300',
  ),
  const Produk(
    id: 5,
    nama: 'Kentang Goreng Crispy',
    kategori: 'Snack',
    harga: 12000,
    stok: 18,
    gambarUrl:
        'https://images.unsplash.com/photo-1576107232684-1279f3908594?w=300',
  ),
  const Produk(
    id: 6,
    nama: 'Air Mineral Botol 600ml',
    kategori: 'Minuman',
    harga: 5000,
    stok: 40,
    gambarUrl:
        'https://images.unsplash.com/photo-1523362628745-0c100150b504?w=300',
  ),
];
