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
}
