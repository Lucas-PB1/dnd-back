import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { CategorySearchQueryDto } from '../../../common/dto/pagination.dto';

export class ArmorQueryDto extends CategorySearchQueryDto {
  @ApiPropertyOptional({
    description: 'Armor category slug (light | medium | heavy | shield)',
    example: 'light',
  })
  @IsOptional()
  @IsString()
  declare category?: string;
}
