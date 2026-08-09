import { ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsInt, IsOptional, Max, Min } from 'class-validator';

export class EldritchInvocationsQueryDto {
  @ApiPropertyOptional({ description: 'Filtrar invocações com minLevel ≤ este nível' })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(20)
  maxMinLevel?: number;
}
