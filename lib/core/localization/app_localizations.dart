import 'package:flutter/material.dart';
import 'package:folio/domain/entities/app_language.dart';

/// Lightweight, compile-safe localization for the two supported languages.
///
/// Keeping the dictionary in Dart makes it easy to use translated strings in
/// tests without generating code, while `t(id, en)` keeps every screen explicit
/// about both languages. Indonesian is the source language.
class AppLocalizations {
  const AppLocalizations(this.locale);

  final Locale locale;

  static const List<Locale> supportedLocales = [Locale('id'), Locale('en')];

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  bool get isId => locale.languageCode != 'en';

  String t(String id, String en) => isId ? id : en;

  // Shell & navigation.
  String get portfolio => t('PORTOFOLIO', 'PORTFOLIO');
  String get theme => t('Tema', 'Theme');
  String get lightTheme => t('Tema terang', 'Light theme');
  String get darkTheme => t('Tema gelap', 'Dark theme');
  String get home => t('Beranda', 'Home');
  String get features => t('Fitur', 'Features');
  String webPreview(String year) =>
      t('PRATINJAU WEB · $year', 'WEB PREVIEW · $year');
  String get session => t('Sesi', 'Session');
  String get time => t('Waktu', 'Time');
  String get activity => t('Aktivitas', 'Activity');
  String get leftThisMonth => t('Sisa bulan ini', 'Left this month');
  String get monthlyDelta =>
      t('+12,4% dari bulan lalu', '+12.4% from last month');
  String get newFromMakers => t('Baru dari pengrajin', 'New from makers');
  String get whereToThisWeek => t('Ke mana minggu ini?', 'Where to this week?');
  String get explore => t('Jelajah', 'Explore');
  String get savedTab => t('Tersimpan', 'Saved');
  String get about => t('Tentang', 'About');
  String get searchWork => t('Cari karya', 'Search work');
  String get openProfile => t('Buka profil', 'Open profile');
  String get switchToLightTheme =>
      t('Ganti ke tema terang', 'Switch to light theme');
  String get switchToDarkTheme =>
      t('Ganti ke tema gelap', 'Switch to dark theme');
  String get switchLanguage => t('Ganti bahasa', 'Switch language');
  String get language => t('Bahasa', 'Language');
  String get back => t('Kembali', 'Back');
  String get folioHome => t('Folio, beranda', 'Folio, home');
  String get pageNotFound => t('Halaman tidak ditemukan', 'Page not found');
  String get backToHome => t('Kembali ke beranda', 'Back to home');
  String get ideaPrompt =>
      t('Punya ide\nyang ingin dibuat?', 'Got an idea\nyou want to build?');
  String get collaboratePrompt => t(
    'Mari bicara soal produk, alur, dan detailnya.',
    "Let's talk about the product, the flow, and the details.",
  );
  String get collaborateCta => t('Ajak kolaborasi', "Let's collaborate");
  String get startConversation => t('Mulai percakapan', 'Start a conversation');

  // Footer & shared feedback.
  String get footerTagline => t(
    'Portofolio saya, disusun seperti app store.',
    'My portfolio, arranged like an app store.',
  );
  String copyright(String year, String name) => t(
    '© $year $name · Dibuat dengan Flutter',
    '© $year $name · Built with Flutter',
  );
  String linkOpenFailed(String platform) => t(
    'Tautan $platform belum bisa dibuka.',
    'The $platform link could not be opened.',
  );
  String get linkOpenFailedGeneric =>
      t('Tautannya belum bisa dibuka.', 'The link could not be opened.');
  String get copyLink => t('Salin tautan', 'Copy link');
  String get copied => t('Sudah disalin.', 'Copied.');
  String get copyEmail => t('Salin email', 'Copy email');
  String get emailCopied => t('Email disalin.', 'Email copied.');
  String get phoneCopied => t('Nomor telepon disalin.', 'Phone number copied.');

