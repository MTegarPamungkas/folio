# Folio Architecture

Dokumen ini menjelaskan aturan arsitektur yang dipakai Folio, alasan di baliknya, dan cara menambah fitur tanpa merusak struktur.

## 1. Dependency rule

```text
┌─────────────────────────────────────────────────────────┐
│ Presentation                                            │
│ pages · widgets · blocs · visual catalog               │
└───────────────────────┬─────────────────────────────────┘
                        │ depends on
                        ▼
┌─────────────────────────────────────────────────────────┐
│ Domain                                                  │
│ entities · repository contracts · use cases             │
│ (pure Dart, no Flutter imports)                         │
└───────────────────────▲─────────────────────────────────┘
                        │ implements
┌───────────────────────┴─────────────────────────────────┐
│ Data                                                    │
│ JSON data source · preferences · contact mailer         │
└─────────────────────────────────────────────────────────┘

Core (DI, routing, theme, responsive) and shared presentation
are framework-level building blocks used from the outer layers.
```

Aturan yang dijaga:

1. **Domain tidak mengimpor Flutter.** Warna, ikon, `BuildContext`, dan widget tidak boleh masuk ke entity, repository contract, atau use case.
2. **Presentation tidak mengakses datasource.** Halaman dan Bloc hanya berbicara melalui use case.
3. **Data mengimplementasikan contract domain.** Repository implementation boleh mengimpor package platform.
4. **Contract berada di domain.** Ini yang membuat repository mudah diganti fake saat test.
5. **Visual adalah concern presentasi.** `Project` tidak menyimpan `Color` atau `IconData`; pemetaan ada di `shared/presentation/theme/project_visuals.dart`.

## 2. Tanggung jawab per layer

### Domain

- `entities/` — model immutable berbasis `Equatable`.
  - `Project` (termasuk `ProjectType` dan `liveUrl`), `Developer`, `PortfolioContent`, `HomeContent`, `ProjectDetail`, `ContactRequest`, dan `AppThemeMode`.
- `repositories/` — kontrak:
  - `PortfolioRepository`
  - `FavoritesRepository`
  - `SettingsRepository`
  - `ContactRepository`
- `usecases/` — satu class untuk satu aksi. Contoh:
  - `GetHomeContent`, `FilterProjects`, `GetProjectDetail`
  - `GetFavoriteIds`, `ToggleFavorite`, `GetSavedProjects`
  - `GetThemeMode`, `SetThemeMode`
  - `GetContactContext`, `SendContactRequest`

Usecase bersifat kecil dan mudah dites. `FilterProjects` misalnya tidak mengetahui Bloc, widget, atau storage.

### Data

- `assets/data/portfolio.json` — satu-satunya sumber konten portofolio (identitas, proyek, pengalaman, pendidikan, organisasi).
- `datasources/portfolio_json_data_source.dart` — membaca asset lewat `AssetBundle`, memvalidasi struktur minimal, lalu memetakan JSON ke entity domain.
- `datasources/preferences_local_data_source.dart` — akses `SharedPreferences`.
- `repositories/` — implementasi contract domain. `PortfolioRepositoryImpl` menerima `PortfolioContent` yang sudah diparse.
- `contact_repository_impl.dart` — menyusun URI `mailto:` dan memanggil `url_launcher`.

Alur startup:

```text
main()
  → configureDependencies()
  → PortfolioJsonDataSource.load('assets/data/portfolio.json')
  → PortfolioContent
  → get_it (singleton)
  → PortfolioRepositoryImpl
  → use cases → Blocs → UI
```

JSON adalah konten, bukan state UI. Tidak ada form edit konten di aplikasi. Perubahan konten dilakukan dengan mengedit file JSON dan rebuild. Domain tetap tidak mengetahui JSON, `AssetBundle`, atau Flutter.

Saat pindah ke REST/Firebase, ganti datasource dengan implementasi remote dan pertahankan mapping ke entity yang sama; Bloc dan halaman tidak perlu berubah.

### Presentation

- Satu folder per fitur:
  - `features/<feature>/presentation/bloc/`
  - `features/<feature>/presentation/pages/`
  - `features/<feature>/presentation/widgets/`
