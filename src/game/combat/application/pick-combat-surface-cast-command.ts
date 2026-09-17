import type { CastSpellDto } from '@game/session/dto/core/session-commands.dto';

/** Campos de cast skirmish/duelo → `CharacterStateRepository.castSpell`. */
export type CombatSurfaceCastInput = {
  spellSlug: string;
  slotLevel?: number;
  itemCastResourceSlug?: string;
  itemCastSpendAmount?: number;
  itemCastItemSlug?: string;
  spiritVariantKey?: string;
  spiritCount?: number;
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
    spiritVariantKey: dto.spiritVariantKey,
    spiritCount: dto.spiritCount,
  };
}
