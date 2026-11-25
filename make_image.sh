#!/bin/sh
# make_image.sh - builds entry.png, the "Edisi Dunia" front page that sums up
# the world news of Wednesday 25 November 2026 for make.fun news-image-20261125.
#
# No PIL on this machine, so the page is composed with ffmpeg's drawtext and
# drawbox filters only. Every line of text lives in its own textfile so no
# shell or filter escaping can garble it. Run: sh make_image.sh
# Output: entry.png beside this script (1024x1024, well under 1 MiB).

set -eu
cd "$(dirname "$0")"

SANS=/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf
BOLD=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf
SERIFB=/usr/share/fonts/truetype/dejavu/DejaVuSerif-Bold.ttf
INK=0x191919
ACCENT=0x8a1f1f
PAPER=0xf8f3e6

TXT=$(mktemp -d)
trap 'rm -rf "$TXT"' EXIT
T() { printf '%s' "$2" > "$TXT/$1.txt"; }

# --- Masthead ---------------------------------------------------------------
T masthead "EDISI DUNIA"
T dateline "WEDNESDAY, 25 NOVEMBER 2026"
T tagline  "THE WORLD IN ONE PAGE"

# --- Lead story: Shenzhou-24 -------------------------------------------------
T lead_kicker "SPACE - THE LEAD STORY"
T lead_head   "SHENZHOU-24 DOCKS AT TIANGONG"
T lead_sub    "Pakistan's first astronaut reaches China's space station"
T lead_b1 "China's Shenzhou-24 crew docked with the Tiangong space station on"
T lead_b2 "25 November, carrying the first Pakistani astronaut into orbit - a"
T lead_b3 "milestone for Beijing's space diplomacy and Pakistan's programme."

# --- Row 1, left: Huawei verdict ---------------------------------------------
T hw_kicker "COURTS - TECHNOLOGY"
T hw_h1 "COURT DELIVERS ITS"
T hw_h2 "HUAWEI VERDICT"
T hw_b1 "A court handed down its verdict in the"
T hw_b2 "long-running Huawei case on 24 November,"
T hw_b3 "the latest turn in the dispute between"
T hw_b4 "Washington and Beijing over the Chinese"
T hw_b5 "telecoms giant's place in world markets."

# --- Row 1, right: Houthi missile at a Riyadh PIF tower ----------------------
T ry_kicker "MIDDLE EAST - CONFLICT"
T ry_h1 "HOUTHI MISSILE FIRED"
T ry_h2 "AT RIYADH PIF TOWER"
T ry_b1 "Yemen's Houthis said they fired a missile"
T ry_b2 "at a tower owned by Saudi Arabia's Public"
T ry_b3 "Investment Fund in Riyadh - a claim that"
T ry_b4 "raised fears of a wider regional"
T ry_b5 "escalation. It was still being assessed."

# drawtext helper: DT <font> <size> <color> <x> <y> <name>
F=""
DT() {
  F="${F}drawtext=fontfile=$1:fontsize=$2:fontcolor=$3:x=$4:y=$5:textfile=$TXT/$6.txt,"
}
# DTN: same, but with text expansion disabled so a literal % survives
DTN() {
  F="${F}drawtext=fontfile=$1:fontsize=$2:fontcolor=$3:x=$4:y=$5:textfile=$TXT/$6.txt:expansion=none,"
}
# drawbox helper: DB <x> <y> <w> <h>
DB() {
  F="${F}drawbox=x=$1:y=$2:w=$3:h=$4:color=$INK:t=fill,"
}

# Masthead block
DT "$SERIFB" 72 "$INK" "(w-text_w)/2" 22 masthead
DB 40 116 944 5
DB 40 127 944 2
DT "$BOLD" 27 "$INK" "(w-text_w)/2" 140 dateline
DT "$SANS" 17 "$INK" "(w-text_w)/2" 176 tagline
DB 40 204 944 2

# Lead block
DT "$BOLD" 17 "$ACCENT" 40 220 lead_kicker
DT "$BOLD" 37 "$INK" 40 246 lead_head
DT "$SANS" 22 "$INK" 40 296 lead_sub
DT "$SANS" 19 "$INK" 40 338 lead_b1
DT "$SANS" 19 "$INK" 40 368 lead_b2
DT "$SANS" 19 "$INK" 40 398 lead_b3
DB 40 448 944 2

