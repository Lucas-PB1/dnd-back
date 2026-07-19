import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { PaginationQueryDto } from '../../../common/dto/pagination.dto';

export class SpellsQueryDto extends PaginationQueryDto {
  @ApiPropertyOptional({
    description: 'Filter by name, slug, school, or level label (case-insensitive)',
  })
  @IsOptional()
  @IsString()
  q?: string;
}
