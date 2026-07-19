import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { PaginationQueryDto } from '../../../common/dto/pagination.dto';

export class ClassesQueryDto extends PaginationQueryDto {
  @ApiPropertyOptional({
    description: 'Filter by name, slug, tagline, or summary (case-insensitive)',
  })
  @IsOptional()
  @IsString()
  q?: string;
}
