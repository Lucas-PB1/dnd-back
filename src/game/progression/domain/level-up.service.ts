import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PhbCharacterLevel } from '@entities/phb-character-level.entity';
import { VSpellByClass } from '@entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { LevelUpPreviewDto } from '../dto/level-up.dto';
import { isAsiOrFeatLevel } from './asi-feat-levels';
import { classExpertiseSlotsNewAtLevel } from '@game/sheet/domain/validation/class-options/class-expertise-slots';
import { classWeaponMasterySlotsNewAtLevel } from '@game/sheet/domain/validation/class-options/class-weapon-mastery-slots';
import {
  loadClassWeaponMasteryProgression,
  loadMaxSpellLevelForCharacter,
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

    const newSpellOptions = await this.findNewSpellOptions(character, nextLevel);
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
      newSpellOptions,
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
    const options: LevelUpPreviewDto['newSpellOptions'] = [];

    const listSlug = spellListClassSlug ?? character.classSlug;
    const classSpells = await this.classSpellsRepo.find({
      where: { classSlug: listSlug },
      order: { spellLevel: 'ASC', spellName: 'ASC' },
    });

    for (const row of classSpells) {
      if (row.spellLevel <= maxSpellLevel) {
        options.push({
          spellSlug: row.spellSlug,
          spellName: row.spellName,
          spellLevel: row.spellLevel,
        });
      }
    }

    if (character.subclassSlug) {
      const subclassSpells = await this.subclassSpellsRepo.find({
        where: { subclassSlug: character.subclassSlug },
      });
      for (const row of subclassSpells) {
        if (row.unlockLevel <= nextLevel) {
          options.push({
            spellSlug: row.spellSlug,
            spellName: row.spellName,
            spellLevel: 0,
          });
        }
      }
    }

    const seen = new Set<string>();
    return options.filter((opt) => {
      if (seen.has(opt.spellSlug)) return false;
      seen.add(opt.spellSlug);
      return true;
    });
  }
}
