import { PhbOptionDef } from '@entities/phb-option.entity';
import { ritualSpellSlotIndex } from '@game/spellcasting/domain/ritual-spell-option-key';

export { ritualSpellSlotIndex };

export const RITUAL_CASTER_FEAT_SLUG = 'ritual-caster';

/** Opções exigidas para Conjurador Ritualista conforme o BP; demais talentos retornam todas as defs. */
export function requiredFeatOptionDefsForInstance(
  featSlug: string,
  defs: PhbOptionDef[],
  proficiencyBonus: number,
): PhbOptionDef[] {
  if (featSlug !== RITUAL_CASTER_FEAT_SLUG) {
    return defs;
  }
  return defs.filter((def) => {
    const slot = ritualSpellSlotIndex(def.optionKey);
    if (slot === null) return true;
    return slot <= proficiencyBonus;
  });
}
