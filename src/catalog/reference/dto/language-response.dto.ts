import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class LanguageResponseDto {
  @ApiProperty({ example: 'common' })
  slug!: string;

  @ApiProperty({ example: 'Comum' })
  name!: string;

  @ApiPropertyOptional()
  script!: string | null;

  @ApiPropertyOptional()
  typicalSpeakers!: string | null;

  @ApiProperty()
  isRare!: boolean;
}
