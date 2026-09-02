import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PhbOptionDef, PhbOptionValue } from '@entities/phb-option.entity';
import { PhbSubclassRef } from '@entities/phb-subclass-ref.entity';
import { SubclassOptionDto } from '@game/sheet/dto/character-sheet.dto';
import {
  BLADE_HOLY_CANTRIP_KEYS,
  BLOOD_STRIKE_OPTION_KEY_RE,
  LORE_BONUS_SKILL_KEYS,
  LORE_MAGICAL_DISCOVERY_KEYS,
  WIZARD_VERSATILITY_OPTION_KEYS,
} from './subclass-option-effects';
import {
  SANGROMANCY_SAVANT_OPTION_KEYS,
  SANGROMANCY_SCHOOL_FILTER_SLUG,
  isSangromancySavantOptionKey,
} from '@game/spellcasting/domain/sangromancy/sangromancy-spells';
import { loadClassSkillChoiceSlugs, skillExists } from '@game/sheet/infrastructure/queries/skill-catalog.queries';
import {
  sangromancySpellMatches,
  spellOnAnyClassListUpToLevel,
  spellOnClassList,
  wizardSchoolSpellMatches,
} from '@game/sheet/infrastructure/queries/spell-catalog.queries';
import { MAGICAL_SECRETS_LIST_SLUGS } from '@game/sheet/domain/validation/spells/magical-secrets';

@Injectable()
export class CharacterSubclassOptionValueValidator {
  constructor(
    private readonly dataSource: DataSource,
    @InjectRepository(PhbSubclassRef)
    private readonly subclassRefRepo: Repository<PhbSubclassRef>,
    @InjectRepository(PhbOptionDef)
    private readonly optionDefRepo: Repository<PhbOptionDef>,
    @InjectRepository(PhbOptionValue)
    private readonly optionValuesRepo: Repository<PhbOptionValue>,
  ) {}

  async validate(
    subclassSlug: string,
    classSlug: string,
    level: number,
    options: SubclassOptionDto[],
  ): Promise<void> {
    const subclass = await this.subclassRefRepo.findOne({
      where: { slug: subclassSlug },
    });
    if (!subclass) return;

    const defs = await this.optionDefRepo.find({
      where: { scope: 'subclass', ownerId: subclass.id },
    });
    const defByKey = new Map(defs.map((def) => [def.optionKey, def]));

    for (const option of options) {
      const def = defByKey.get(option.optionKey);
      if (!def) continue;
      if ((def.unlockLevel ?? 1) > level) continue;

      if (def.valueType === 'catalog' || def.valueType === 'terrain') {
        await this.assertCatalogValue(subclass.id, option);
        if (BLOOD_STRIKE_OPTION_KEY_RE.test(def.optionKey)) {
          this.assertDistinctBloodStrikes(options);
        }
        continue;
      }
      if (def.valueType === 'skill_list') {
        await this.validateSkillList(def, option, classSlug, options);
        continue;
      }
      if (def.valueType === 'spell') {
        await this.validateSpell(def, option, level, options);
      }
    }
  }

  private async assertCatalogValue(
    ownerId: string,
    option: SubclassOptionDto,
  ): Promise<void> {
    const valid = await this.optionValuesRepo.findOne({
      where: {
        scope: 'subclass',
        ownerId,
        optionKey: option.optionKey,
        valueId: option.valueId,
      },
    });
    if (!valid) {
      throw new BadRequestException(
        `Subclass option '${option.optionKey}/${option.valueId}' is invalid`,
      );
    }
  }

  private async validateSkillList(
    def: PhbOptionDef,
    option: SubclassOptionDto,
    classSlug: string,
    options: SubclassOptionDto[],
  ): Promise<void> {
    if (!(await skillExists(this.dataSource, option.valueId))) {
      throw new BadRequestException(
        `Skill '${option.valueId}' is invalid for '${def.optionKey}'`,
      );
    }

    if (def.optionKey === 'warScholarSkill') {
      const pool = await loadClassSkillChoiceSlugs(this.dataSource, classSlug);
      if (!pool.includes(option.valueId)) {
        throw new BadRequestException(
          `Skill '${option.valueId}' is not in the fighter skill list for warScholarSkill`,
        );
      }
    }

    if (LORE_BONUS_SKILL_KEYS.has(def.optionKey)) {
      const siblings = options.filter((entry) =>
        LORE_BONUS_SKILL_KEYS.has(entry.optionKey),
      );
      const duplicates = siblings.filter(
        (entry) => entry.valueId === option.valueId,
      );
      if (duplicates.length > 1) {
        throw new BadRequestException(
          'Colégio do Saber bonus skills must be different',
        );
      }
    }
  }

