import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSubclassOptionValue, PhbSubclassRef } from '../../../entities/phb-subclass-option-value.entity';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { SubclassOptionResponseDto } from '../dto/subclass-option-response.dto';

@Injectable()
export class FindSubclassOptionsQuery {
  constructor(
    @InjectRepository(PhbSubclassRef)
    private readonly subclassRepo: Repository<PhbSubclassRef>,
    @InjectRepository(PhbSubclassOptionValue)
    private readonly optionValuesRepo: Repository<PhbSubclassOptionValue>,
    private readonly catalogLookup: CatalogLookupService,
  ) {}

  async execute(
    subclassSlug: string,
    characterLevel = 20,
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<SubclassOptionResponseDto>> {
    await this.catalogLookup.findSubclassOrFail(subclassSlug);

    const subclass = await this.subclassRepo.findOne({ where: { slug: subclassSlug } });
    if (!subclass) {
      throw new NotFoundException(`Subclass '${subclassSlug}' not found`);
    }

    const rows = await this.dataSourceQuery(subclass.id, characterLevel);
    const grouped = this.groupOptions(rows);
    return paginate(grouped, page, limit);
  }

  private async dataSourceQuery(
    subclassId: string,
    characterLevel: number,
  ): Promise<
    {
      optionKey: string;
      optionLabel: string;
      unlockLevel: number;
      valueId: string;
      valueLabel: string;
      sortOrder: number;
    }[]
  > {
    return this.optionValuesRepo.manager.query(
      `SELECT def.option_key AS "optionKey",
              def.label AS "optionLabel",
              def.unlock_level AS "unlockLevel",
              val.value_id AS "valueId",
              val.label AS "valueLabel",
              val.sort_order AS "sortOrder"
       FROM rpg.phb_subclass_option_def def
       JOIN rpg.phb_subclass_option_value val
         ON val.subclass_id = def.subclass_id AND val.option_key = def.option_key
       WHERE def.subclass_id = $1
         AND def.unlock_level <= $2
       ORDER BY def.unlock_level ASC, def.option_key ASC, val.sort_order ASC`,
      [subclassId, characterLevel],
    );
  }

  private groupOptions(
    rows: {
      optionKey: string;
      optionLabel: string;
      unlockLevel: number;
      valueId: string;
      valueLabel: string;
      sortOrder: number;
    }[],
  ): SubclassOptionResponseDto[] {
    const map = new Map<string, SubclassOptionResponseDto>();

    for (const row of rows) {
      let group = map.get(row.optionKey);
      if (!group) {
        group = {
          optionKey: row.optionKey,
          label: row.optionLabel,
          unlockLevel: row.unlockLevel,
          values: [],
        };
        map.set(row.optionKey, group);
      }
      group.values.push({
        valueId: row.valueId,
        label: row.valueLabel,
        sortOrder: row.sortOrder,
      });
    }

    return [...map.values()];
  }
}
