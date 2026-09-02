import { ApiProperty } from '@nestjs/swagger';

export class AggregatedHeritageTraitDto {
  @ApiProperty({ example: 'improved-darkvision' })
  traitSlug!: string;

  @ApiProperty({ example: 'Visão no Escuro Aprimorada' })
  traitName!: string;

  @ApiProperty({ example: 2 })
  takeCount!: number;

  @ApiProperty({ example: [1, 4] })
  slotIndexes!: number[];

  @ApiProperty({ type: [String] })
  activeBenefits!: string[];
}
