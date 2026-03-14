import { cn } from "../lib/cn"
import { REGION_BG_COLORS } from "../lib/regions"

type FilterBarProps = {
  regions: string[]
  active: string | null
  onSelect: (region: string | null) => void
}

export function FilterBar({ regions, active, onSelect }: FilterBarProps) {
  return (
    <div className="flex gap-2 overflow-x-auto px-5 pb-4 scrollbar-none">
      <button
        onClick={() => onSelect(null)}
        className={cn(
          "shrink-0 rounded-full px-4 py-1.5 text-sm font-600 transition-colors",
          active === null
            ? "bg-ink text-white"
            : "bg-border/50 text-ink-muted hover:bg-border"
        )}
      >
        All
      </button>
      {regions.map((region) => (
        <button
          key={region}
          onClick={() => onSelect(region)}
          className={cn(
            "shrink-0 rounded-full px-4 py-1.5 text-sm font-600 transition-colors",
            active === region
              ? cn(REGION_BG_COLORS[region], "text-white")
              : "bg-border/50 text-ink-muted hover:bg-border"
          )}
        >
          {region}
        </button>
      ))}
    </div>
  )
}
