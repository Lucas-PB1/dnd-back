import type { SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';

/** Normaliza kinds antigos `gh_heritage_*` → `heritage_*` (pós J039). */
export function normalizeHeritageChoiceKind(choiceKind: string): string {
  return choiceKind.startsWith('gh_heritage_')
    ? `heritage_${choiceKind.slice('gh_heritage_'.length)}`
    : choiceKind;
}

export function isHeritageChoiceKind(choiceKind: string): boolean {
  const normalized = normalizeHeritageChoiceKind(choiceKind);
  return normalized.startsWith('heritage_');
}

export function splitOriginChoices(choices: readonly SpeciesChoiceDto[]): {
  speciesChoices: SpeciesChoiceDto[];
  heritageChoices: SpeciesChoiceDto[];
} {
  const speciesChoices: SpeciesChoiceDto[] = [];
  const heritageChoices: SpeciesChoiceDto[] = [];

  for (const choice of choices) {
    const choiceKind = normalizeHeritageChoiceKind(choice.choiceKind);
    if (choiceKind.startsWith('heritage_')) {
      heritageChoices.push({ ...choice, choiceKind });
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
    return {
      kind: 'heritage',
      choices: input.heritageChoices.map((choice) => ({
        ...choice,
        choiceKind: normalizeHeritageChoiceKind(choice.choiceKind),
      })),
    };
  }
  if (input.speciesChoices !== undefined) {
    return { kind: 'species', choices: input.speciesChoices };
  }
  return undefined;
}