- Halaman tipis: membaca state lewat `BlocBuilder`, merangkai section, dan meneruskan callback.
- Widget section dipisah agar file halaman tidak menjadi monolit.
- Halaman detail proyek memakai widget per bagian: hero, screenshots aplikasi atau live website, story, aside, related.
- Preview website dipisah menjadi `WebsitePreviewSection` + `BrowserFrame` + `WebsiteArtwork`, dengan iframe web melalui conditional import.
- Profil dipecah menjadi intro, prinsip, skill, pengalaman, pendidikan/organisasi, dan preferensi/kontak.
- Copy tidak ditulis langsung di widget: ambil dari `context.l10n`. Tiap string punya getter sendiri, sedangkan string berparameter menjadi method (`greeting(name)`, `savedCount(count)`). Bahasa aktif mengikuti locale `MaterialApp`, dan konten `portfolio.json` ikut lewat `context.language`.

### Core

- `core/di/injection_container.dart` — komposisi dependency dengan `get_it`.
- `core/router/app_router.dart` — route + provider Bloc per halaman.
- `core/localization/app_localizations.dart` — semua copy antarmuka (Indonesia/Inggris) sebagai getter bertipe, plus `context.l10n`.
- `core/localization/entity_labels.dart` — label enum (`ProjectType`, `ProjectCategory`, `SkillGroupKind`, platform) yang dipetakan ke copy.
- `core/responsive/` — breakpoint dan layout primitive.
- `core/theme/` — token dan tema Material 3.
- `core/utils/` — tautan eksternal dan clipboard.

### Shared presentation

- `shared/presentation/widgets/` — design system dan komponen yang dipakai lintas fitur.
- `shared/presentation/theme/project_visuals.dart` — palet, ikon, dan pemetaan visual per proyek.

## 3. State management

Global state disediakan di root aplikasi:

- `SettingsBloc` — tema.
- `FavoritesBloc` — ID proyek tersimpan.
- `ExploreBloc` — query dan filter, sengaja global agar kategori dari Beranda bisa membuka Explore dengan filter yang benar.
- `ProfileBloc` — identitas developer yang dibutuhkan shell, footer, dan halaman detail.

Page-level state dibuat oleh route builder:

- `HomeBloc`
- `AboutBloc`
- `SavedBloc`
- `ProjectDetailBloc`
- `ContactBloc`

Setiap perubahan state masuk lewat event. Event class berada di `<feature>_event.dart`, handler di `<feature>_bloc.dart`, dan output di `<feature>_state.dart`.

Contoh event:

- `SettingsThemeModeChanged`, `SettingsThemeToggled`
- `FavoriteToggled`
- `ExploreQueryChanged`, `ExploreCategoryChanged`, `ExploreFiltersCleared`
- `HomeStarted`, `AboutStarted`, `ProjectDetailStarted`
- `ContactNameChanged`, `ContactEmailChanged`, `ContactSubmitted`
- `SavedFavoritesChanged`

`SavedBloc` menerima event `SavedFavoritesChanged` dari stream `FavoritesBloc`; halaman tidak menggabungkan dua sumber state secara manual.

### Alur favorit

```text
Tap bookmark
  → FavoritesBloc.add(FavoriteToggled(projectId))
  → ToggleFavorite (usecase)
  → FavoritesRepository → SharedPreferences
  → FavoritesBloc emits FavoritesState
  → icon berubah, badge berubah, SavedBloc ikut memperbarui daftar
```

### Alur kontak

```text
Isi form
  → ContactBloc.add(ContactNameChanged / ContactEmailChanged / ...)
  → ContactBloc.add(ContactSubmitted())
  → validasi di event handler
  → SendContactRequest
  → ContactRepository → mailto
  → ContactStatus.success / failure
  → BlocListener menampilkan snackbar
```

## 4. Dependency injection

`get_it` dipakai sebagai composition root:

- singleton: datasource dan repository;
- lazy singleton: use case stateless dan Bloc global;
- factory: Bloc halaman;
- factory berparameter: `ProjectDetailBloc(projectId)` dan `ContactBloc(projectId)`.

