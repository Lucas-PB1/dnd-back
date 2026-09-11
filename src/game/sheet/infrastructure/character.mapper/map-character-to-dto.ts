import { DataSource, Repository } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterResponseDto } from '../../dto/character-response.dto';
import { CharacterDomainService } from '../../domain/core/character-domain.service';
import { computeDerivedStats } from '../../domain/stats/character-derived-stats';
import {
  applyClassAbilityBoosts,
  classHitPointsBonus,
} from '../../domain/stats/class-ability-boost';
import { CharacterSheetRepository } from '../character-sheet.repository';
import { CharacterSheetData } from '../../domain/character-sheet.types';
import { ResolveEquippedArmorClass } from '@game/combat/application/resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from '@game/combat/application/resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from '@game/combat/application/resolve-equipment-compliance';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import {
  resolveSizeCategory,
  sizeCategoryFromChoices,
} from '@game/combat/domain/equipment';
import { ResolveActivePermanentItemEffects } from '@game/inventory/application/effects/resolve-active-permanent-item-effects';
import { resolveCharacterCombatSlice } from '@game/combat/application/resolve-character-combat-slice';
import { resolveCharacterSpellcastingSlice } from '@game/spellcasting/application/resolve-character-spellcasting-slice';
import { collectFightingStyleSlugsFromSubclassOptions } from '../../domain/validation/class-options/fighting-style-feat-options';
import { collectMasteredWeaponSlugs } from '../../domain/validation/class-options/class-weapon-mastery-slots';
import { assembleCharacterResponseDto } from '../assemble-character-response-dto';
import { sheetProfile } from '@common/perf/sheet-profile';
import { LoadCharacterThreadBundleQuery } from '../../application/load-character-thread-bundle.query';
import { PhbHeritageTrait } from '@entities/heritage/phb-heritage-trait.entity';
import { resolveAggregatedHeritageTraits } from '../../domain/heritage/resolve-aggregated-heritage-traits';
import { resolveSheetMeta } from './resolve-sheet-meta';
import { loadGatedSpeciesEffects, type LoadEffectCatalog } from '@game/effects';
import { resolveJackOfAllTradesLevel } from '@game/sheet/infrastructure/queries/class-meta.queries';

export type MapCharacterToDtoDeps = {
  dataSource: DataSource;
  domain: CharacterDomainService;
  sheet: CharacterSheetRepository;
  equippedArmorClass: ResolveEquippedArmorClass;
  equippedWeaponAttacks: ResolveEquippedWeaponAttacks;
  equipmentCompliance: ResolveEquipmentCompliance;
  permanentItemEffects: ResolveActivePermanentItemEffects;
  subclassSpellsRepo: Repository<VPhbSubclassPreparedSpell>;
  heritageTraitRepo: Repository<PhbHeritageTrait>;
  grantedSpellCatalog: LoadGrantedSpellCatalog;
  loadCharacterThread: LoadCharacterThreadBundleQuery;
  effectCatalog: LoadEffectCatalog;
};

