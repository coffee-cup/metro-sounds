# Architecture

## Overview

Metro Sounds is a static single-page app. Users browse a grid of railway jingles from around the world and tap to play them. No accounts, no backend, no database.

## Data Flow

```
JSON data file → React components → HTML5 Audio API → speakers
```

## File Structure

```
src/
  data/
    jingles.json          # array of jingle entries
  components/             # React UI components
  App.tsx                 # root component
  main.tsx                # entry point
public/
  audio/                  # static .mp3 files (one per jingle)
  favicon.svg
```

## Data Model

Each jingle has a flexible schema. Only `id`, `label`, and `audioFile` are required:

```ts
type Jingle = {
  id: string
  label: string           // display name, e.g. "Tokyo Metro" or "Montreal"
  audioFile: string       // filename in public/audio/
  city?: string
  country?: string
  region?: string         // e.g. "Asia", "Europe"
  line?: string           // railway line or company
  notes?: string          // fun facts, context
}
```

## Audio

- Pre-spliced from YouTube compilation into individual MP3 files
- Stored in `public/audio/`, served as static assets
- Playback via HTML5 `<audio>` or `Audio()` API
- Only one jingle plays at a time

## Styling

- Tailwind CSS, utility-first
- Tokyo Metro design language: clean lines, bold color accents per region/line, clear typography
- Mobile-first breakpoints
- Light theme primary (dark theme possible later)
