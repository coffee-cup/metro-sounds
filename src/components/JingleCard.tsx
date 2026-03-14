import { cn } from "../lib/cn"
import { REGION_DOT_COLORS } from "../lib/regions"
import type { Jingle } from "../types"

type JingleCardProps = {
  jingle: Jingle
  isPlaying: boolean
  onPlay: () => void
}

export function JingleCard({ jingle, isPlaying, onPlay }: JingleCardProps) {
  const dotColor = jingle.region
    ? REGION_DOT_COLORS[jingle.region] ?? "bg-ink-muted"
    : "bg-ink-muted"

  return (
    <button
      onClick={onPlay}
      className={cn(
        "flex w-full items-start gap-3 border border-rule-light px-4 py-3",
        "text-left",
        isPlaying && "bg-ink text-white"
      )}
    >
      <div
        className={cn(
          "mt-1 flex size-7 shrink-0 items-center justify-center",
          isPlaying ? "text-white" : "text-ink"
        )}
      >
        {isPlaying ? <PauseIcon /> : <PlayIcon />}
      </div>
      <div className="min-w-0 pt-0.5">
        <p className={cn("text-sm font-600 text-pretty", isPlaying ? "text-white" : "text-ink")}>
          {jingle.label}
        </p>
        <div className="mt-1 flex items-center gap-1.5">
          <span className={cn("inline-block size-1.5 rounded-full", dotColor)} />
          <span
            className={cn(
              "text-xs",
              isPlaying ? "text-white/60" : "text-ink-muted"
            )}
          >
            {jingle.country ?? jingle.region ?? "Unknown"}
          </span>
        </div>
      </div>
    </button>
  )
}

function PlayIcon() {
  return (
    <svg width="12" height="14" viewBox="0 0 12 14" fill="currentColor">
      <path d="M0 0v14l12-7L0 0z" />
    </svg>
  )
}

function PauseIcon() {
  return (
    <svg width="12" height="14" viewBox="0 0 12 14" fill="currentColor">
      <rect x="0" y="0" width="4" height="14" />
      <rect x="8" y="0" width="4" height="14" />
    </svg>
  )
}
