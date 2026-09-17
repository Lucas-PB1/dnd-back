import { ApiProperty } from '@nestjs/swagger';

export class CatalogNamedLabelDto {
  @ApiProperty({ example: 'abjuracao' })
  slug!: string;

  @ApiProperty({ example: 'Abjuração' })
  name!: string;

  @ApiProperty({ example: 1, required: false })
  sortOrder?: number;
}
