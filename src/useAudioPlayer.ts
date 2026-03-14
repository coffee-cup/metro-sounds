import { useState, useRef } from "react"

type PlayerState = {
  currentId: string | null
  isPlaying: boolean
}

const audio = new Audio()

export function useAudioPlayer() {
  const [state, setState] = useState<PlayerState>({
    currentId: null,
    isPlaying: false,
  })
  const initialized = useRef(false)

  if (!initialized.current) {
    initialized.current = true
    audio.addEventListener("ended", () => {
      setState({ currentId: null, isPlaying: false })
    })
  }

  function play(id: string, audioFile: string) {
    if (state.currentId === id && state.isPlaying) {
      audio.pause()
      setState({ currentId: id, isPlaying: false })
      return
    }

    if (state.currentId === id && !state.isPlaying) {
      audio.play()
      setState({ currentId: id, isPlaying: true })
      return
    }

    audio.src = `/audio/${audioFile}`
    audio.play()
    setState({ currentId: id, isPlaying: true })
  }

  function stop() {
    audio.pause()
    audio.currentTime = 0
    setState({ currentId: null, isPlaying: false })
  }

  return { state, play, stop }
}
