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
  const [search, setSearchRaw] = useState(
    () => new URLSearchParams(window.location.search).get("q") ?? ""
  )

  function setSearch(value: string) {
    setSearchRaw(value)
    const url = new URL(window.location.href)
    if (value) {
      url.searchParams.set("q", value)
    } else {
      url.searchParams.delete("q")
    }
    window.history.replaceState(null, "", url)
  }
  const { state, play } = useAudioPlayer()

  const filtered = typedJingles.filter((j) => {
    if (regionFilter && j.region !== regionFilter) return false
    if (search) {
      const q = search.toLowerCase()
      return (
        j.label.toLowerCase().includes(q) ||
        j.country?.toLowerCase().includes(q) ||
        j.region?.toLowerCase().includes(q)
      )
    }
    return true
  })

  return (
    <div className="mx-auto min-h-dvh max-w-3xl">
      <Header />
      <div className="px-5 pb-3">
        <input
          type="text"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          placeholder="Search jingles..."
          className="w-full border border-rule-light px-3 py-2 text-sm text-ink placeholder:text-ink-muted focus:border-ink focus:outline-none"
        />
      </div>
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
