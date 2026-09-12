import { ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsArray,
  IsBoolean,
  IsInt,
  IsOptional,
  IsString,
  Min,
} from 'class-validator';


export class TableActionOptionsDto {
  @ApiPropertyOptional({ description: 'Quantidade (ex.: Mãos Consagradas, Bastião)' })
  @IsOptional()
  @IsInt()
  @Min(1)
  amount?: number;

  @ApiPropertyOptional({ description: 'Dados a gastar (ex.: Luz Medicinal)' })
  @IsOptional()
  @IsInt()
  @Min(1)
  diceCount?: number;

  @ApiPropertyOptional({ description: 'Comando de companheiro' })
  @IsOptional()
  @IsString()
  companionCommand?: string;

  @ApiPropertyOptional({ description: 'Total atual do teste (check_boost)' })
  @IsOptional()
  @IsInt()
  @Min(1)
  checkTotal?: number;

  @ApiPropertyOptional({ description: 'CD do teste (check_boost)' })
  @IsOptional()
  @IsInt()
  @Min(1)
  dc?: number;

  @ApiPropertyOptional({ description: 'Gasta dado psi em vez do uso gratuito' })
  @IsOptional()
  @IsBoolean()
  usePsiDie?: boolean;

  @ApiPropertyOptional({ description: 'Slug da manobra' })
  @IsOptional()
  @IsString()
  maneuverSlug?: string;

  @ApiPropertyOptional({ description: 'Slug da metamagia' })
  @IsOptional()
  @IsString()
  metamagicSlug?: string;

  @ApiPropertyOptional({ description: 'Implacável (manobra sem Superioridade)' })
  @IsOptional()
  @IsBoolean()
  useRelentless?: boolean;

  @ApiPropertyOptional({ description: 'Slug de magia (precaução / Criaturas Espectrais)' })
  @IsOptional()
  @IsString()
  spellSlug?: string;

  @ApiPropertyOptional({
    description:
      'Variante spirit (spectral-summon / fey-reinforcements / cast spirit)',
  })
  @IsOptional()
  @IsString()
  spiritVariantKey?: string;

  @ApiPropertyOptional({ description: 'Opção tipada (ex.: Golpe de Sangue)' })
  @IsOptional()
  @IsString()
  optionSlug?: string;

  @ApiPropertyOptional({
    description: 'Sangue da Criação: rerrola custo e fica com o menor',
  })
  @IsOptional()
  @IsBoolean()
  takeLowerBloodCost?: boolean;

  @ApiPropertyOptional({
    type: [String],
    description: 'Máscaras a vestir (set-persona-masks)',
  })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  masks?: string[];

  @ApiPropertyOptional({ description: 'Nível de tracker (ex.: aspecto bestial)' })
  @IsOptional()
  @IsInt()
  @Min(0)
  level?: number;

  @ApiPropertyOptional({ description: 'Item do inventário (pacto / arma de fogo)' })
  @IsOptional()
  @IsString()
  itemSlug?: string;

  @ApiPropertyOptional({ description: 'Tiros (fire-chamber)' })
  @IsOptional()
  @IsInt()
  @Min(1)
  shots?: number;

  @ApiPropertyOptional({ description: 'Círculo do espaço (Passo Lunar etc.)' })
  @IsOptional()
  @IsInt()
  @Min(1)
  slotLevel?: number;
}
