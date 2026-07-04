import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { PaginationQueryDto } from '../../../common/dto/pagination.dto';

export class ItemsQueryDto extends PaginationQueryDto {
  @ApiPropertyOptional({ description: 'Filter by name or slug (case-insensitive)' })
  @IsOptional()
  @IsString()
  q?: string;

  @ApiPropertyOptional({ example: 'weapon', description: 'Filter by item_type' })
  @IsOptional()
  @IsString()
  itemType?: string;
}
