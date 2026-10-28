import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folio/domain/entities/app_language.dart';
import 'package:folio/features/settings/presentation/bloc/settings_bloc.dart';

/// Hand-written localization for the static interface copy.
///
/// Content that lives in `portfolio.json` is localized by the domain entities
/// (`taglineIn`, `bioIn`, …). This class only covers strings that are part of
/// the app chrome and shared widgets. Indonesian is the source language, so
/// lookups fall back to the key itself.
class AppStrings {
  const AppStrings(this.language);

  final AppLanguage language;

  bool get isEnglish => language.isEnglish;

  String tr(String source) => isEnglish ? _english[source] ?? source : source;

  String trArgs(String source, Map<String, String> values) {
    var result = tr(source);
    for (final entry in values.entries) {
      result = result.replaceAll('{${entry.key}}', entry.value);
    }
    return result;
  }
}

extension AppLocalization on BuildContext {
  AppLanguage get language => watch<SettingsBloc>().state.language;

  AppStrings get strings => AppStrings(language);

  String tr(String source) => strings.tr(source);

  String trArgs(String source, Map<String, String> values) =>
      strings.trArgs(source, values);

  /// For callbacks that run outside the build phase (snack bars, shares…).
  String readTr(String source) =>
      AppStrings(read<SettingsBloc>().state.language).tr(source);

  String readTrArgs(String source, Map<String, String> values) =>
      AppStrings(read<SettingsBloc>().state.language).trArgs(source, values);
}

