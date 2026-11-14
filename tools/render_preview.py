"""Render the widget picker preview image used on Android 8-11.

Android 12+ uses res/layout/widget_preview.xml instead. Keep the two in sync:
same dark card, time on the left, date on the right, vertically centered.

Run through tools/render_preview.ps1 (Docker), which provides Pillow and
the Noto Sans CJK font.
"""
import sys

from PIL import Image, ImageDraw, ImageFont

FONT = "/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc"
FONT_INDEX_JP = 0  # Noto Sans CJK JP

SCALE = 2  # px per dp; the picker scales the image down to fit anyway
WIDTH, HEIGHT = 372 * SCALE, 150 * SCALE
RADIUS = 24 * SCALE
PADDING = 18 * SCALE  # card inset (10dp) + widget padding (8dp)
BACKGROUND = (0x2C, 0x3E, 0x50, 255)
TEXT = (255, 255, 255, 255)

TIME, DATE = "9:41", "11月15日(日)"


def main(out_path: str) -> None:
    img = Image.new("RGBA", (WIDTH, HEIGHT), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    draw.rounded_rectangle((0, 0, WIDTH - 1, HEIGHT - 1), RADIUS, fill=BACKGROUND)

    time_font = ImageFont.truetype(FONT, 76 * SCALE, index=FONT_INDEX_JP)
    date_font = ImageFont.truetype(FONT, 23 * SCALE, index=FONT_INDEX_JP)

    # anchor "lm"/"rm": left/right edge, vertical middle of the text.
    draw.text((PADDING, HEIGHT / 2), TIME, font=time_font, fill=TEXT, anchor="lm")
    draw.text((WIDTH - PADDING, HEIGHT / 2), DATE, font=date_font, fill=TEXT, anchor="rm")

    img.save(out_path, optimize=True)


if __name__ == "__main__":
    main(sys.argv[1])
