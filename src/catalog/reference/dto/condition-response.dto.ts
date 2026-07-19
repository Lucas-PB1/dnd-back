import { ApiProperty } from '@nestjs/swagger';

export class ConditionResponseDto {
  @ApiProperty({ example: 'poisoned' })
  slug!: string;

  @ApiProperty({ example: 'Envenenado' })
  name!: string;
}
