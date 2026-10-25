# Deploy ke GitHub Pages

Workflow [`deploy-pages.yml`](../.github/workflows/deploy-pages.yml) membangun Flutter Web dan menerbitkannya ke GitHub Pages setiap kali ada push ke `main` atau `master`.

## 1. Buat repo dan push

```bash
git init -b main
git add .
git commit -m "Build Folio portfolio"
git remote add origin https://github.com/USERNAME/NAMA_REPO.git
git push -u origin main
```

## 2. Aktifkan Pages

Di repo GitHub:

1. **Settings → Pages**
2. Bagian **Build and deployment**
3. **Source: GitHub Actions**

Tidak perlu memilih branch `gh-pages`; workflow akan mengunggah artifact sendiri.

## 3. URL hasil

- Repo proyek `USERNAME/folio` → `https://USERNAME.github.io/folio/`
- Repo user site `USERNAME/USERNAME.github.io` → `https://USERNAME.github.io/`

Workflow mendeteksi otomatis apakah repo adalah user site atau project site, lalu mengatur `--base-href` yang sesuai.

## Kenapa base href penting?

GitHub Pages project site disajikan dari subpath `/NAMA_REPO/`, bukan dari `/`. Tanpa base href, Flutter akan mencari `main.dart.js` di domain root dan halaman menjadi blank.

Build lokal yang menyerupai GitHub Pages:

```bash
flutter build web --release --base-href /folio/
```

## Live website preview

Link demo `sites/mis-msa.html` tetap ikut ter-build. `Uri.base.resolve()` akan menghasilkan:

```text
https://USERNAME.github.io/folio/sites/mis-msa.html
```

Tombol **Buka langsung** membuka URL tersebut di tab baru.

## Custom domain

Jika memakai custom domain di root:

```bash
flutter build web --release --base-href /
```

Sesuaikan langkah build di workflow menjadi `BASE_HREF="/"` dan tambahkan file `web/CNAME` berisi domain.

## Troubleshooting

- **Halaman blank / 404 asset** — pastikan build memakai base href yang sesuai dengan URL Pages.
- **Deploy tidak berjalan** — cek **Settings → Pages → Source** sudah diset ke **GitHub Actions**.
- **Live preview tidak muncul** — pastikan `web/sites/mis-msa.html` ikut ter-commit dan build web berhasil.
- **Routing halaman** — aplikasi memakai hash routing (`#/explore`, `#/project/...`), jadi deep link tidak membutuhkan fallback 404.
