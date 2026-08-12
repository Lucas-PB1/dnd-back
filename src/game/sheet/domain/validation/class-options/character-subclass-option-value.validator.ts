import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PhbOptionDef, PhbOptionValue } from '@entities/phb-option.entity';
import { PhbSubclassRef } from '@entities/phb-subclass-ref.entity';
import { VSpellByClass } from '@entities/views/v-spell-by-class.entity';
import { SubclassOptionDto } from '@game/sheet/dto/character-sheet.dto';
import {
  LORE_BONUS_SKILL_KEYS,
  LORE_MAGICAL_DISCOVERY_KEYS,
  WIZARD_VERSATILITY_OPTION_KEYS,
} from './subclass-option-effects';

const LORE_SPELL_LIST_CLASS_SLUGS = ['cleric', 'druid', 'wizard'] as const;

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
    @InjectRepository(VSpellByClass)
    private readonly classSpellsRepo: Repository<VSpellByClass>,
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
    const skillRows = await this.dataSource.query<{ ok: number }[]>(
      `SELECT 1 AS ok FROM rpg.phb_skill WHERE slug = $1 LIMIT 1`,
      [option.valueId],
    );
    if (skillRows.length === 0) {
      throw new BadRequestException(
        `Skill '${option.valueId}' is invalid for '${def.optionKey}'`,
      );
    }

    if (def.optionKey === 'warScholarSkill') {
      const poolRows = await this.dataSource.query<{ slug: string }[]>(
        `SELECT skill_slug AS slug
         FROM rpg.v_phb_class_skill_choice
         WHERE class_slug = $1`,
        [classSlug],
      );
      if (!poolRows.some((row) => row.slug === option.valueId)) {
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

    if (WIZARD_VERSATILITY_OPTION_KEYS.has(def.optionKey)) {
      await this.validateWizardVersatility(def, option);
      const prefix = def.optionKey.replace(/\d+$/, '');
      this.assertDistinctPair(
        options,
        [`${prefix}1`, `${prefix}2`],
      );
    }
  }

  private assertDistinctPair(
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

  private async validateLoreMagicalDiscovery(
    option: SubclassOptionDto,
    level: number,
  ): Promise<void> {
    const maxLevel = Math.min(3, Math.ceil(level / 2));
    const rows = await this.dataSource.query<{ ok: number }[]>(
      `SELECT 1 AS ok
       FROM rpg.v_spell_by_class v
       WHERE v.class_slug = ANY($1::text[])
         AND v.spell_slug = $2
         AND v.spell_level <= $3
       LIMIT 1`,
      [LORE_SPELL_LIST_CLASS_SLUGS, option.valueId, maxLevel],
    );
    if (rows.length === 0) {
      throw new BadRequestException(
        `Spell '${option.valueId}' is not a valid Lore magical discovery`,
      );
    }
  }

  private async validateWizardVersatility(
    def: PhbOptionDef,
    option: SubclassOptionDto,
  ): Promise<void> {
    const maxLevel = def.spellMaxLevel ?? 2;
    const schoolSlugs = def.spellSchoolSlugs ?? [];
    const rows = await this.dataSource.query<{ ok: number }[]>(
      `SELECT 1 AS ok
       FROM rpg.phb_spell s
       JOIN rpg.phb_spell_school sch ON sch.id = s.school_id
       JOIN rpg.v_spell_by_class v ON v.spell_slug = s.slug AND v.class_slug = 'wizard'
       WHERE s.slug = $1
         AND s.level BETWEEN 1 AND $2
         AND sch.slug = ANY($3::text[])
       LIMIT 1`,
      [option.valueId, maxLevel, schoolSlugs],
    );
    if (rows.length === 0) {
      throw new BadRequestException(
        `Spell '${option.valueId}' is not a valid wizard school choice for '${def.optionKey}'`,
      );
    }
  }
}
