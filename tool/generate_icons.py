"""Generate the Folio launcher and PWA icons.

Run from the project root:
    python tool/generate_icons.py
"""

from pathlib import Path
from PIL import Image, ImageDraw, ImageFilter, ImageFont

ROOT = Path(__file__).resolve().parent.parent
FONT = ROOT / "assets" / "fonts" / "PlusJakartaSans-ExtraBold.ttf"
INK = (23, 22, 20, 255)
CREAM = (247, 244, 236, 255)
ORANGE = (255, 92, 53, 255)
BASE = 1024


def build_icon() -> Image.Image:
    canvas = Image.new("RGBA", (BASE, BASE), INK)

    glow = Image.new("RGBA", (BASE, BASE), (0, 0, 0, 0))
    glow_draw = ImageDraw.Draw(glow)
    glow_draw.ellipse(
        (BASE * 0.42, BASE * 0.45, BASE * 1.16, BASE * 1.16),
        fill=(255, 92, 53, 90),
    )
    glow = glow.filter(ImageFilter.GaussianBlur(120))
    canvas.alpha_composite(glow)

    draw = ImageDraw.Draw(canvas)
    font = ImageFont.truetype(str(FONT), 560)
    draw.text((BASE * 0.31, BASE * 0.72), "f", font=font, fill=CREAM, anchor="ls")
    dot_radius = BASE * 0.064
    dot_center = (BASE * 0.655, BASE * 0.665)
    draw.ellipse(
        (
            dot_center[0] - dot_radius,
            dot_center[1] - dot_radius,
            dot_center[0] + dot_radius,
            dot_center[1] + dot_radius,
        ),
        fill=ORANGE,
    )
    return canvas.convert("RGB")


def save_resized(base: Image.Image, path: Path, size: int) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    image = base if size == BASE else base.resize((size, size), Image.Resampling.LANCZOS)
    image.save(path, "PNG", optimize=True)


def main() -> None:
    icon = build_icon()

    for size in (192, 512):
        save_resized(icon, ROOT / "web" / "icons" / f"Icon-{size}.png", size)
        save_resized(
            icon,
            ROOT / "web" / "icons" / f"Icon-maskable-{size}.png",
            size,
        )
    save_resized(icon, ROOT / "web" / "favicon.png", 64)
    save_resized(icon, ROOT / "web" / "icons" / "Icon-192.png", 192)

    android_sizes = {
        "mipmap-mdpi": 48,
        "mipmap-hdpi": 72,
        "mipmap-xhdpi": 96,
        "mipmap-xxhdpi": 144,
        "mipmap-xxxhdpi": 192,
    }
    for folder, size in android_sizes.items():
        save_resized(
            icon,
            ROOT / "android" / "app" / "src" / "main" / "res" / folder / "ic_launcher.png",
            size,
        )

    ios_sizes = {
        "Icon-App-20x20@1x.png": 20,
        "Icon-App-20x20@2x.png": 40,
        "Icon-App-20x20@3x.png": 60,
        "Icon-App-29x29@1x.png": 29,
        "Icon-App-29x29@2x.png": 58,
        "Icon-App-29x29@3x.png": 87,
        "Icon-App-40x40@1x.png": 40,
        "Icon-App-40x40@2x.png": 80,
        "Icon-App-40x40@3x.png": 120,
        "Icon-App-60x60@2x.png": 120,
        "Icon-App-60x60@3x.png": 180,
        "Icon-App-76x76@1x.png": 76,
        "Icon-App-76x76@2x.png": 152,
        "Icon-App-83.5x83.5@2x.png": 167,
        "Icon-App-1024x1024@1x.png": 1024,
    }
    ios_dir = ROOT / "ios" / "Runner" / "Assets.xcassets" / "AppIcon.appiconset"
    for name, size in ios_sizes.items():
        save_resized(icon, ios_dir / name, size)

    macos_sizes = {
        "app_icon_16.png": 16,
        "app_icon_32.png": 32,
        "app_icon_64.png": 64,
        "app_icon_128.png": 128,
        "app_icon_256.png": 256,
        "app_icon_512.png": 512,
        "app_icon_1024.png": 1024,
    }
    macos_dir = ROOT / "macos" / "Runner" / "Assets.xcassets" / "AppIcon.appiconset"
    for name, size in macos_sizes.items():
        save_resized(icon, macos_dir / name, size)

    ico_sizes = [(16, 16), (24, 24), (32, 32), (48, 48), (64, 64), (128, 128), (256, 256)]
    icon.save(
        ROOT / "windows" / "runner" / "resources" / "app_icon.ico",
        format="ICO",
        sizes=ico_sizes,
    )
    print("Folio icons generated.")


if __name__ == "__main__":
    main()
