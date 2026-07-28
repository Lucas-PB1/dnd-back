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

export class EncounterCombatantDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({ enum: ['pc', 'creature'] })
  kind!: 'pc' | 'creature';

  @ApiPropertyOptional({ nullable: true })
  characterId!: string | null;

  @ApiProperty({ example: 'Thorin' })
  displayName!: string;

  @ApiPropertyOptional({ example: 17, nullable: true })
  initiativeTotal!: number | null;

  @ApiPropertyOptional({ example: 2, nullable: true })
  initiativeModifier!: number | null;

  @ApiProperty({ example: 0 })
  sortOrder!: number;

  @ApiProperty()
  isActive!: boolean;

  @ApiProperty()
  isCurrentTurn!: boolean;

  @ApiPropertyOptional({ nullable: true, description: 'Nível (PC)' })
  level!: number | null;

  @ApiPropertyOptional({ nullable: true })
  armorClass!: number | null;

  @ApiPropertyOptional({
    nullable: true,
    description: 'PV atuais (exato; null se oculto/% para jogador)',
  })
  hpCurrent!: number | null;

  @ApiPropertyOptional({ nullable: true })
  hpMax!: number | null;

  @ApiPropertyOptional({
    nullable: true,
    description: 'PV em % 0–100 (visão jogador de criaturas)',
  })
  hpPercent!: number | null;

  @ApiPropertyOptional({ type: [String], description: 'Talentos (PC)' })
  featSlugs!: string[];

  @ApiPropertyOptional({ type: [String], description: 'Condições (PC)' })
  conditions!: string[];

  @ApiPropertyOptional({
    nullable: true,
    description: 'Inspiração (PC)',
  })
  inspiration!: boolean | null;
}

export class CampaignEncounterDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  campaignId!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty({ enum: ['active', 'closed'] })
  status!: 'active' | 'closed';

  @ApiProperty({ example: 1 })
  round!: number;

  @ApiProperty({ example: 0 })
  currentTurnIndex!: number;

  @ApiProperty()
  playersCanView!: boolean;

  @ApiProperty({ enum: ['hidden', 'percent', 'exact'] })
  creatureHpVisibility!: 'hidden' | 'percent' | 'exact';

  @ApiPropertyOptional({ nullable: true })
  currentCombatantId!: string | null;

  @ApiPropertyOptional({
    nullable: true,
    description: 'characterId se o turno atual for um PC',
  })
  currentCharacterId!: string | null;

  @ApiProperty({ type: [EncounterCombatantDto] })
  combatants!: EncounterCombatantDto[];
}
