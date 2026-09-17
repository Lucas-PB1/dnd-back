import type { CastSpellDto } from '@game/session/dto/core/session-commands.dto';

/** Campos de cast skirmish/duelo → `CharacterStateRepository.castSpell`. */
export type CombatSurfaceCastInput = {
  spellSlug: string;
  slotLevel?: number;
  itemCastResourceSlug?: string;
  itemCastSpendAmount?: number;
  itemCastItemSlug?: string;
};

export function pickCombatSurfaceCastCommand(
  dto: CombatSurfaceCastInput,
): CastSpellDto {
  return {
    spellSlug: dto.spellSlug,
    slotLevel: dto.slotLevel,
    itemCastResourceSlug: dto.itemCastResourceSlug,
    itemCastSpendAmount: dto.itemCastSpendAmount,
    itemCastItemSlug: dto.itemCastItemSlug,
  };
}
