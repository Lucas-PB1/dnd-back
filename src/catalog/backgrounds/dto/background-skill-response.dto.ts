import { ApiProperty } from '@nestjs/swagger';

export class BackgroundSkillResponseDto {
  @ApiProperty({ example: 'insight' })
  slug!: string;

  @ApiProperty({ example: 'Intuição' })
  name!: string;
}
