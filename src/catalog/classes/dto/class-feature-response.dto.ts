import { ApiProperty } from '@nestjs/swagger';

export class ClassFeatureResponseDto {
  @ApiProperty({ example: 'bard' })
  classSlug!: string;

  @ApiProperty({ example: 1 })
  featureLevel!: number;

  @ApiProperty({ example: 'Conjuração' })
  featureName!: string;

  @ApiProperty({ example: 'Você aprendeu a conjurar magias através da prática e dedicação.' })
  featureDescription!: string;
}
