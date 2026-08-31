import type { SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';

const LEGACY_HERITAGE_CHOICE_PREFIXES = ['heritage_', 'gh_heritage_'] as const;

export function isHeritageChoiceKind(choiceKind: string): boolean {
  return LEGACY_HERITAGE_CHOICE_PREFIXES.some((prefix) =>
    choiceKind.startsWith(prefix),
  );
}

export function splitOriginChoices(choices: readonly SpeciesChoiceDto[]): {
  speciesChoices: SpeciesChoiceDto[];
  heritageChoices: SpeciesChoiceDto[];
} {
  const speciesChoices: SpeciesChoiceDto[] = [];
  const heritageChoices: SpeciesChoiceDto[] = [];

  for (const choice of choices) {
    if (isHeritageChoiceKind(choice.choiceKind)) {
      heritageChoices.push(choice);
    } else {
      speciesChoices.push(choice);
    }
  }

  return { speciesChoices, heritageChoices };
}

export function resolveOriginChoicesForSync(input: {
  speciesChoices?: SpeciesChoiceDto[];
  heritageChoices?: SpeciesChoiceDto[];
}):
  | { kind: 'heritage'; choices: SpeciesChoiceDto[] }
  | { kind: 'species'; choices: SpeciesChoiceDto[] }
  | undefined {
  if (input.heritageChoices !== undefined) {
    return { kind: 'heritage', choices: input.heritageChoices };
  }
  if (input.speciesChoices !== undefined) {
    return { kind: 'species', choices: input.speciesChoices };
  }
  return undefined;
}
