import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbHeritageTrait } from '@entities/heritage/phb-heritage-trait.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { requireNonEmpty } from '@common/require-found';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import {
  HeritageTraitOptionGroupDto,
  HeritageTraitResponseDto,
} from '../dto/heritage-trait-response.dto';
import { HeritagesMapper } from '../heritages.mapper';

type OptionRow = {
  traitSlug: string;
  optionKey: string;
  optionLabel: string;
  valueType: string;
  valueId: string;
  valueLabel: string;
  sortOrder: number;
};

@Injectable()
export class FindHeritageTraitsQuery {
  constructor(
    @InjectRepository(PhbHeritageTrait)
    private readonly traitsRepo: Repository<PhbHeritageTrait>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: HeritagesMapper,
  ) {}

  async execute(
    heritageSlug: string,
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<HeritageTraitResponseDto>> {
    await this.catalogLookup.findHeritageOrFail(heritageSlug);

    const rows = await this.traitsRepo.find({
      order: { category: 'ASC', slug: 'ASC' },
    });
    requireNonEmpty(rows, 'Modular heritage trait pool is empty');
    const optionsBySlug = await this.loadTraitOptions();

    return paginateByKeys(
      rows.map((row) =>
        this.mapper.toTraitDto(row, optionsBySlug.get(row.slug) ?? []),
      ),
      {
        cursor,
        limit,
        keyNames: ['category', 'slug'],
        encodeRow: (row) => ({ category: row.category, slug: row.slug }),
      },
    );
  }

  private async loadTraitOptions(): Promise<
    Map<string, HeritageTraitOptionGroupDto[]>
  > {
    const rows = await this.traitsRepo.manager.query<OptionRow[]>(
      `SELECT ht.slug AS "traitSlug",
              def.option_key AS "optionKey",
              COALESCE(def.label, def.option_key) AS "optionLabel",
              def.value_type::text AS "valueType",
              val.value_id AS "valueId",
              val.label AS "valueLabel",
              val.sort_order AS "sortOrder"
       FROM rpg.phb_option_def def
       JOIN rpg.phb_heritage_trait ht ON ht.id = def.owner_id
       JOIN rpg.phb_option_value val
         ON val.scope = def.scope
        AND val.owner_id = def.owner_id
        AND val.option_key = def.option_key
       WHERE def.scope = 'heritage'::rpg.option_scope
       ORDER BY ht.slug, def.sort_order, def.option_key, val.sort_order`,
    );
    const byTrait = new Map<string, Map<string, HeritageTraitOptionGroupDto>>();
    for (const row of rows) {
      const groups = byTrait.get(row.traitSlug) ?? new Map();
      let group = groups.get(row.optionKey);
      if (!group) {
        group = {
          optionKey: row.optionKey,
          label: row.optionLabel,
          valueType: row.valueType,
          values: [],
        };
        groups.set(row.optionKey, group);
      }
      group.values.push({
        valueId: row.valueId,
        label: row.valueLabel,
        sortOrder: row.sortOrder,
      });
      byTrait.set(row.traitSlug, groups);
    }
    const result = new Map<string, HeritageTraitOptionGroupDto[]>();
    for (const [slug, groups] of byTrait) {
      result.set(slug, [...groups.values()]);
    }
    return result;
  }
}
