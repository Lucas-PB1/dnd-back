

export function rollArtifactSpellD6(rng: () => number = Math.random): number {
  return Math.floor(rng() * 6) + 1;
}

export function artifactSpellSuppressedUntilRest(d6: number): boolean {
  return d6 >= 1 && d6 <= 5;
}
