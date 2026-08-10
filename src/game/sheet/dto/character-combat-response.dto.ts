import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class EquipmentWarningResponseDto {
  @ApiProperty({ example: 'lacks_armor_training' })
  code!: string;

  @ApiProperty({ example: 'Sem treino com Cota de Malha…' })
  message!: string;

  @ApiPropertyOptional({ example: 'chain-mail' })
  itemSlug?: string;
}

export class WeaponAttackResponseDto {
  @ApiProperty({ example: 'longsword' })
  itemSlug!: string;

  @ApiProperty({ example: 'Espada Longa' })
  itemName!: string;

  @ApiProperty({ enum: ['melee', 'ranged'], example: 'melee' })
  mode!: 'melee' | 'ranged';

  @ApiProperty({ example: 5 })
  attackBonus!: number;

  @ApiProperty({ enum: ['forca', 'destreza'], example: 'forca' })
  abilitySlug!: 'forca' | 'destreza';

  @ApiProperty({ example: true })
  proficient!: boolean;

  @ApiProperty({ example: '1d10' })
  damageDice!: string;

  @ApiProperty({ example: 3 })
  damageBonus!: number;

  @ApiPropertyOptional({ example: 'Cortante' })
  damageType!: string | null;

  @ApiProperty({ example: 'corpo a corpo: FOR + PB · versátil (2 mãos)' })
  attackNote!: string;

  @ApiProperty({ example: '1d10 +3 (FOR)' })
  damageNote!: string;

  @ApiProperty({ enum: ['main', 'light_bonus', 'dual_bonus'], example: 'main' })
  role!: 'main' | 'light_bonus' | 'dual_bonus';

  @ApiProperty({ example: false })
  attackDisadvantage!: boolean;

  @ApiProperty({ example: false })
  omitsAbilityDamage!: boolean;

  @ApiProperty({ example: false })
  greatWeaponFighting!: boolean;

  @ApiProperty({ example: true })
  masteryActive!: boolean;

  @ApiPropertyOptional({ example: 'sap' })
  masterySlug!: string | null;

  @ApiPropertyOptional({ example: 'Drenar' })
  masteryName!: string | null;

  @ApiProperty({ example: false })
  nickUsesAttackAction!: boolean;

  @ApiPropertyOptional({ example: null })
  grazeOnMissDamage!: number | null;

  @ApiProperty({ example: false })
  isFirearm!: boolean;

  @ApiProperty({ example: 20 })
  critThreshold!: number;

  @ApiPropertyOptional({ example: null })
  overkillExtraDice!: string | null;

  @ApiPropertyOptional({ example: 6 })
  reloadCapacity!: number | null;

  @ApiProperty({ example: false })
  hasRecoil!: boolean;

  @ApiProperty({ example: 2, description: 'Dano da Fúria aplicado (0 se inativa)' })
  rageDamageBonus!: number;

  @ApiPropertyOptional({ example: '1d10' })
  brutalStrikeDice!: string | null;

  @ApiPropertyOptional({
    example: '1d6+2',
    description: 'Fúria Divina (Fanático) — 1º acerto/turno com Fúria ativa',
  })
  divineFuryDice!: string | null;

  @ApiProperty({
    example: true,
    description: 'Arma com Acuidade ou ataque à distância, elegível para Ataque Furtivo',
  })
  sneakAttackEligible!: boolean;

  @ApiPropertyOptional({
    example: '1d6',
    description: 'Dado de Artes Marciais do Monge aplicado neste ataque',
  })
  martialArtsDie!: string | null;

  @ApiPropertyOptional({
    example: 'weapon-charm-blade-1',
    description: 'Encanto de arma preso a esta arma',
  })
  attachedCharmSlug!: string | null;

  @ApiPropertyOptional({
    example: 'Encanto de Arma: Lâmina +1',
    description: 'Nome do encanto para exibição na ficha',
  })
  attachedCharmName!: string | null;
}
