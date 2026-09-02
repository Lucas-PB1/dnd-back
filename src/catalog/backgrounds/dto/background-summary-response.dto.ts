import { PickType } from '@nestjs/swagger';
import { BackgroundResponseDto } from './background-response.dto';

export class BackgroundSummaryResponseDto extends PickType(
  BackgroundResponseDto,
  ['slug', 'name', 'editionSlug'] as const,
) {}
