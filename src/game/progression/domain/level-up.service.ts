import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { PhbCharacterLevel } from '../../../entities/phb-character-level.entity';
import { VSpellByClass } from '../../../entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '../../../entities/views/v-phb-subclass-prepared-spell.entity';
import { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import { CharacterDomainService } from '../../sheet/domain/character-domain.service';
import { hpGainPerLevel } from '../../sheet/domain/hit-points.calc';
import { abilityModifier } from '../../sheet/domain/ability-modifier';
import { LevelUpPreviewDto } from '../dto/level-up.dto';

const ASI_FEAT_LEVELS = new Set([4, 8, 12, 16, 19]);

@Injectable()
export class LevelUpService {
  constructor(
    private readonly dataSource: DataSource,
    private readonly catalogLookup: CatalogLookupService,
    private readonly domain: CharacterDomainService,
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
    const phbClass = await this.catalogLookup.findClassOrFail(character.classSlug);
    const profile = this.domain.classHpProfile(phbClass);
    const conMod = abilityModifier(character.abilityScores.constituicao);
    const estimatedHpGain = hpGainPerLevel(profile.hpFixedPerLevel, conMod);
    const estimatedHitPointsMax = await this.domain.calculateHitPointsMaxForCharacter({
      level: nextLevel,
      classSlug: character.classSlug,
      abilityScores: character.abilityScores,
    });

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
    const maxSpellLevel = this.maxSpellLevelForCharacterLevel(nextLevel);
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

  /** Tabela simplificada PHB — full caster progression até nível 20. */
  private maxSpellLevelForCharacterLevel(level: number): number {
    if (level >= 17) return 9;
    if (level >= 15) return 8;
    if (level >= 13) return 7;
    if (level >= 11) return 6;
    if (level >= 9) return 5;
    if (level >= 7) return 4;
    if (level >= 5) return 3;
    if (level >= 3) return 2;
    if (level >= 1) return 1;
    return 0;
  }
}
