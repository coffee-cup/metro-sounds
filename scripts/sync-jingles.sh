#!/bin/bash
# Idempotent script: copies sounds/*/jingle.mp3 → public/audio/ and generates src/data/jingles.json
# Re-run whenever jingles are added or changed.
set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOUNDS_DIR="$REPO_ROOT/sounds"
AUDIO_DIR="$REPO_ROOT/public/audio"
DATA_DIR="$REPO_ROOT/src/data"
OUTPUT="$DATA_DIR/jingles.json"

mkdir -p "$AUDIO_DIR" "$DATA_DIR"

# Copy all audio files
count=0
for dir in "$SOUNDS_DIR"/*/; do
  [ ! -f "$dir/jingle.mp3" ] && continue
  slug=$(basename "$dir")
  cp "$dir/jingle.mp3" "$AUDIO_DIR/$slug.mp3"
  count=$((count + 1))
done
echo "Copied $count audio files to public/audio/"

# Generate jingles.json using python for proper JSON handling
python3 -c "
import json, os, glob

REGION_MAP = {
    'Germany': 'Europe', 'Netherlands': 'Europe', 'France': 'Europe',
    'Spain': 'Europe', 'Portugal': 'Europe', 'United Kingdom': 'Europe',
    'Switzerland': 'Europe', 'Italy': 'Europe', 'Czech Republic': 'Europe',
    'Slovakia': 'Europe', 'Poland': 'Europe', 'Finland': 'Europe',
    'Denmark': 'Europe', 'Ukraine': 'Europe', 'Romania': 'Europe',
    'Greece': 'Europe', 'Hungary': 'Europe', 'Russia': 'Europe',
    'Japan': 'Asia', 'South Korea': 'Asia', 'Indonesia': 'Asia',
    'Singapore': 'Asia', 'Malaysia': 'Asia', 'China': 'Asia',
    'India': 'Asia', 'Kazakhstan': 'Asia', 'Turkey': 'Asia',
    'United States': 'North America', 'Canada': 'North America',
    'Australia': 'Oceania',
}

sounds_dir = '$SOUNDS_DIR'
jingles = []

for meta_path in sorted(glob.glob(os.path.join(sounds_dir, '*/metadata.json'))):
    with open(meta_path) as f:
        meta = json.load(f)
    slug = os.path.basename(os.path.dirname(meta_path))
    mp3 = os.path.join(os.path.dirname(meta_path), 'jingle.mp3')
    if not os.path.exists(mp3):
        continue
    entry = {
        'id': slug,
        'label': meta['name'],
        'audioFile': slug + '.mp3',
    }
    country = meta.get('country', '')
    if country:
        entry['country'] = country
    region = REGION_MAP.get(country, '')
    if region:
        entry['region'] = region
    jingles.append(entry)

with open('$OUTPUT', 'w') as f:
    json.dump(jingles, f, indent=2, ensure_ascii=False)
    f.write('\n')

print(f'Generated jingles.json with {len(jingles)} entries')
"
