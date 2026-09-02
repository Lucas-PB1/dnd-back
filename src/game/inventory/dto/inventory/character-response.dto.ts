import { ApiProperty } from '@nestjs/swagger';
import { CoinPurseDto } from '@game/sheet/dto/coin-purse.dto';
import { InventoryItemResponseDto } from './item-response.dto';

export class InventoryEncumbranceDto {
  @ApiProperty({ example: 12.5, description: 'Peso total carregado (kg)' })
  totalWeightKg!: number;

  @ApiProperty({
    example: 75,
    description: 'Capacidade de carga = Força × 7,5 kg',
  })
  carryingCapacityKg!: number;

  @ApiProperty({
    example: false,
    description: 'True quando totalWeightKg > carryingCapacityKg',
  })
  encumbered!: boolean;
}

export class InventoryPaymentContextDto {
  @ApiProperty({
    example: true,
    description: 'Personagem vinculado a pelo menos uma campanha',
  })
  inCampaign!: boolean;

  @ApiProperty({
    example: false,
    description: 'Viewer é DM ou assistant em alguma campanha do personagem',
  })
  viewerIsDmOrAssistant!: boolean;

  @ApiProperty({
    example: false,
    description: 'Alguma campanha permite “Não pagar”',
  })
  allowPlayerSkipPayment!: boolean;

  @ApiProperty({
    example: true,
    description: 'Cobrança se aplica (campanha + player)',
  })
  chargeApplies!: boolean;
}

export class CharacterInventoryResponseDto {
  @ApiProperty({ type: [InventoryItemResponseDto] })
  items!: InventoryItemResponseDto[];

  @ApiProperty({ type: InventoryEncumbranceDto })
  encumbrance!: InventoryEncumbranceDto;

  @ApiProperty({ type: CoinPurseDto })
  wealth!: CoinPurseDto;

  @ApiProperty({ type: InventoryPaymentContextDto })
  paymentContext!: InventoryPaymentContextDto;
}
