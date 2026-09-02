import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Max,
  MaxLength,
  Min,
  MinLength,
} from 'class-validator';

export const ACTOR_KINDS = ['creature', 'mount', 'vehicle', 'companion'] as const;

export class ActorSpeedInputDto {
  @ApiProperty({ example: 'walk' })
  @IsString()
  @MinLength(1)
  @MaxLength(32)
  movementKind!: string;

  @ApiProperty({ example: 30 })
  @IsInt()
  @Min(0)
  speedFt!: number;
}

export class ActorActionInputDto {
  @ApiProperty({ example: 'Mordida' })
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  name!: string;

  @ApiPropertyOptional({ enum: ['action', 'bonus', 'reaction', 'legendary', 'other'] })
  @IsOptional()
  @IsIn(['action', 'bonus', 'reaction', 'legendary', 'other'])
  actionBucket?: 'action' | 'bonus' | 'reaction' | 'legendary' | 'other';

  @ApiPropertyOptional({ example: 5 })
  @IsOptional()
  @IsInt()
  attackBonus?: number;

  @ApiPropertyOptional({ example: '1d8+3' })
  @IsOptional()
  @IsString()
  damageExpression?: string;

  @ApiPropertyOptional({ example: 5 })
  @IsOptional()
  @IsInt()
  @Min(0)
  reachFt?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  description?: string;

  @ApiPropertyOptional({ example: 0 })
  @IsOptional()
  @IsInt()
  sortOrder?: number;
}

export class ActorSpellInputDto {
  @ApiProperty({ example: 'bola-de-fogo' })
  @IsString()
  spellSlug!: string;

  @ApiProperty({ enum: ['at_will', 'per_day', 'recharge', 'slot'] })
  @IsIn(['at_will', 'per_day', 'recharge', 'slot'])
  usageKind!: 'at_will' | 'per_day' | 'recharge' | 'slot';

  @ApiPropertyOptional({ example: 3 })
  @IsOptional()
  @IsInt()
  @Min(1)
  usesPerDay?: number;

  @ApiPropertyOptional({ example: 3 })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(9)
  slotLevel?: number;

  @ApiPropertyOptional({ example: '5-6' })
  @IsOptional()
  @IsString()
  rechargeDice?: string;

  @ApiPropertyOptional({ example: 0 })
  @IsOptional()
  @IsInt()
  sortOrder?: number;
}
