import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
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
  ValidateNested,
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

export class DuelBloodStrikeDto {
  @ApiProperty({ example: 'hunting-strike' })
  @IsString()
  optionSlug!: string;

  @ApiPropertyOptional({
    description: 'Sangue da Criação (L10+): menor de dois custos',
  })
  @IsOptional()
  @IsBoolean()
  takeLowerBloodCost?: boolean;
}

export class DuelAttackDto {
  @ApiProperty({ example: 'longsword' })
  @IsString()
  itemSlug!: string;

  @ApiProperty({ enum: ['melee', 'ranged'], example: 'melee' })
  @IsIn(['melee', 'ranged'])
  mode!: 'melee' | 'ranged';

  @ApiPropertyOptional({ type: DuelBloodStrikeDto })
  @IsOptional()
  @ValidateNested()
  @Type(() => DuelBloodStrikeDto)
  bloodStrike?: DuelBloodStrikeDto;

  @ApiPropertyOptional({
    enum: ['acid', 'necrotic', 'poison'],
    description: 'Armamento de Sangue (L7+)',
  })
  @IsOptional()
  @IsIn(['acid', 'necrotic', 'poison'])
  damageTypeOverride?: 'acid' | 'necrotic' | 'poison';

  @ApiPropertyOptional({
    description: 'Explosão de Sangue (L7+) se o ataque errar',
  })
  @IsOptional()
  @IsBoolean()
  bloodExplosionOnMiss?: boolean;

  @ApiPropertyOptional({
    enum: ['push', 'sap', 'slow'],
    description: 'Mestre Tático (L9+): sobrescreve maestria com Empurrar/Drenar/Lento',
  })
  @IsOptional()
  @IsIn(['push', 'sap', 'slow'])
  masteryOverrideSlug?: 'push' | 'sap' | 'slow';

  @ApiPropertyOptional({
    description: 'Resvalar (graze) — automático via maestria quando ativa',
  })
  @IsOptional()
  @IsBoolean()
  graze?: boolean;
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

  @ApiPropertyOptional({ nullable: true })
  masterySlug?: string | null;
}

export class DuelSpellOptionDto {
  @ApiProperty()
  spellSlug!: string;

  @ApiProperty({ enum: ['known', 'prepared', 'always_prepared'] })
  listType!: string;
}

export class DuelBloodStrikeOptionDto {
  @ApiProperty()
  slug!: string;

  @ApiProperty()
  label!: string;

  @ApiProperty()
  costDice!: string;
}

export class DuelBloodStrikePanelDto {
  @ApiProperty()
  available!: boolean;

  @ApiProperty()
  remaining!: number;

  @ApiProperty()
  max!: number;

  @ApiProperty()
  saveDc!: number;

  @ApiProperty({ type: [DuelBloodStrikeOptionDto] })
  options!: DuelBloodStrikeOptionDto[];

  @ApiProperty()
  canTakeLowerCost!: boolean;

  @ApiProperty()
  canArmament!: boolean;

  @ApiProperty()
  canExplosion!: boolean;
}

export class DuelFighterPanelDto {
  @ApiProperty()
  available!: boolean;

  @ApiProperty({ description: 'Ataques por ação (inclui Nick se aplicável)' })
  attacksPerAction!: number;

  @ApiPropertyOptional({ nullable: true })
  turnAttacksRemaining!: number | null;

  @ApiProperty({ description: 'Mestre Tático (L9+)' })
  tacticalMaster!: boolean;

  @ApiProperty()
  secondWindRemaining!: number;

  @ApiProperty()
  secondWindMax!: number;

  @ApiProperty()
  actionSurgeRemaining!: number;

  @ApiProperty()
  actionSurgeMax!: number;

  @ApiProperty()
  indomitableRemaining!: number;

  @ApiProperty()
  indomitableMax!: number;
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
  @ApiProperty({
    enum: ['participant', 'spectator'],
    description:
      'participant = combate; spectator = só leitura via link do duelo',
  })
  viewerRole!: 'participant' | 'spectator';

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

  @ApiPropertyOptional({ type: DuelBloodStrikePanelDto, nullable: true })
  bloodStrike!: DuelBloodStrikePanelDto | null;

  @ApiPropertyOptional({ type: DuelFighterPanelDto, nullable: true })
  fighter!: DuelFighterPanelDto | null;

  @ApiPropertyOptional({
    nullable: true,
    description: 'Ataques restantes no turno atual',
  })
  turnAttacksRemaining!: number | null;

  @ApiProperty({ type: [String] })
  arenaEffects!: DuelArenaEffect[];

  @ApiPropertyOptional({ nullable: true })
  arenaEffectSourceCharacterId!: string | null;

  @ApiProperty()
  seesInMagicalDarkness!: boolean;

  @ApiProperty({ type: [DuelCombatLogEntryDto] })
  combatLog!: DuelCombatLogEntryDto[];
}
