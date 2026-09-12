import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';
import { TableActionOptionsDto } from './table-action-options.dto';

export class UseMonsterHunterTableActionDto extends TableActionOptionsDto {
  @ApiProperty({ example: 'studied-response' })
  @IsString()
  @IsNotEmpty()
  actionSlug!: string;
}
