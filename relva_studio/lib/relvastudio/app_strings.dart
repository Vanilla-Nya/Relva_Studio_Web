import 'app_settings.dart';

class AppStrings {
  final AppLanguage language;
  const AppStrings(this.language);

  // ─── General ───────────────────────────────────────────────────────────────
  String get appTitle => language == AppLanguage.id ? 'Relva Studio' : 'Relva Studio';

  // ─── Navigation ────────────────────────────────────────────────────────────
  String get navHome => language == AppLanguage.id ? 'Beranda' : 'Home';
  String get navProducts => language == AppLanguage.id ? 'Produk' : 'Products';

  // ─── Hero Section ──────────────────────────────────────────────────────────
  String get heroTitle => language == AppLanguage.id
      ? 'Selamat Datang di Relva'
      : 'Welcome to Relva';

  String get heroSubtitle => language == AppLanguage.id
      ? 'Mitra terpercaya Anda dalam inovasi digital dan solusi kreatif'
      : 'Your trusted partner in digital innovation and creative solutions';

  String get heroButton => language == AppLanguage.id
      ? 'Jelajahi Produk Kami'
      : 'Explore Our Products';

  // ─── About Section ─────────────────────────────────────────────────────────
  String get aboutTitle => language == AppLanguage.id ? 'Tentang Relva' : 'About Relva';

  String get aboutDesc => language == AppLanguage.id
      ? 'Relva adalah perusahaan teknologi inovatif yang berspesialisasi dalam menciptakan solusi digital mutakhir. Kami mengubah ide menjadi aplikasi yang kuat yang mendorong pertumbuhan bisnis dan meningkatkan pengalaman pengguna. Tim kami menggabungkan keahlian teknis dengan pemikiran kreatif untuk memberikan hasil luar biasa bagi klien kami.'
      : 'Relva is an innovative technology company specializing in creating cutting-edge digital solutions. We transform ideas into powerful applications that drive business growth and enhance user experiences. Our team combines technical expertise with creative thinking to deliver exceptional results for our clients.';

  String get stat1Label => language == AppLanguage.id ? 'Tahun Pengalaman' : 'Years Experience';
  String get stat2Label => language == AppLanguage.id ? 'Proyek Selesai' : 'Projects Delivered';
  String get stat3Label => language == AppLanguage.id ? 'Kepuasan Klien' : 'Client Satisfaction';

  // ─── Services Section ──────────────────────────────────────────────────────
  String get servicesTitle => language == AppLanguage.id ? 'Layanan Kami' : 'Our Services';
  String get servicesSubtitle => language == AppLanguage.id
      ? 'Kami menawarkan layanan pengembangan aplikasi yang komprehensif'
      : 'We offer comprehensive application development services';

  String get service1Title => language == AppLanguage.id ? 'Aplikasi Web' : 'Web Applications';
  String get service1Desc => language == AppLanguage.id
      ? 'Solusi web kustom dibangun dengan framework modern seperti Flutter Web dan React'
      : 'Custom web solutions built with modern frameworks like Flutter Web and React';

  String get service2Title => language == AppLanguage.id ? 'Aplikasi Mobile' : 'Mobile Applications';
  String get service2Desc => language == AppLanguage.id
      ? 'Aplikasi mobile cross-platform untuk iOS dan Android menggunakan Flutter dan Dart'
      : 'Cross-platform mobile apps for iOS and Android using Flutter and Dart';

  String get service3Title => language == AppLanguage.id ? 'Aplikasi Desktop' : 'Desktop Applications';
  String get service3Desc => language == AppLanguage.id
      ? 'Solusi perangkat lunak desktop profesional untuk bisnis dan produktivitas'
      : 'Professional desktop software solutions for business and productivity';

  String get service4Title => language == AppLanguage.id ? 'Perangkat Lunak Kustom' : 'Custom Software';
  String get service4Desc => language == AppLanguage.id
      ? 'Pengembangan perangkat lunak yang disesuaikan untuk memenuhi kebutuhan bisnis spesifik Anda'
      : 'Tailored software development to meet your specific business needs';

  // ─── Product Preview ───────────────────────────────────────────────────────
  String get featuredTitle => language == AppLanguage.id ? 'Produk Unggulan' : 'Featured Product';
  String get mapotechDesc => language == AppLanguage.id
      ? '1 Ekosistem, 3 Solusi Kesehatan Digital — Menghubungkan pasien, dokter, dan apotek dalam satu platform'
      : '1 Ecosystem, 3 Digital Health Solutions — Connecting patients, doctors, and pharmacies in one platform';
  String get mapotekDesc => mapotechDesc;
  String get feat1 => language == AppLanguage.id ? 'Smart\nEMR' : 'Smart\nEMR';
  String get feat2 => language == AppLanguage.id ? 'E-Resep\nDigital' : 'Digital\nE-Rx';
  String get feat3 => language == AppLanguage.id ? 'Smart\nApotek' : 'Smart\nPharmacy';
  String get seeMoreBtn => language == AppLanguage.id ? 'Lihat Lebih Banyak Produk' : 'See More Products';

  // ─── Contact Section ───────────────────────────────────────────────────────
  String get contactTitle => language == AppLanguage.id ? 'Hubungi Kami' : 'Get In Touch';
  String get contactSubtitle => language == AppLanguage.id
      ? 'Siap mewujudkan ide Anda? Hubungi kami sekarang!'
      : 'Ready to bring your ideas to life? Contact us today!';
  String get contactPerson => language == AppLanguage.id ? 'Kontak Person' : 'Contact Person';
  String get contactWhatsApp => language == AppLanguage.id
      ? 'Hubungi via WhatsApp'
      : 'Contact via WhatsApp';

  // ─── Products Page ─────────────────────────────────────────────────────────
  String get productsTitle => language == AppLanguage.id ? 'Produk Kami' : 'Our Products';
  String get productsSubtitle => language == AppLanguage.id
      ? 'Temukan rangkaian solusi digital inovatif kami yang dirancang untuk mengubah operasi bisnis Anda.'
      : 'Discover our range of innovative digital solutions designed to transform your business operations.';
  String get learnMore => language == AppLanguage.id ? 'Pelajari Lebih Lanjut' : 'Learn More';
  String get tryMapotech => language == AppLanguage.id ? 'Lihat MAPOTECH' : 'Explore MAPOTECH';
  // Keep backward compat alias
  String get tryMapotek => tryMapotech;
  String get flagship => language == AppLanguage.id ? 'PRODUK UNGGULAN' : 'FLAGSHIP PRODUCT';
  String get comingSoon => language == AppLanguage.id ? 'Segera Hadir' : 'Coming soon!';

  // ─── Settings Panel ────────────────────────────────────────────────────────
  String get settingsTitle => language == AppLanguage.id ? 'Pengaturan' : 'Settings';
  String get themeLabel => language == AppLanguage.id ? 'Tema' : 'Theme';
  String get languageLabel => language == AppLanguage.id ? 'Bahasa' : 'Language';
  String get themeLight => language == AppLanguage.id ? 'Terang' : 'Light';
  String get themeDark => language == AppLanguage.id ? 'Gelap' : 'Dark';
  String get langEn => language == AppLanguage.id ? 'Inggris' : 'English';
  String get langId => language == AppLanguage.id ? 'Indonesia' : 'Indonesian';
}
