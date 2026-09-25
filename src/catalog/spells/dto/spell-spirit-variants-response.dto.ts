import { ApiProperty } from '@nestjs/swagger';

export class SpellSpiritVariantDto {
  @ApiProperty({ example: 'terra' })
  variantKey!: string;

  @ApiProperty({ example: 'Terra' })
  label!: string;

  @ApiProperty({ example: 'espirito-bestial-terra' })
  templateSlug!: string;

  @ApiProperty({
    example: 1,
    description: 'Custo no orçamento do cast (Animar Objetos: 1/2/3)',
  })
  budgetCost!: number;
}

export class SpellSpiritVariantsResponseDto {
  @ApiProperty({ example: 'invocar-fera' })
  spellSlug!: string;

  @ApiProperty({ type: [SpellSpiritVariantDto] })
  variants!: SpellSpiritVariantDto[];
}
