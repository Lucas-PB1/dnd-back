import { parseDiceExpression, rollDie, type Rng } from '@game/dice/domain/dice';
import { LoadEffectCatalog } from '@game/effects';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { slotRefundMatches } from '@game/session/domain/slot-refund-on-die-match';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { recoverSpellSlot } from '../resources/spell-slots';

export async function applySlotRefundOnCast(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  slotLevelUsed: number;
  sheetRepository: CharacterSheetRepository;
  effectCatalog: LoadEffectCatalog;
  rng?: Rng;
}): Promise<boolean> {
  const sheet = await input.sheetRepository.load(input.character.id);
  const featSlugs = (sheet.characterFeats ?? []).map((feat) => feat.featSlug);
  if (featSlugs.length === 0) return false;

  const effects = await input.effectCatalog.load({
    ownerKind: 'feat',
    ownerSlugs: featSlugs,
    triggers: ['on_cast'],
    kinds: ['slot_refund_on_die_match'],
  });
  const effect = effects.find(
    (row) => row.kind === 'slot_refund_on_die_match',
  );
  if (!effect) return false;

  const maxSlotLevel = Math.max(1, effect.numeric?.flat ?? 4);
  const die = effect.dice?.die ?? '1d4';
  const faces = parseDiceExpression(die).sides;
  const dieRoll = rollDie(faces, input.rng ?? Math.random);
  if (
    !slotRefundMatches({
      slotLevel: input.slotLevelUsed,
      dieRoll,
      maxSlotLevel,
    })
  ) {
    return false;
  }
  recoverSpellSlot(input.state, input.slotLevelUsed);
  return true;
}
