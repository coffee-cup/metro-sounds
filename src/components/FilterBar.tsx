import { cn } from "../lib/cn"

type FilterBarProps = {
  regions: string[]
  active: string | null
  onSelect: (region: string | null) => void
}

export function FilterBar({ regions, active, onSelect }: FilterBarProps) {
  return (
    <div className="flex gap-1 overflow-x-auto px-5 py-4 scrollbar-none">
      <button
        onClick={() => onSelect(null)}
        className={cn(
          "shrink-0 border border-rule-light px-3 py-1 text-xs font-600 uppercase tracking-wide",
          active === null
            ? "border-ink bg-ink text-white"
            : "text-ink-muted hover:border-ink hover:text-ink"
        )}
      >
        All
      </button>
      {regions.map((region) => (
        <button
          key={region}
          onClick={() => onSelect(region)}
          className={cn(
            "shrink-0 border border-rule-light px-3 py-1 text-xs font-600 uppercase tracking-wide",
            active === region
              ? "border-ink bg-ink text-white"
              : "text-ink-muted hover:border-ink hover:text-ink"
          )}
        >
          {region}
        </button>
      ))}
    </div>
  )
}
