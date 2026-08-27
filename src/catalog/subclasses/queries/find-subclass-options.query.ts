import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbOptionValue } from '@entities/phb-option.entity';
import { PhbSubclassRef } from '@entities/phb-subclass-ref.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import { SubclassOptionResponseDto } from '../dto/subclass-option-response.dto';

const STATIC_VALUE_TYPES = new Set([
  'catalog',
  'terrain',
  'fighting_style',
]);

@Injectable()
export class FindSubclassOptionsQuery {
  constructor(
    @InjectRepository(PhbSubclassRef)
    private readonly subclassRepo: Repository<PhbSubclassRef>,
    @InjectRepository(PhbOptionValue)
    private readonly optionValuesRepo: Repository<PhbOptionValue>,
    private readonly catalogLookup: CatalogLookupService,
  ) {}

  async execute(
    subclassSlug: string,
    characterLevel = 20,
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<SubclassOptionResponseDto>> {
    await this.catalogLookup.findSubclassOrFail(subclassSlug);

    const subclass = await this.subclassRepo.findOne({ where: { slug: subclassSlug } });
    if (!subclass) {
      throw new NotFoundException(`Subclass '${subclassSlug}' not found`);
    }

    const [defs, valueRows] = await Promise.all([
      this.loadOptionDefs(subclass.id, characterLevel),
      this.loadOptionValues(subclass.id, characterLevel),
    ]);
    const grouped = this.groupOptions(defs, valueRows);
    return paginateByKeys(grouped, {
      cursor,
      limit,
      keyNames: ['optionKey'],
      encodeRow: (row) => ({ optionKey: row.optionKey }),
    });
  }

  private loadOptionDefs(subclassId: string, characterLevel: number) {
    return this.optionValuesRepo.manager.query<
      {
        optionKey: string;
        optionLabel: string;
        unlockLevel: number;
        valueType: string;
        spellMaxLevel: number | null;
        spellSchoolSlugs: string[] | null;
        sortOrder: number;
      }[]
    >(
      `SELECT def.option_key AS "optionKey",
              def.label AS "optionLabel",
              def.unlock_level AS "unlockLevel",
              def.value_type::text AS "valueType",
              def.spell_max_level AS "spellMaxLevel",
              def.spell_school_slugs AS "spellSchoolSlugs",
              def.sort_order AS "sortOrder"
       FROM rpg.phb_option_def def
       WHERE def.scope = 'subclass'::rpg.option_scope
         AND def.owner_id = $1
         AND def.unlock_level <= $2
       ORDER BY def.unlock_level ASC, def.sort_order ASC, def.option_key ASC`,
      [subclassId, characterLevel],
    );
  }

  private loadOptionValues(subclassId: string, characterLevel: number) {
    return this.optionValuesRepo.manager.query<
      {
        optionKey: string;
        valueId: string;
        valueLabel: string;
        sortOrder: number;
        benefit: string | null;
      }[]
    >(
      `SELECT val.option_key AS "optionKey",
              val.value_id AS "valueId",
              val.label AS "valueLabel",
              val.sort_order AS "sortOrder",
              COALESCE(val.benefit, val.level1_benefit) AS "benefit"
       FROM rpg.phb_option_value val
       JOIN rpg.phb_option_def def
         ON def.scope = val.scope
        AND def.owner_id = val.owner_id
        AND def.option_key = val.option_key
       WHERE val.scope = 'subclass'::rpg.option_scope
         AND val.owner_id = $1
         AND def.unlock_level <= $2
       ORDER BY val.option_key ASC, val.sort_order ASC`,
      [subclassId, characterLevel],
    );
  }

  private groupOptions(
    defs: {
      optionKey: string;
      optionLabel: string;
      unlockLevel: number;
      valueType: string;
      spellMaxLevel: number | null;
      spellSchoolSlugs: string[] | null;
      sortOrder: number;
    }[],
    valueRows: {
      optionKey: string;
      valueId: string;
      valueLabel: string;
      sortOrder: number;
      benefit: string | null;
    }[],
  ): SubclassOptionResponseDto[] {
    const valuesByKey = new Map<string, SubclassOptionResponseDto['values']>();
    for (const row of valueRows) {
      const list = valuesByKey.get(row.optionKey) ?? [];
      list.push({
        valueId: row.valueId,
        label: row.valueLabel,
        sortOrder: row.sortOrder,
        benefit: row.benefit,
      });
      valuesByKey.set(row.optionKey, list);
    }

    return defs.map((def) => ({
      optionKey: def.optionKey,
      label: def.optionLabel,
      unlockLevel: def.unlockLevel,
      valueType: def.valueType,
      spellMaxLevel: def.spellMaxLevel,
      spellSchoolSlugs: def.spellSchoolSlugs,
      values: STATIC_VALUE_TYPES.has(def.valueType)
        ? (valuesByKey.get(def.optionKey) ?? [])
        : [],
    }));
  }
}
