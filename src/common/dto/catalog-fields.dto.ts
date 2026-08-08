import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsIn, IsOptional } from 'class-validator';

/** Mixin de query: `fields=summary` para listagens de catálogo. */
export class CatalogFieldsQueryDto {
  @ApiPropertyOptional({
    description: 'summary = payload leve (sem description). Omit = DTO completo.',
    enum: ['summary'],
  })
  @IsOptional()
  @IsIn(['summary'])
  fields?: 'summary';
}
