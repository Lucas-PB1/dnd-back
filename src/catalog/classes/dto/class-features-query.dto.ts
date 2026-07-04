import { ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsInt, IsOptional, Max, Min } from 'class-validator';
import { PaginationQueryDto } from '../../../common/dto/pagination.dto';

export class ClassFeaturesQueryDto extends PaginationQueryDto {
  @ApiPropertyOptional({
    description: 'Máximo nível de classe para filtrar features (1–20)',
    example: 5,
    minimum: 1,
    maximum: 20,
  })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(20)
  maxLevel?: number;
}
