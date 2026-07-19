import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { SearchQueryDto } from '../../../common/dto/pagination.dto';

export class ItemsQueryDto extends SearchQueryDto {
  @ApiPropertyOptional({
    example: 'weapon',
    description:
      'Filter by item_type. Comma-separated for multiple (e.g. gear,tool,focus,other)',
  })
  @IsOptional()
  @IsString()
  itemType?: string;
}
