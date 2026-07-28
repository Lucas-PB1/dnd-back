import { ApiProperty } from '@nestjs/swagger';

export class FightingStyleResponseDto {
  @ApiProperty({ example: 'dueling' })
  slug!: string;

  @ApiProperty({ example: 'Duelismo' })
  name!: string;

  @ApiProperty({
    example:
      'Quando você estiver empunhando uma arma corpo a corpo em uma mão…',
  })
  description!: string;
}
