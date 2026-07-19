import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class ClassResponseDto {
  @ApiProperty({ example: 'fighter' })
  slug!: string;

  @ApiProperty({ example: 'Guerreiro' })
  name!: string;

  @ApiPropertyOptional({ example: 'Mestre de armas e armaduras' })
  tagline!: string | null;

  @ApiPropertyOptional({ example: 'Domine todas as armas e armaduras.' })
  summary!: string | null;

  @ApiPropertyOptional({
    description: 'Texto introdutório completo da classe (PHB)',
  })
  description!: string | null;

  @ApiProperty({ example: 'D10' })
  hitDie!: string;

  @ApiPropertyOptional({ example: 'Força ou Destreza' })
  primaryAbilityLabel!: string | null;

  @ApiPropertyOptional({ example: 'or' })
  primaryAbilityOperator!: string | null;

  @ApiPropertyOptional({ type: [String], example: ['forca', 'destreza'] })
  primaryAbilitySlugs!: string[];

  @ApiPropertyOptional()
  hpLevel1DieValue!: number | null;

  @ApiPropertyOptional()
  hpFixedPerLevel!: number | null;

  @ApiPropertyOptional()
  skillChoiceCount!: number | null;

  @ApiPropertyOptional()
  skillChoiceFrom!: string | null;

  @ApiPropertyOptional()
  sourceChapter!: number | null;

  @ApiPropertyOptional()
  editionSlug!: string | null;

  @ApiProperty({ type: [String], example: ['forca', 'constituicao'] })
  savingThrowSlugs!: string[];

  @ApiProperty({ type: [String], example: ['Força', 'Constituição'] })
  savingThrowNames!: string[];

  @ApiProperty({ type: [String], example: ['light', 'medium', 'shield'] })
  armorTrainingSlugs!: string[];

  @ApiProperty({ type: [String], example: ['Leve', 'Média', 'Escudo'] })
  armorTrainingNames!: string[];

  @ApiProperty({ type: [String], example: ['armas-simples', 'armas-marciais'] })
  weaponProficiencySlugs!: string[];

  @ApiProperty({ type: [String], example: ['Armas simples', 'Armas marciais'] })
  weaponProficiencyNames!: string[];
}
