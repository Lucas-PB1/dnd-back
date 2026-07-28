import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { PaginationQueryDto } from '../../../common/dto/pagination.dto';

export class FightingStylesQueryDto extends PaginationQueryDto {
  @ApiPropertyOptional({
    description: 'Filter by class slug (e.g. fighter, paladin, ranger)',
    example: 'fighter',
  })
  @IsOptional()
  @IsString()
  class?: string;
}
