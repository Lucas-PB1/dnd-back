import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { PaginationQueryDto } from '../../../common/dto/pagination.dto';

export class WeaponsQueryDto extends PaginationQueryDto {
  @ApiPropertyOptional({
    description:
      'Filter by name, slug, category, damage type (case-insensitive)',
  })
  @IsOptional()
  @IsString()
  q?: string;
}
