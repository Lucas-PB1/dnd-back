import { CharacterFeatDto } from '@game/sheet/dto/character-sheet.dto';
import {
  readEldritchInvocationOriginFeatBindings,
  type ClassOptionLike,
} from '@game/combat/domain/warlock';
import { nextFeatInstanceIndex } from '../validation/feats/character-feat';

/**
 * Materializa talentos de Origem de Lições dos Primeiros em characterFeats.
 * Não remove talentos — use `syncLessonsOriginCharacterFeats` na atualização.
 */
export function resolveLessonsOriginCharacterFeats(
  classOptions: readonly ClassOptionLike[] | null | undefined,
  provided: CharacterFeatDto[],
): CharacterFeatDto[] {
  const bindings = readEldritchInvocationOriginFeatBindings(classOptions);
  if (bindings.length === 0) return provided;

  const feats = [...provided];
  for (const binding of bindings) {
    if (feats.some((feat) => feat.featSlug === binding.featSlug)) continue;
    feats.push({
      featSlug: binding.featSlug,
      instanceIndex: nextFeatInstanceIndex(feats, binding.featSlug),
    });
  }
  return feats;
}

/**
 * Sincroniza characterFeats ao trocar picks de Lições dos Primeiros.
 * Remove talentos que só existiam por picks antigos (não protegidos).
 */
export function syncLessonsOriginCharacterFeats(input: {
  previousClassOptions: readonly ClassOptionLike[] | null | undefined;
  nextClassOptions: readonly ClassOptionLike[] | null | undefined;
  characterFeats: CharacterFeatDto[];
  /** Slugs que não devem ser removidos (antecedente, humano, etc.). */
  protectedFeatSlugs: ReadonlySet<string>;
}): CharacterFeatDto[] {
  const previous = new Set(
    readEldritchInvocationOriginFeatBindings(input.previousClassOptions).map(
      (binding) => binding.featSlug,
    ),
  );
  const next = new Set(
    readEldritchInvocationOriginFeatBindings(input.nextClassOptions).map(
      (binding) => binding.featSlug,
    ),
  );

  let feats = input.characterFeats.filter((feat) => {
    if (!previous.has(feat.featSlug)) return true;
    if (next.has(feat.featSlug)) return true;
    if (input.protectedFeatSlugs.has(feat.featSlug)) return true;
    return false;
  });

  for (const featSlug of next) {
    if (feats.some((feat) => feat.featSlug === featSlug)) continue;
    feats = [
      ...feats,
      {
        featSlug,
        instanceIndex: nextFeatInstanceIndex(feats, featSlug),
      },
    ];
  }

  return feats;
}
