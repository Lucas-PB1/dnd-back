import type { CatalogEffect } from '../domain/catalog-effect';
import {
  filterEffectsByOptionGates,
  withDefaultSpeciesChoices,
  type EffectChoiceRef,
} from '../domain/queries/option-gates';
import type { LoadEffectCatalog } from './load-effect-catalog';
import type { EffectKind } from '../domain/catalog-effect';

/** Carrega efeitos de espécie e aplica gates de opção (cultura/linhagem). */
export async function loadGatedSpeciesEffects(input: {
  effectCatalog: LoadEffectCatalog;
  speciesSlug: string | null | undefined;
  speciesChoices?: readonly EffectChoiceRef[];
  kinds?: EffectKind[];
}): Promise<CatalogEffect[]> {
  const slug = input.speciesSlug?.trim();
  if (!slug) return [];
  const raw = await input.effectCatalog.load({
    ownerKind: 'species',
    ownerSlugs: [slug],
    ...(input.kinds?.length ? { kinds: input.kinds } : {}),
  });
  return filterEffectsByOptionGates(
    raw,
    withDefaultSpeciesChoices(slug, input.speciesChoices ?? []),
  );
}