export async function mapCharacterToDto(
  deps: MapCharacterToDtoDeps,
  row: PlayerCharacter,
  sheetData?: CharacterSheetData,
): Promise<CharacterResponseDto> {
  const loaded =
    sheetData ??
    deps.sheet.mergeSheetData(
      await sheetProfile('sheet.p030', () =>
        deps.sheet.load(row.id, row.backgroundSlug),
      ),
      row.abilityGenerationMethodSlug,
    );

  const { proficiencyBonus, classBoosts, speciesSize } = await resolveSheetMeta(
    deps.domain,
    deps.dataSource,
    row,
    loaded,
  );

  const { scores: effectiveAbilityScores } = applyClassAbilityBoosts(
    row.abilityScores,
    row.level,
    classBoosts,
  );
  const classHpBonus = classHitPointsBonus(
    row.abilityScores.constituicao,
    effectiveAbilityScores.constituicao,
    row.level,
  );
  const featSlugs = loaded.characterFeats.map((feat) => feat.featSlug);
  const fightingStyleSlugs = collectFightingStyleSlugsFromSubclassOptions(
    loaded.subclassOptions,
  );
  const featEffects = await deps.effectCatalog.load({
    ownerKind: 'feat',
    ownerSlugs: [...new Set([...featSlugs, ...fightingStyleSlugs])],
  });
  const speciesEffects = await loadGatedSpeciesEffects({
    effectCatalog: deps.effectCatalog,
    speciesSlug: row.speciesSlug,
    speciesChoices: loaded.speciesChoices,
  });
  const jackOfAllTradesUnlockLevel = await resolveJackOfAllTradesLevel(
    deps.dataSource,
    row.classSlug,
  );
  const derived = computeDerivedStats({
    abilityScores: effectiveAbilityScores,
    proficiencyBonus,
    classSkillSlugs: loaded.classSkillSlugs,
    backgroundSkillSlugs: loaded.backgroundSkillSlugs,
    speciesChoices: loaded.speciesChoices,
    featOptions: loaded.featOptions,
    characterFeats: loaded.characterFeats,
    featEffects,
    classOptions: loaded.classOptions,
    subclassOptions: loaded.subclassOptions,
    classSlug: row.classSlug,
    level: row.level,
    jackOfAllTradesUnlockLevel,
  });
  const sizeCategory = resolveSizeCategory(
    speciesSize ?? undefined,
    sizeCategoryFromChoices(loaded.speciesChoices),
  );

  const [combat, spellcasting, thread, aggregatedHeritageTraits] =
    await Promise.all([
      sheetProfile('combat', () =>
        resolveCharacterCombatSlice({
          characterId: row.id,
          abilityScores: effectiveAbilityScores,
          classSlug: row.classSlug,
          subclassSlug: row.subclassSlug,
          speciesSlug: row.speciesSlug ?? undefined,
          heritageChoices: loaded.heritageChoices,
          speciesChoices: loaded.speciesChoices,
          classOptions: loaded.classOptions,
          transformation: loaded.transformation,
          level: row.level,
          proficiencyBonus,
          featSlugs,
          featEffects,
          speciesEffects,
          fightingStyleSlugs,
          masteredWeaponSlugs: collectMasteredWeaponSlugs({
            classOptions: loaded.classOptions,
            featOptions: loaded.featOptions,
          }),
          sizeCategory,
          dataSource: deps.dataSource,
          equippedArmorClass: deps.equippedArmorClass,
          equippedWeaponAttacks: deps.equippedWeaponAttacks,
          equipmentCompliance: deps.equipmentCompliance,
          permanentItemEffects: deps.permanentItemEffects,
        }),
      ),
      sheetProfile('spellcasting', () =>
        resolveCharacterSpellcastingSlice({
          dataSource: deps.dataSource,
          subclassSpellsRepo: deps.subclassSpellsRepo,
          grantedSpellCatalog: deps.grantedSpellCatalog,
          sheet: loaded,
          speciesSlug: row.speciesSlug ?? undefined,
          subclassSlug: row.subclassSlug,
          level: row.level,
          classSlug: row.classSlug,
          proficiencyBonus,
          abilityModifiers: derived.abilityModifiers,
          featSlugs,
          speciesEffects,
        }),
      ),
      sheetProfile('thread', () => deps.loadCharacterThread.execute(row.id)),
      row.heritageSlug && loaded.heritageChoices.length > 0
        ? sheetProfile('heritage.aggregate', () =>
            resolveAggregatedHeritageTraits(
              loaded.heritageChoices,
              deps.heritageTraitRepo,
            ),
          )
        : Promise.resolve([]),
    ]);

  return assembleCharacterResponseDto({
    row,
    loaded,
    effectiveAbilityScores,
    proficiencyBonus,
    classHpBonus,
    derived,
    combat,
    spellcasting,
    thread,
    aggregatedHeritageTraits,
  });
}
