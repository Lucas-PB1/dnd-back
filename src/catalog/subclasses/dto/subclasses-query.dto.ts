import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { PaginationQueryDto } from '../../../common/dto/pagination.dto';

export class SubclassesQueryDto extends PaginationQueryDto {
  @ApiPropertyOptional({
    description: 'Filter by name, slug, class, or summary (case-insensitive)',
  })
  @IsOptional()
  @IsString()
  q?: string;

  @ApiPropertyOptional({
    description: 'Parent class slug (e.g. fighter)',
    example: 'fighter',
  })
  @IsOptional()
  @IsString()
  class?: string;
}
