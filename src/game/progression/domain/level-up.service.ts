import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PhbCharacterLevel } from '@entities/phb-character-level.entity';
import { PhbSubclassRef } from '@entities/phb-subclass-ref.entity';
import { VSpellByClass } from '@entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { loadSubclassOptionSlotsNewAtLevel } from '@game/sheet/infrastructure/queries/class-option.queries';
import { LevelUpPreviewDto } from '../dto/level-up.dto';
import { isAsiOrFeatLevel } from './asi-feat-levels';
import { classExpertiseSlotsNewAtLevel } from '@game/sheet/domain/validation/class-options/class-expertise-slots';
import { classWeaponMasterySlotsNewAtLevel } from '@game/sheet/domain/validation/class-options/class-weapon-mastery-slots';
import {
  loadClassFeaturesAtLevel,
  loadClassWeaponMasteryProgression,
  loadMaxSpellLevelForCharacter,
  loadSubclassFeaturesAtLevel,
  loadSubclassSpellListClassSlug,
  loadSubclassUnlockLevel,
} from '../infrastructure/queries/level-up-catalog.queries';

@Injectable()
export class LevelUpService {
  constructor(
    private readonly dataSource: DataSource,
    private readonly domain: CharacterDomainService,
    private readonly sheetRepository: CharacterSheetRepository,
    @InjectRepository(PhbCharacterLevel)
    private readonly levelsRepo: Repository<PhbCharacterLevel>,
    @InjectRepository(VSpellByClass)
    private readonly classSpellsRepo: Repository<VSpellByClass>,
    @InjectRepository(VPhbSubclassPreparedSpell)
    private readonly subclassSpellsRepo: Repository<VPhbSubclassPreparedSpell>,
  ) {}

  async buildPreview(character: PlayerCharacter): Promise<LevelUpPreviewDto> {
    if (character.level >= 20) {
      throw new BadRequestException('Character is already at maximum level');
    }

    const nextLevel = character.level + 1;
    const sheet = await this.sheetRepository.load(character.id);
    const hitPointsSources = {
      speciesSlug: character.speciesSlug,
      subclassSlug: character.subclassSlug,
      featSlugs: sheet.characterFeats.map((feat) => feat.featSlug),
    };
    const [currentHitPointsMax, estimatedHitPointsMax] = await Promise.all(
      [character.level, nextLevel].map((level) =>
        this.domain.calculateHitPointsMaxForCharacter({
          level,
          classSlug: character.classSlug,
          abilityScores: character.abilityScores,
          hitPointsSources,
        }),
      ),
    );
    const estimatedHpGain = estimatedHitPointsMax - currentHitPointsMax;

    const [currentPbRow, nextPbRow] = await Promise.all([
      this.levelsRepo.findOne({ where: { level: character.level } }),
      this.levelsRepo.findOne({ where: { level: nextLevel } }),
    ]);

    const subclassUnlockLevel = await loadSubclassUnlockLevel(
      this.dataSource,
      character.classSlug,
    );
    const subclassRequired =
      nextLevel >= subclassUnlockLevel && !character.subclassSlug;

    const [
      newSpellOptions,
      newAlwaysPreparedSpells,
      newSubclassOptionSlots,
      classFeatures,
      subclassFeatures,
    ] = await Promise.all([
      this.findNewSpellOptions(character, nextLevel),
      this.findAlwaysPreparedSpellsNewAtLevel(character, nextLevel),
      this.findNewSubclassOptionSlots(character, nextLevel),
      loadClassFeaturesAtLevel(
        this.dataSource,
        character.classSlug,
        nextLevel,
      ),
      loadSubclassFeaturesAtLevel(
        this.dataSource,
        character.subclassSlug,
        nextLevel,
      ),
    ]);
    const masteryProgression = await loadClassWeaponMasteryProgression(
      this.dataSource,
      character.classSlug,
    );

    return {
      currentLevel: character.level,
      nextLevel,
      currentProficiencyBonus: currentPbRow?.proficiencyBonus ?? 2,
      nextProficiencyBonus: nextPbRow?.proficiencyBonus ?? 2,
      estimatedHpGain,
      estimatedHitPointsMax,
      subclassRequired,
      subclassUnlockLevel,
      isAsiOrFeatLevel: isAsiOrFeatLevel(character.classSlug, nextLevel),
      newFeatures: [...classFeatures, ...subclassFeatures],
      newSpellOptions,
      newAlwaysPreparedSpells,
      newSubclassOptionSlots,
      newClassExpertiseSlots: classExpertiseSlotsNewAtLevel(
        character.classSlug,
        nextLevel,
      ),
      newWeaponMasterySlots: classWeaponMasterySlotsNewAtLevel(
        masteryProgression,
        nextLevel,
      ),
    };
  }

  /**
   * Lista de magias para conjuradores reais (slots de classe/subclasse).
   * Não inclui always-prepared de subclasse sem spellcasting (ex.: Lâmina do Esplendor).
   */
  private async findNewSpellOptions(
    character: PlayerCharacter,
    nextLevel: number,
  ): Promise<LevelUpPreviewDto['newSpellOptions']> {
    const spellListClassSlug = await loadSubclassSpellListClassSlug(
      this.dataSource,
      character.subclassSlug,
    );
    const maxSpellLevel = await loadMaxSpellLevelForCharacter(
      this.dataSource,
      character.classSlug,
      nextLevel,
      character.subclassSlug,
    );
    if (maxSpellLevel <= 0 && !spellListClassSlug) {
      return [];
    }

    const listSlug = spellListClassSlug ?? character.classSlug;
    const classSpells = await this.classSpellsRepo.find({
      where: { classSlug: listSlug },
      order: { spellLevel: 'ASC', spellName: 'ASC' },
    });

    const options: LevelUpPreviewDto['newSpellOptions'] = [];
    for (const row of classSpells) {
      if (row.spellLevel <= maxSpellLevel) {
        options.push({
          spellSlug: row.spellSlug,
          spellName: row.spellName,
          spellLevel: row.spellLevel,
        });
      }
    }

    const seen = new Set<string>();
    return options.filter((opt) => {
      if (seen.has(opt.spellSlug)) return false;
      seen.add(opt.spellSlug);
      return true;
    });
  }

  /** Magias always-prepared que desbloqueiam exatamente neste nível. */
  private async findAlwaysPreparedSpellsNewAtLevel(
    character: PlayerCharacter,
    nextLevel: number,
  ): Promise<LevelUpPreviewDto['newAlwaysPreparedSpells']> {
    if (!character.subclassSlug) return [];

    const subclassSpells = await this.subclassSpellsRepo.find({
      where: { subclassSlug: character.subclassSlug },
    });
    return subclassSpells
      .filter((row) => row.unlockLevel === nextLevel)
      .map((row) => ({
        spellSlug: row.spellSlug,
        spellName: row.spellName,
        spellLevel: 0,
      }));
  }

  private async findNewSubclassOptionSlots(
    character: PlayerCharacter,
    nextLevel: number,
  ): Promise<LevelUpPreviewDto['newSubclassOptionSlots']> {
    if (!character.subclassSlug) return [];

    const subclass = await this.dataSource
      .getRepository(PhbSubclassRef)
      .findOne({ where: { slug: character.subclassSlug }, select: ['id'] });
    if (!subclass) return [];

    const slots = await loadSubclassOptionSlotsNewAtLevel(
      this.dataSource,
      subclass.id,
      nextLevel,
    );
    return slots.map((slot) => ({
      optionKey: slot.optionKey,
      label: slot.label,
      unlockLevel: slot.unlockLevel,
    }));
  }
}
