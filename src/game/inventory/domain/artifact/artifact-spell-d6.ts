/** RAW: após usar magia de prop aleatória de artefato, 1d6 — 1–5 suprime até DL. */

export function rollArtifactSpellD6(rng: () => number = Math.random): number {
  return Math.floor(rng() * 6) + 1;
}

/** true = não pode usar de novo até DL (MVP ≈ amanhecer). */
export function artifactSpellSuppressedUntilRest(d6: number): boolean {
  return d6 >= 1 && d6 <= 5;
}
