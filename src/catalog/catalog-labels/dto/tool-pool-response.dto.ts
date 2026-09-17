import { ApiProperty } from '@nestjs/swagger';
import { CatalogNamedLabelDto } from './catalog-named-label.dto';

export class ToolPoolResponseDto {
  @ApiProperty({ example: 'instrument', enum: ['instrument', 'gaming', 'artisan'] })
  pool!: 'instrument' | 'gaming' | 'artisan';

  @ApiProperty({ type: [CatalogNamedLabelDto] })
  items!: CatalogNamedLabelDto[];
}
