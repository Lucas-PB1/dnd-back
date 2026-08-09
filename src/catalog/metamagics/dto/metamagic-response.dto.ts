import { ApiProperty } from '@nestjs/swagger';

export class MetamagicResponseDto {
  @ApiProperty()
  slug!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty()
  description!: string;

  @ApiProperty({ description: 'Custo em Pontos de Feitiçaria (1 ou 2)' })
  cost!: number;

  @ApiProperty()
  stacksWithOther!: boolean;

  @ApiProperty()
  sortOrder!: number;
}