  // Home.
  String get portfolioYear => t('Portofolio · 2026', 'Portfolio · 2026');
  String get heroPrefix => t('Temukan ', 'Discover ');
  String get heroHighlight => t('karya', 'work');
  String get heroSuffix =>
      t(' yang\nsedang saya bangun.', " I'm\ncurrently building.");
  String get heroDescription => t(
    'Portofolio saya, disusun seperti app store. Jelajahi aplikasi dan website yang saya bangun, buka studi kasusnya, lalu simpan yang paling relevan untukmu.',
    'My portfolio, arranged like an app store. Browse the apps and websites I built, open the case studies, and save the ones that matter to you.',
  );
  String get selectedWork => t('Karya pilihan', 'Selected work');
  String get projectsAndModules => t('Proyek & modul', 'Projects & modules');
  String get experience => t('Pengalaman', 'Experience');
  String get startHere => t('MULAI DARI SINI', 'START HERE');
  String get exploreCategories => t('Jelajahi kategori', 'Explore categories');
  String get exploreCategoriesBody => t(
    'Temukan karya sesuai bidang yang sedang kamu cari.',
    'Find work in the field you are looking for.',
  );
  String projectCount(String count) => t('$count karya', '$count works');
  String get justReleased => t('BARU SAYA RILIS', 'JUST RELEASED');
  String get latestReleases => t('Rilis terbaru', 'Latest releases');
  String get latestReleasesBody => t(
    'Karya yang baru saya selesaikan—dari eksplorasi pertama sampai rilis.',
    'Work I just wrapped up—from first exploration to release.',
  );
  String get exploreAll => t('Jelajah semua', 'Explore all');
  String get behindTheScreens => t('DI BALIK LAYAR', 'BEHIND THE SCREENS');
  String get tidyDesign => t('Desain yang rapi,\n', 'Tidy design,\n');
  String get calmCode => t('kode yang tenang.', 'calm code.');
  String get makerBody => t(
    'Saya menghubungkan riset, desain, dan engineering untuk bikin produk yang terasa sederhana—dan bertahan lama.',
    'I connect research, design, and engineering to build products that feel simple—and last.',
  );
  String get getToKnowMe => t('Kenalan lebih dekat', 'Get to know me');
  String get mobileDeveloper => t('Mobile Developer', 'Mobile Developer');
  String get fullStack => t('Full Stack', 'Full Stack');
  String showItem(String index) =>
      t('Tampilkan pilihan $index', 'Show item $index');
  String get previousItem => t('Pilihan sebelumnya', 'Previous item');
  String get nextItem => t('Pilihan berikutnya', 'Next item');
  String get myPick => t('PILIHAN SAYA', 'MY PICK');
  String get openProject => t('Buka proyek', 'Open project');

  // Explore.
  String get exploreTitle => t('Jelajah koleksi', 'Explore the collection');
  String get exploreHighlight => t('semua karya.', 'every project.');
  String get exploreBody => t(
    'Cari berdasarkan nama proyek, teknologi, atau kategori. Semua studi kasus saya ada di sini.',
    'Search by project name, technology, or category. All my case studies live here.',
  );
  String get noMatches => t('Belum ada yang cocok', 'No matches yet');
  String get noMatchesBody => t(
    'Coba kata kunci lain, atau hapus filter kategorinya buat lihat semua karya.',
    'Try another keyword, or clear the category filter to see every project.',
  );
  String get showAll => t('Tampilkan semua', 'Show all');
  String resultsFound(String count) =>
      t('$count hasil ditemukan', '$count results found');
  String selectedWorksCount(String count) =>
      t('$count karya pilihan', '$count selected works');
  String searchFor(String query) => t('untuk “$query”', 'for “$query”');
  String inCategory(String category) => t('di $category', 'in $category');
  String get reset => t('Reset', 'Reset');
  String get all => t('Semua', 'All');
  String get searchPlaceholder => t(
    'Cari proyek, teknologi, atau kategori…',
    'Search projects, tech, or categories…',
  );
  String get clearSearch => t('Hapus pencarian', 'Clear search');

  // Saved.
  String get savedTitle => t('Koleksi pribadi', 'Personal collection');
  String get savedHeadlineLead => t('Karya yang\nkamu ', 'Work you\n');
  String get savedHeadlineAccent => t('simpan.', 'saved.');
  String get savedSubtitle =>
      t('Hanya tersimpan di perangkat ini.', 'Only saved on this device.');
  String get savedEmptyTitle =>
      t('Belum ada karya tersimpan', 'No saved work yet');
  String get savedEmptyBody => t(
    'Ketuk ikon simpan di proyek buat menyimpannya di sini. Koleksimu tetap ada saat kamu kembali.',
    'Tap the save icon on a project to keep it here. Your collection stays when you come back.',
  );
  String get startExploring => t('Mulai jelajah', 'Start exploring');
  String savedCount(String count) =>
      t('$count karya tersimpan', '$count saved works');
  String get addWork => t('Tambah karya', 'Add work');

