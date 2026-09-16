import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';
import { TableActionOptionsDto } from './table-action-options.dto';

export class UseItemTableActionDto extends TableActionOptionsDto {
  @ApiProperty({ example: 'pocao-de-cura' })
  @IsString()
  itemSlug!: string;

  @ApiProperty({ example: 'item-pocao-de-cura-usar' })
  @IsString()
  actionSlug!: string;
}
