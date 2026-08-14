/** Opt-in: SHEET_PROFILE=1 — spans do GET ficha (measure:character). */

export type SheetProfileSpan = { name: string; ms: number };

const spans: SheetProfileSpan[] = [];

export function isSheetProfileEnabled(): boolean {
  return process.env.SHEET_PROFILE === '1';
}

export function resetSheetProfile(): void {
  spans.length = 0;
}

export function getSheetProfileSpans(): readonly SheetProfileSpan[] {
  return spans;
}

export async function sheetProfile<T>(
  name: string,
  run: () => Promise<T>,
): Promise<T> {
  if (!isSheetProfileEnabled()) return run();
  const started = performance.now();
  try {
    return await run();
  } finally {
    spans.push({ name, ms: performance.now() - started });
  }
}
