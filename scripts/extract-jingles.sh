#!/bin/bash
set -e

SOUNDS_DIR="/Users/jr/dev/metro-sounds/sounds"
SOURCE="$SOUNDS_DIR/Railway Jingles from Around the World [ZG7nYwzOZu0].webm"

# Timestamps derived from ffmpeg scene detection + manual verification of version transitions.
# Format: start_seconds|end_seconds|slug|name|country
JINGLES=(
  "0|2.333|deutsche-bahn|Deutsche Bahn (German Railways)|Germany"
  "2.333|5.733|nederlandse-spoorwegen|Nederlandse Spoorwegen (Dutch Railways)|Netherlands"
  "5.733|9.167|sncf|SNCF (French National Railway Company)|France"
  "9.167|12|renfe-operadora-v1|Renfe-Operadora (National Network of Spanish Railways) Version 1|Spain"
  "12|14.833|renfe-operadora-v2|Renfe-Operadora (National Network of Spanish Railways) Version 2|Spain"
  "14.833|17.467|comboios-de-portugal|Comboios de Portugal (Trains of Portugal)|Portugal"
  "17.467|20.067|national-rail|National Rail (formerly British Rail)|United Kingdom"
  "20.067|22.667|swiss-federal-railways-german|Swiss Federal Railways (German Version)|Switzerland"
  "22.667|24.733|swiss-federal-railways-french|Swiss Federal Railways (French Version)|Switzerland"
  "24.733|27.2|swiss-federal-railways-italian|Swiss Federal Railways (Italian Version)|Switzerland"
  "27.2|30.133|trenitalia|Trenitalia (Italian Railways)|Italy"
  "30.133|33|obb-v1|ÖBB - Österreichische Bundesbahnen (Austrian Federal Railways) Version 1|Austria"
  "33|34.067|obb-v2|ÖBB - Österreichische Bundesbahnen (Austrian Federal Railways) Version 2|Austria"
  "34.067|37.333|ceske-drahy|České Dráhy (Czech Railways)|Czech Republic"
  "37.333|42|zssk-v1|Železničná Spoločnosť Slovensko (Railway Company of Slovakia) Version 1|Slovakia"
  "42|47.1|zssk-v2|Železničná Spoločnosť Slovensko (Railway Company of Slovakia) Version 2|Slovakia"
  "47.1|50.967|pkp|Polskie Koleje Państwowe (Polish State Railways)|Poland"
  "50.967|51.767|vr-group-finland|VR-Yhtymä Oyj (VR-Group PLC Finland)|Finland"
  "51.767|54.1|dsb|Danske Statsbaner (Danish State Railways)|Denmark"
  "54.1|55.767|ukrainian-railways|Українські залізниці (Ukrainian Railways)|Ukraine"
  "55.767|62.167|cfr|Căile Ferate Române (Romanian Railways)|Romania"
  "62.167|64.533|hellenic-train|Ελληνικό Τρένο (Hellenic Train)|Greece"
  "64.533|67|mav-v1|Magyar Államvasutak (Hungarian State Railways) Version 1|Hungary"
  "67|71.367|mav-v2|Magyar Államvasutak (Hungarian State Railways) Version 2|Hungary"
  "71.367|75.767|russian-railways|Российские железные дороги (Russian Railways)|Russia"
  "75.767|79.533|jr-west-japan|JR西日本 (West Japan Railway Company)|Japan"
  "79.533|82.767|jr-east-japan|JR東日本 (East Japan Railway Company)|Japan"
  "82.767|92.667|korail-new|한국철도공사 KORAIL (Korean Railroad Corporation) New Version|South Korea"
  "92.667|102.467|korail-old|한국철도공사 KORAIL (Korean Railroad Corporation) Old Version|South Korea"
  "102.467|109.767|korail-approaching-seoul|한국철도공사 KORAIL (Korean Railroad Corporation) Approaching Seoul|South Korea"
  "109.767|118.833|kereta-api-indonesia|Kereta Api Indonesia (Indonesian Railways)|Indonesia"
  "118.833|121.733|singapore-mrt|Pengangkutan Gerak Cepat (Singapore Mass Rapid Transit)|Singapore"
  "121.733|125.067|ktm-malaysia|KTM - Keretapi Tanah Melayu (Malaysian Railways Limited)|Malaysia"
  "125.067|130.633|china-railway-high-speed|中国高速铁路 CRH (China Railway High-speed)|China"
  "130.633|136.367|indian-railways|भारतीय रेल (Indian Railways)|India"
  "136.367|137.2|kazakhstan-temir-joly|Қазақстан Темір Жолы (Kazakhstan Temir Joly)|Kazakhstan"
  "137.2|140.767|tcdd|Türkiye Cumhuriyeti Devlet Demiryolları (Turkish State Railways)|Turkey"
  "140.767|144.467|amtrak|Amtrak (National Railroad Passenger Corporation)|United States"
  "144.467|147|via-rail-v1|VIA Rail (Via Rail Canada Inc.) Version 1|Canada"
  "147|148.5|via-rail-v2|VIA Rail (Via Rail Canada Inc.) Version 2|Canada"
  "148.5|150.067|go-transit-sydney-metro|GO Transit / Sydney Metro|Canada"
  "150.067|151.6|go-transit-manual|GO Transit (Manual Announcement)|Canada"
)

for entry in "${JINGLES[@]}"; do
  IFS='|' read -r start end slug name country <<< "$entry"

  dir="$SOUNDS_DIR/$slug"
  mkdir -p "$dir"

  duration=$(awk "BEGIN {printf \"%.3f\", $end - $start}")
  ffmpeg -y -i "$SOURCE" -ss "$start" -t "$duration" -vn -ab 128k "$dir/jingle.mp3" 2>/dev/null

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
