import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterResponseDto } from '../dto/character-response.dto';
import { CharacterSheetData } from '../domain/character-sheet.types';
import type { MappedCombatSlice } from '@game/combat/application/resolve-character-combat-slice';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterThreadBundleDto } from '../dto/character-thread.dto';
import type { AggregatedHeritageTraitDto } from '../dto/character-response.dto';

type SpellcastingSlice = {
  characterSpells: CharacterResponseDto['characterSpells'];
  spellcastingAbilitySlug: CharacterResponseDto['spellcastingAbilitySlug'];
  spellSaveDc: CharacterResponseDto['spellSaveDc'];
  spellAttackBonus: CharacterResponseDto['spellAttackBonus'];
};

type DerivedSlice = {
  abilityModifiers: CharacterResponseDto['abilityModifiers'];
  passivePerception: number;
};

export function assembleCharacterResponseDto(input: {
  row: PlayerCharacter;
  loaded: CharacterSheetData;
  effectiveAbilityScores: AbilityScores;
  proficiencyBonus: number;
  classHpBonus: number;
  derived: DerivedSlice;
  combat: MappedCombatSlice;
  spellcasting: SpellcastingSlice;
  thread: CharacterThreadBundleDto | null;
  aggregatedHeritageTraits?: AggregatedHeritageTraitDto[];
}): CharacterResponseDto {
  const { row, loaded, combat, spellcasting, derived } = input;
  return {
    id: row.id,
    name: row.name,
    level: row.level,
    classSlug: row.classSlug,
    speciesSlug: row.speciesSlug,
    heritageSlug: row.heritageSlug,
    backgroundSlug: row.backgroundSlug,
    subclassSlug: row.subclassSlug,
    alignmentSlug: row.alignmentSlug,
    abilityScores: row.abilityScores,
    effectiveAbilityScores: input.effectiveAbilityScores,
    hitPointsMax:
      row.hitPointsMax === null
        ? null
        : row.hitPointsMax +
          combat.itemHpBonus +
          combat.heritageHpBonus +
          input.classHpBonus,
    hitPointsCurrent: row.hitPointsCurrent,
    proficiencyBonus: input.proficiencyBonus,
    classSkillSlugs: loaded.classSkillSlugs,
    speciesChoices: loaded.speciesChoices,
    heritageChoices: loaded.heritageChoices,
    aggregatedHeritageTraits: input.aggregatedHeritageTraits,
    subclassOptions: loaded.subclassOptions,
    classOptions: loaded.classOptions,
    characterFeats: loaded.characterFeats,
    featOptions: loaded.featOptions,
    characterSpells: spellcasting.characterSpells,
    equipment: loaded.equipment,
    languageSlugs: loaded.languageSlugs,
    abilityGenerationMethodSlug: loaded.abilityGenerationMethodSlug,
    backgroundSkillSlugs: loaded.backgroundSkillSlugs,
    backgroundAbilityBoostMode:
      row.backgroundBoostMode === 'plus1x3' ? 'plus1x3' : 'plus2plus1',
    backgroundAbilityBoostPlus2Slug: row.backgroundBoostPlus2AbilitySlug,
    backgroundAbilityBoostPlus1Slug: row.backgroundBoostPlus1AbilitySlug,
    backgroundAbilityBoostPlus1Slugs: row.backgroundBoostPlus1Slugs,
    backgroundToolItemSlug: row.backgroundToolItemSlug,
    abilityModifiers: derived.abilityModifiers,
    passivePerception: derived.passivePerception,
    armorClass: combat.armorClass,
    armorClassNote: combat.armorClassNote,
    weaponAttacks: combat.weaponAttacks,
    equipmentWarnings: combat.equipmentWarnings,
    cannotCastSpellsInArmor: combat.cannotCastSpellsInArmor,
    speedPenaltyMeters: combat.speedPenaltyMeters,
    itemSpeedBonusMeters: combat.itemSpeedBonusMeters,
    classCombatNotes: combat.classCombatNotes,
    attacksPerAction: combat.attacksPerAction,
    savingThrowAuraBonus: combat.savingThrowAuraBonus,
    spellcastingAbilitySlug: spellcasting.spellcastingAbilitySlug,
    spellSaveDc: spellcasting.spellSaveDc,
    spellAttackBonus: spellcasting.spellAttackBonus,
    campaigns: [],
    coins: {
      copper: row.coinCopper,
      silver: row.coinSilver,
      electrum: row.coinElectrum,
      gold: row.coinGold,
      platinum: row.coinPlatinum,
    },
    thread: input.thread,
    createdAt: row.createdAt.toISOString(),
    updatedAt: row.updatedAt.toISOString(),
  };
}