  private async validateSpell(
    def: PhbOptionDef,
    option: SubclassOptionDto,
    level: number,
    options: SubclassOptionDto[],
  ): Promise<void> {
    if (LORE_MAGICAL_DISCOVERY_KEYS.has(def.optionKey)) {
      await this.validateLoreMagicalDiscovery(option, level);
      this.assertDistinctPair(options, [...LORE_MAGICAL_DISCOVERY_KEYS]);
      return;
    }

    if (BLADE_HOLY_CANTRIP_KEYS.has(def.optionKey)) {
      await this.validateClericCantrip(option);
      this.assertDistinctPair(options, [...BLADE_HOLY_CANTRIP_KEYS]);
      return;
    }

    if (WIZARD_VERSATILITY_OPTION_KEYS.has(def.optionKey)) {
      await this.validateWizardVersatility(def, option);
      const prefix = def.optionKey.replace(/\d+$/, '');
      this.assertDistinctPair(
        options,
        [`${prefix}1`, `${prefix}2`],
      );
      return;
    }

    if (isSangromancySavantOptionKey(def.optionKey)) {
      await this.validateSangromancySavant(def, option);
      this.assertDistinctAcrossKeys(options, [...SANGROMANCY_SAVANT_OPTION_KEYS]);
    }
  }

  private assertDistinctBloodStrikes(options: SubclassOptionDto[]): void {
    const values = options
      .filter((entry) => BLOOD_STRIKE_OPTION_KEY_RE.test(entry.optionKey))
      .map((entry) => entry.valueId)
      .filter(Boolean);
    if (new Set(values).size !== values.length) {
      throw new BadRequestException(
        'Golpes de Sangue devem ser diferentes entre si',
      );
    }
  }

  private assertDistinctPair(
    options: SubclassOptionDto[],
    keys: readonly string[],
  ): void {
    this.assertDistinctAcrossKeys(options, keys);
  }

  private assertDistinctAcrossKeys(
    options: SubclassOptionDto[],
    keys: readonly string[],
  ): void {
    const values = options
      .filter((entry) => keys.includes(entry.optionKey))
      .map((entry) => entry.valueId)
      .filter(Boolean);
    if (new Set(values).size !== values.length) {
      throw new BadRequestException(
        'Subclass spell choices must be different',
      );
    }
  }

  private async validateClericCantrip(
    option: SubclassOptionDto,
  ): Promise<void> {
    const valid = await spellOnClassList(this.dataSource, {
      classSlug: 'cleric',
      spellSlug: option.valueId,
      spellLevel: 0,
    });
    if (!valid) {
      throw new BadRequestException(
        `Spell '${option.valueId}' is not a Cleric cantrip`,
      );
    }
  }

  private async validateLoreMagicalDiscovery(
    option: SubclassOptionDto,
    level: number,
  ): Promise<void> {
    const maxLevel = Math.min(3, Math.ceil(level / 2));
    const valid = await spellOnAnyClassListUpToLevel(
      this.dataSource,
      MAGICAL_SECRETS_LIST_SLUGS,
      option.valueId,
      maxLevel,
    );
    if (!valid) {
      throw new BadRequestException(
        `Spell '${option.valueId}' is not a valid Lore magical discovery`,
      );
    }
  }

  private async validateSangromancySavant(
    def: PhbOptionDef,
    option: SubclassOptionDto,
  ): Promise<void> {
    const maxLevel = def.spellMaxLevel ?? 2;
    const schoolSlugs = def.spellSchoolSlugs ?? [];
    if (!schoolSlugs.includes(SANGROMANCY_SCHOOL_FILTER_SLUG)) {
      throw new BadRequestException(
        `Subclass option '${def.optionKey}' is misconfigured for Sangromancy`,
      );
    }

    if (!(await sangromancySpellMatches(this.dataSource, option.valueId, maxLevel))) {
      throw new BadRequestException(
        `Spell '${option.valueId}' is not a valid Sangromancy choice for '${def.optionKey}'`,
      );
    }
  }

  private async validateWizardVersatility(
    def: PhbOptionDef,
    option: SubclassOptionDto,
  ): Promise<void> {
    const maxLevel = def.spellMaxLevel ?? 2;
    const schoolSlugs = def.spellSchoolSlugs ?? [];
    if (
      !(await wizardSchoolSpellMatches(
        this.dataSource,
        option.valueId,
        maxLevel,
        schoolSlugs,
      ))
    ) {
      throw new BadRequestException(
        `Spell '${option.valueId}' is not a valid wizard school choice for '${def.optionKey}'`,
      );
    }
  }
}
