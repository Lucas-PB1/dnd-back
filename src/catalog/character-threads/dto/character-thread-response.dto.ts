import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CharacterThreadGoalDto {
  @ApiProperty({ example: 1 })
  sortOrder!: number;

  @ApiProperty()
  text!: string;
}

export class CharacterThreadBenefitDto {
  @ApiProperty({ example: 'cunning' })
  benefitKey!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty()
  description!: string;

  @ApiPropertyOptional({
    nullable: true,
    description: 'Se preenchido, escolher exatamente um benefício deste grupo',
  })
  choiceGroup!: string | null;

  @ApiProperty()
  sortOrder!: number;
}

export class CharacterThreadMilestoneDto {
  @ApiProperty()
  id!: number;

  @ApiProperty({ enum: ['least', 'lesser', 'greater', 'superior'] })
  rank!: string;

  @ApiProperty()
  sortOrder!: number;

  @ApiProperty({ type: [CharacterThreadBenefitDto] })
  benefits!: CharacterThreadBenefitDto[];
}

export class CharacterThreadSummaryResponseDto {
  @ApiProperty({ example: 'bloodsworn' })
  slug!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty()
  editionSlug!: string;

  @ApiProperty()
  summary!: string;

  @ApiProperty()
  sortOrder!: number;
}

export class CharacterThreadResponseDto extends CharacterThreadSummaryResponseDto {
  @ApiPropertyOptional({ nullable: true })
  specialRulesText!: string | null;

  @ApiProperty({ type: [CharacterThreadGoalDto] })
  goals!: CharacterThreadGoalDto[];

  @ApiProperty({ type: [CharacterThreadMilestoneDto] })
  milestones!: CharacterThreadMilestoneDto[];
}
