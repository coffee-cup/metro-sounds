import { useState } from "react"
import jingles from "./data/jingles.json"
import type { Jingle } from "./types"
import { useAudioPlayer } from "./useAudioPlayer"
import { Header } from "./components/Header"
import { FilterBar } from "./components/FilterBar"
import { JingleGrid } from "./components/JingleGrid"

const typedJingles = jingles as Jingle[]
const regions = [...new Set(typedJingles.map((j) => j.region).filter(Boolean))] as string[]

export default function App() {
  const [regionFilter, setRegionFilter] = useState<string | null>(null)
  const { state, play } = useAudioPlayer()

  const filtered = regionFilter
    ? typedJingles.filter((j) => j.region === regionFilter)
    : typedJingles

  return (
    <div className="mx-auto min-h-dvh max-w-3xl">
      <Header />
      <FilterBar
        regions={regions}
        active={regionFilter}
        onSelect={setRegionFilter}
      />
      <JingleGrid
        jingles={filtered}
        currentId={state.isPlaying ? state.currentId : null}
        onPlay={(j) => play(j.id, j.audioFile)}
      />
    </div>
  )
}
