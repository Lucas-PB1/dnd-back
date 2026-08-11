import { ApiProperty } from '@nestjs/swagger';

/** Câmara de arma de fogo no estado da ficha. */
export class FirearmChamberDto {
  @ApiProperty({ example: 'revolver' })
  itemSlug!: string;

  @ApiProperty({ example: 4 })
  remaining!: number;

  @ApiProperty({ example: 6 })
  capacity!: number;
}
