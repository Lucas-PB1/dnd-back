import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { PaginationQueryDto } from '../../../common/dto/pagination.dto';

export class ArmorQueryDto extends PaginationQueryDto {
  @ApiPropertyOptional({
    description: 'Filter by name, slug, or category (case-insensitive)',
  })
  @IsOptional()
  @IsString()
  q?: string;
}
