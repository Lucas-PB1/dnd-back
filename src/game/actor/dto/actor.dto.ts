import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsArray,
  IsIn,
  IsInt,
  IsObject,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  MaxLength,
  Min,
  MinLength,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';
import type { AbilityScores } from '@game/shared/domain/ability-scores';
import type { ActorKind } from '../infrastructure/game-actor.entity';

const ACTOR_KINDS = ['creature', 'mount', 'vehicle', 'companion'] as const;

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

export class CreateActorDto {
  @ApiProperty({ enum: ACTOR_KINDS })
  @IsIn(ACTOR_KINDS)
  actorKind!: ActorKind;

  @ApiProperty({ example: 'Goblin #1' })
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  name!: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsUUID()
  campaignId?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsUUID()
  parentCharacterId?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  templateSlug?: string;

  @ApiPropertyOptional({ example: 7 })
  @IsOptional()
  @IsInt()
  @Min(0)
  hitPointsMax?: number;

  @ApiPropertyOptional({ example: 7 })
  @IsOptional()
  @IsInt()
  @Min(0)
  hitPointsCurrent?: number;

  @ApiPropertyOptional({ example: 15 })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(40)
  armorClass?: number;

  @ApiPropertyOptional({ example: 2 })
  @IsOptional()
  @IsInt()
  initiativeModifier?: number;

  @ApiPropertyOptional({ example: 2 })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(9)
  proficiencyBonus?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  sizeSlug?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  notes?: string;

  @ApiPropertyOptional({ type: [ActorSpeedInputDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ActorSpeedInputDto)
  speeds?: ActorSpeedInputDto[];

  @ApiPropertyOptional({ type: [ActorActionInputDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ActorActionInputDto)
  actions?: ActorActionInputDto[];

  @ApiPropertyOptional({ type: [ActorSpellInputDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ActorSpellInputDto)
  spells?: ActorSpellInputDto[];
}

export class UpdateActorDto {
  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  name?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsInt()
  @Min(0)
  hitPointsMax?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsInt()
  @Min(0)
  hitPointsCurrent?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(40)
  armorClass?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsInt()
  initiativeModifier?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  notes?: string;
}

export class SpawnActorFromTemplateDto {
  @ApiProperty({ example: 'primal-companion-earth' })
  @IsString()
  templateSlug!: string;

  @ApiProperty({ enum: ACTOR_KINDS })
  @IsIn(ACTOR_KINDS)
  actorKind!: ActorKind;

  @ApiPropertyOptional()
  @IsOptional()
  @IsUUID()
  campaignId?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsUUID()
  parentCharacterId?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  @MaxLength(120)
  nameOverride?: string;
}

export class ActorSummaryResponseDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty({ enum: ACTOR_KINDS })
  actorKind!: ActorKind;

  @ApiPropertyOptional({ nullable: true })
  parentCharacterId!: string | null;

  @ApiPropertyOptional({ nullable: true })
  templateSlug!: string | null;

  @ApiPropertyOptional({ nullable: true })
  campaignId!: string | null;

  @ApiPropertyOptional({ nullable: true })
  hitPointsCurrent!: number | null;

  @ApiPropertyOptional({ nullable: true })
  hitPointsMax!: number | null;

  @ApiPropertyOptional({ nullable: true })
  armorClass!: number | null;

  @ApiProperty()
  createdAt!: string;

  @ApiProperty()
  updatedAt!: string;
}

export class ActorResponseDto extends ActorSummaryResponseDto {
  @ApiPropertyOptional({ nullable: true })
  parentCharacterId!: string | null;

  @ApiPropertyOptional({ nullable: true })
  templateSlug!: string | null;

  @ApiPropertyOptional({ nullable: true })
  initiativeModifier!: number | null;

  @ApiPropertyOptional({ nullable: true })
  proficiencyBonus!: number | null;

  @ApiProperty()
  abilityScores!: AbilityScores;

  @ApiPropertyOptional({ nullable: true })
  sizeSlug!: string | null;

  @ApiPropertyOptional({ nullable: true })
  notes!: string | null;

  @ApiPropertyOptional({ nullable: true })
  spellcastingAbilitySlug!: string | null;

  @ApiPropertyOptional({ nullable: true })
  spellSaveDc!: number | null;

  @ApiPropertyOptional({ nullable: true })
  spellAttackBonus!: number | null;

  @ApiPropertyOptional({ nullable: true })
  damageThreshold!: number | null;

  @ApiPropertyOptional({ nullable: true })
  crewCapacity!: number | null;

  @ApiPropertyOptional({ nullable: true })
  passengerCapacity!: number | null;

  @ApiPropertyOptional({ nullable: true })
  cargoCapacityLb!: number | null;

  @ApiProperty({ type: [ActorSpeedInputDto] })
  speeds!: ActorSpeedInputDto[];

  @ApiProperty({ type: [ActorActionInputDto] })
  actions!: (ActorActionInputDto & { id: string })[];

  @ApiProperty({ type: [ActorSpellInputDto] })
  spells!: ActorSpellInputDto[];

  @ApiPropertyOptional({ nullable: true })
  state!: {
    conditions: string[];
    tempHp: number;
    concentratingOn: string | null;
    innateSpellUses: Record<string, number>;
  } | null;
}

export class RollActorAttackDto {
  @ApiProperty({ description: 'UUID da ação em game_actor_action' })
  @IsUUID()
  actionId!: string;

  @ApiPropertyOptional({ enum: ['normal', 'advantage', 'disadvantage'] })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: 'normal' | 'advantage' | 'disadvantage';
}

export class RollActorAttackResponseDto {
  @ApiProperty()
  expression!: string;

  @ApiProperty()
  total!: number;

  @ApiProperty()
  modifier!: number;

  @ApiProperty()
  actionName!: string;

  @ApiPropertyOptional()
  damageExpression?: string | null;
}
