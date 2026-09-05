import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';

export class UseFeatTableActionDto {
  @ApiProperty({ example: 'healer' })
  @IsString()
  featSlug!: string;

  @ApiProperty({ example: 'healer-combat-medic' })
  @IsString()
  actionSlug!: string;
}
