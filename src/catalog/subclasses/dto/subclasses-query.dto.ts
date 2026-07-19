import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { SearchQueryDto } from '../../../common/dto/pagination.dto';

export class SubclassesQueryDto extends SearchQueryDto {
  @ApiPropertyOptional({
    description: 'Parent class slug (e.g. fighter)',
    example: 'fighter',
  })
  @IsOptional()
  @IsString()
  class?: string;
}
