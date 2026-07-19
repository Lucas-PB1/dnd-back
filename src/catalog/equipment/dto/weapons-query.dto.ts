import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';
import { CategorySearchQueryDto } from '../../../common/dto/pagination.dto';

export class WeaponsQueryDto extends CategorySearchQueryDto {
  @ApiPropertyOptional({
    description: 'Weapon category (simple | martial)',
    example: 'simple',
  })
  @IsOptional()
  @IsString()
  declare category?: string;
}
