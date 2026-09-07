import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsArray,
  IsBoolean,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Max,
  Min,
} from 'class-validator';
import { CharacterStateResponseDto } from '../character-state-response.dto';

export class PatchCharacterStateDto {
  @ApiPropertyOptional({ example: ['poisoned'] })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  conditions?: string[];

  @ApiPropertyOptional({ example: 5 })
  @IsOptional()
  @IsInt()
  @Min(0)
  tempHp?: number;

  @ApiPropertyOptional({ example: null, description: 'null para encerrar concentração' })
  @IsOptional()
  @IsString()
  concentratingOn?: string | null;

  @ApiPropertyOptional({ example: 2, description: 'Sucessos em death saves (0–3)' })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(3)
  deathSaveSuccesses?: number;

  @ApiPropertyOptional({ example: 1, description: 'Falhas em death saves (0–3)' })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(3)
  deathSaveFailures?: number;

  @ApiPropertyOptional({ example: true })
  @IsOptional()
  @IsBoolean()
  inspiration?: boolean;

  @ApiPropertyOptional({
    example: ['snow_ice', 'in_water'],
    description:
      'Circunstâncias de mesa (snow_ice | in_water | extreme_cold). Substitui a lista inteira.',
  })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  mesaCircumstances?: string[];
}

export class RestDto {
  @ApiProperty({ enum: ['short', 'long'] })
  @IsIn(['short', 'long'])
  type!: 'short' | 'long';

  @ApiPropertyOptional({
    example: 1,
    description:
      'Dados de vida a gastar no descanso curto (ignorado no longo). Padrão 0.',
  })
  @IsOptional()
  @IsInt()
  @Min(0)
  hitDiceSpent?: number;
}

export class RestResponseDto {
  @ApiProperty({ enum: ['short', 'long'] })
  type!: 'short' | 'long';

  @ApiProperty({ type: CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiPropertyOptional({ example: 1 })
  hitDiceSpent?: number;

  @ApiPropertyOptional({ example: [7, 4], description: 'Faces brutas dos dados gastos' })
  hitDiceRolls?: number[];

  @ApiPropertyOptional({ example: 12 })
  hitPointsHealed?: number;

  @ApiPropertyOptional({
    example: ['Cargas — Varinha de Mísseis Mágicos: recuperou 5 (1d6+1).'],
    description: 'Notas de recover 1dN de itens no descanso longo',
  })
  notes?: string[];
}
