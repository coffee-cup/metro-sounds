export function Header() {
  return (
    <header className="px-5 pt-10 pb-2 sm:pt-14">
      <a href="/">
        <h1 className="font-display text-4xl font-800 tracking-tight text-balance sm:text-5xl">
          Metro Sounds
        </h1>
      </a>
      <p className="mt-2 text-base text-ink-secondary text-pretty">
        Railway jingles from around the world
      </p>
      <div className="mt-6 h-1 bg-rule" />
    </header>
  )
}
