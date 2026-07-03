import { ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsInt, IsOptional, Max, Min } from 'class-validator';
import { PaginationQueryDto } from '../../../common/dto/pagination.dto';

export class ClassSpellsQueryDto extends PaginationQueryDto {
  @ApiPropertyOptional({ description: 'Max spell circle (0–9)', minimum: 0, maximum: 9, example: 3 })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(0)
  @Max(9)
  maxLevel?: number;
}
