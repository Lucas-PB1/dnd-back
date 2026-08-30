import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

/** Slugs de mesa do Caçador de Monstros (catálogo C063–C065 + economy declarada). */
export class UseMonsterHunterTableActionDto {
  @ApiProperty({ example: 'studied-response' })
  @IsString()
  @IsNotEmpty()
  actionSlug!: string;
}
