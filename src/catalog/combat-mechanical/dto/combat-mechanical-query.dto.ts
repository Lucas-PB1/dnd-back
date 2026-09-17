import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';

export class CombatMechanicalQueryDto {
  @ApiPropertyOptional({
    description: 'Filtra economy/panel actions da classe (mantém espécies/talentos/itens).',
    example: 'fighter',
  })
  @IsOptional()
  @IsString()
  classSlug?: string;

  @ApiPropertyOptional({
    description: 'Filtra subsets de subclasse (manobras, table actions, etc.).',
    example: 'battle-master',
  })
  @IsOptional()
  @IsString()
  subclassSlug?: string;

  @ApiPropertyOptional({
    description: 'Filtra economy actions do talento.',
    example: 'lucky',
  })
  @IsOptional()
  @IsString()
  featSlug?: string;

  @ApiPropertyOptional({
    description: 'Filtra economy actions do item.',
    example: 'potion-of-healing',
  })
  @IsOptional()
  @IsString()
  itemSlug?: string;

  @ApiPropertyOptional({
    description: 'Filtra economy actions da espécie.',
    example: 'dwarf',
  })
  @IsOptional()
  @IsString()
  speciesSlug?: string;

  @ApiPropertyOptional({
    description: 'Filtra economy actions do character thread.',
    example: 'cursemarked',
  })
  @IsOptional()
  @IsString()
  threadSlug?: string;

  @ApiPropertyOptional({
    description: 'Filtra economy actions do traço de herança.',
    example: 'potent-breath',
  })
  @IsOptional()
  @IsString()
  heritageTraitSlug?: string;
}
