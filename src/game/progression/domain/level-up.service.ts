import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { PhbCharacterLevel } from '../../../entities/phb-character-level.entity';
import { VSpellByClass } from '../../../entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '../../../entities/views/v-phb-subclass-prepared-spell.entity';
import { VClassSpellSlots } from '../../../entities/views/v-class-spell-slots.entity';
import { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import { CharacterDomainService } from '../../sheet/domain/character-domain.service';
import { maxSpellLevelFromSlots } from '../../sheet/domain/max-spell-level';
import { CharacterSheetRepository } from '../../sheet/infrastructure/character-sheet.repository';
import { LevelUpPreviewDto } from '../dto/level-up.dto';

const ASI_FEAT_LEVELS = new Set([4, 8, 12, 16, 19]);

@Injectable()
export class LevelUpService {
  constructor(
    private readonly dataSource: DataSource,
    private readonly catalogLookup: CatalogLookupService,
    private readonly domain: CharacterDomainService,
    private readonly sheetRepository: CharacterSheetRepository,
    @InjectRepository(PhbCharacterLevel)
    private readonly levelsRepo: Repository<PhbCharacterLevel>,
    @InjectRepository(VSpellByClass)
    private readonly classSpellsRepo: Repository<VSpellByClass>,
    @InjectRepository(VPhbSubclassPreparedSpell)
    private readonly subclassSpellsRepo: Repository<VPhbSubclassPreparedSpell>,
    @InjectRepository(VClassSpellSlots)
    private readonly spellSlotsRepo: Repository<VClassSpellSlots>,
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

    const subclassUnlockLevel = await this.resolveSubclassUnlockLevel(character.classSlug);
    const subclassRequired = nextLevel >= subclassUnlockLevel && !character.subclassSlug;

    const newSpellOptions = await this.findNewSpellOptions(character, nextLevel);

    return {
      currentLevel: character.level,
      nextLevel,
      currentProficiencyBonus: currentPbRow?.proficiencyBonus ?? 2,
      nextProficiencyBonus: nextPbRow?.proficiencyBonus ?? 2,
      estimatedHpGain,
      estimatedHitPointsMax,
      subclassRequired,
      subclassUnlockLevel,
      isAsiOrFeatLevel: ASI_FEAT_LEVELS.has(nextLevel),
      newSpellOptions,
    };
  }

  private async resolveSubclassUnlockLevel(classSlug: string): Promise<number> {
    const rows = await this.dataSource.query<{ subclass_unlock_level: number }[]>(
      `SELECT subclass_unlock_level FROM rpg.phb_class WHERE slug = $1`,
      [classSlug],
    );
    return rows[0]?.subclass_unlock_level ?? 3;
  }

  private async findNewSpellOptions(
    character: PlayerCharacter,
    nextLevel: number,
  ): Promise<LevelUpPreviewDto['newSpellOptions']> {
    const maxSpellLevel = await this.maxSpellLevelForClass(
      character.classSlug,
      nextLevel,
    );
    const options: LevelUpPreviewDto['newSpellOptions'] = [];

    const classSpells = await this.classSpellsRepo.find({
      where: { classSlug: character.classSlug },
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

  /** Círculo máximo com slot > 0 na tabela da classe (full / half / pact). */
  private async maxSpellLevelForClass(
    classSlug: string,
    level: number,
  ): Promise<number> {
    const row = await this.spellSlotsRepo.findOne({
      where: { classSlug, classLevel: level },
    });
    return maxSpellLevelFromSlots(row?.spellSlots);
  }
}
