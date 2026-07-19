import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsIn, IsOptional } from 'class-validator';
import { SearchQueryDto } from '../../../common/dto/pagination.dto';

export class LanguagesQueryDto extends SearchQueryDto {
  @ApiPropertyOptional({
    description: 'Filter rare languages (true | false)',
    enum: ['true', 'false'],
  })
  @IsOptional()
  @IsIn(['true', 'false'])
  rare?: 'true' | 'false';
}
