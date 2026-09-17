export async function runAutomaticActorTurns(input: {
  isFinished: () => boolean;
  currentKind: () => Promise<'pc' | 'actor'>;
  resolveActorTurn: () => Promise<void>;
  advanceTurn: () => Promise<void>;
}): Promise<void> {
  while (!input.isFinished()) {
    const kind = await input.currentKind();
    if (kind !== 'actor') return;
    await input.resolveActorTurn();
    if (input.isFinished()) return;
    await input.advanceTurn();
  }
}