  // About.
  String get aboutMe => t('Tentang saya', 'About me');
  String greeting(String name) => t('Halo, saya $name.\n', "Hi, I'm $name.\n");
  String get aboutHeadlineLead =>
      t('Saya bikin produk\nyang ', 'I build products\nthat are ');
  String get aboutHeadlineAccent => t('siap dipakai.', 'ready to use.');
  String get viewWork => t('Lihat karya', 'View work');
  String get yearsOfExperience => t('Tahun pengalaman', 'Years of experience');
  String get collaborations => t('Kolaborasi', 'Collaborations');
  String get howIWork => t('Cara saya bekerja', 'How I work');
  String get principlesTitle =>
      t('Prinsip yang saya pegang', 'Principles I hold');
  String get principlesBody => t(
    'Ini bukan aturan kaku—cuma cara saya mengambil keputusan.',
    'These are not rigid rules—just how I make decisions.',
  );
  String get toolboxTitle => t('Perangkat kerja', 'Toolbox');
  String get toolboxSubtitle => t('Hal yang saya kuasai', "What I'm good at");
  String get toolboxBody => t(
    'Dari merancang alur di Figma sampai merilis build yang stabil.',
    'From mapping flows in Figma to shipping stable builds.',
  );
  String toolsCount(String count) => t('$count tools', '$count tools');
  String get journey => t('Perjalanan', 'Journey');
  String get journeyTitle =>
      t('Belajar sambil membangun', 'Learning by building');
  String get journeyBody => t(
    'Dari magang dan Bangkit Academy sampai aplikasi enterprise yang dipakai di lapangan.',
    'From internships and Bangkit Academy to enterprise apps used in the field.',
  );
  String get now => t('SEKARANG', 'NOW');
  String get educationTitle =>
      t('Pendidikan & organisasi', 'Education & organizations');
  String get educationSubtitle =>
      t('Tempat saya belajar dan tumbuh', 'Where I learned and grew');
  String get educationBody => t(
    'Dari SMK sampai kuliah, plus pengalaman organisasi.',
    'From vocational school to university, plus organizational experience.',
  );
  String get educationLabel => t('PENDIDIKAN', 'EDUCATION');
  String get organizationsLabel => t('ORGANISASI', 'ORGANIZATIONS');
  String get displayPreferences =>
      t('Preferensi tampilan', 'Display preferences');
  String get displayPreferencesBody => t(
    'Pilih tema yang paling nyaman. Pilihanmu disimpan di perangkat ini.',
    'Pick the theme that feels best. Your choice is stored on this device.',
  );
  String get system => t('Sistem', 'System');
  String get light => t('Terang', 'Light');
  String get dark => t('Gelap', 'Dark');
  String get somethingToBuild =>
      t('ADA YANG INGIN DIBANGUN?', 'SOMETHING TO BUILD?');
  String get tellMeYourIdea => t('Ceritakan idemu.', 'Tell me your idea.');
  String get contactCtaBody => t(
    'Saya terbuka untuk proyek produk, aplikasi, dan kolaborasi jangka panjang.',
    "I'm open to product work, apps, and long-term collaborations.",
  );

