import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsBoolean, IsIn, IsOptional, IsString } from 'class-validator';
import type { AdvantageMode } from '../domain/dice';

export class RollAttackDto {
  @ApiProperty({ example: 'longsword' })
  @IsString()
  itemSlug!: string;

  @ApiProperty({ enum: ['melee', 'ranged'], example: 'melee' })
  @IsIn(['melee', 'ranged'])
  mode!: 'melee' | 'ranged';

  @ApiPropertyOptional({
    enum: ['normal', 'advantage', 'disadvantage'],
    default: 'normal',
  })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: AdvantageMode;
}

export class RollDamageDto {
  @ApiProperty({ example: 'longsword' })
  @IsString()
  itemSlug!: string;

  @ApiProperty({ enum: ['melee', 'ranged'], example: 'melee' })
  @IsIn(['melee', 'ranged'])
  mode!: 'melee' | 'ranged';

  @ApiPropertyOptional({ default: false })
  @IsOptional()
  @IsBoolean()
  critical?: boolean;
}

export class RollSkillDto {
  @ApiProperty({ example: 'athletics' })
  @IsString()
  skillSlug!: string;

  @ApiPropertyOptional({
    enum: ['normal', 'advantage', 'disadvantage'],
    default: 'normal',
  })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: AdvantageMode;
}

export class RollSavingThrowDto {
  @ApiProperty({
    example: 'destreza',
    enum: ['forca', 'destreza', 'constituicao', 'inteligencia', 'sabedoria', 'carisma'],
  })
  @IsIn(['forca', 'destreza', 'constituicao', 'inteligencia', 'sabedoria', 'carisma'])
  abilitySlug!: string;

  @ApiPropertyOptional({
    enum: ['normal', 'advantage', 'disadvantage'],
    default: 'normal',
  })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: AdvantageMode;
}

export class RollInitiativeDto {
  @ApiPropertyOptional({
    enum: ['normal', 'advantage', 'disadvantage'],
    default: 'normal',
  })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: AdvantageMode;
}

export class CharacterRollResponseDto {
  @ApiProperty({ example: 'attack' })
  kind!: 'attack' | 'damage' | 'skill' | 'saving_throw' | 'initiative';

  @ApiProperty({ example: 'Ataque — Espada Longa (corpo a corpo)' })
  label!: string;

  @ApiProperty({ example: '1d20+5' })
  expression!: string;

  @ApiProperty({ example: 17 })
  total!: number;

  @ApiProperty({ example: 5 })
  modifier!: number;

  @ApiPropertyOptional({ enum: ['normal', 'advantage', 'disadvantage'] })
  mode?: AdvantageMode;

  @ApiPropertyOptional()
  critical?: boolean;

  @ApiPropertyOptional({
    description: 'Faces do d20 (checks) ou dados de dano',
  })
  rolls!: number[];

  @ApiPropertyOptional({ description: 'Faces mantidas (vantagem/desvantagem)' })
  kept?: number[];
}
