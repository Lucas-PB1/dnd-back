import { ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsInt, IsOptional, IsString, Max, Min } from 'class-validator';
import { SearchQueryDto } from '../../../common/dto/pagination.dto';

export class SpellsQueryDto extends SearchQueryDto {
  @ApiPropertyOptional({
    description: 'Spell circle (0 = cantrip, 1–9)',
    minimum: 0,
    maximum: 9,
  })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(0)
  @Max(9)
  level?: number;

  @ApiPropertyOptional({
    description: 'School slug (e.g. evocacao)',
    example: 'evocacao',
  })
  @IsOptional()
  @IsString()
  school?: string;
}
