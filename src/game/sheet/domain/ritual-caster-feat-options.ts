import { PhbFeatOptionDef } from '../../../entities/phb-feat-option.entity';

export const RITUAL_CASTER_FEAT_SLUG = 'ritual-caster';

const RITUAL_SPELL_KEY = /^ritualSpell(\d+)$/;

export function ritualSpellSlotIndex(optionKey: string): number | null {
  const match = RITUAL_SPELL_KEY.exec(optionKey);
  if (!match) return null;
  return Number.parseInt(match[1], 10);
}

/** Opções exigidas para Conjurador Ritualista conforme o BP; demais talentos retornam todas as defs. */
export function requiredFeatOptionDefsForInstance(
  featSlug: string,
  defs: PhbFeatOptionDef[],
  proficiencyBonus: number,
): PhbFeatOptionDef[] {
  if (featSlug !== RITUAL_CASTER_FEAT_SLUG) {
    return defs;
  }
  return defs.filter((def) => {
    const slot = ritualSpellSlotIndex(def.optionKey);
    if (slot === null) return true;
    return slot <= proficiencyBonus;
  });
}
