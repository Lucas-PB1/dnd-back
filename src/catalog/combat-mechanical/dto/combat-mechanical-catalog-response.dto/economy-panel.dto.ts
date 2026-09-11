import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class ClassEconomyActionDto {
  @ApiProperty({ example: 'fighter-second-wind' })
  id!: string;

  @ApiProperty({ example: 'Recuperar Fôlego' })
  name!: string;

  @ApiProperty({ example: 'bonus' })
  economy!: string;

  @ApiPropertyOptional({ example: 'fighter', nullable: true })
  classSlug?: string | null;

  @ApiProperty({ example: 1 })
  minLevel!: number;

  @ApiPropertyOptional({ example: 'psi-warrior' })
  subclassSlug?: string;

  @ApiPropertyOptional({ example: 'dwarf', nullable: true })
  speciesSlug?: string | null;

  @ApiPropertyOptional({ example: 'lucky', nullable: true })
  featSlug?: string | null;

  @ApiPropertyOptional({ example: 'ring-of-barrels', nullable: true })
  itemSlug?: string | null;

  @ApiPropertyOptional({ example: 'extra-tough', nullable: true })
  heritageTraitSlug?: string | null;

  @ApiPropertyOptional({ example: 'sworn-huskarl', nullable: true })
  threadSlug?: string | null;

  @ApiPropertyOptional({ example: 'giantAncestryId' })
  requiresOptionKey?: string;

  @ApiPropertyOptional({ example: 'cloud' })
  requiresOptionValue?: string;

  @ApiPropertyOptional({ example: 'secondWind' })
  resourceSlug?: string;

  @ApiPropertyOptional()
  freeResourceSlug?: string;

  @ApiPropertyOptional()
  alwaysSpendsResource?: boolean;

  @ApiPropertyOptional()
  summary?: string;

  @ApiPropertyOptional()
  description?: string;

  @ApiPropertyOptional({ example: 'second-wind' })
  tableAction?: string;

  @ApiPropertyOptional()
  spendAmount?: number;

  @ApiPropertyOptional({
    example: 'intimidating-presence',
    description: 'Pool a recuperar após o gasto de resourceSlug',
  })
  recoverResourceSlug?: string;

  @ApiPropertyOptional({ example: 1 })
  recoverAmount?: number;

  @ApiPropertyOptional({
    example: 'misseis-magicos',
    description: 'Magia do catálogo vinculada a esta action (cast de item)',
  })
  spellSlug?: string;
}

export class ClassPanelActionDto {
  @ApiProperty({ example: 'bard|grant-inspiration' })
  panelKey!: string;

  @ApiProperty({ example: 'bard' })
  classSlug!: string;

  @ApiPropertyOptional({ example: 'lore' })
  subclassSlug?: string;

  @ApiProperty({ example: 'grant-inspiration' })
  slug!: string;

  @ApiProperty({ example: 'Conceder Inspiração' })
  name!: string;

  @ApiPropertyOptional({
    description: 'Resumo curto (C010 title)',
  })
  title?: string;

  @ApiPropertyOptional({
    description:
      'Texto jogável (C009 description quando table_action = slug)',
  })
  description?: string;

  @ApiProperty({ example: 1 })
  minLevel!: number;

  @ApiPropertyOptional({ example: 'bardicInspiration' })
  resourceSlug?: string;

  @ApiProperty({ example: 'base' })
  section!: string;

  @ApiProperty()
  spendsFocus!: boolean;

  @ApiProperty()
  sortOrder!: number;
}