  // Contact.
  String get openingEmailApp =>
      t('Membuka aplikasi email kamu…', 'Opening your email app…');
  String get emailAppUnavailableOnDevice => t(
    'Aplikasi email tidak tersedia di perangkat ini.',
    'Email app is not available on this device.',
  );
  String get contactTitle => t('Kontak', 'Contact');
  String get contactHeadlineLead =>
      t('Mari bikin sesuatu\nyang ', "Let's make something\n");
  String get contactHeadlineAccent => t('berkesan.', 'memorable.');
  String get contactBody => t(
    'Punya produk yang ingin dibangun, alur yang ingin dirapikan, atau ide yang masih setengah jadi? Ceritakan saja — saya senang mendengarnya.',
    'Have a product to build, a flow to untangle, or a half-formed idea? Tell me about it — I would love to hear it.',
  );
  String get writeMessage => t('Tulis pesan', 'Write a message');
  String get contactAvailability => t(
    'Saya terbuka untuk proyek dan diskusi.',
    "I'm open to projects and conversations.",
  );
  String get nameLabel => t('Nama', 'Name');
  String get fullName => t('Nama lengkap', 'Full name');
  String get projectType => t('Jenis proyek', 'Project type');
  String get messageLabel => t('Pesan', 'Message');
  String get messageHint => t(
    'Ceritakan sedikit tentang produk, tujuan, dan waktu yang kamu bayangkan…',
    'Tell me a little about the product, the goal, and the timing you have in mind…',
  );
  String get preparingEmail => t('Menyiapkan email…', 'Preparing email…');
  String get openEmailApp => t('Buka aplikasi email', 'Open email app');
  String get formDisclaimer => t(
    'Form ini cuma membuka aplikasi email dengan pesan yang sudah terisi. Tidak ada data yang dikirim ke server.',
    'This form only opens your email app with the message pre-filled. No data is sent to a server.',
  );
  String get phone => t('Telepon', 'Phone');
  String get email => t('Email', 'Email');
  String get location => t('Lokasi', 'Location');
  String get responseTime => t('Waktu respons', 'Response time');
  String get responseTimeValue =>
      t('Biasanya dalam 1–2 hari kerja', 'Usually within 1–2 business days');
  String get findMeOn => t('TEMUKAN SAYA DI', 'FIND ME ON');
  String get processTitle => t('Prosesnya sederhana', 'The process is simple');
  String get processStepContext => t(
    'Kamu ceritakan konteks dan tujuan.',
    'You share the context and the goal.',
  );
  String get processStepReply => t(
    'Saya balas dengan pertanyaan dan kemungkinan arah.',
    'I reply with questions and a possible direction.',
  );
  String get processStepSchedule => t(
    'Kita jadwalkan percakapan singkat tanpa tekanan.',
    'We schedule a short, no-pressure conversation.',
  );
  String get projectTypeMobile => t('Aplikasi mobile', 'Mobile app');
  String get projectTypeDesign => t('Desain produk', 'Product design');
  String get projectTypeConsulting => t('Konsultasi', 'Consulting');
  String get projectTypeOther => t('Kolaborasi lain', 'Other collaboration');
  String get nameError =>
      t('Nama kamu belum diisi.', 'Your name is still empty.');
  String get emailError =>
      t('Format emailnya belum benar.', 'That email format is not right yet.');
  String get messageError => t(
    'Ceritakan sedikit lebih banyak—minimal 20 karakter.',
    'Tell me a bit more—at least 20 characters.',
  );

  // Project detail.
  String get projectNotFound =>
      t('Proyek tidak ditemukan.', 'Project not found.');
  String get shareProject => t('Bagikan proyek', 'Share project');
  String get webVersion => t('Versi web', 'Web version');
  String get projectLinkCopied =>
      t('Tautan proyek disalin.', 'Project link copied.');
  String me(String name) => t('Saya, $name', 'Me, $name');
  String get proposeCollaboration =>
      t('Ajukan kolaborasi', 'Propose a collaboration');
  String get information => t('Informasi', 'Information');
  String get typeLabel => t('TIPE', 'TYPE');
  String get yearLabel => t('TAHUN', 'YEAR');
  String get categoryLabel => t('Kategori', 'Category');
  String get roleLabel => t('Peran', 'Role');
  String get timelineLabel => t('Durasi', 'Timeline');
  String get statusLabel => t('Status', 'Status');
  String get platformLabel => t('Platform', 'Platform');
  String get builtWith => t('Dibuat dengan', 'Built with');
  String get interestedTitle =>
      t('Tertarik dengan pendekatan ini?', 'Interested in this approach?');
  String get interestedBody => t(
    'Ceritakan tantangan produkmu. Saya senang membantu memetakan langkah pertamanya.',
    'Tell me about your product challenge. I enjoy helping map the first step.',
  );
  String get githubRepository => t('Repositori GitHub', 'GitHub repository');
  String get liveWebsite => t('Website live', 'Live website');
  String get webDemo => t('Web demo', 'Web demo');
  String get downloadApk => t('Unduh APK', 'Download APK');
  String get links => t('Tautan', 'Links');
  String get caseStudy => t('STUDI KASUS', 'CASE STUDY');
  String get storyTitle =>
      t('Cerita di balik proyek', 'The story behind the project');
  String get designedLabel => t('YANG SAYA RANCANG', 'WHAT I DESIGNED');
  String get keyFeatures => t('Fitur utama', 'Key features');
  String get whatsNew => t('Yang baru dirilis', "What's new");
  String get appScreens => t('Tampilan aplikasi', 'App screens');
  String get appScreensBody => t(
    'Tangkapan layar asli, dari alur utama sampai fiturnya.',
    'Real captures, from the main flow to the details.',
  );
  String get threeScreensBody => t(
    'Tiga layar yang menunjukkan arah visual dan alur utama.',
    'Three screens showing the visual direction and main flow.',
  );
  String capturesCount(String count) =>
      t('$count TANGKAPAN', '$count CAPTURES');
  String get threeScreens => t('3 LAYAR', '3 SCREENS');
  String get liveSite => t('Situs live', 'Live site');
  String get live => t('LIVE', 'LIVE');
  String get liveSiteBody => t(
    'Jelajahi situsnya langsung di sini, atau buka di tab baru.',
    'Explore the site right here, or open it in a new tab.',
  );
  String get liveSiteBodyEmbedded => t(
    'Situs live tampil langsung di sini—geser di dalam bingkai atau buka di tab baru.',
    'The live site renders right here—scroll inside the frame or open it in a new tab.',
  );
  String get reload => t('Muat ulang', 'Reload');
  String get openLive => t('Buka langsung', 'Open live');
  String get liveSiteOpenFailed => t(
    'Situsnya belum bisa dibuka dari preview.',
    'The site could not be opened from the preview.',
  );
  String get liveSiteOpenFailedBody => t(
    'Kamu bisa tetap di halaman ini atau buka situsnya langsung di tab baru.',
    'You can stay on this page or open the site in a new tab.',
  );
  String get noLiveSiteBody => t(
    'Proyek ini belum punya situs live untuk ditampilkan.',
    'This project has no live site to show yet.',
  );
  String get noLiveSiteOpenBody => t(
    'Proyek ini belum punya situs live untuk dibuka.',
    'This project has no live site to open yet.',
  );
  String get noLiveSite => t('Belum ada situs live', 'No live site yet');
  String get websiteScreens => t('Tampilan situs', 'Website screens');
  String get websiteScreensBody => t(
    'Tangkapan halaman asli, dari beranda sampai formulir.',
    'Real page captures, from the home page to the form.',
  );
  String pagesCount(String count) => t('$count HALAMAN', '$count PAGES');
  String get keepExploring => t('LANJUTKAN MENJELAJAH', 'KEEP EXPLORING');
  String get relatedTitle =>
      t('Karya lain yang mungkin cocok', 'Other work you might like');
  String get seeAll => t('Lihat semua', 'See all');
  String get view => t('Lihat', 'View');
  String get searchDestinations => t('Cari destinasi', 'Search destinations');
  String get findLocalWork => t('Cari karya lokal', 'Find local work');
  String get reloadPreview => t('Muat ulang preview', 'Reload preview');

