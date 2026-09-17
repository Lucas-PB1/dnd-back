import { ApiProperty } from '@nestjs/swagger';
import { CatalogNamedLabelDto } from './catalog-named-label.dto';

export class FeatCategoryResponseDto extends CatalogNamedLabelDto {
  @ApiProperty({ example: 'Talento de Origem' })
  typeLabel!: string;
}
