import { ApiProperty } from '@nestjs/swagger';

export class FirearmChamberDto {
  @ApiProperty({ example: 'revolver' })
  itemSlug!: string;

  @ApiProperty({ example: 4 })
  remaining!: number;

  @ApiProperty({ example: 6 })
  capacity!: number;
}
