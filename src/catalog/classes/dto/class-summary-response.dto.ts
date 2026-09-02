import { PickType } from '@nestjs/swagger';
import { ClassResponseDto } from './class-response.dto';

export class ClassSummaryResponseDto extends PickType(ClassResponseDto, [
  'slug',
  'name',
  'editionSlug',
] as const) {}
