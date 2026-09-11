import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ClassProficienciesQuery } from '@catalog/game-port';
import { assertUnique } from '@common/assert';
import { PhbOptionDef } from '@entities/phb-option.entity';
import { PhbFeatRef } from '@entities/phb-feat-ref.entity';
import { PhbCharacterLevel } from '@entities/phb-character-level.entity';
import { FeatOptionDto, CharacterFeatDto } from '@game/sheet/dto/character-sheet.dto';
import { requiredAbilityScoreImprovementDefs } from './ability-score-improvement-feat-options';
import { CharacterFeatOptionValueValidator } from './character-feat-option-value.validator';
import {
  validateAbilityScoreImprovement,
  validateLinkedCastingAbilityMatchesAsi,
  validateMagicInitiateSpellLists,
  validateRitualCasterSpells,
} from './character-feat-option-rules';
import {
  requiredFeatOptionDefsForInstance,
  ritualSpellSlotIndex,
  RITUAL_CASTER_FEAT_SLUG,
} from './ritual-caster-feat-options';

import {
  loadClassFightingStyleSlugs,
  loadClassSavingThrowSlugs,
} from '@game/sheet/infrastructure/queries/feat-option.queries';

@Injectable()
export class CharacterFeatOptionsValidator {
  constructor(
    private readonly proficiencies: ClassProficienciesQuery,
    @InjectRepository(PhbFeatRef)
    private readonly featRefRepo: Repository<PhbFeatRef>,
    @InjectRepository(PhbOptionDef)
    private readonly featOptionDefRepo: Repository<PhbOptionDef>,
    @InjectRepository(PhbCharacterLevel)
    private readonly characterLevelsRepo: Repository<PhbCharacterLevel>,
    private readonly optionValueValidator: CharacterFeatOptionValueValidator,
  ) {}

  async validateFeatOptions(
    characterFeats: CharacterFeatDto[],
    options: FeatOptionDto[],
    characterLevel = 1,
    classSlug?: string,
  ): Promise<void> {
    const proficiencyBonus = await this.resolveProficiencyBonus(characterLevel);
    const classSavingThrowSlugs = classSlug
      ? await loadClassSavingThrowSlugs(this.proficiencies, classSlug)
      : [];
    const classFightingStyleSlugs = classSlug
      ? await loadClassFightingStyleSlugs(this.proficiencies, classSlug)
      : [];
    const keys = options.map(
      (o) => `${o.featSlug}:${o.instanceIndex ?? 0}:${o.optionKey}`,
    );
    assertUnique(keys, 'Duplicate feat option keys are not allowed');

    for (const option of options) {
      const match = characterFeats.find(
        (feat) =>
          feat.featSlug === option.featSlug &&
          feat.instanceIndex === (option.instanceIndex ?? 0),
      );
      if (!match) {
        throw new BadRequestException(
          `Feat option for '${option.featSlug}' instance ${option.instanceIndex ?? 0} but feat is not selected`,
        );
      }
    }

    for (const feat of characterFeats) {
      const defs = await this.loadFeatOptionDefs(feat.featSlug);
      if (defs.length === 0) continue;

      const featOptions = options.filter(
        (o) =>
          o.featSlug === feat.featSlug &&
          (o.instanceIndex ?? 0) === feat.instanceIndex,
      );
      const providedKeys = new Set(featOptions.map((o) => o.optionKey));
      const requiredDefs = requiredAbilityScoreImprovementDefs(
        feat.featSlug,
        requiredFeatOptionDefsForInstance(feat.featSlug, defs, proficiencyBonus),
        featOptions,
      );
      const missing = requiredDefs.filter((def) => !providedKeys.has(def.optionKey));
      if (missing.length > 0) {
        throw new BadRequestException(
          `Feat '${feat.featSlug}' instance ${feat.instanceIndex} requires options: ${missing.map((d) => d.optionKey).join(', ')}`,
        );
      }

      for (const option of featOptions) {
        const def = defs.find((d) => d.optionKey === option.optionKey);
        if (!def) {
          if (
            feat.featSlug === RITUAL_CASTER_FEAT_SLUG &&
            ritualSpellSlotIndex(option.optionKey) !== null
          ) {
            const slot = ritualSpellSlotIndex(option.optionKey)!;
            if (slot > proficiencyBonus) {
              throw new BadRequestException(
                `Feat 'ritual-caster' allows ${proficiencyBonus} ritual spell choice(s) at level ${characterLevel}`,
              );
            }
          }
          throw new BadRequestException(
            `Unknown feat option '${option.optionKey}' for '${feat.featSlug}'`,
          );
        }
        await this.optionValueValidator.validate(
          def,
          option,
          featOptions,
          feat.featSlug,
          classSavingThrowSlugs,
          classFightingStyleSlugs,
        );
      }
    }

    validateMagicInitiateSpellLists(characterFeats, options);
    validateRitualCasterSpells(characterFeats, options, proficiencyBonus);
    validateLinkedCastingAbilityMatchesAsi(characterFeats, options);
    validateAbilityScoreImprovement(characterFeats, options);
  }

  private async resolveProficiencyBonus(level: number): Promise<number> {
    const row = await this.characterLevelsRepo.findOne({ where: { level } });
    if (!row) {
      throw new BadRequestException(`Character level '${level}' not found in catalog`);
    }
    return row.proficiencyBonus;
  }

  private async loadFeatOptionDefs(featSlug: string): Promise<PhbOptionDef[]> {
    const feat = await this.featRefRepo.findOne({ where: { slug: featSlug } });
    if (!feat) return [];
    return this.featOptionDefRepo.find({
      where: { scope: 'feat' as const, ownerId: feat.id },
      order: { sortOrder: 'ASC', optionKey: 'ASC' },
    });
  }
}
