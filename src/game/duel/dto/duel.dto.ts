import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsBoolean,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  MaxLength,
  Min,
  MinLength,
} from 'class-validator';
import type { DuelEndReason, DuelStatus } from '../domain/duel-status';
import type { DuelArenaEffect } from '../domain/arena-effects';

export class CreateDuelDto {
  @ApiProperty({ format: 'uuid' })
  @IsUUID()
  characterId!: string;
}

export class JoinDuelDto {
  @ApiProperty({ example: 'A3K9MQ2P' })
  @IsString()
  @MinLength(6)
  @MaxLength(16)
  inviteCode!: string;

  @ApiProperty({ format: 'uuid' })
  @IsUUID()
  characterId!: string;
}

export class SetDuelReadyDto {
  @ApiProperty({ description: 'Marcar ou desmarcar pronto' })
  @IsBoolean()
  ready!: boolean;
}

export class DuelAttackDto {
  @ApiProperty({ example: 'longsword' })
  @IsString()
  itemSlug!: string;

  @ApiProperty({ enum: ['melee', 'ranged'], example: 'melee' })
  @IsIn(['melee', 'ranged'])
  mode!: 'melee' | 'ranged';
}

export class DuelCastSpellDto {
  @ApiProperty({ example: 'escuridao' })
  @IsString()
  spellSlug!: string;

  @ApiPropertyOptional({ minimum: 0, maximum: 9 })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(9)
  slotLevel?: number;
}

export class DuelConditionDto {
  @ApiProperty({ enum: ['add', 'remove'] })
  @IsIn(['add', 'remove'])
  action!: 'add' | 'remove';

  @ApiProperty({ enum: ['self', 'opponent'] })
  @IsIn(['self', 'opponent'])
  target!: 'self' | 'opponent';

  @ApiProperty({ example: 'poisoned' })
  @IsString()
  condition!: string;
}

export class DuelCharacterSummaryDto {
  @ApiProperty()
  characterId!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty()
  level!: number;

  @ApiProperty()
  classSlug!: string;

  @ApiPropertyOptional({ nullable: true })
  speciesSlug!: string | null;
}

export class DuelCombatantDto {
  @ApiProperty()
  userId!: string;

  @ApiProperty()
  characterId!: string;

  @ApiProperty()
  characterName!: string;

  @ApiProperty()
  level!: number;

  @ApiProperty()
  classSlug!: string;

  @ApiPropertyOptional({ nullable: true })
  speciesSlug!: string | null;

  @ApiProperty()
  ready!: boolean;

  @ApiPropertyOptional({ nullable: true })
  initiative!: number | null;

  @ApiProperty()
  hitPointsCurrent!: number;

  @ApiProperty()
  hitPointsMax!: number;

  @ApiProperty()
  armorClass!: number;

  @ApiPropertyOptional({ nullable: true })
  portraitUrl!: string | null;

  @ApiProperty()
  tempHp!: number;

  @ApiProperty({ type: [String] })
  conditions!: string[];

  @ApiProperty()
  joinedAt!: string;
}

export class DuelWeaponOptionDto {
  @ApiProperty()
  itemSlug!: string;

  @ApiProperty()
  itemName!: string;

  @ApiProperty({ enum: ['melee', 'ranged'] })
  mode!: 'melee' | 'ranged';

  @ApiProperty()
  attackBonus!: number;
}

export class DuelSpellOptionDto {
  @ApiProperty()
  spellSlug!: string;

  @ApiProperty({ enum: ['known', 'prepared', 'always_prepared'] })
  listType!: string;
}

export class DuelCombatLogEntryDto {
  @ApiProperty()
  at!: string;

  @ApiProperty()
  text!: string;
}

export class DuelMemberDto {
  @ApiProperty()
  userId!: string;

  @ApiProperty()
  characterId!: string;

  @ApiProperty()
  characterName!: string;

  @ApiProperty()
  level!: number;

  @ApiProperty()
  classSlug!: string;

  @ApiPropertyOptional({ nullable: true })
  speciesSlug!: string | null;

  @ApiProperty()
  ready!: boolean;

  @ApiPropertyOptional({ nullable: true })
  initiative!: number | null;

  @ApiProperty()
  joinedAt!: string;
}

export class DuelSummaryDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({
    enum: ['open', 'ready', 'active', 'finished', 'cancelled'],
  })
  status!: DuelStatus;

  @ApiProperty()
  inviteCode!: string;

  @ApiProperty()
  createdBy!: string;

  @ApiPropertyOptional({ type: DuelCharacterSummaryDto, nullable: true })
  myCharacter!: DuelCharacterSummaryDto | null;

  @ApiPropertyOptional({ type: DuelCharacterSummaryDto, nullable: true })
  opponentCharacter!: DuelCharacterSummaryDto | null;

  @ApiPropertyOptional({ nullable: true })
  winnerUserId!: string | null;

  @ApiPropertyOptional({ nullable: true })
  endReason!: DuelEndReason | null;

  @ApiProperty()
  createdAt!: string;

  @ApiProperty()
  updatedAt!: string;
}

export class DuelDetailDto extends DuelSummaryDto {
  @ApiProperty({ type: [DuelMemberDto] })
  members!: DuelMemberDto[];

  @ApiProperty({ type: [DuelCombatantDto] })
  combatants!: DuelCombatantDto[];

  @ApiPropertyOptional({ nullable: true })
  turnCharacterId!: string | null;

  @ApiProperty()
  round!: number;

  @ApiProperty()
  myTurn!: boolean;

  @ApiProperty({ type: [DuelWeaponOptionDto] })
  myWeapons!: DuelWeaponOptionDto[];

  @ApiProperty({ type: [DuelSpellOptionDto] })
  mySpells!: DuelSpellOptionDto[];

  @ApiProperty({ type: [String] })
  arenaEffects!: DuelArenaEffect[];

  @ApiPropertyOptional({ nullable: true })
  arenaEffectSourceCharacterId!: string | null;

  @ApiProperty()
  seesInMagicalDarkness!: boolean;

  @ApiProperty({ type: [DuelCombatLogEntryDto] })
  combatLog!: DuelCombatLogEntryDto[];
}
