import jingles from "./data/jingles.json"
import triviaOrder from "./data/trivia.json"
import type { Jingle } from "./types"
import { useAudioPlayer } from "./useAudioPlayer"
import { Header } from "./components/Header"
import { JingleCard } from "./components/JingleCard"

const jingleMap = new Map((jingles as Jingle[]).map((j) => [j.id, j]))
const triviaJingles = triviaOrder
  .map((id) => jingleMap.get(id))
  .filter((j): j is Jingle => j != null)

export default function TriviaPage() {
  const { state, play } = useAudioPlayer()

  return (
    <div className="mx-auto min-h-dvh max-w-3xl">
      <Header />
      <div className="flex flex-col gap-2 px-5 pb-8">
        {triviaJingles.map((jingle, i) => (
          <div key={jingle.id} className="flex items-start gap-3">
            <span className="w-6 shrink-0 pt-3 text-right text-sm font-600 tabular-nums text-ink-muted">
              {i + 1}
            </span>
            <div className="min-w-0 flex-1">
              <JingleCard
                jingle={jingle}
                isPlaying={state.isPlaying && state.currentId === jingle.id}
                onPlay={() => play(jingle.id, jingle.audioFile)}
              />
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
