import { PickType } from '@nestjs/swagger';
import { SpeciesResponseDto } from './species-response.dto';

export class SpeciesSummaryResponseDto extends PickType(SpeciesResponseDto, [
  'slug',
  'name',
  'editionSlug',
] as const) {}
