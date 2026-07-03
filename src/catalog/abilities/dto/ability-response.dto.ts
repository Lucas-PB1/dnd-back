import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class AbilityResponseDto {
  @ApiProperty({ example: 'forca' })
  slug!: string;

  @ApiProperty({ example: 'Força' })
  name!: string;

  @ApiProperty({ example: 1 })
  sortOrder!: number;
}
