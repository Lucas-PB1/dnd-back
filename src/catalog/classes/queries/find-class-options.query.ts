import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbOptionValue } from '@entities/phb-option.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import {
  PaginatedResponseDto,
  paginate,
} from '@common/dto/pagination.dto';
import { ClassOptionResponseDto } from '../dto/class-option-response.dto';

type OptionRow = {
  optionKey: string;
  optionLabel: string;
  unlockLevel: number;
  valueType: string;
  valueId: string;
  valueLabel: string;
  sortOrder: number;
  benefit: string | null;
};

@Injectable()
export class FindClassOptionsQuery {
  constructor(
    @InjectRepository(PhbOptionValue)
    private readonly optionValues: Repository<PhbOptionValue>,
    private readonly catalogLookup: CatalogLookupService,
  ) {}

  async execute(
    classSlug: string,
    characterLevel = 20,
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<ClassOptionResponseDto>> {
    await this.catalogLookup.findClassOrFail(classSlug);
    const rows = await this.optionValues.manager.query<OptionRow[]>(
      `SELECT def.option_key AS "optionKey",
              def.label AS "optionLabel",
              COALESCE(def.unlock_level, 1) AS "unlockLevel",
              def.value_type::text AS "valueType",
              val.value_id AS "valueId",
              val.label AS "valueLabel",
              val.sort_order AS "sortOrder",
              val.benefit AS "benefit"
       FROM rpg.phb_option_def def
       JOIN rpg.phb_option_value val
         ON val.scope = def.scope
        AND val.owner_id = def.owner_id
        AND val.option_key = def.option_key
       JOIN rpg.phb_class c ON c.id = def.owner_id
       WHERE def.scope = 'class'::rpg.option_scope
         AND c.slug = $1
         AND COALESCE(def.unlock_level, 1) <= $2
       ORDER BY def.unlock_level ASC NULLS FIRST, def.sort_order ASC, def.option_key ASC, val.sort_order ASC`,
      [classSlug, characterLevel],
    );
    return paginate(this.groupOptions(rows), page, limit);
  }

  private groupOptions(rows: OptionRow[]): ClassOptionResponseDto[] {
    const map = new Map<string, ClassOptionResponseDto>();
    for (const row of rows) {
      let group = map.get(row.optionKey);
      if (!group) {
        group = {
          optionKey: row.optionKey,
          label: row.optionLabel,
          unlockLevel: row.unlockLevel,
          valueType: row.valueType,
          values: [],
        };
        map.set(row.optionKey, group);
      }
      group.values.push({
        valueId: row.valueId,
        label: row.valueLabel,
        sortOrder: row.sortOrder,
        benefit: row.benefit,
      });
    }
    return [...map.values()];
  }
}
