import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  CharacterResponseDto,
  CharacterSummaryResponseDto,
} from '../dto/character-response.dto';
import { CharacterDomainService } from '../domain/core/character-domain.service';
import { computeDerivedStats } from '../domain/stats/character-derived-stats';
import {
  applyClassAbilityBoosts,
  classHitPointsBonus,
  type ClassAbilityBoostRow,
} from '../domain/stats/class-ability-boost';
import { loadClassAbilityBoosts } from './load-class-ability-boosts';
import { CharacterSheetRepository } from './character-sheet.repository';
import { CharacterSheetData } from '../domain/character-sheet.types';
import { ResolveEquippedArmorClass } from '@game/combat/application/resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from '@game/combat/application/resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from '@game/combat/application/resolve-equipment-compliance';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import {
  resolveSizeCategory,
  sizeCategoryFromChoices,
} from '@game/combat/domain/equipment';
import { ResolveActivePermanentItemEffects } from '@game/inventory/application/resolve-active-permanent-item-effects';
import { resolveCharacterCombatSlice } from '@game/combat/application/resolve-character-combat-slice';
import { resolveCharacterSpellcastingSlice } from '@game/spellcasting/application/resolve-character-spellcasting-slice';
import { collectFightingStyleSlugsFromSubclassOptions } from '../domain/validation/class-options/fighting-style-feat-options';
import { collectMasteredWeaponSlugs } from '../domain/validation/class-options/class-weapon-mastery-slots';
import { assembleCharacterResponseDto } from './assemble-character-response-dto';
import { sheetProfile } from '@common/perf/sheet-profile';
import { LoadCharacterThreadBundleQuery } from '../application/load-character-thread-bundle.query';

@Injectable()
export class CharacterMapper {
  constructor(
    private readonly dataSource: DataSource,
    private readonly domain: CharacterDomainService,
    private readonly sheet: CharacterSheetRepository,
    private readonly equippedArmorClass: ResolveEquippedArmorClass,
    private readonly equippedWeaponAttacks: ResolveEquippedWeaponAttacks,
    private readonly equipmentCompliance: ResolveEquipmentCompliance,
    private readonly permanentItemEffects: ResolveActivePermanentItemEffects,
    @InjectRepository(VPhbSubclassPreparedSpell)
    private readonly subclassSpellsRepo: Repository<VPhbSubclassPreparedSpell>,
    private readonly grantedSpellCatalog: LoadGrantedSpellCatalog,
    private readonly loadCharacterThread: LoadCharacterThreadBundleQuery,
  ) {}

  async toDto(
    row: PlayerCharacter,
    sheetData?: CharacterSheetData,
  ): Promise<CharacterResponseDto> {
    const loaded =
      sheetData ??
      this.sheet.mergeSheetData(
        await sheetProfile('sheet.p030', () =>
          this.sheet.load(row.id, row.backgroundSlug),
        ),
        row.abilityGenerationMethodSlug,
      );

    const { proficiencyBonus, classBoosts, speciesSize } =
      await this.resolveSheetMeta(row, loaded);

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
    const derived = computeDerivedStats({
      abilityScores: effectiveAbilityScores,
      proficiencyBonus,
      classSkillSlugs: loaded.classSkillSlugs,
      backgroundSkillSlugs: loaded.backgroundSkillSlugs,
      speciesChoices: loaded.speciesChoices,
      featOptions: loaded.featOptions,
      characterFeats: loaded.characterFeats,
      classOptions: loaded.classOptions,
      subclassOptions: loaded.subclassOptions,
      classSlug: row.classSlug,
      level: row.level,
    });
    const featSlugs = loaded.characterFeats.map((feat) => feat.featSlug);
    const sizeCategory = resolveSizeCategory(
      speciesSize ?? undefined,
      sizeCategoryFromChoices(loaded.speciesChoices),
    );
    const fightingStyleSlugs = collectFightingStyleSlugsFromSubclassOptions(
      loaded.subclassOptions,
    );

    const [combat, spellcasting, thread] = await Promise.all([
      sheetProfile('combat', () =>
        resolveCharacterCombatSlice({
          characterId: row.id,
          abilityScores: effectiveAbilityScores,
          classSlug: row.classSlug,
          subclassSlug: row.subclassSlug,
          speciesSlug: row.speciesSlug,
          speciesChoices: loaded.speciesChoices,
          classOptions: loaded.classOptions,
          level: row.level,
          proficiencyBonus,
          featSlugs,
          fightingStyleSlugs,
          masteredWeaponSlugs: collectMasteredWeaponSlugs({
            classOptions: loaded.classOptions,
            featOptions: loaded.featOptions,
          }),
          sizeCategory,
          dataSource: this.dataSource,
          equippedArmorClass: this.equippedArmorClass,
          equippedWeaponAttacks: this.equippedWeaponAttacks,
          equipmentCompliance: this.equipmentCompliance,
          permanentItemEffects: this.permanentItemEffects,
        }),
      ),
      sheetProfile('spellcasting', () =>
        resolveCharacterSpellcastingSlice({
          dataSource: this.dataSource,
          subclassSpellsRepo: this.subclassSpellsRepo,
          grantedSpellCatalog: this.grantedSpellCatalog,
          sheet: loaded,
          speciesSlug: row.speciesSlug,
          subclassSlug: row.subclassSlug,
          level: row.level,
          classSlug: row.classSlug,
          proficiencyBonus,
          abilityModifiers: derived.abilityModifiers,
          featSlugs,
        }),
      ),
      sheetProfile('thread', () => this.loadCharacterThread.execute(row.id)),
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
    });
  }

  toSummaryDto(row: PlayerCharacter): CharacterSummaryResponseDto {
    return {
      id: row.id,
      name: row.name,
      level: row.level,
      classSlug: row.classSlug,
      className: row.classSlug,
      speciesSlug: row.speciesSlug,
      speciesName: row.speciesSlug,
      backgroundSlug: row.backgroundSlug,
      subclassSlug: row.subclassSlug,
      subclassName: row.subclassSlug,
      createdAt: row.createdAt.toISOString(),
      updatedAt: row.updatedAt.toISOString(),
      campaigns: [],
    };
  }

  toSummaryList(rows: PlayerCharacter[]): CharacterSummaryResponseDto[] {
    return rows.map((row) => this.toSummaryDto(row));
  }

  /** Prefere meta do P032; fallback para queries legadas se o bundle ainda não trouxer. */
  private async resolveSheetMeta(
    row: PlayerCharacter,
    loaded: CharacterSheetData,
  ): Promise<{
    proficiencyBonus: number;
    classBoosts: ClassAbilityBoostRow[];
    speciesSize: string | null;
  }> {
    if (loaded.proficiencyBonus != null) {
      return {
        proficiencyBonus: loaded.proficiencyBonus,
        classBoosts: loaded.classAbilityBoosts ?? [],
        speciesSize: loaded.speciesSize ?? null,
      };
    }

    const [proficiencyBonus, classBoosts] = await sheetProfile(
      'pb+boosts+species',
      () =>
        Promise.all([
          this.domain.getProficiencyBonus(row.level),
          loadClassAbilityBoosts(this.dataSource, row.classSlug),
        ]),
    );
    return {
      proficiencyBonus,
      classBoosts: loaded.classAbilityBoosts ?? classBoosts,
      speciesSize: loaded.speciesSize ?? null,
    };
  }
}
