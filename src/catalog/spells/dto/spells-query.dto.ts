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

  @ApiPropertyOptional({ description: 'Ritual spells only / exclude', example: true })
  @IsOptional()
  @Transform(({ value }) => {
    if (value === undefined || value === null || value === '') return undefined;
    return value === true || value === 'true' || value === '1';
  })
  @IsBoolean()
  ritual?: boolean;

  @ApiPropertyOptional({
    description: 'Concentration spells only / exclude',
    example: true,
  })
  @IsOptional()
  @Transform(({ value }) => {
    if (value === undefined || value === null || value === '') return undefined;
    return value === true || value === 'true' || value === '1';
  })
  @IsBoolean()
  concentration?: boolean;

  @ApiPropertyOptional({
    description: 'attack = requires attack roll; save = has saving throw',
    enum: ['attack', 'save'],
  })
  @IsOptional()
  @IsIn(['attack', 'save'])
  roll?: 'attack' | 'save';

  @ApiPropertyOptional({
    description: 'Casting time bucket',
    enum: ['action', 'bonus', 'reaction', 'minute', 'hour'],
  })
  @IsOptional()
  @IsIn(['action', 'bonus', 'reaction', 'minute', 'hour'])
  castingTime?: 'action' | 'bonus' | 'reaction' | 'minute' | 'hour';

  @ApiPropertyOptional({
    description: 'Saving throw ability slug (e.g. destreza)',
    example: 'destreza',
  })
  @IsOptional()
  @IsString()
  saveAbility?: string;

  @ApiPropertyOptional({
    description: 'Range / area bucket',
    enum: ['self', 'touch', 'short', 'medium', 'long'],
  })
  @IsOptional()
  @IsIn(['self', 'touch', 'short', 'medium', 'long'])
  rangeKind?: 'self' | 'touch' | 'short' | 'medium' | 'long';

  @ApiPropertyOptional({
    description:
      'summary = slug/name/level/school only (labels). Omit for full DTO.',
    enum: ['summary'],
  })
  @IsOptional()
  @IsIn(['summary'])
  fields?: 'summary';
}