Bloc global hidup selama proses aplikasi. Bloc halaman dibuat oleh `BlocProvider` di route dan ditutup otomatis bersama halaman.

Keuntungannya: halaman tidak membuat dependency sendiri, dan test dapat melakukan `GetIt.instance.reset()` lalu mendaftarkan fake.

## 5. Website live preview

Proyek bertipe `ProjectType.website` menampilkan browser frame, bukan mockup ponsel.

```text
Project.liveUrl
  → resolve relatif terhadap host (khusus web)
  → WebsiteEmbed (iframe, web-only)
  → WebsiteArtwork (fallback native / preview statis)
  → tombol Buka langsung (url_launcher) selalu tersedia bila URL valid
```

Implementasi iframe memakai conditional import:

- `website_embed_web.dart` — `dart:ui_web` + `package:web`, membuat `HTMLIFrameElement`.
- `website_embed_stub.dart` — mengembalikan artwork statis di Android/iOS/desktop native.
- `website_embed.dart` — memilih implementasi lewat `dart.library.js_interop`.

Demo microsite berada di `web/sites/` dan ikut tersalin saat `flutter build web`. Untuk produksi, ganti `liveUrl` relatif dengan URL publik absolut.

## 6. Layout responsif

Breakpoint hanya didefinisikan sekali:

| Window class | Lebar | Navigasi |
| --- | --- | --- |
| compact | `< 700` | bottom navigation |
| medium | `700–979` | bottom navigation |
| expanded | `≥ 980` | sidebar |

Primitive yang dipakai:

- `AdaptivePage` — scroll, padding, max-width.
- `AdaptiveTwoPane` — dua kolom ↔ stack; mendukung fixed width, flex, urutan mobile, dan menyembunyikan pane sekunder di mobile.
- `AdaptiveColumns` — wrap/grid dengan perhitungan kolom otomatis.
- `AdaptiveGap` dan `ResponsiveValue<T>` — spacing/nilai adaptif.
- `context.isCompact`, `context.isExpanded`, `context.responsive<T>()` — helper yang membaca window class.

Tujuannya: halaman tidak lagi menulis `LayoutBuilder + hitung kolom + Wrap` berulang-ulang.

## 7. Menambah fitur

Contoh menambah fitur “Press”:

1. Buat entity dan/atau use case di `domain/`.
2. Jika butuh data baru, tambahkan contract di `domain/repositories/` lalu implementasi di `data/`.
3. Daftarkan dependency di `core/di/injection_container.dart`.
4. Buat `features/press/presentation/bloc/` + halaman + widget section.
5. Daftarkan route. Jika state hanya milik halaman, bungkus halaman dengan `BlocProvider`.
6. Tambahkan test use case/Bloc dan layout test bila halaman baru.

## 8. Testing

- `test/domain/` — use case murni.
- `test/features/` — Bloc dengan `bloc_test` dan fake repository.
- `test/app_test.dart` — alur pencarian, form kontak, persistensi.
- `test/routes_test.dart` — semua route pada viewport mobile dengan teks 130% dan desktop, termasuk halaman website live.
- `test/data/portfolio_json_data_source_test.dart` — memastikan JSON bisa diparse dan field penting tersedia.

Selain `flutter test`, dua guard dijalankan manual:

- `dart run tool/check_l10n.dart` — setiap entri harus berbentuk `t(id, en)`, nama dan teks sumber unik, placeholder cocok dengan parameter, dan tidak ada entri yang tidak terpakai.
- `dart run tool/check_hardcoded.dart` — menandai copy Indonesia yang ditulis langsung di widget, bukan lewat `context.l10n`.

Test tidak membutuhkan backend atau perangkat fisik.

## 9. Prinsip yang dipertahankan

- Satu sumber kebenaran untuk tema dan favorit.
- Domain tetap bebas framework.
- Halaman tidak menyimpan business logic.
- Layout responsif memakai komponen, bukan copy-paste.
- Konten demo dipisahkan dari mekanisme aplikasi sehingga mudah diganti.
