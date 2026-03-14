#!/bin/bash
set -e

SOUNDS_DIR="/Users/jr/dev/metro-sounds/sounds"
SOURCE="$SOUNDS_DIR/Railway Jingles from Around the World [ZG7nYwzOZu0].webm"

# Format: start_seconds|end_seconds|slug|name|country
JINGLES=(
  "0|2|german-railways|German Railways|Germany"
  "2|5|dutch-railways|Dutch Railways|Netherlands"
  "5|9|french-national-railway-company|French National Railway Company|France"
  "9|11|national-network-of-spanish-railways-v1|National Network of Spanish Railways (Version 1)|Spain"
  "11|15|national-network-of-spanish-railways-v2|National Network of Spanish Railways (Version 2)|Spain"
  "15|17|trains-of-portugal|Trains of Portugal|Portugal"
  "17|20|national-rail-british-rail|National Rail/British Rail|United Kingdom"
  "20|22|swiss-federal-railways-german-version|Swiss Federal Railways (German Version)|Switzerland"
  "22|24|swiss-federal-railways-french-version|Swiss Federal Railways (French Version)|Switzerland"
  "24|27|swiss-federal-railways-italian-version|Swiss Federal Railways (Italian Version)|Switzerland"
  "27|30|italian-railways|Italian Railways|Italy"
  "30|32|australian-federal-railways-v1|Australian Federal Railways (Version 1)|Australia"
  "32|34|australian-federal-railways-v2|Australian Federal Railways (Version 2)|Australia"
  "34|36|czech-railways|Czech Railways|Czech Republic"
  "36|41|the-railway-company-of-slovakia-v1|The Railway Company of Slovakia (Version 1)|Slovakia"
  "41|47|the-railway-company-of-slovakia-v2|The Railway Company of Slovakia (Version 2)|Slovakia"
  "47|51|polish-state-railways|Polish State Railways|Poland"
  "51|52|vr-group-plc-finland|VR-Group PLC Finland|Finland"
  "52|54|danish-state-railways|Danish State Railways|Denmark"
  "54|56|ukrainian-railways|Ukrainian Railways|Ukraine"
  "56|62|romanian-railways|Romanian Railways|Romania"
  "62|64|hellenic-train-greece|Hellenic Train Greece|Greece"
  "64|66|hungarian-state-railways-v1|Hungarian State Railways (Version 1)|Hungary"
  "66|71|hungarian-state-railways-v2|Hungarian State Railways (Version 2)|Hungary"
  "71|75|russian-railways|Russian Railways|Russia"
  "75|79|west-japan-railway-company|West Japan Railway Company|Japan"
  "79|83|east-japan-railway-company|East Japan Railway Company|Japan"
  "83|91|korean-railroad-corporation-new-version|Korean Railroad Corporation (New Version)|South Korea"
  "91|102|korean-railroad-corporation-old-version|Korean Railroad Corporation (Old Version)|South Korea"
  "102|110|korean-railroad-corporation-approaching-seoul|Korean Railroad Corporation (Approaching Seoul)|South Korea"
  "110|119|indonesian-railways|Indonesian Railways|Indonesia"
  "119|121|singapore-mass-rapid-transit|Singapore Mass Rapid Transit|Singapore"
  "121|125|malaysian-railways-limited|Malaysian Railways Limited|Malaysia"
  "125|130|china-railway-high-speed|China Railway High-speed|China"
  "130|136|indian-railways|Indian Railways|India"
  "136|137|kazakhstan-temir-joly|Kazakhstan Temir Joly (Kazakhstan Railway)|Kazakhstan"
  "137|140|turkish-state-railways|Turkish State Railways|Turkey"
  "140|144|amtrak|Amtrak (American National Railroad Passenger Corporation)|United States"
  "144|146|via-rail-canada-v1|Via Rail Canada (Version 1)|Canada"
  "146|148|via-rail-canada-v2|Via Rail Canada (Version 2)|Canada"
  "148||canada-go-transit-sydney-metro|Canada GO Transit/Sydney Metro|Canada"
)

for entry in "${JINGLES[@]}"; do
  IFS='|' read -r start end slug name country <<< "$entry"

  dir="$SOUNDS_DIR/$slug"
  mkdir -p "$dir"

  # Build ffmpeg command
  if [ -n "$end" ]; then
    duration=$((end - start))
    ffmpeg -y -i "$SOURCE" -ss "$start" -t "$duration" -vn -ab 128k "$dir/jingle.mp3" 2>/dev/null
  else
    ffmpeg -y -i "$SOURCE" -ss "$start" -vn -ab 128k "$dir/jingle.mp3" 2>/dev/null
  fi

  # Write metadata.json
  cat > "$dir/metadata.json" << METAEOF
{
  "name": "$name",
  "slug": "$slug",
  "country": "$country"
}
METAEOF

  echo "✓ $slug"
done

echo ""
echo "Done! Extracted ${#JINGLES[@]} jingles."
