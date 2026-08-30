import { ApiPropertyOptional } from '@nestjs/swagger';
import { Transform } from 'class-transformer';
import { IsBoolean, IsIn, IsOptional } from 'class-validator';

function parseTruthy(value: unknown): boolean | undefined {
  if (value == null || value === '') return undefined;
  if (value === true || value === 'true' || value === '1' || value === 1) return true;
  if (value === false || value === 'false' || value === '0' || value === 0) return false;
  return undefined;
}

/** Mixin de query: `fields=summary` para listagens de catálogo. */
export class CatalogFieldsQueryDto {
  @ApiPropertyOptional({
    description: 'summary = payload leve (sem description). Omit = DTO completo.',
    enum: ['summary'],
  })
  @IsOptional()
  @IsIn(['summary'])
  fields?: 'summary';

  @ApiPropertyOptional({
    description:
      'Inclui entradas só de compêndio (heritages GH, antecedentes avançados). Omit/false = listagem jogável.',
  })
  @IsOptional()
  @Transform(({ value }) => parseTruthy(value))
  @IsBoolean()
  includeCatalogOnly?: boolean;
}
