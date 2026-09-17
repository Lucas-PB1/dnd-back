import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsArray,
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

export class CreateSkirmishDto {
  @ApiProperty()
  @IsUUID()
  characterId!: string;

  @ApiProperty({ example: 'goblin' })
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  templateSlug!: string;
}

/** Declaração de reação do PC antes do turno automático da criatura. */
export class EndSkirmishTurnDto {
  @ApiPropertyOptional({
    enum: ['shield', 'uncanny_dodge'],
    description:
      'Reação no próximo ataque que acertar você: Escudo Arcano (+5 CA) ou Esquiva Sobrenatural (metade do dano)',
  })
  @IsOptional()
  @IsIn(['shield', 'uncanny_dodge'])
  defenderReaction?: 'shield' | 'uncanny_dodge';
}

export class ResolveSkirmishAttackDto {
  @ApiProperty()
  @IsUUID()
  attackerCombatantId!: string;

  @ApiProperty()
  @IsUUID()
  targetCombatantId!: string;

  @ApiPropertyOptional({ enum: ['normal', 'advantage', 'disadvantage'] })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: 'normal' | 'advantage' | 'disadvantage';

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  itemSlug?: string;

  @ApiPropertyOptional({ enum: ['melee', 'ranged'] })
  @IsOptional()
  @IsIn(['melee', 'ranged'])
  mode?: 'melee' | 'ranged';

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  spentInspiration?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  sneakAttack?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  divineSmite?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(5)
  smiteSlotLevel?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  smiteVsUndeadOrFiend?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  huntersMark?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  colossusSlayer?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  divineStrike?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  graze?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  steadyAim?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  strokeOfLuck?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  assassinate?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  brutalStrike?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  cunningStrikeEffects?: string[];
}

export class CastSkirmishSpellDto {
  @ApiProperty({ example: 'raio-de-fogo' })
  @IsString()
  @MinLength(1)
  spellSlug!: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(9)
  slotLevel?: number;
}

export class PatchSkirmishConditionDto {
  @ApiProperty({ enum: ['add', 'remove'] })
  @IsIn(['add', 'remove'])
  action!: 'add' | 'remove';

  @ApiProperty({ enum: ['self', 'opponent'] })
  @IsIn(['self', 'opponent'])
  target!: 'self' | 'opponent';

  @ApiProperty({ example: 'poisoned' })
  @IsString()
  @MinLength(1)
  condition!: string;
}

export class AppendSkirmishLogDto {
  @ApiProperty({ example: 'Arma Sagrada ativada' })
  @IsString()
  @MinLength(1)
  @MaxLength(500)
  text!: string;
}

export class SkirmishCombatantDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({ enum: ['pc', 'actor'] })
  kind!: 'pc' | 'actor';

  @ApiPropertyOptional({ nullable: true })
  characterId!: string | null;

  @ApiPropertyOptional({ nullable: true })
  actorId!: string | null;

  @ApiProperty()
  displayName!: string;

  @ApiPropertyOptional({ nullable: true })
  initiativeTotal!: number | null;

  @ApiPropertyOptional({ nullable: true })
  initiativeModifier!: number | null;

  @ApiProperty()
  sortOrder!: number;

  @ApiProperty()
  isActive!: boolean;

  @ApiProperty()
  isCurrentTurn!: boolean;

  @ApiPropertyOptional({ nullable: true })
  armorClass!: number | null;

  @ApiPropertyOptional({ nullable: true })
  hpCurrent!: number | null;

  @ApiPropertyOptional({ nullable: true })
  hpMax!: number | null;

  @ApiProperty({ type: [String] })
  conditions!: string[];
}

export class SkirmishWeaponOptionDto {
  @ApiProperty()
  itemSlug!: string;

  @ApiProperty({ enum: ['melee', 'ranged'] })
  mode!: 'melee' | 'ranged';
}

export class SkirmishLogEntryDto {
  @ApiProperty()
  at!: string;

  @ApiProperty()
  text!: string;
}

export class SkirmishSummaryDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({ enum: ['active', 'finished'] })
  status!: 'active' | 'finished';

  @ApiProperty()
  characterId!: string;

  @ApiProperty()
  characterName!: string;

  @ApiPropertyOptional({ nullable: true })
  opponentName!: string | null;

  @ApiProperty()
  round!: number;

  @ApiPropertyOptional({ enum: ['pc', 'actor'], nullable: true })
  winnerKind!: 'pc' | 'actor' | null;

  @ApiProperty()
  createdAt!: string;

  @ApiProperty()
  updatedAt!: string;
}

export class SkirmishSpellOptionDto {
  @ApiProperty()
  spellSlug!: string;

  @ApiProperty()
  listType!: string;
}

export class SkirmishFighterPanelDto {
  @ApiProperty()
  available!: boolean;

  @ApiProperty()
  attacksPerAction!: number;

  @ApiPropertyOptional({ nullable: true })
  turnAttacksRemaining!: number | null;

  @ApiProperty()
  secondWindRemaining!: number;

  @ApiProperty()
  secondWindMax!: number;

  @ApiProperty()
  actionSurgeRemaining!: number;

  @ApiProperty()
  actionSurgeMax!: number;
}

export class SkirmishDetailDto extends SkirmishSummaryDto {
  @ApiProperty({ type: [SkirmishCombatantDto] })
  combatants!: SkirmishCombatantDto[];

  @ApiPropertyOptional({ nullable: true })
  currentCombatantId!: string | null;

  @ApiProperty()
  myTurn!: boolean;

  @ApiPropertyOptional({ nullable: true })
  turnAttacksRemaining!: number | null;

  @ApiProperty({ type: [SkirmishWeaponOptionDto] })
  myWeapons!: SkirmishWeaponOptionDto[];

  @ApiProperty({ type: [SkirmishSpellOptionDto] })
  mySpells!: SkirmishSpellOptionDto[];

  @ApiPropertyOptional({ type: SkirmishFighterPanelDto, nullable: true })
  fighter!: SkirmishFighterPanelDto | null;

  @ApiProperty({ type: [String], default: [] })
  arenaEffects!: string[];

  @ApiProperty({
    description: 'PC ainda tem reação disponível nesta rodada',
  })
  pcReactionAvailable!: boolean;

  @ApiProperty({ type: [SkirmishLogEntryDto] })
  combatLog!: SkirmishLogEntryDto[];
}

export class SkirmishAttackResultDto {
  @ApiProperty({ type: SkirmishDetailDto })
  skirmish!: SkirmishDetailDto;

  @ApiProperty()
  hit!: boolean;

  @ApiProperty()
  critical!: boolean;

  @ApiProperty()
  attackTotal!: number;

  @ApiProperty()
  attackExpression!: string;

  @ApiProperty({ type: [Number] })
  attackRolls!: number[];

  @ApiProperty()
  targetAc!: number;

  @ApiPropertyOptional({ nullable: true })
  damageTotal!: number | null;

  @ApiPropertyOptional({ nullable: true })
  damageExpression!: string | null;

  @ApiProperty({ type: [Number] })
  damageRolls!: number[];

  @ApiPropertyOptional({ nullable: true })
  note!: string | null;

  @ApiProperty()
  attackerCombatantId!: string;

  @ApiProperty()
  targetCombatantId!: string;
}
