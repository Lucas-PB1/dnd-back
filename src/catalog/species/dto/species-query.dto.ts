import { IntersectionType } from '@nestjs/swagger';
import { CatalogFieldsQueryDto } from '@common/dto/catalog-fields.dto';
import { SearchQueryDto } from '@common/dto/pagination.dto';

export class SpeciesQueryDto extends IntersectionType(
  SearchQueryDto,
  CatalogFieldsQueryDto,
) {}
