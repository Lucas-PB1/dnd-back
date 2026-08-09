import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsIn, IsOptional, IsString } from 'class-validator';
import { CategorySearchQueryDto } from '@common/dto/pagination.dto';

export class FeatsQueryDto extends CategorySearchQueryDto {
  @ApiPropertyOptional({
    description: 'Feat category slug (e.g. origin, general)',
    example: 'origin',
  })
  @IsOptional()
  @IsString()
  declare category?: string;

  @ApiPropertyOptional({
    description: 'summary = slug/name only (labels). Omit for full DTO.',
    enum: ['summary'],
  })
  @IsOptional()
  @IsIn(['summary'])
  fields?: 'summary';
}
