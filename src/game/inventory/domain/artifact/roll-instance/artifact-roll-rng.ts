export type Rng = () => number;

export function rollD100(rng: Rng): number {
  return Math.floor(rng() * 100) + 1;
}

export function pickOne<T>(items: readonly T[], rng: Rng): T {
  return items[Math.floor(rng() * items.length)]!;
}
