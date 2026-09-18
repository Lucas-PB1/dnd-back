import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
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
import { CombatAttackFlagsDto } from '@game/combat/dto/combat-attack-flags.dto';

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

/** Table-action tipada no skirmish (economy genérica; ex. second-wind, action-surge). */
export class SkirmishTableActionDto {
  @ApiProperty({ example: 'second-wind' })
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  actionSlug!: string;
}

/** Declaração de reação do PC antes do turno automático da criatura. */
export class EndSkirmishTurnDto {
  @ApiPropertyOptional({
    enum: ['shield', 'uncanny_dodge', 'parry'],
    description:
      'Reação no próximo ataque que acertar você: Escudo Arcano (+5 CA), Esquiva Sobrenatural (metade) ou Aparar (dado de superioridade + FOR/DES). Use ao resolver o turno da criatura (2º end-turn).',
  })
  @IsOptional()
  @IsIn(['shield', 'uncanny_dodge', 'parry'])
  defenderReaction?: 'shield' | 'uncanny_dodge' | 'parry';
}

/** Reação do PC no turno da criatura (ex.: ataque de oportunidade). */
export class SkirmishReactDto {
  @ApiProperty({
    enum: ['opportunity_attack'],
    example: 'opportunity_attack',
  })
  @IsIn(['opportunity_attack'])
  reactionSlug!: 'opportunity_attack';

  @ApiPropertyOptional({
    description: 'Arma equipada para a OA (default: primeira disponível)',
  })
  @IsOptional()
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  itemSlug?: string;

  @ApiPropertyOptional({ enum: ['melee', 'ranged'], default: 'melee' })
  @IsOptional()
  @IsIn(['melee', 'ranged'])
  mode?: 'melee' | 'ranged';
}

export class ResolveSkirmishAttackDto extends CombatAttackFlagsDto {
  @ApiProperty()
  @IsUUID()
  attackerCombatantId!: string;

  @ApiProperty()
  @IsUUID()
  targetCombatantId!: string;

  @ApiPropertyOptional({
    example: 'trip-attack',
    description:
      'Manobra Battle Master no acerto (gasta Dado de Superioridade): trip-attack, menacing-attack, pushing-attack…',
  })
  @IsOptional()
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  battleMasterManeuverSlug?: string;
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

  @ApiPropertyOptional({
    example: 'heightened-spell',
    description:
      'Metamagia tipada de combate (heightened-spell | seeking-spell); gasta Pontos de Feitiçaria',
  })
  @IsOptional()
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  metamagicSlug?: string;

  @ApiPropertyOptional({
    example: 'varinhaMisseisCharges',
    description:
      'Cast via carga de item ativo (ex. Varinha de Mísseis Mágicos); gasta o resource do item',
  })
  @IsOptional()
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  itemCastResourceSlug?: string;

  @ApiPropertyOptional({
    example: 2,
    description: 'Cargas gastas no cast de item (padrão 1 no motor de ficha)',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(20)
  itemCastSpendAmount?: number;

  @ApiPropertyOptional({
    example: 'anel-de-invisibilidade',
    description:
      'Cast gratuito de item ativo (sem pool de cargas; economy com spell_slug)',
  })
  @IsOptional()
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  itemCastItemSlug?: string;

  @ApiPropertyOptional({
    example: 'terra',
    description: 'Variante de espírito (Invocar Fera: ar | terra | agua)',
  })
  @IsOptional()
  @IsString()
  @MinLength(1)
  @MaxLength(60)
  spiritVariantKey?: string;
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

  @ApiProperty({
    description:
      'Turno da criatura pausado: use POST /react (OA) e depois end-turn de novo',
  })
  awaitingActorResolution!: boolean;

  @ApiProperty({
    description: 'PC pode declarar ataque de oportunidade agora',
  })
  canOpportunityAttack!: boolean;

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
