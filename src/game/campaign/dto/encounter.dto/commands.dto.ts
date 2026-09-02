import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsBoolean,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Max,
  MaxLength,
  Min,
  MinLength,
} from 'class-validator';

export class CreateCampaignEncounterDto {
  @ApiProperty({ example: 'Emboscada na estrada' })
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  name!: string;
}

export class PatchCampaignEncounterDto {
  @ApiPropertyOptional({ example: 'Emboscada reforçada' })
  @IsOptional()
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  name?: string;

  @ApiPropertyOptional({
    description: 'Se true, jogadores da campanha veem o encontro ativo',
  })
  @IsOptional()
  @IsBoolean()
  playersCanView?: boolean;

  @ApiPropertyOptional({ enum: ['hidden', 'percent', 'exact'] })
  @IsOptional()
  @IsIn(['hidden', 'percent', 'exact'])
  creatureHpVisibility?: 'hidden' | 'percent' | 'exact';
}

export class RollEncounterInitiativeDto {
  @ApiPropertyOptional({ enum: ['normal', 'advantage', 'disadvantage'] })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: 'normal' | 'advantage' | 'disadvantage';
}

export class AddEncounterCreatureDto {
  @ApiProperty({ example: 'Goblin #1' })
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  name!: string;

  @ApiProperty({ example: 7 })
  @IsInt()
  @Min(1)
  @Max(9999)
  hpMax!: number;

  @ApiPropertyOptional({ example: 7 })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(9999)
  hpCurrent?: number;

  @ApiProperty({ example: 15 })
  @IsInt()
  @Min(1)
  @Max(40)
  armorClass!: number;

  @ApiPropertyOptional({ example: 2, description: 'Modificador de iniciativa' })
  @IsOptional()
  @IsInt()
  @Min(-10)
  @Max(20)
  initiativeModifier?: number;
}

export class PatchEncounterCombatantDto {
  @ApiPropertyOptional({ example: 17 })
  @IsOptional()
  @IsInt()
  initiativeTotal?: number;

  @ApiPropertyOptional({ example: 3 })
  @IsOptional()
  @IsInt()
  initiativeModifier?: number;

  @ApiPropertyOptional({ example: true })
  @IsOptional()
  @IsBoolean()
  isActive?: boolean;

  @ApiPropertyOptional({
    example: 'Ogro ferido',
    description: 'Só criaturas',
  })
  @IsOptional()
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  displayName?: string;

  @ApiPropertyOptional({ example: 12, description: 'Só criaturas' })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(9999)
  hpCurrent?: number;

  @ApiPropertyOptional({ example: 59, description: 'Só criaturas' })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(9999)
  hpMax?: number;

  @ApiPropertyOptional({ example: 16, description: 'Só criaturas' })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(40)
  armorClass?: number;
}
