param(
  [string]$Repository = 'MTegarPamungkas/folio',
  [string]$BaseHref = '/folio/'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$projectRoot = Split-Path -Parent $PSScriptRoot
$tempRoot = [IO.Path]::GetTempPath()
$deployDir = Join-Path $tempRoot 'folio-gh-pages'

Push-Location $projectRoot
try {
  Write-Host 'Building Flutter web...' -ForegroundColor Cyan
  # Flutter writes harmless warnings to stderr; keep them from aborting the
  # script under `$ErrorActionPreference = 'Stop'` (Windows PowerShell 5.1).
  $previousErrorAction = $ErrorActionPreference
  $ErrorActionPreference = 'Continue'
  try {
    & flutter build web --release --base-href $BaseHref
    $buildExitCode = $LASTEXITCODE
  } finally {
    $ErrorActionPreference = $previousErrorAction
  }
  if ($buildExitCode -ne 0) {
    throw 'Flutter web build failed.'
  }
} finally {
  Pop-Location
}

if (Test-Path -LiteralPath $deployDir) {
  $resolved = (Resolve-Path -LiteralPath $deployDir).Path
  if (-not $resolved.StartsWith($tempRoot, [StringComparison]::OrdinalIgnoreCase)) {
    throw "Refusing to remove unexpected path: $resolved"
  }
  Remove-Item -LiteralPath $deployDir -Recurse -Force
}

New-Item -ItemType Directory -Path $deployDir -Force | Out-Null
Copy-Item -Path (Join-Path $projectRoot 'build\web\*') -Destination $deployDir -Recurse -Force
New-Item -ItemType File -Path (Join-Path $deployDir '.nojekyll') -Force | Out-Null

$commitMessage = @'
chore(pages): publish production web build

Deploy the latest Flutter web build with the GitHub Pages base href and
project live previews.
'@

Push-Location $deployDir
try {
  git init -b gh-pages | Out-Null
  if ($LASTEXITCODE -ne 0) { throw 'git init failed.' }

  git add .
  if ($LASTEXITCODE -ne 0) { throw 'git add failed.' }

  git commit -m $commitMessage --allow-empty | Out-Null
  if ($LASTEXITCODE -ne 0) { throw 'git commit failed.' }

  git remote add origin "https://github.com/$Repository.git"
  if ($LASTEXITCODE -ne 0) { throw 'git remote add failed.' }

  git push --force -u origin gh-pages
  if ($LASTEXITCODE -ne 0) { throw 'git push failed.' }
} finally {
  Pop-Location
}

if (Test-Path -LiteralPath $deployDir) {
  Remove-Item -LiteralPath $deployDir -Recurse -Force
}

$owner, $name = $Repository.Split('/')
$owner = $owner.ToLowerInvariant()
$name = $name.ToLowerInvariant()
$siteUrl = if ($name -like '*.github.io') {
  "https://$name/"
} else {
  "https://$owner.github.io/$name/"
}

Write-Host ''
Write-Host "Deployed to: $siteUrl" -ForegroundColor Green
Write-Host 'It can take a minute for GitHub Pages to refresh the deployment.' -ForegroundColor DarkGray
