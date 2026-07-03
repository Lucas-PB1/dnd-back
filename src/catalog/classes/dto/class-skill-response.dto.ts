import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class ClassSkillResponseDto {
  @ApiProperty({ example: 'athletics' })
  slug!: string;

  @ApiProperty({ example: 'Atletismo' })
  name!: string;

  @ApiPropertyOptional({ example: 2 })
  skillChoiceCount!: number | null;

  @ApiPropertyOptional()
  skillChoiceFrom!: string | null;
}
