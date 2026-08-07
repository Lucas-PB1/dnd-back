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
import { CharacterStateResponseDto } from './character-state-response.dto';

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

export class ResourceDieRollDto {
  @ApiProperty({ example: 'risk' })
  resourceSlug!: string;

  @ApiProperty({ example: 8 })
  faces!: number;

  @ApiProperty({ example: 5 })
  value!: number;

  @ApiProperty({ example: '1d8' })
  expression!: string;
}

export class UseClassResourceResponseDto {
  @ApiProperty({ type: CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiPropertyOptional({ type: ResourceDieRollDto })
  roll?: ResourceDieRollDto | null;
}

export class UseManeuverDto {
  @ApiProperty({ example: 'bite-the-bullet' })
  @IsString()
  maneuverSlug!: string;
}

export class UseManeuverResponseDto {
  @ApiProperty({ type: CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiProperty({ example: 'bite-the-bullet' })
  maneuverSlug!: string;

  @ApiProperty({ example: 'Morda a Bala' })
  maneuverName!: string;

  @ApiProperty({ example: 'temp_hp' })
  effectKind!: string;

  @ApiProperty({ type: ResourceDieRollDto })
  riskRoll!: ResourceDieRollDto;

  @ApiPropertyOptional({ example: 12 })
  tempHpGained?: number;

  @ApiPropertyOptional({ example: 7 })
  missDamage?: number;

  @ApiPropertyOptional({ example: 4 })
  acBonus?: number;

  @ApiPropertyOptional({ example: 3 })
  checkBonus?: number;

  @ApiProperty({ example: '+12 PV Temporários' })
  note!: string;
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

  @ApiPropertyOptional({
    example: true,
    description:
      'Usar conjuração free de magia concedida (1×/LD) em vez de slot de classe',
  })
  @IsOptional()
  @IsBoolean()
  useFreeCast?: boolean;

  @ApiPropertyOptional({
    example: 'magic-missile-free',
    description:
      'Gasta este recurso de classe em vez de slot (ex.: Mísseis Mágicos gratuitos)',
  })
  @IsOptional()
  @IsString()
  freeCastResourceSlug?: string;
}

export class CastSpellResponseDto {
  @ApiProperty({ example: 'alarme' })
  spellSlug!: string;

  @ApiPropertyOptional({ example: 1 })
  slotLevelUsed!: number | null;

  @ApiPropertyOptional({
    example: 'Mísseis Mágicos: 7 dardo(s) · penetram Escudo',
  })
  note?: string | null;

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
