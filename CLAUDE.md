# Metro Sounds

Mobile-friendly web app that plays railway jingles from around the world. Sourced from [this YouTube compilation](https://www.youtube.com/watch?v=ZG7nYwzOZu0), spliced into individual static audio clips.

## Stack

- React 19 + TypeScript + Vite
- Tailwind CSS
- Bun (package manager)

## Commands

- `bun run check` — typecheck (no emit). Run after big changes
- `bun run build` — typecheck + build
- `bun run lint` — eslint
- **Never run `bun run dev`** — the user manages the dev server themselves

## Architecture

- Purely static SPA, no backend/API
- Audio files live in `public/audio/`
- Jingle data in a JSON file (src/data/)
- Metadata per jingle is flexible: some have city + country, others just a railway company name
- HTML5 Audio API for playback

## UI Direction

- **Tokyo Metro inspired**: clean, colorful line indicators, precise typography
- Mobile-first, responsive
- Should feel "metro-y" — easy to understand, professional, slightly fun
- Use the `frontend-design` skill when designing UI components
- Browse jingles via a list/card grid (no map)

## Guidelines

- No tests for now
- No backend — keep everything static
- When adding jingles, only a label is required; other metadata (city, country, region, line) is optional
