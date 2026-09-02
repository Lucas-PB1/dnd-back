import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class InventoryItemResponseDto {
  @ApiProperty({ example: 'longsword' })
  itemSlug!: string;

  @ApiProperty({ example: 'Espada Longa' })
  itemName!: string;

  @ApiProperty({ example: 'weapon' })
  itemType!: string;

  @ApiProperty({ example: 1 })
  quantity!: number;

  @ApiProperty({ enum: ['equipped', 'backpack'] })
  location!: 'equipped' | 'backpack';

  @ApiPropertyOptional({
    enum: ['armor', 'main_hand', 'off_hand', 'shield', 'worn', 'carried'],
  })
  equipmentSlot!: string | null;

  @ApiProperty({ example: false })
  attuned!: boolean;

  @ApiProperty({
    example: false,
    description: 'Arma vinculada ao Pacto da Lâmina (Bruxo)',
  })
  isPactWeapon!: boolean;

  @ApiProperty({
    example: false,
    description: 'True when phb_item.properties.requiresAttunement',
  })
  requiresAttunement!: boolean;

  @ApiProperty({
    example: false,
    description: 'True when phb_item.properties.cursed',
  })
  cursed!: boolean;

  @ApiProperty({
    example: false,
    description:
      'True when instance_properties.curseBroken (após Remover Maldição / Mestre)',
  })
  curseBroken!: boolean;

  @ApiProperty({
    example: false,
    description:
      'True when equipped and (no attunement required or currently attuned)',
  })
  effectsActive!: boolean;

  @ApiProperty({
    example: false,
    description:
      'True when phb_item.properties.consumable (poção/óleo/pergaminho)',
  })
  consumable!: boolean;

  @ApiProperty({
    enum: ['active', 'inactive_unequipped', 'inactive_unattuned'],
    description: 'Estado dos efeitos permanentes do item',
  })
  effectsStatus!: 'active' | 'inactive_unequipped' | 'inactive_unattuned';

  @ApiPropertyOptional({
    example: 1.5,
    description: 'Peso unitário em kg (parseado de phb_item.weight)',
  })
  weightKg!: number;

  @ApiPropertyOptional({
    example: 'weapon-charm-blade-1',
    description: 'Encanto de arma preso a este item (slug do catálogo)',
  })
  attachedCharmSlug!: string | null;

  @ApiPropertyOptional({
    example: 'Encanto de Arma: Lâmina +1',
    description: 'Nome do encanto preso (quando attachedCharmSlug está definido)',
  })
  attachedCharmName!: string | null;

  @ApiPropertyOptional({
    example: 'arma-1-2-ou-3',
    description: 'Cobertura DMG presa a esta peça (slug do catálogo)',
  })
  attachedCoverageSlug!: string | null;

  @ApiPropertyOptional({
    example: 'Arma, +1, +2 ou +3',
    description: 'Nome da cobertura presa',
  })
  attachedCoverageName!: string | null;

  @ApiPropertyOptional({
    example: 2,
    description: 'Tier +1/+2/+3 da cobertura (quando aplicável)',
  })
  attachedCoverageBonus!: number | null;

  @ApiPropertyOptional({
    example: true,
    description: 'Sintonia da cobertura anexada',
  })
  attachedCoverageAttuned!: boolean;

  @ApiPropertyOptional({
    example: true,
    description: 'True quando a cobertura anexada exige sintonia',
  })
  attachedCoverageRequiresAttunement!: boolean;

  @ApiPropertyOptional({
    example: 'bola-de-fogo',
    description: 'Magia vinculada (Arma Magificada)',
  })
  attachedCoverageSpellSlug!: string | null;

  @ApiPropertyOptional({
    example: 'bola-de-fogo',
    description: 'Magia vinculada em item único (ex.: Cajado Magificado)',
  })
  boundSpellSlug!: string | null;

  @ApiPropertyOptional({
    example: false,
    description: 'True quando phb_item.properties.kind = coverage',
  })
  isCoverage!: boolean;

  @ApiPropertyOptional({
    example: 'large-vehicle',
    nullable: true,
    description: 'phb_item.properties.kind (transporte, coverage, etc.)',
  })
  propertiesKind!: string | null;

  @ApiProperty({
    example: false,
    description: 'True quando phb_item.properties.magic = true',
  })
  isMagic!: boolean;

  @ApiPropertyOptional({
    description:
      'Estado por instância (props de artefato roladas na 1ª sintonia, senciência, etc.)',
    example: {
      artifactRandom: {
        rolledAt: '2026-08-11T12:00:00.000Z',
        minorBeneficial: [{ slug: 'ac-bonus-1', summaryPt: '+1 CA' }],
      },
      sentience: {
        alignment: 'CM',
        inteligencia: 15,
        sabedoria: 13,
        carisma: 16,
      },
    },
  })
  instanceProperties!: Record<string, unknown> | null;

  @ApiPropertyOptional({
    example: '15 PO',
    description: 'Preço de catálogo (phb_item.cost.text) para compra/venda',
  })
  costText!: string | null;

  @ApiPropertyOptional({
    example: 'mochila',
    description: 'Recipiente (bolsa/saca/…); null = raiz',
    nullable: true,
  })
  containedInItemSlug!: string | null;
}
