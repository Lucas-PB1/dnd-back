import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PhbOptionDef, PhbOptionValue } from '@entities/reference/phb-option.entity';
import { PhbSubclassRef } from '@entities/subclass-feature/phb-subclass-ref.entity';
import { SubclassOptionDto } from '@game/sheet/dto/character-sheet.dto';
import { BLOOD_STRIKE_OPTION_KEY_RE } from '../subclass-option-effects';
import { assertDistinctBloodStrikes } from './assert-distinct-choices';
import { validateSubclassOptionSkillList } from './validate-skill-list';
import { validateSubclassOptionSpell } from './validate-spell-choices';

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
          assertDistinctBloodStrikes(options);
        }
        continue;
      }
      if (def.valueType === 'skill_list') {
        await validateSubclassOptionSkillList(
          this.dataSource,
          def,
          option,
          classSlug,
          options,
        );
        continue;
      }
      if (def.valueType === 'spell') {
        await validateSubclassOptionSpell(
          this.dataSource,
          def,
          option,
          level,
          options,
        );
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
}
