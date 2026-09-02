import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class EncounterCombatantDto {
  @ApiProperty()
  id!: string;

  @ApiProperty({ enum: ['pc', 'actor'] })
  kind!: 'pc' | 'actor';

  @ApiPropertyOptional({ nullable: true })
  characterId!: string | null;

  @ApiPropertyOptional({ nullable: true })
  actorId!: string | null;

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

  @ApiPropertyOptional({
    nullable: true,
    description: 'actorId se o turno atual for um actor',
  })
  currentActorId!: string | null;

  @ApiProperty({ type: [EncounterCombatantDto] })
  combatants!: EncounterCombatantDto[];
}
