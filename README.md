# Metro Sounds

Browse and listen to railway jingles from around the world. Sourced from [this YouTube compilation](https://www.youtube.com/watch?v=ZG7nYwzOZu0), spliced into individual clips.

## Setup

```
bun install
bash scripts/sync-jingles.sh
bun run dev
```

The sync script copies audio files to `public/audio/` and generates `src/data/jingles.json` from the metadata in `sounds/`. Run it again whenever jingles are added or changed.

## Adding jingles

Create a directory in `sounds/` with a `jingle.mp3` and `metadata.json`:

```json
{
  "name": "Deutsche Bahn",
  "country": "Germany"
}
```

Then re-run `bash scripts/sync-jingles.sh`.
