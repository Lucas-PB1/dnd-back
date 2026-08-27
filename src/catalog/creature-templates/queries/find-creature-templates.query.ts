import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbCreatureTemplate } from '@entities/phb-creature-template.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQbCursor,
} from '@common/dto/pagination.dto';
import {
  CreatureTemplateResponseDto,
  CreatureTemplateSummaryResponseDto,
} from '../dto/creature-template-response.dto';
import { CreatureTemplateMapper } from '../creature-template.mapper';
import { VPhbCreatureTemplateBundle } from '@entities/views/v-phb-creature-template-bundle.entity';

const CURSOR_KEYS = [
  { expr: 'creature.name', name: 'name' },
  { expr: 'creature.slug', name: 'slug' },
] as const;

@Injectable()
export class FindCreatureTemplatesQuery {
  constructor(
    @InjectRepository(PhbCreatureTemplate)
    private readonly templates: Repository<PhbCreatureTemplate>,
    private readonly mapper: CreatureTemplateMapper,
  ) {}

  async execute(
    cursor?: string,
    limit = 20,
    q?: string,
    editionSlugs?: string[],
    fields?: 'summary',
  ): Promise<
    PaginatedResponseDto<
      CreatureTemplateResponseDto | CreatureTemplateSummaryResponseDto
    >
  > {
    const qb = this.templates
      .createQueryBuilder('creature')
      .orderBy('creature.name', 'ASC')
      .addOrderBy('creature.slug', 'ASC');

    if (fields === 'summary') {
      qb.select([
        'creature.slug',
        'creature.name',
        'creature.editionSlug',
        'creature.creatureType',
        'creature.sizeSlug',
        'creature.challengeRating',
        'creature.armorClass',
        'creature.hitPointsAvg',
      ]);
    }

    applyIlikeSearch(
      qb,
      [
        'creature.name',
        'creature.slug',
        'creature.creatureType',
        "COALESCE(creature.creatureSubtype, '')",
      ],
      q,
    );

    const slugs = editionSlugs?.map((slug) => slug.trim()).filter(Boolean);
    if (slugs?.length) {
      qb.andWhere('creature.editionSlug IN (:...editionSlugs)', {
        editionSlugs: slugs,
      });
    }

    const { rows, meta } = await paginateQbCursor(qb, {
      cursor,
      limit,
      keys: CURSOR_KEYS,
      encodeRow: (row) => ({ name: row.name, slug: row.slug }),
    });

    const data =
      fields === 'summary'
        ? rows.map((row) => this.mapper.toSummaryDto(row))
        : rows.map((row) => this.mapper.toSummaryDto(row));

    return { data, meta };
  }
}

@Injectable()
export class FindCreatureTemplateBySlugQuery {
  constructor(
    @InjectRepository(VPhbCreatureTemplateBundle)
    private readonly bundles: Repository<VPhbCreatureTemplateBundle>,
    private readonly mapper: CreatureTemplateMapper,
  ) {}

  async execute(slug: string): Promise<CreatureTemplateResponseDto> {
    const row = await this.bundles.findOne({ where: { slug } });
    if (!row) {
      throw new NotFoundException(`Creature template '${slug}' not found`);
    }
    return this.mapper.toDto(row);
  }
}
