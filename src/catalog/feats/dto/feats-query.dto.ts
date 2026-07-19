import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { PaginationQueryDto } from '../../../common/dto/pagination.dto';

export class FeatsQueryDto extends PaginationQueryDto {
  @ApiPropertyOptional({
    description:
      'Filter by name, slug, category, or prerequisite (case-insensitive)',
  })
  @IsOptional()
  @IsString()
  q?: string;
}
