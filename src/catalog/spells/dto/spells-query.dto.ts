import { ApiPropertyOptional } from '@nestjs/swagger';
import { Transform, Type } from 'class-transformer';
import {
  IsBoolean,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Max,
  Min,
} from 'class-validator';
import { SearchQueryDto } from '@common/dto/pagination.dto';

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

  @ApiPropertyOptional({
    description: 'Only spells tagged [Sangromancia] (Grim Hollow Cap. 7)',
    example: true,
  })
  @IsOptional()
  @Transform(({ value }) => value === true || value === 'true' || value === '1')
  @IsBoolean()
  sangromancy?: boolean;

  @ApiPropertyOptional({
    description:
      'summary = slug/name/level/school only (labels). Omit for full DTO.',
    enum: ['summary'],
  })
  @IsOptional()
  @IsIn(['summary'])
  fields?: 'summary';
}
