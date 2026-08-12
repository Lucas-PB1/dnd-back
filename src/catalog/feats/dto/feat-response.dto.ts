import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class FeatBenefitDto {
  @ApiPropertyOptional()
  name?: string;

  @ApiPropertyOptional()
  description?: string;
}

export class FeatAbilityPrerequisiteDto {
  @ApiProperty({ example: 'destreza' })
  abilitySlug!: string;

  @ApiProperty({ example: 13 })
  minimumScore!: number;
}

export class FeatOptionPrerequisiteDto {
  @ApiProperty({ example: 'elemental-adept' })
  featSlug!: string;

  @ApiProperty({ example: 'damageType' })
  optionKey!: string;

  @ApiProperty({ example: 'cold' })
  valueId!: string;
}

export class FeatResponseDto {
  @ApiProperty({ example: 'alert' })
  slug!: string;

  @ApiProperty({ example: 'Alerta' })
  name!: string;

  @ApiProperty({ example: 'origin' })
  categorySlug!: string;

  @ApiProperty({ example: 'Origem' })
  categoryName!: string;

  @ApiProperty({ example: 'Talento de Origem' })
  categoryTypeLabel!: string;

  @ApiProperty()
  repeatable!: boolean;

  @ApiPropertyOptional()
  prerequisite!: string | null;

  @ApiPropertyOptional({ example: 4 })
  minimumLevel!: number | null;

  @ApiProperty({ type: [FeatAbilityPrerequisiteDto] })
  abilityPrerequisites!: FeatAbilityPrerequisiteDto[];

  @ApiProperty()
  requiresSpellcasting!: boolean;

  @ApiPropertyOptional({ example: 'medium' })
  requiredArmorTrainingSlug!: string | null;

  @ApiProperty()
  requiresFightingStyle!: boolean;

  @ApiProperty()
  requiresWeaponMastery!: boolean;

  @ApiProperty({
    type: [String],
    example: ['blessing-of-baldur'],
    description: 'Talentos que devem constar na ficha antes deste',
  })
  requiredFeatSlugs!: string[];

  @ApiProperty({
    type: [String],
    example: ['deception'],
    description: 'Perícias que o personagem precisa ter',
  })
  requiredSkillSlugs!: string[];

  @ApiProperty({
    type: [String],
    example: ['giantkin', 'trollkin'],
    description: 'Espécies aceitas (qualquer uma)',
  })
  requiredSpeciesSlugs!: string[];

  @ApiProperty({
    type: [String],
    example: ['armas-marciais'],
    description: 'Proficiências de arma exigidas (todas)',
  })
  requiredWeaponProficiencySlugs!: string[];

  @ApiProperty({
    type: [FeatOptionPrerequisiteDto],
    description: 'Opções de talento já adquirido exigidas',
  })
  requiredFeatOptions!: FeatOptionPrerequisiteDto[];

  @ApiPropertyOptional()
  sourceChapter!: number | null;

  @ApiPropertyOptional()
  sourceChapterTitle!: string | null;

  @ApiPropertyOptional()
  editionSlug!: string | null;

  @ApiProperty({ type: [FeatBenefitDto] })
  benefits!: FeatBenefitDto[];
}
