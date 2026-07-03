import { ApiProperty } from '@nestjs/swagger';

export class AbilityGenerationMethodResponseDto {
  @ApiProperty({ example: 'standard-array' })
  slug!: string;

  @ApiProperty({ example: 'Conjunto Padrão' })
  name!: string;

  @ApiProperty()
  description!: string;
}
