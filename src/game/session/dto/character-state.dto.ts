import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsArray,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Min,
  ValidateNested,
} from 'class-validator';

export class SpellSlotsMapDto {
  @ApiPropertyOptional({ example: 2, description: 'Slots de 1º círculo disponíveis no total' })
  '1'?: number;

  @ApiPropertyOptional({ example: 0 })
  '2'?: number;

  @ApiPropertyOptional({ example: 0 })
  '3'?: number;

  @ApiPropertyOptional({ example: 0 })
  '4'?: number;

  @ApiPropertyOptional({ example: 0 })
  '5'?: number;

  @ApiPropertyOptional({ example: 0 })
  '6'?: number;

  @ApiPropertyOptional({ example: 0 })
  '7'?: number;

  @ApiPropertyOptional({ example: 0 })
  '8'?: number;

  @ApiPropertyOptional({ example: 0 })
  '9'?: number;
}

export class ClassResourceStateDto {
  @ApiProperty({ example: 'rage' })
  slug!: string;

  @ApiProperty({ example: 'Fúria' })
  name!: string;

  @ApiProperty({ example: 3 })
  max!: number;

  @ApiProperty({ example: 1 })
  used!: number;

  @ApiProperty({ example: 2 })
  remaining!: number;
}

export class CharacterStateResponseDto {
  @ApiProperty({ example: { '1': 2 } })
  spellSlotsMax!: Record<string, number>;

  @ApiProperty({ example: { '1': 1 } })
  spellSlotsUsed!: Record<string, number>;

  @ApiProperty({ example: { '1': 1 } })
  spellSlotsRemaining!: Record<string, number>;

  @ApiProperty({ type: [ClassResourceStateDto] })
  classResources!: ClassResourceStateDto[];

  @ApiPropertyOptional({ example: 'alarme' })
  concentratingOn!: string | null;

  @ApiProperty({ example: ['poisoned'] })
  conditions!: string[];

  @ApiProperty({ example: 0 })
  tempHp!: number;

  @ApiPropertyOptional({ example: 8 })
  hitPointsCurrent!: number | null;

  @ApiPropertyOptional({ example: 10 })
  hitPointsMax!: number | null;

  @ApiProperty({
    example: 3,
    description: 'Dados de vida restantes (máximo = nível do personagem)',
  })
  hitDiceCurrent!: number;

  @ApiProperty({
    example: 5,
    description: 'Máximo de dados de vida (= nível)',
  })
  hitDiceMax!: number;

  @ApiPropertyOptional({
    example: 'D10',
    description: 'Dado de vida da classe (catálogo)',
  })
  hitDie!: string | null;
}

export class UseClassResourceDto {
  @ApiProperty({ example: 'rage' })
  @IsString()
  resourceSlug!: string;

  @ApiPropertyOptional({ example: 1, description: 'Usos a gastar (padrão 1)' })
  @IsOptional()
  @IsInt()
  @Min(1)
  amount?: number;
}

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
}

export class CastSpellDto {
  @ApiProperty({ example: 'alarme' })
  @IsString()
  spellSlug!: string;

  @ApiPropertyOptional({
    example: 1,
    description: 'Círculo do slot a gastar (padrão = nível da magia; truques não gastam slot)',
  })
  @IsOptional()
  @IsInt()
  @Min(0)
  slotLevel?: number;
}

export class CastSpellResponseDto {
  @ApiProperty({ example: 'alarme' })
  spellSlug!: string;

  @ApiPropertyOptional({ example: 1 })
  slotLevelUsed!: number | null;

  @ApiProperty({ type: CharacterStateResponseDto })
  state!: CharacterStateResponseDto;
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
}
