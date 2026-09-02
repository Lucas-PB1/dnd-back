import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsIn, IsOptional, IsUUID } from 'class-validator';
import type { AbilityScores } from '@game/shared/domain/ability-scores';
import type { ActorKind } from '../../infrastructure/game-actor.entity';
import {
  ACTOR_KINDS,
  ActorActionInputDto,
  ActorSpeedInputDto,
  ActorSpellInputDto,
} from './input.dto';

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
  @ApiPropertyOptional({
    example: '/catalog/mounts/camelo.png',
    nullable: true,
  })
  imageUrl!: string | null;

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
