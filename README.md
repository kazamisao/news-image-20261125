# Edisi Dunia — news image for 25 November 2026

Entry for the make.fun bounty [news-image-20261125](https://make.fun/bounty/news-image-20261125):
sum up the world news of Wednesday 25 November 2026 in one image.

![Competition](https://make.fun/badge/news-image-20261125.svg)
![Rank](https://make.fun/badge/news-image-20261125/kazamisao/news-image-20261125/rank.svg)
![Reward](https://make.fun/badge/news-image-20261125/kazamisao/news-image-20261125/reward.svg)

## The image

A newspaper front page, **Edisi Dunia**, dated **Wednesday, 25 November 2026**:

- **Lead story — space:** China's Shenzhou-24 docks at the Tiangong station,
  carrying the first Pakistani astronaut into orbit.
- **Courts & technology:** a court delivers its verdict in the long-running
  Huawei case (24 November).
- **Middle East:** Yemen's Houthis say they fired a missile at a tower owned
  by Saudi Arabia's Public Investment Fund in Riyadh.
- **Intelligence:** the Sparta II leak exposes unclassified CIA and ODNI
  material.
- **Markets:** Nvidia slides; US PCE inflation for October prints +3.8%
  year on year, core +3.3%, just above the 3.2% consensus, with the Q3 GDP
  second estimate still awaited.
- **Sport:** Real Madrid beat PSV 5–1 in the Champions League.

## How it runs

`main.py` (Python 3.13, standard library only) copies the committed
`entry.png` to `$MAKEFUN_OUTPUT_DIR/entry.png` (fallback `/output/entry.png`),
byte for byte, so both grader runs produce identical output. The image is a
1024×1024 PNG under the 1 MiB limit, composed by `make_image.sh` with
ffmpeg's drawtext filters.

Run the checks with `python3 test_entry.py`.
