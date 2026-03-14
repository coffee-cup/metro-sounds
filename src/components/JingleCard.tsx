import { cn } from "../lib/cn"
import { REGION_COLORS } from "../lib/regions"
import type { Jingle } from "../types"

type JingleCardProps = {
  jingle: Jingle
  isPlaying: boolean
  onPlay: () => void
}

export function JingleCard({ jingle, isPlaying, onPlay }: JingleCardProps) {
  const borderColor = jingle.region
    ? REGION_COLORS[jingle.region] ?? "border-l-border"
    : "border-l-border"

  return (
    <button
      onClick={onPlay}
      className={cn(
        "flex w-full items-center gap-3 rounded-lg border-l-4 bg-surface-card px-4 py-3.5",
        "text-left shadow-sm hover:shadow-md",
        "active:scale-[0.98] transition-shadow",
        borderColor,
        isPlaying && "ring-2 ring-ink/10"
      )}
    >
      <div className="flex size-9 shrink-0 items-center justify-center rounded-full bg-surface">
        {isPlaying ? <PauseIcon /> : <PlayIcon />}
      </div>
      <div className="min-w-0">
        <p className="truncate text-sm font-600 text-ink">{jingle.label}</p>
        {jingle.country && (
          <p className="truncate text-xs text-ink-muted">{jingle.country}</p>
        )}
      </div>
    </button>
  )
}

function PlayIcon() {
  return (
    <svg
      width="14"
      height="14"
      viewBox="0 0 14 14"
      fill="currentColor"
      className="ml-0.5 text-ink-muted"
    >
      <path d="M3 1.5v11l9-5.5L3 1.5z" />
    </svg>
  )
}

function PauseIcon() {
  return (
    <svg
      width="14"
      height="14"
      viewBox="0 0 14 14"
      fill="currentColor"
      className="text-ink"
    >
      <rect x="2.5" y="1.5" width="3" height="11" rx="0.5" />
      <rect x="8.5" y="1.5" width="3" height="11" rx="0.5" />
    </svg>
  )
}
