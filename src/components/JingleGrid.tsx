import { JingleCard } from "./JingleCard"
import type { Jingle } from "../types"

type JingleGridProps = {
  jingles: Jingle[]
  currentId: string | null
  onPlay: (jingle: Jingle) => void
}

export function JingleGrid({ jingles, currentId, onPlay }: JingleGridProps) {
  if (jingles.length === 0) {
    return (
      <div className="px-5 py-16 text-center text-sm text-ink-muted">
        No jingles found
      </div>
    )
  }

  return (
    <div className="grid grid-cols-2 gap-2 px-5 pb-8">
      {jingles.map((jingle) => (
        <JingleCard
          key={jingle.id}
          jingle={jingle}
          isPlaying={currentId === jingle.id}
          onPlay={() => onPlay(jingle)}
        />
      ))}
    </div>
  )
}
