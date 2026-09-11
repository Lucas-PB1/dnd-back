import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';
import { TableActionOptionsDto } from './table-action-options.dto';

/** Slugs de mesa do Caçador de Monstros (catálogo C063–C065 + economy declarada). */
export class UseMonsterHunterTableActionDto extends TableActionOptionsDto {
  @ApiProperty({ example: 'studied-response' })
  @IsString()
  @IsNotEmpty()
  actionSlug!: string;
}
