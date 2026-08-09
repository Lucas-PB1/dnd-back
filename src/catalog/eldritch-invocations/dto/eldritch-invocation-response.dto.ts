import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class EldritchInvocationResponseDto {
  @ApiProperty()
  slug!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty()
  description!: string;

  @ApiProperty()
  minLevel!: number;

  @ApiPropertyOptional({ nullable: true })
  requiresPactSlug!: string | null;

  @ApiPropertyOptional({ nullable: true })
  requiresInvocationSlug!: string | null;

  @ApiProperty()
  repeatable!: boolean;

  @ApiProperty({
    enum: ['passive', 'note', 'free_cast', 'bonus', 'action', 'reaction'],
  })
  kind!: string;

  @ApiPropertyOptional({ nullable: true })
  grantedSpellSlug!: string | null;

  @ApiProperty()
  sortOrder!: number;
}
