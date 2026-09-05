import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import type { AdvantageMode } from '../../domain/dice';

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

  @ApiPropertyOptional({
    description: 'Nota situacional (Tiro intestinal, Tiro na cabeça, etc.)',
  })
  note?: string;

  @ApiPropertyOptional({
    description: 'Bônus de CA por cobertura aplicado ao alvo',
    example: 2,
  })
  targetAcBonus?: number;

  @ApiPropertyOptional({
    description: 'CA efetiva do alvo (targetAc + cobertura) quando informada',
    example: 17,
  })
  effectiveTargetAc?: number;

  @ApiPropertyOptional({
    description: 'Acerto contra effectiveTargetAc (quando targetAc informado)',
  })
  hit?: boolean;

  @ApiPropertyOptional({
    description: 'Ataque bloqueado por cobertura total (sem rolagem)',
  })
  blocked?: boolean;

  @ApiPropertyOptional({
    description:
      'Atacante Selvagem: segunda rolagem de dano da arma (jogador escolhe)',
    type: 'array',
  })
  alternateRolls?: Array<{
    expression: string;
    total: number;
    rolls: number[];
  }>;
}
