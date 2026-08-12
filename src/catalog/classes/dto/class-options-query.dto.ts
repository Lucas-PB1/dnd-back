import { ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsInt, IsOptional, Max, Min } from 'class-validator';
import { PaginationQueryDto } from '@common/dto/pagination.dto';

export class ClassOptionsQueryDto extends PaginationQueryDto {
  @ApiPropertyOptional({
    description: 'Nível do personagem para filtrar opções desbloqueadas (1–20)',
    example: 7,
    minimum: 1,
    maximum: 20,
  })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(20)
  level?: number;
}
