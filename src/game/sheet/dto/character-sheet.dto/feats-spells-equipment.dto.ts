import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsIn,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  Min,
} from 'class-validator';

export class CharacterFeatDto {
  @ApiProperty({ example: 'magic-initiate' })
  @IsString()
  @IsNotEmpty()
  featSlug!: string;

  @ApiProperty({ example: 0, description: '0-based instance when the feat is repeatable' })
  @IsInt()
  @Min(0)
  instanceIndex!: number;
}

export class FeatOptionDto {
  @ApiProperty({ example: 'magic-initiate' })
  @IsString()
  @IsNotEmpty()
  featSlug!: string;

  @ApiPropertyOptional({ example: 0, default: 0 })
  @IsOptional()
  @IsInt()
  @Min(0)
  instanceIndex?: number;

  @ApiProperty({ example: 'spellList' })
  @IsString()
  @IsNotEmpty()
  optionKey!: string;

  @ApiProperty({ example: 'cleric' })
  @IsString()
  @IsNotEmpty()
  valueId!: string;
}

export class CharacterSpellDto {
  @ApiProperty({ example: 'fire-bolt' })
  @IsString()
  @IsNotEmpty()
  spellSlug!: string;

  @ApiProperty({ enum: ['known', 'prepared', 'always_prepared'] })
  @IsString()
  @IsIn(['known', 'prepared', 'always_prepared'])
  listType!: 'known' | 'prepared' | 'always_prepared';

  /** Derivado na resposta: origem da magia na ficha (ignorado no input). */
  @ApiPropertyOptional({
    enum: ['class', 'subclass', 'feat', 'species'],
    description: 'Fonte da magia (preenchido na resposta)',
  })
  @IsOptional()
  @IsIn(['class', 'subclass', 'feat', 'species'])
  source?: 'class' | 'subclass' | 'feat' | 'species';

  /** Derivado: atributo de conjuração efetivo desta magia (ignorado no input). */
  @ApiPropertyOptional({ example: 'inteligencia' })
  @IsOptional()
  @IsString()
  spellcastingAbilitySlug?: string;

  /** Derivado: CD desta magia (ignorado no input). */
  @ApiPropertyOptional({ example: 13 })
  @IsOptional()
  @IsInt()
  spellSaveDc?: number;

  /** Derivado: bônus de ataque mágico desta magia (ignorado no input). */
  @ApiPropertyOptional({ example: 5 })
  @IsOptional()
  @IsInt()
  spellAttackBonus?: number;

  /**
   * Derivado: economia de conjuração concedida (ignorado no input).
   * `at_will` | `once_per_long_rest` | `slot_only`
   */
  @ApiPropertyOptional({
    enum: ['at_will', 'once_per_long_rest', 'slot_only'],
  })
  @IsOptional()
  @IsIn(['at_will', 'once_per_long_rest', 'slot_only'])
  castEconomy?: 'at_will' | 'once_per_long_rest' | 'slot_only';
}

export class CharacterEquipmentDto {
  @ApiProperty({ enum: ['class', 'background'] })
  @IsString()
  @IsIn(['class', 'background'])
  source!: 'class' | 'background';

  @ApiProperty({ example: 'a' })
  @IsString()
  @IsNotEmpty()
  packageSlug!: string;

  @ApiPropertyOptional({ example: 'longsword' })
  @IsOptional()
  @IsString()
  itemSlug?: string;

  @ApiPropertyOptional({ example: 1 })
  @IsOptional()
  @IsInt()
  @Min(1)
  quantity?: number;

  @ApiPropertyOptional({ example: 0 })
  @IsOptional()
  @IsInt()
  @Min(0)
  sortOrder?: number;
}
