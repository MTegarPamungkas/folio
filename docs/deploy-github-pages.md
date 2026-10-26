# Deploy ke GitHub Pages

Situs live: **https://mtegarpamungkas.github.io/folio/**

Repo: **https://github.com/MTegarPamungkas/folio**

Deploy memakai branch `gh-pages`, bukan GitHub Actions. Cara ini tidak membutuhkan runner Actions dan tetap bekerja untuk project site di subpath `/folio/`.

## Cara update situs

```powershell
pwsh tool/deploy_pages.ps1
```

Script akan:

1. build Flutter Web dengan `--base-href /folio/`;
2. menambahkan `.nojekyll`;
3. membuat commit deploy di branch `gh-pages`;
4. mem-push branch tersebut ke GitHub.

Setelah push, GitHub Pages biasanya memperbarui situs dalam 1–2 menit.

## Setup pertama kali

Jika repo ini dipindah atau dibuat ulang:

1. Push kode utama ke branch `main`.
2. Jalankan `pwsh tool/deploy_pages.ps1`.
3. Buka **Settings → Pages**.
4. Pilih **Deploy from a branch**.
5. Branch: `gh-pages`, folder: `/ (root)`.
6. Simpan.

Branch `gh-pages` hanya berisi hasil build; kode sumber tetap di `main`.

## Repo atau domain lain

Script menerima nama repo dan base href:

```powershell
pwsh tool/deploy_pages.ps1 `
  -Repository "USERNAME/portfolio" `
  -BaseHref "/portfolio/"
```

Untuk user site `USERNAME.github.io`:

```powershell
pwsh tool/deploy_pages.ps1 `
  -Repository "USERNAME/USERNAME.github.io" `
  -BaseHref "/"
```

## Kenapa base href penting?

GitHub Pages project site disajikan dari `/NAMA_REPO/`, bukan `/`. Tanpa base href, Flutter mencari `main.dart.js` di root domain dan halaman menjadi blank.

Build manual yang setara:

```bash
flutter build web --release --base-href /folio/
```

## Live web preview

Preview mengikuti `liveUrl` proyek. Dompetektif memakai URL absolut:

```text
https://mtegarpamungkas.github.io/dompetektif/
```

Tombol **Buka langsung** membuka URL tersebut di tab baru. Proyek website statis juga bisa memakai file di `web/sites/` dengan URL relatif.

## Custom domain

Untuk custom domain di root:

1. Tambahkan file `web/CNAME` berisi domain.
2. Build/deploy dengan `-BaseHref "/"`.
3. Atur DNS sesuai instruksi GitHub Pages.

## Troubleshooting

- **Halaman blank / asset 404** — base href tidak sesuai dengan URL Pages.
- **Situs tidak berubah** — pastikan branch `gh-pages` baru saja ter-push dan tunggu build Pages selesai.
- **Live preview tidak muncul** — pastikan `liveUrl` valid dan situsnya mengizinkan iframe.
- **Routing halaman** — aplikasi memakai hash routing (`#/explore`, `#/project/...`), jadi deep link tidak membutuhkan fallback 404.
