import { LoaderCircle } from "lucide-react"

export default function Loading() {
  return (
    <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 flex flex-col gap-4 items-center">
      <div className="text-3xl font-bold text-center text-muted-foreground">
        Loading...
      </div>
      <LoaderCircle className="text-muted-foreground size-24 animate-spin" />
    </div>
  )
}