# Row 1: two columns with a vertical divider
DB 510 470 2 218
DT "$BOLD" 15 "$ACCENT" 40 468 hw_kicker
DT "$BOLD" 25 "$INK" 40 492 hw_h1
DT "$BOLD" 25 "$INK" 40 524 hw_h2
DT "$SANS" 17 "$INK" 40 564 hw_b1
DT "$SANS" 17 "$INK" 40 591 hw_b2
DT "$SANS" 17 "$INK" 40 618 hw_b3
DT "$SANS" 17 "$INK" 40 645 hw_b4
DT "$SANS" 17 "$INK" 40 672 hw_b5

DT "$BOLD" 15 "$ACCENT" 534 468 ry_kicker
DT "$BOLD" 25 "$INK" 534 492 ry_h1
DT "$BOLD" 25 "$INK" 534 524 ry_h2
DT "$SANS" 17 "$INK" 534 564 ry_b1
DT "$SANS" 17 "$INK" 534 591 ry_b2
DT "$SANS" 17 "$INK" 534 618 ry_b3
DT "$SANS" 17 "$INK" 534 645 ry_b4
DT "$SANS" 17 "$INK" 534 672 ry_b5
DB 40 702 944 2

# --- Row 2, left: Sparta II leak ----------------------------------------------
T sp_kicker "INTELLIGENCE - LEAK"
T sp_h1 "SPARTA II LEAK HITS"
T sp_h2 "CIA AND ODNI FILES"
T sp_b1 "The Sparta II leak exposed unclassified"
T sp_b2 "material from the CIA and the office of"
T sp_b3 "the US Director of National Intelligence,"
T sp_b4 "a breach officials are still assessing."

# --- Row 2, right: Nvidia slide and the PCE print ------------------------------
T mk_kicker "MARKETS - ECONOMY"
T mk_h1 "NVIDIA SLIDES; PCE"
T mk_h2 "INFLATION AT +3.8%"
T mk_b1 "Nvidia shares fell as investors weighed"
T mk_b2 "the AI rally. October PCE inflation"
T mk_b3 "printed +3.8% year on year, core +3.3%,"
T mk_b4 "just above the 3.2% consensus. The Q3"
T mk_b5 "GDP second estimate was still awaited."

# --- Sports band ----------------------------------------------------------------
T sport "SPORT - REAL MADRID 5-1 PSV: A FIVE-GOAL CHAMPIONS LEAGUE ROUT"
T footer "All stories as reported on 24-25 November 2026"

# Row 2: two columns with a vertical divider
DB 510 722 2 196
DT "$BOLD" 15 "$ACCENT" 40 720 sp_kicker
DT "$BOLD" 25 "$INK" 40 744 sp_h1
DT "$BOLD" 25 "$INK" 40 776 sp_h2
DT "$SANS" 17 "$INK" 40 816 sp_b1
DT "$SANS" 17 "$INK" 40 843 sp_b2
DT "$SANS" 17 "$INK" 40 870 sp_b3
DT "$SANS" 17 "$INK" 40 897 sp_b4

DT "$BOLD" 15 "$ACCENT" 534 720 mk_kicker
DT "$BOLD" 25 "$INK" 534 744 mk_h1
DTN "$BOLD" 25 "$INK" 534 776 mk_h2
DT "$SANS" 17 "$INK" 534 816 mk_b1
DT "$SANS" 17 "$INK" 534 843 mk_b2
DTN "$SANS" 17 "$INK" 534 870 mk_b3
DTN "$SANS" 17 "$INK" 534 897 mk_b4
DT "$SANS" 17 "$INK" 534 924 mk_b5

# Sports band and footer
DB 40 952 944 3
DT "$BOLD" 22 "$INK" 40 966 sport
DT "$SANS" 13 "$INK" "(w-text_w)/2" 1000 footer

# Render: one still image from a solid paper-coloured canvas.
F=${F%,}
ffmpeg -y -v error -f lavfi -i "color=c=${PAPER}:s=1024x1024" \
  -vf "$F" -frames:v 1 entry.png

ls -la entry.png
