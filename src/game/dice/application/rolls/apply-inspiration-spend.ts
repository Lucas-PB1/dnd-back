import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterResourceSpender } from '@game/session/domain/character-resource-spender';
import {
  hasInspirationRefundOnFail,
  type LoadEffectCatalog,
} from '@game/effects';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';

export async function applyInspirationSpend(input: {
  resourceSpender: CharacterResourceSpender;
  sheet: CharacterSheetRepository;
  effectCatalog: LoadEffectCatalog;
  character: PlayerCharacter;
  spentInspiration: boolean;
  failed: boolean | null;
  notes: string[];
}): Promise<void> {
  if (!input.spentInspiration) return;

  const had = await input.resourceSpender.getInspiration(input.character);
  if (!had) return;

  await input.resourceSpender.setInspiration(input.character, false);

  if (input.failed !== true) {
    input.notes.push('Inspiração gasta');
    return;
  }

  const sheet = await input.sheet.load(input.character.id);
  const featSlugs = sheet.characterFeats.map((f) => f.featSlug);
  const effects = await input.effectCatalog.load({
    ownerKind: 'feat',
    ownerSlugs: featSlugs,
  });
  if (!hasInspirationRefundOnFail(effects, featSlugs)) {
    input.notes.push('Inspiração gasta');
    return;
  }

  await input.resourceSpender.setInspiration(input.character, true);
  input.notes.push('IH: inspiração não gasta (teste falhou)');
}
