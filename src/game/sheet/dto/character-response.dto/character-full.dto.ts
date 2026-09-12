import { ApiProperty, ApiPropertyOptional, PickType } from '@nestjs/swagger';
import { AbilityScoresDto } from '../ability-scores.dto';
import { CharacterCampaignRefDto } from '../character-campaign-ref.dto';
import { CoinPurseDto } from '../coin-purse.dto';
import {
  EquipmentWarningResponseDto,
  WeaponAttackResponseDto,
} from '../character-combat-response.dto';
import { CharacterThreadBundleDto } from '../character-thread.dto';
import { CharacterIdentityResponseDto } from './character-identity.dto';

export class CharacterResponseDto extends CharacterIdentityResponseDto {
  @ApiProperty({
    example: { forca: 2, destreza: 1, constituicao: 0, inteligencia: 0, sabedoria: 1, carisma: -1 },
    description: 'Modificadores derivados dos abilityScores',
  })
  abilityModifiers!: AbilityScoresDto;

  @ApiProperty({
    example: 13,
    description: '10 + mod Sab + PB se proficiente em Percepção',
  })
  passivePerception!: number;

  @ApiProperty({
    example: 12,
    description: 'CA considerando armadura e escudo equipados no inventário',
  })
  armorClass!: number;

  @ApiProperty({
    example: 'Armadura de Couro + Escudo',
    description: 'Descrição legível da composição da CA',
  })
  armorClassNote!: string;

  @ApiProperty({
    example: 2,
    description:
      'Soma tipada de ac_bonus de talentos (sticky/gate — aplicar na UI quando toggle ligado)',
  })
  featAcBonus!: number;

  @ApiProperty({
    type: 'array',
    items: {
      type: 'object',
      properties: {
        featSlug: { type: 'string', example: 'defensive-duelist' },
        bonus: { type: 'number', example: 6 },
      },
    },
    description: 'Quais talentos compõem featAcBonus (para a UI mostrar o nome)',
  })
  featAcBonusSources!: { featSlug: string; bonus: number }[];

  @ApiProperty({
    description: 'Flags de efeitos de talento para UI de roll/cast',
  })
  featEffectFlags!: {
    inspirationRefundOnFail: boolean;
    damageDieFloor: boolean;
    damageDieFlip: boolean;
    damageDieExplode: boolean;
    improveCritical: boolean;
    slotElevate: boolean;
    slotReduce: boolean;
    wieldTwoHandedOneHand: boolean;
    versatileOneHandFullDamage: boolean;
  };

  @ApiProperty({ type: [WeaponAttackResponseDto] })
  weaponAttacks!: WeaponAttackResponseDto[];

  @ApiPropertyOptional({
    example: 'sabedoria',
    description: 'Atributo de conjuração da classe (phb_class_spellcasting)',
  })
  spellcastingAbilitySlug!: string | null;

  @ApiPropertyOptional({
    example: 14,
    description: 'CD de magia: 8 + PB + mod do atributo de conjuração',
  })
  spellSaveDc!: number | null;

  @ApiPropertyOptional({
    example: 6,
    description: 'Bônus de ataque mágico: PB + mod do atributo de conjuração',
  })
  spellAttackBonus!: number | null;

  @ApiProperty({ type: [EquipmentWarningResponseDto] })
  equipmentWarnings!: EquipmentWarningResponseDto[];

  @ApiProperty({
    example: false,
    description: 'True se armadura/escudo sem treino impede conjuração',
  })
  cannotCastSpellsInArmor!: boolean;

  @ApiProperty({
    example: 0,
    description: 'Penalidade de deslocamento em metros (Força < strength_req)',
    enum: [0, 3],
  })
  speedPenaltyMeters!: 0 | 3;

  @ApiProperty({
    example: 0,
    description:
      'Bônus de deslocamento em metros (itens + Movimento Rápido + speed_bonus de feats)',
  })
  itemSpeedBonusMeters!: number;

  @ApiProperty({
    type: [String],
    example: ['Sentido de Perigo: Vantagem em salvaguardas de Destreza'],
    description: 'Notas de combate de classe (Bárbaro, Guerreiro etc.)',
  })
  classCombatNotes!: string[];

  @ApiProperty({
    example: 2,
    description: 'Ataques por Ação Atacar (Ataque Extra do Guerreiro)',
  })
  attacksPerAction!: number;

  @ApiProperty({
    example: 3,
    description:
      'Bônus de salvaguarda de auras/features de classe (ex.: Aura de Proteção). 0 se não houver. Front não recalcula.',
  })
  savingThrowAuraBonus!: number;

  @ApiProperty({ type: [CharacterCampaignRefDto] })
  campaigns!: CharacterCampaignRefDto[];

  @ApiProperty({ type: CoinPurseDto, description: 'Saldo das 5 moedas D&D' })
  coins!: CoinPurseDto;

  @ApiPropertyOptional({
    type: CharacterThreadBundleDto,
    description: 'Character Thread ativo + histórico (Northlands)',
  })
  thread!: CharacterThreadBundleDto | null;
}

export class CharacterSummaryResponseDto extends PickType(CharacterResponseDto, [
  'id',
  'name',
  'level',
  'classSlug',
  'speciesSlug',
  'heritageSlug',
  'backgroundSlug',
  'subclassSlug',
  'portraitUrl',
  'createdAt',
  'updatedAt',
  'campaigns',
] as const) {
  @ApiProperty({ example: 'Guerreiro' })
  className!: string;

  @ApiProperty({ example: 'Anão' })
  speciesName!: string;

  @ApiPropertyOptional({ example: 'Campeão', nullable: true })
  subclassName!: string | null;
}
