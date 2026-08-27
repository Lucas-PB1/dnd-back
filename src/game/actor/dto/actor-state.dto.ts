import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsArray,
  IsInt,
  IsObject,
  IsOptional,
  IsString,
  Max,
  Min,
} from 'class-validator';
import type { AbilityScores } from '@game/shared/domain/ability-scores';

export class PatchActorStateDto {
  @ApiPropertyOptional({ type: [String] })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  conditions?: string[];

  @ApiPropertyOptional({ example: 5 })
  @IsOptional()
  @IsInt()
  @Min(0)
  tempHp?: number;

  @ApiPropertyOptional({ nullable: true, example: 'escudo-da-fe' })
  @IsOptional()
  @IsString()
  concentratingOn?: string | null;

  @ApiPropertyOptional()
  @IsOptional()
  @IsObject()
  innateSpellUses?: Record<string, number>;

  @ApiPropertyOptional({ example: 12 })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(9999)
  hitPointsCurrent?: number;

  @ApiPropertyOptional({ example: 45 })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(9999)
  hitPointsMax?: number;

  @ApiPropertyOptional({ example: 16 })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(40)
  armorClass?: number;
}

export class ActorStateResponseDto {
  @ApiProperty()
  actorId!: string;

  @ApiPropertyOptional({ nullable: true })
  hitPointsCurrent!: number | null;

  @ApiPropertyOptional({ nullable: true })
  hitPointsMax!: number | null;

  @ApiPropertyOptional({ nullable: true })
  armorClass!: number | null;

  @ApiProperty()
  abilityModifiers!: AbilityScores;

  @ApiProperty({ type: [String] })
  conditions!: string[];

  @ApiProperty()
  tempHp!: number;

  @ApiPropertyOptional({ nullable: true })
  concentratingOn!: string | null;

  @ApiProperty()
  innateSpellUses!: Record<string, number>;
}
