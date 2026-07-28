import { ApiProperty } from '@nestjs/swagger';

export class BackgroundLanguageResponseDto {
  @ApiProperty({ example: 'common' })
  slug!: string;

  @ApiProperty({ example: 'Comum' })
  name!: string;

  @ApiProperty({ example: false })
  isRare!: boolean;
}
