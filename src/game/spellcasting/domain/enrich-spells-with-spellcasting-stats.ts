import type { AbilityKey } from '@game/build/domain/ability-generation';
import type { AbilityModifiers } from '@game/sheet/domain/stats/character-derived-stats';
import type {
  CharacterSpellDto,
  FeatOptionDto,
  SpeciesChoiceDto,
} from '@game/sheet/dto/character-sheet.dto';
import type {
  FeatGrantedSpellRow,
  SpeciesGrantedSpellRow,
} from './granted-spells/types';
import { resolveSpellcastingAbilityForSpell } from './resolve-granted-spellcasting-ability';
import { resolveGrantedSpellCastEconomy } from './resolve-granted-spell-cast-economy';
import { spellcastingDerivedStats } from './spellcasting-stats';

/** Anexa atributo/CD/ataque/economia por magia (campos só de resposta). */
export function enrichSpellsWithSpellcastingStats(
  spells: readonly CharacterSpellDto[],
  input: {
    classAbilitySlug: AbilityKey | null;
    proficiencyBonus: number;
    abilityModifiers: AbilityModifiers;
    featOptions?: readonly FeatOptionDto[];
    speciesChoices?: readonly SpeciesChoiceDto[];
    featFixedSpells?: readonly FeatGrantedSpellRow[];
    speciesSlug?: string;
    speciesCatalog?: readonly SpeciesGrantedSpellRow[];
  },
): CharacterSpellDto[] {
  return spells.map((spell) => {
    const ability = resolveSpellcastingAbilityForSpell({
      source: spell.source,
      spellSlug: spell.spellSlug,
      classAbilitySlug: input.classAbilitySlug,
      featOptions: input.featOptions,
      speciesChoices: input.speciesChoices,
      featFixedSpells: input.featFixedSpells,
    });
    const stats = spellcastingDerivedStats({
      spellcastingAbilitySlug: ability,
      proficiencyBonus: input.proficiencyBonus,
      abilityModifiers: input.abilityModifiers,
    });
    const castEconomy = resolveGrantedSpellCastEconomy({
      spellSlug: spell.spellSlug,
      source: spell.source,
      featOptions: input.featOptions,
      featFixedSpells: input.featFixedSpells,
      speciesSlug: input.speciesSlug,
      speciesChoices: input.speciesChoices,
      speciesCatalog: input.speciesCatalog,
    });
    return {
      ...spell,
      spellcastingAbilitySlug: stats.spellcastingAbilitySlug ?? undefined,
      spellSaveDc: stats.spellSaveDc ?? undefined,
      spellAttackBonus: stats.spellAttackBonus ?? undefined,
      castEconomy,
    };
  });
}
