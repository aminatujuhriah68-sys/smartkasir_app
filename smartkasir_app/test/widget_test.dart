import 'package:flutter_test/flutter_test.dart';

import 'package:smartkasir_app/main.dart';

void main() {
  testWidgets('Splash screen menghitung mundur lalu pindah ke halaman utama', (
    WidgetTester tester,
  ) async {
    // Bangun aplikasi dan render frame pertama.
    await tester.pumpWidget(const SmartKasirApp());

    // Splash screen tampil dengan hitung mundur 10 detik.
    expect(find.text('SmartKasir'), findsOneWidget);
    expect(
      find.text('Menyiapkan sistem SmartKasir (10 detik)...'),
      findsOneWidget,
    );

    // Setelah 3 detik, hitungan tersisa 7 detik.
    await tester.pump(const Duration(seconds: 3));
    expect(
      find.text('Menyiapkan sistem SmartKasir (7 detik)...'),
      findsOneWidget,
    );

    // Sisa 7 detik habis: aplikasi pindah ke MainNavigationPage.
    await tester.pump(const Duration(seconds: 7));
    await tester.pump(
      const Duration(seconds: 1),
    ); // Selesaikan animasi transisi

    // Splash screen hilang, halaman utama (tab Beranda + Dashboard) tampil.
    expect(find.textContaining('detik'), findsNothing);
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Total Penjualan Hari Ini'), findsOneWidget);

    // Badge promo dari Live Tweak 3 muncul di produk Kopi Susu.
    expect(find.text('PROMO 20%'), findsOneWidget);
  });
}
