import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { CategorySearchQueryDto } from '../../../common/dto/pagination.dto';

export class FeatsQueryDto extends CategorySearchQueryDto {
  @ApiPropertyOptional({
    description: 'Feat category slug (e.g. origin, general)',
    example: 'origin',
  })
  @IsOptional()
  @IsString()
  declare category?: string;
}
