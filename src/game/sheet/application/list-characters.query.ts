import { Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { CharacterMapper } from '../infrastructure/character.mapper';
import { CharacterSummaryResponseDto } from '../dto/character-response.dto';
import { CampaignService } from '@game/campaign/application/campaign.service';

type CatalogLabelRow = {
  kind: 'class' | 'species' | 'subclass';
  slug: string;
  name: string;
};

@Injectable()
export class ListCharactersQuery {
  constructor(
    private readonly repository: CharacterRepository,
    private readonly mapper: CharacterMapper,
    private readonly campaigns: CampaignService,
    @InjectDataSource() private readonly dataSource: DataSource,
  ) {}

  async execute(userId: string): Promise<CharacterSummaryResponseDto[]> {
    const rows = await this.repository.findAllByUser(userId);
    const dtos = this.mapper.toSummaryList(rows);
    await this.attachCatalogNames(dtos);
    const refs = await this.campaigns.listCampaignRefsByCharacterIds(
      dtos.map((d) => d.id),
      userId,
    );
    for (const dto of dtos) {
      dto.campaigns = refs.get(dto.id) ?? [];
    }
    return dtos;
  }

  private async attachCatalogNames(
    dtos: CharacterSummaryResponseDto[],
  ): Promise<void> {
    if (dtos.length === 0) return;

    const classSlugs = uniqueSlugs(dtos.map((d) => d.classSlug));
    const speciesSlugs = uniqueSlugs(dtos.map((d) => d.speciesSlug));
    const subclassSlugs = uniqueSlugs(
      dtos.map((d) => d.subclassSlug).filter((s): s is string => !!s),
    );

    const rows = (await this.dataSource.query(
      `
      SELECT 'class'::text AS kind, slug, name
      FROM rpg.phb_class
      WHERE slug = ANY($1::text[])
      UNION ALL
      SELECT 'species'::text, slug, name
      FROM rpg.phb_species
      WHERE slug = ANY($2::text[])
      UNION ALL
      SELECT 'subclass'::text, slug, name
      FROM rpg.phb_subclass
      WHERE slug = ANY($3::text[])
      `,
      [classSlugs, speciesSlugs, subclassSlugs],
    )) as CatalogLabelRow[];

    const classNames = new Map<string, string>();
    const speciesNames = new Map<string, string>();
    const subclassNames = new Map<string, string>();
    for (const row of rows) {
      if (row.kind === 'class') classNames.set(row.slug, row.name);
      else if (row.kind === 'species') speciesNames.set(row.slug, row.name);
      else subclassNames.set(row.slug, row.name);
    }

    for (const dto of dtos) {
      dto.className = classNames.get(dto.classSlug) ?? dto.classSlug;
      dto.speciesName = speciesNames.get(dto.speciesSlug) ?? dto.speciesSlug;
      dto.subclassName = dto.subclassSlug
        ? (subclassNames.get(dto.subclassSlug) ?? dto.subclassSlug)
        : null;
    }
  }
}

function uniqueSlugs(values: string[]): string[] {
  return [...new Set(values)];
}
