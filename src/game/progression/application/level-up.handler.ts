import { BadRequestException, Injectable } from '@nestjs/common';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { UpdateCharacterHandler } from '@game/sheet/application/update-character.handler';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { classExpertiseSlotsNewAtLevel } from '@game/sheet/domain/validation/class-options/class-expertise-slots';
import { classWeaponMasterySlotsNewAtLevel } from '@game/sheet/domain/validation/class-options/class-weapon-mastery-slots';
import { LevelUpDto } from '../dto/level-up.dto';
import { CharacterResponseDto } from '@game/sheet/dto/character-response.dto';
import { UpdateCharacterDto } from '@game/sheet/dto/update-character.dto';
import { DataSource } from 'typeorm';
import { isAsiOrFeatLevel } from '../domain/asi-feat-levels';
import {
  applyLevelUpAsiBoost,
  resolveLevelUpAsiFromDto,
} from '../domain/level-up-asi';

@Injectable()
export class LevelUpHandler {
  constructor(
    private readonly repository: CharacterRepository,
    private readonly updateCharacter: UpdateCharacterHandler,
    private readonly characterState: CharacterStateRepository,
    private readonly sheetRepository: CharacterSheetRepository,
    private readonly dataSource: DataSource,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: LevelUpDto,
  ): Promise<CharacterResponseDto> {
    const character = await this.repository.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );

    if (character.level >= 20) {
      throw new BadRequestException('Character is already at maximum level');
    }

    const previousLevel = character.level;
    const nextLevel = previousLevel + 1;

    const masteryProgression = await this.dataSource.query<
      { level: number; weaponMastery: number | null }[]
    >(
      `SELECT cp.level, cp.weapon_mastery AS "weaponMastery"
       FROM rpg.phb_class_progression cp
       JOIN rpg.phb_class c ON c.id = cp.class_id
       WHERE c.slug = $1
       ORDER BY cp.level`,
      [character.classSlug],
    );
    const newExpertiseSlots = classExpertiseSlotsNewAtLevel(
      character.classSlug,
      nextLevel,
    );
    const newMasterySlots = classWeaponMasterySlotsNewAtLevel(
      masteryProgression,
      nextLevel,
    );

    let classOptions = dto.classOptions;
    if (newExpertiseSlots.length > 0 || newMasterySlots.length > 0) {
      const sheet = await this.sheetRepository.load(character.id);
      const merged = classOptions ?? sheet.classOptions;
      const missingExpertise = newExpertiseSlots.filter(
        (slot) =>
          !merged.some(
            (option) => option.optionKey === slot.optionKey && option.valueId,
          ),
      );
      if (missingExpertise.length > 0) {
        throw new BadRequestException(
          `Level ${nextLevel} unlocks expertise choices: ${missingExpertise.map((slot) => slot.optionKey).join(', ')}`,
        );
      }
      const missingMastery = newMasterySlots.filter(
        (slot) =>
          !merged.some(
            (option) => option.optionKey === slot.optionKey && option.valueId,
          ),
      );
      if (missingMastery.length > 0) {
        throw new BadRequestException(
          `Level ${nextLevel} unlocks weapon mastery choices: ${missingMastery.map((slot) => slot.optionKey).join(', ')}`,
        );
      }
      classOptions = merged;
    }

    const asiInput = resolveLevelUpAsiFromDto(dto);
    if (asiInput && !isAsiOrFeatLevel(character.classSlug, nextLevel)) {
      throw new BadRequestException(
        `Level ${nextLevel} is not an ASI/feat level for class '${character.classSlug}'`,
      );
    }

    const patch: UpdateCharacterDto = {
      level: nextLevel,
      subclassSlug: dto.subclassSlug,
      classSkillSlugs: dto.classSkillSlugs,
      speciesChoices: dto.speciesChoices,
      subclassOptions: dto.subclassOptions,
      classOptions,
      characterFeats: dto.characterFeats,
      featOptions: dto.featOptions,
      characterSpells: dto.characterSpells,
      equipment: dto.equipment,
      languageSlugs: dto.languageSlugs,
      abilityGenerationMethodSlug: dto.abilityGenerationMethodSlug,
    };
    if (asiInput) {
      patch.abilityScores = applyLevelUpAsiBoost(character.abilityScores, asiInput);
    }

    const updated = await this.updateCharacter.execute(userId, characterId, patch);
    await this.characterState.syncHitDiceOnLevelChange(
      characterId,
      previousLevel,
      nextLevel,
    );
    return updated;
  }
}
