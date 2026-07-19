import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { SearchQueryDto } from '../../../common/dto/pagination.dto';

export class SkillsQueryDto extends SearchQueryDto {
  @ApiPropertyOptional({
    description: 'Ability slug (e.g. strength, dexterity)',
    example: 'dexterity',
  })
  @IsOptional()
  @IsString()
  ability?: string;
}
