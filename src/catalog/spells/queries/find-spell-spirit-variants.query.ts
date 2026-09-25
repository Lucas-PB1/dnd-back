import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSpellSpiritVariant } from '@entities/spirit/phb-spell-spirit.entity';
import { SpellSpiritVariantsResponseDto } from '../dto/spell-spirit-variants-response.dto';

@Injectable()
export class FindSpellSpiritVariantsQuery {
  constructor(
    @InjectRepository(PhbSpellSpiritVariant)
    private readonly variants: Repository<PhbSpellSpiritVariant>,
  ) {}

  async execute(): Promise<SpellSpiritVariantsResponseDto[]> {
    const rows = await this.variants.find({
      order: { spellSlug: 'ASC', id: 'ASC' },
    });
    const bySpell = new Map<string, SpellSpiritVariantsResponseDto>();
    for (const row of rows) {
      const group = bySpell.get(row.spellSlug) ?? {
        spellSlug: row.spellSlug,
        variants: [],
      };
      group.variants.push({
        variantKey: row.variantKey,
        label: row.label,
        templateSlug: row.templateSlug,
        budgetCost: row.budgetCost ?? 1,
      });
      bySpell.set(row.spellSlug, group);
    }
    return [...bySpell.values()];
  }
}
