import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class ItemSummaryResponseDto {
  @ApiProperty({ example: 'longsword' })
  slug!: string;

  @ApiProperty({ example: 'Espada Longa' })
  name!: string;

  @ApiProperty({ example: 'weapon' })
  itemType!: string;

  @ApiPropertyOptional({ example: '15 PO', nullable: true })
  costText!: string | null;

  @ApiPropertyOptional({ example: '1,5 kg', nullable: true })
  weight!: string | null;

  @ApiPropertyOptional({
    description: 'properties.kind (service, mount, coverage, …)',
    nullable: true,
  })
  kind!: string | null;

  @ApiPropertyOptional({ example: false })
  consumable!: boolean;

  @ApiPropertyOptional({ example: false })
  magic!: boolean;

  @ApiPropertyOptional({
    example: '/catalog/mounts/camelo.png',
    nullable: true,
  })
  imageUrl!: string | null;
}