export class ClassResponseDto {
  slug!: string;
  name!: string;
  hitDie!: string;
  primaryAbilityLabel!: string | null;
  primaryAbilityOperator!: string | null;
  primaryAbilitySlugs!: string[];
  hpLevel1DieValue!: number | null;
  hpFixedPerLevel!: number | null;
  skillChoiceCount!: number | null;
  skillChoiceFrom!: string | null;
  sourceChapter!: number | null;
  editionSlug!: string | null;
}
