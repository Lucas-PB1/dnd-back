import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsBoolean, IsOptional, IsString } from 'class-validator';
import { TableActionOptionsDto } from './table-action-options.dto';

export class UseFeatTableActionDto extends TableActionOptionsDto {
  @ApiProperty({ example: 'healer' })
  @IsString()
  featSlug!: string;

  @ApiProperty({ example: 'healer-combat-medic' })
  @IsString()
  actionSlug!: string;

  @ApiPropertyOptional({
    example: true,
    description: 'Força ligar/desligar toggle de circunstância (snow/água/frio)',
  })
  @IsOptional()
  @IsBoolean()
  enabled?: boolean;
}