  // Screenshot galleries.
  String get mainScreen => t('Utama', 'Main');
  String get detailScreen => t('Detail', 'Detail');
  String get summaryScreen => t('Ringkasan', 'Summary');
  String galleryCapturesSwipe(String count) => t(
    '$count tangkapan layar asli—geser untuk lihat semua.',
    '$count real captures—swipe to see them all.',
  );
  String get galleryThreeScreens => t(
    'Tiga layar utama, dari alur sampai ringkasan.',
    'Three key screens, from the flow to the summary.',
  );
  String get swipeToPreview =>
      t('Geser untuk melihat pratinjau', 'Swipe to see the previews');
  String galleryRealCaptures(String count) => t(
    '$count tangkapan layar asli dari aplikasi.',
    '$count real captures from the app.',
  );
  String galleryRealPages(String count) => t(
    '$count halaman asli dari situs live.',
    '$count real pages from the live site.',
  );
  String galleryRealPagesSwipe(String count) => t(
    '$count halaman asli—geser untuk lihat semua.',
    '$count real pages—swipe to see them all.',
  );
  String get openSite => t('Buka situs', 'Open site');

  // Favorites.
  String removedFromSaved(String name) =>
      t('$name dihapus dari tersimpan.', '$name removed from saved.');
  String savedNotice(String name) => t('$name disimpan.', '$name saved.');
  String get removeFromSaved => t('Hapus dari tersimpan', 'Remove from saved');
  String get saveProject => t('Simpan proyek', 'Save project');
  String get save => t('Simpan', 'Save');

  // Categories, types, skill groups, platforms.
  String get aiCreative => t('AI & Kreatif', 'AI & Creative');
  String get productivity => t('Produktivitas', 'Productivity');
  String get foodCategory => t('Kuliner', 'Food');
  String get career => t('Karier', 'Career');
  String get experiments => t('Eksperimen', 'Experiments');
  String get architecture => t('Arsitektur', 'Architecture');
  String get design => t('Desain', 'Design');
  String get productAndOps => t('Produk & Operasi', 'Product & Ops');
  String get webResponsive => t('Web · Responsif', 'Web · Responsive');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any(
      (supported) => supported.languageCode == locale.languageCode,
    );
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}

extension AppLocalizationContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// The language used for content in `portfolio.json` (`taglineIn`, `bioIn`).
  AppLanguage get language => AppLanguage.fromCode(l10n.locale.languageCode);
}
