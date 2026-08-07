import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PhbOptionDef, PhbOptionValue } from '../../../../../entities/phb-option.entity';
import { VSpellByClass } from '../../../../../entities/views/v-spell-by-class.entity';
import { FeatOptionDto } from '../../../dto/character-sheet.dto';
import { validateFeatProficiencyOption } from './feat-option-proficiency';
import { RESILIENT_FEAT_SLUG } from './resilient-feat-options';

@Injectable()
export class CharacterFeatOptionValueValidator {
  constructor(
    private readonly dataSource: DataSource,
    @InjectRepository(VSpellByClass)
    private readonly classSpellsRepo: Repository<VSpellByClass>,
    @InjectRepository(PhbOptionValue)
    private readonly featOptionValueRepo: Repository<PhbOptionValue>,
  ) {}

  async validate(
    def: PhbOptionDef,
    option: FeatOptionDto,
    featOptions: FeatOptionDto[],
    featSlug: string,
    classSavingThrowSlugs: string[],
    classFightingStyleSlugs: string[],
  ): Promise<void> {
    if (def.valueType === 'fighting_style') {
      await this.validateFightingStyle(def, option, classFightingStyleSlugs);
      return;
    }
    if (def.valueType === 'catalog') {
      await this.assertCatalogValue(def, option);
      return;
    }
    if (def.valueType === 'ability') {
      await this.validateAbility(def, option, featSlug, classSavingThrowSlugs);
      return;
    }
    if (def.valueType === 'spell') {
      await this.validateSpell(def, option, featOptions);
      return;
    }
    if (def.valueType === 'proficiency') {
      await validateFeatProficiencyOption(
        this.dataSource,
        this.featOptionValueRepo,
        def,
        option,
        featOptions,
      );
    }
  }

  private async validateFightingStyle(
    def: PhbOptionDef,
    option: FeatOptionDto,
    classFightingStyleSlugs: string[],
  ): Promise<void> {
    if (!classFightingStyleSlugs.includes(option.valueId)) {
      throw new BadRequestException(
        `Feat option '${def.optionKey}/${option.valueId}' is not a valid fighting style for this class`,
      );
    }
    const exists = await this.dataSource.query<{ ok: number }[]>(
      `SELECT 1 AS ok FROM rpg.phb_fighting_style WHERE slug = $1 LIMIT 1`,
      [option.valueId],
    );
    if (exists.length === 0) {
      throw new BadRequestException(
        `Feat option '${def.optionKey}/${option.valueId}' is invalid`,
      );
    }
  }

  private async assertCatalogValue(
    def: PhbOptionDef,
    option: FeatOptionDto,
  ): Promise<void> {
    const valid = await this.featOptionValueRepo.findOne({
      where: {
        scope: 'feat' as const,
        ownerId: def.ownerId,
        optionKey: def.optionKey,
        valueId: option.valueId,
      },
    });
    if (!valid) {
      throw new BadRequestException(
        `Feat option '${def.optionKey}/${option.valueId}' is invalid`,
      );
    }
  }

  private async validateAbility(
    def: PhbOptionDef,
    option: FeatOptionDto,
    featSlug: string,
    classSavingThrowSlugs: string[],
  ): Promise<void> {
    await this.assertCatalogValue(def, option);
    if (
      featSlug === RESILIENT_FEAT_SLUG &&
      def.optionKey === 'abilityIncrease' &&
      classSavingThrowSlugs.includes(option.valueId)
    ) {
      throw new BadRequestException(
        'Resilient must choose an ability without save proficiency from your class',
      );
    }
  }

  private async validateSpell(
    def: PhbOptionDef,
    option: FeatOptionDto,
    featOptions: FeatOptionDto[],
  ): Promise<void> {
    if (def.spellRitualOnly) {
      const ritualRows = await this.dataSource.query<{ ok: number }[]>(
        `SELECT 1 AS ok
         FROM rpg.phb_spell s
         WHERE s.slug = $1
           AND s.level = $2
           AND s.ritual = TRUE
         LIMIT 1`,
        [option.valueId, def.spellMaxLevel ?? 1],
      );
      if (ritualRows.length === 0) {
        throw new BadRequestException(
          `Spell '${option.valueId}' must be a level ${def.spellMaxLevel ?? 1} ritual for '${def.optionKey}'`,
        );
      }
      return;
    }

    if (def.spellSchoolSlugs?.length) {
      const schoolRows = await this.dataSource.query<{ ok: number }[]>(
        `SELECT 1 AS ok
         FROM rpg.phb_spell s
         JOIN rpg.phb_spell_school sch ON sch.id = s.school_id
         WHERE s.slug = $1
           AND s.level = $2
           AND sch.slug = ANY($3::text[])
         LIMIT 1`,
        [option.valueId, def.spellMaxLevel ?? 1, def.spellSchoolSlugs],
      );
      if (schoolRows.length === 0) {
        throw new BadRequestException(
          `Spell '${option.valueId}' is not a valid choice for '${def.optionKey}'`,
        );
      }
      return;
    }

    const spellList = featOptions.find((o) => o.optionKey === def.dependsOnOptionKey)?.valueId;
    if (!spellList) {
      throw new BadRequestException(
        `Feat option '${def.optionKey}' requires '${def.dependsOnOptionKey}' first`,
      );
    }
    const spell = await this.classSpellsRepo.findOne({
      where: { classSlug: spellList, spellSlug: option.valueId },
    });
    if (!spell) {
      throw new BadRequestException(
        `Spell '${option.valueId}' is not on the '${spellList}' list`,
      );
    }
    if (def.spellMaxLevel !== null && spell.spellLevel !== def.spellMaxLevel) {
      throw new BadRequestException(
        `Spell '${option.valueId}' must be level ${def.spellMaxLevel} for '${def.optionKey}'`,
      );
    }
    if (def.optionKey === 'cantrip2') {
      const first = featOptions.find((o) => o.optionKey === 'cantrip1')?.valueId;
      if (first && first === option.valueId) {
        throw new BadRequestException('Cantrip choices must be different');
      }
    }
  }
}