const Map<String, String> _english = {
  // Shell & navigation.
  'PORTOFOLIO': 'PORTFOLIO',
  'Tema': 'Theme',
  'Tema terang': 'Light theme',
  'Tema gelap': 'Dark theme',
  'Beranda': 'Home',
  'Fitur': 'Features',
  'PRATINJAU WEB · {year}': 'WEB PREVIEW · {year}',
  'Sesi': 'Session',
  'Waktu': 'Time',
  'Aktivitas': 'Activity',
  'Sisa bulan ini': 'Left this month',
  '+12,4% dari bulan lalu': '+12.4% from last month',
  'Baru dari pengrajin': 'New from makers',
  'Ke mana minggu ini?': 'Where to this week?',
  'Jelajah': 'Explore',
  'Tersimpan': 'Saved',
  'Tentang': 'About',
  'Cari karya': 'Search work',
  'Ganti tema': 'Switch theme',
  'Buka profil': 'Open profile',
  'Ganti ke tema terang': 'Switch to light theme',
  'Ganti ke tema gelap': 'Switch to dark theme',
  'Ganti bahasa': 'Switch language',
  'Bahasa': 'Language',
  'Bahasa Indonesia': 'Indonesian',
  'English': 'English',
  'Kembali': 'Back',
  'Folio, beranda': 'Folio, home',
  'Halaman tidak ditemukan': 'Page not found',
  'Kembali ke beranda': 'Back to home',
  'Punya ide\nyang ingin dibuat?': 'Got an idea\nyou want to build?',
  'Mari bicara soal produk, alur, dan detailnya.':
      "Let's talk about the product, the flow, and the details.",
  'Ajak kolaborasi': "Let's collaborate",
  'Mulai percakapan': 'Start a conversation',

  // Footer & shared feedback.
  'Portofolio saya, disusun seperti app store.':
      'My portfolio, arranged like an app store.',
  '© {year} {name} · Dibuat dengan Flutter':
      '© {year} {name} · Built with Flutter',
  'Dibuat dengan Flutter': 'Built with Flutter',
  'Tautan {platform} belum bisa dibuka.':
      'The {platform} link could not be opened.',
  'Tautannya belum bisa dibuka.': 'The link could not be opened.',
  'Salin tautan': 'Copy link',
  'Sudah disalin.': 'Copied.',
  'Salin email': 'Copy email',
  'Email disalin.': 'Email copied.',
  'Nomor telepon disalin.': 'Phone number copied.',

  // Home.
  'Portofolio · 2026': 'Portfolio · 2026',
  'Temukan ': 'Discover ',
  'karya': 'work',
  ' yang\nsedang saya bangun.': " I'm\ncurrently building.",
  'Portofolio saya, disusun seperti app store. Jelajahi aplikasi dan website yang saya bangun, buka studi kasusnya, lalu simpan yang paling relevan untukmu.':
      'My portfolio, arranged like an app store. Browse the apps and websites I built, open the case studies, and save the ones that matter to you.',
  'Karya pilihan': 'Selected work',
  'Proyek & modul': 'Projects & modules',
  'Pengalaman': 'Experience',
  'MULAI DARI SINI': 'START HERE',
  'Jelajahi kategori': 'Explore categories',
  'Temukan karya sesuai bidang yang sedang kamu cari.':
      'Find work in the field you are looking for.',
  '{count} karya': '{count} works',
  'BARU SAYA RILIS': 'JUST RELEASED',
  'Rilis terbaru': 'Latest releases',
  'Karya yang baru saya selesaikan—dari eksplorasi pertama sampai rilis.':
      'Work I just wrapped up—from first exploration to release.',
  'Jelajah semua': 'Explore all',
  'DI BALIK LAYAR': 'BEHIND THE SCREENS',
  'Desain yang rapi,\nkode yang tenang.': 'Tidy design,\ncalm code.',
  'Desain yang rapi,\n': 'Tidy design,\n',
  'kode yang tenang.': 'calm code.',
  'Saya menghubungkan riset, desain, dan engineering untuk bikin produk yang terasa sederhana—dan bertahan lama.':
      'I connect research, design, and engineering to build products that feel simple—and last.',
  'Kenalan lebih dekat': 'Get to know me',
  'Mobile Developer': 'Mobile Developer',
  'Full Stack': 'Full Stack',
  'Tampilkan pilihan {index}': 'Show item {index}',
  'Pilihan sebelumnya': 'Previous item',
  'Pilihan berikutnya': 'Next item',
  'PILIHAN SAYA': 'MY PICK',
  'Buka proyek': 'Open project',

  // Explore.
  'Jelajah koleksi': 'Explore the collection',
  'semua karya.': 'every project.',
  'Cari berdasarkan nama proyek, teknologi, atau kategori. Semua studi kasus saya ada di sini.':
      'Search by project name, technology, or category. All my case studies live here.',
  'Belum ada yang cocok': 'No matches yet',
  'Coba kata kunci lain, atau hapus filter kategorinya buat lihat semua karya.':
      'Try another keyword, or clear the category filter to see every project.',
  'Tampilkan semua': 'Show all',
  '{count} hasil ditemukan': '{count} results found',
  '{count} karya pilihan': '{count} selected works',
  'untuk “{query}”': 'for “{query}”',
  'di {category}': 'in {category}',
  'Reset': 'Reset',
  'Semua': 'All',
  'Cari proyek, teknologi, atau kategori…':
      'Search projects, tech, or categories…',
  'Hapus pencarian': 'Clear search',

  // Saved.
  'Koleksi pribadi': 'Personal collection',
  'Karya yang\nkamu ': 'Work you\n',
  'simpan.': 'saved.',
  'Hanya tersimpan di perangkat ini.': 'Only saved on this device.',
  'Belum ada karya tersimpan': 'No saved work yet',
  'Ketuk ikon simpan di proyek buat menyimpannya di sini. Koleksimu tetap ada saat kamu kembali.':
      'Tap the save icon on a project to keep it here. Your collection stays when you come back.',
  'Mulai jelajah': 'Start exploring',
  '{count} karya tersimpan': '{count} saved works',
  'Tambah karya': 'Add work',

  // About.
  'Tentang saya': 'About me',
  'Halo, saya {name}.\n': "Hi, I'm {name}.\n",
  'Saya bikin produk\nyang ': 'I build products\nthat are ',
  'siap dipakai.': 'ready to use.',
  'Lihat karya': 'View work',
  'Tahun pengalaman': 'Years of experience',
  'Kolaborasi': 'Collaborations',
  'Cara saya bekerja': 'How I work',
  'Prinsip yang saya pegang': 'Principles I hold',
  'Ini bukan aturan kaku—cuma cara saya mengambil keputusan.':
      'These are not rigid rules—just how I make decisions.',
  'Perangkat kerja': 'Toolbox',
  'Hal yang saya kuasai': "What I'm good at",
  'Dari merancang alur di Figma sampai merilis build yang stabil.':
      'From mapping flows in Figma to shipping stable builds.',
  '{count} tools': '{count} tools',
  'Perjalanan': 'Journey',
  'Belajar sambil membangun': 'Learning by building',
  'Dari magang dan Bangkit Academy sampai aplikasi enterprise yang dipakai di lapangan.':
      'From internships and Bangkit Academy to enterprise apps used in the field.',
  'SEKARANG': 'NOW',
  'Pendidikan & organisasi': 'Education & organizations',
  'Tempat saya belajar dan tumbuh': 'Where I learned and grew',
  'Dari SMK sampai kuliah, plus pengalaman organisasi.':
      'From vocational school to university, plus organizational experience.',
  'PENDIDIKAN': 'EDUCATION',
  'ORGANISASI': 'ORGANIZATIONS',
  'Preferensi tampilan': 'Display preferences',
  'Pilih tema yang paling nyaman. Pilihanmu disimpan di perangkat ini.':
      'Pick the theme that feels best. Your choice is stored on this device.',
  'Sistem': 'System',
  'Terang': 'Light',
  'Gelap': 'Dark',
  'ADA YANG INGIN DIBANGUN?': 'SOMETHING TO BUILD?',
  'Ceritakan idemu.': 'Tell me your idea.',
  'Saya terbuka untuk proyek produk, aplikasi, dan kolaborasi jangka panjang.':
      "I'm open to product work, apps, and long-term collaborations.",

  // Contact.
  'Membuka aplikasi email kamu…': 'Opening your email app…',
  'Aplikasi email tidak tersedia.': 'Email app is not available.',
  'Aplikasi email tidak tersedia di perangkat ini.':
      'Email app is not available on this device.',
  'Kontak': 'Contact',
  'Mari bikin sesuatu\nyang ': "Let's make something\n",
  'berkesan.': 'memorable.',
  'Punya produk yang ingin dibangun, alur yang ingin dirapikan, atau ide yang masih setengah jadi? Ceritakan saja — saya senang mendengarnya.':
      'Have a product to build, a flow to untangle, or a half-formed idea? Tell me about it — I would love to hear it.',
  'Tulis pesan': 'Write a message',
  'Saya terbuka untuk proyek dan diskusi.':
      "I'm open to projects and conversations.",
  'Nama': 'Name',
  'Nama lengkap': 'Full name',
  'Jenis proyek': 'Project type',
  'Pesan': 'Message',
  'Ceritakan sedikit tentang produk, tujuan, dan waktu yang kamu bayangkan…':
      'Tell me a little about the product, the goal, and the timing you have in mind…',
  'Menyiapkan email…': 'Preparing email…',
  'Buka aplikasi email': 'Open email app',
  'Form ini cuma membuka aplikasi email dengan pesan yang sudah terisi. Tidak ada data yang dikirim ke server.':
      'This form only opens your email app with the message pre-filled. No data is sent to a server.',
  'Telepon': 'Phone',
  'Email': 'Email',
  'Lokasi': 'Location',
  'Waktu respons': 'Response time',
  'Biasanya dalam 1–2 hari kerja': 'Usually within 1–2 business days',
  'TEMUKAN SAYA DI': 'FIND ME ON',
  'Prosesnya sederhana': 'The process is simple',
  'Kamu ceritakan konteks dan tujuan.': 'You share the context and the goal.',
  'Saya balas dengan pertanyaan dan kemungkinan arah.':
      'I reply with questions and a possible direction.',
  'Kita jadwalkan percakapan singkat tanpa tekanan.':
      'We schedule a short, no-pressure conversation.',
  'Aplikasi mobile': 'Mobile app',
  'Desain produk': 'Product design',
  'Konsultasi': 'Consulting',
  'Kolaborasi lain': 'Other collaboration',
  'Nama kamu belum diisi.': 'Your name is still empty.',
  'Format emailnya belum benar.': 'That email format is not right yet.',
  'Ceritakan sedikit lebih banyak—minimal 20 karakter.':
      'Tell me a bit more—at least 20 characters.',

  // Project detail.
  'Proyek tidak ditemukan.': 'Project not found.',
  'Bagikan proyek': 'Share project',
  'Versi web': 'Web version',
  'Tautan proyek disalin.': 'Project link copied.',
  'Saya, {name}': 'Me, {name}',
  'Ajukan kolaborasi': 'Propose a collaboration',
  'Informasi': 'Information',
  'TIPE': 'TYPE',
  'TAHUN': 'YEAR',
  'Kategori': 'Category',
  'Peran': 'Role',
  'Durasi': 'Timeline',
  'Status': 'Status',
  'Platform': 'Platform',
  'Dibuat dengan': 'Built with',
  'Tertarik dengan pendekatan ini?': 'Interested in this approach?',
  'Ceritakan tantangan produkmu. Saya senang membantu memetakan langkah pertamanya.':
      'Tell me about your product challenge. I enjoy helping map the first step.',
  'Repositori GitHub': 'GitHub repository',
  'Website live': 'Live website',
  'Web demo': 'Web demo',
  'Unduh APK': 'Download APK',
  'Tautan': 'Links',
  'STUDI KASUS': 'CASE STUDY',
  'Cerita di balik proyek': 'The story behind the project',
  'YANG SAYA RANCANG': 'WHAT I DESIGNED',
  'Fitur utama': 'Key features',
  'Yang baru dirilis': "What's new",
  'Tampilan aplikasi': 'App screens',
  'Tangkapan layar asli, dari alur utama sampai fiturnya.':
      'Real captures, from the main flow to the details.',
  'Tiga layar yang menunjukkan arah visual dan alur utama.':
      'Three screens showing the visual direction and main flow.',
  '{count} TANGKAPAN': '{count} CAPTURES',
  '3 LAYAR': '3 SCREENS',
  'Situs live': 'Live site',
  'LIVE': 'LIVE',
  'Jelajahi situsnya langsung di sini, atau buka di tab baru.':
      'Explore the site right here, or open it in a new tab.',
  'Situs live tampil langsung di sini—geser di dalam bingkai atau buka di tab baru.':
      'The live site renders right here—scroll inside the frame or open it in a new tab.',
  'Muat ulang': 'Reload',
  'Buka langsung': 'Open live',
  'Situsnya belum bisa dibuka dari preview.':
      'The site could not be opened from the preview.',
  'Kamu bisa tetap di halaman ini atau buka situsnya langsung di tab baru.':
      'You can stay on this page or open the site in a new tab.',
  'Proyek ini belum punya situs live untuk ditampilkan.':
      'This project has no live site to show yet.',
  'Proyek ini belum punya situs live untuk dibuka.':
      'This project has no live site to open yet.',
  'Belum ada situs live': 'No live site yet',
  'Tampilan situs': 'Website screens',
  'Tangkapan halaman asli, dari beranda sampai formulir.':
      'Real page captures, from the home page to the form.',
  '{count} HALAMAN': '{count} PAGES',
  'LANJUTKAN MENJELAJAH': 'KEEP EXPLORING',
  'Karya lain yang mungkin cocok': 'Other work you might like',
  'Lihat semua': 'See all',
  'Lihat': 'View',
  'Cari destinasi': 'Search destinations',
  'Cari karya lokal': 'Find local work',
  'Muat ulang preview': 'Reload preview',

  // Screenshot galleries.
  'Utama': 'Main',
  'Detail': 'Detail',
  'Ringkasan': 'Summary',
  'tangkapan layar asli dari aplikasi.': 'real captures from the app.',
  '{count} tangkapan layar asli—geser untuk lihat semua.':
      '{count} real captures—swipe to see them all.',
  'Tiga layar utama, dari alur sampai ringkasan.':
      'Three key screens, from the flow to the summary.',
  'Geser untuk melihat pratinjau': 'Swipe to see the previews',
  '{count} tangkapan layar asli dari aplikasi.':
      '{count} real captures from the app.',
  '{count} halaman asli dari situs live.':
      '{count} real pages from the live site.',
  '{count} halaman asli—geser untuk lihat semua.':
      '{count} real pages—swipe to see them all.',
  'Buka situs': 'Open site',

  // Favorites.
  '{name} dihapus dari tersimpan.': '{name} removed from saved.',
  '{name} disimpan.': '{name} saved.',
  'Hapus dari tersimpan': 'Remove from saved',
  'Simpan proyek': 'Save project',
  'Simpan': 'Save',

  // Categories, types, skill groups, platforms.
  'AI & Kreatif': 'AI & Creative',
  'Produktivitas': 'Productivity',
  'Kuliner': 'Food',
  'Karier': 'Career',
  'Eksperimen': 'Experiments',
  'Arsitektur': 'Architecture',
  'Desain': 'Design',
  'Produk & Operasi': 'Product & Ops',
  'Web · Responsif': 'Web · Responsive',
};
