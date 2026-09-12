import {
  isBlastInvocationSlug,
  isLessonsOfTheFirstOnesSlug,
  LESSONS_OF_THE_FIRST_ONES_SLUG,
  warlockInvocationLimit,
} from '../features';
import { cantripEligibleForBlastInvocation, knownPactSlugsFromPicks } from './read';
import type { FeatureScheduleBand } from '../../feature-schedule';
import type {
  EldritchBlastCantripBinding,
  EldritchCantripEligibility,
  EldritchInvocationCatalogRow,
  EldritchOriginFeatBinding,
} from './types';

export function validateEldritchInvocationPicks(input: {
  level: number;
  picks: readonly { slug: string; instanceIndex: number }[];
  catalog: readonly EldritchInvocationCatalogRow[];
  featureSchedules: readonly FeatureScheduleBand[];
}): string[] {
  const errors: string[] = [];
  const limit = warlockInvocationLimit(input.level, input.featureSchedules);
  if (input.picks.length > limit) {
    errors.push(
      `Bruxo nível ${input.level} permite até ${limit} invocação(ões); recebeu ${input.picks.length}`,
    );
  }

  const bySlug = new Map(input.catalog.map((row) => [row.slug, row]));
  const pickedSlugs = input.picks.map((p) => p.slug);
  const counts = new Map<string, number>();
  for (const slug of pickedSlugs) {
    counts.set(slug, (counts.get(slug) ?? 0) + 1);
  }

  const pactKnown = knownPactSlugsFromPicks(input.picks);
  const invocationKnown = new Set(pickedSlugs);

  for (const pick of input.picks) {
    const row = bySlug.get(pick.slug);
    if (!row) {
      errors.push(`Invocação desconhecida: '${pick.slug}'`);
      continue;
    }
    if (input.level < row.minLevel) {
      errors.push(
        `Invocação '${row.name}' requer Bruxo nível ${row.minLevel}`,
      );
    }
    if (row.requiresPactSlug && !pactKnown.has(row.requiresPactSlug)) {
      errors.push(
        `Invocação '${row.name}' requer ${row.requiresPactSlug}`,
      );
    }
    if (
      row.requiresInvocationSlug &&
      !invocationKnown.has(row.requiresInvocationSlug)
    ) {
      errors.push(
        `Invocação '${row.name}' requer ${row.requiresInvocationSlug}`,
      );
    }
    const count = counts.get(pick.slug) ?? 0;
    if (!row.repeatable && count > 1) {
      errors.push(`Invocação '${row.name}' não é repetível`);
    }
  }

  return errors;
}

export function validateEldritchBlastCantripBindings(input: {
  picks: readonly { slug: string; instanceIndex: number }[];
  bindings: readonly EldritchBlastCantripBinding[];
  cantripsBySlug: ReadonlyMap<string, EldritchCantripEligibility>;
}): string[] {
  const errors: string[] = [];
  const bindingByIndex = new Map(
    input.bindings.map((binding) => [binding.instanceIndex, binding]),
  );
  const usedCantripByInvocation = new Map<string, Set<string>>();

  for (const pick of input.picks) {
    if (!isBlastInvocationSlug(pick.slug)) continue;
    const binding = bindingByIndex.get(pick.instanceIndex);
    if (!binding) {
      errors.push(
        `Invocação '${pick.slug}' (slot ${pick.instanceIndex}) requer um truque vinculado`,
      );
      continue;
    }
    if (binding.invocationSlug !== pick.slug) {
      errors.push(
        `Truque vinculado no slot ${pick.instanceIndex} não corresponde a '${pick.slug}'`,
      );
      continue;
    }
    const cantrip = input.cantripsBySlug.get(binding.cantripSlug);
    if (!cantrip || !cantrip.isWarlockCantrip) {
      errors.push(
        `Truque '${binding.cantripSlug}' não é um truque de Bruxo conhecido`,
      );
      continue;
    }
    if (!cantripEligibleForBlastInvocation(pick.slug, cantrip)) {
      errors.push(
        `Truque '${binding.cantripSlug}' não é elegível para '${pick.slug}'`,
      );
      continue;
    }
    const used = usedCantripByInvocation.get(pick.slug) ?? new Set<string>();
    if (used.has(binding.cantripSlug)) {
      errors.push(
        `Truque '${binding.cantripSlug}' já está vinculado a outra '${pick.slug}'`,
      );
    }
    used.add(binding.cantripSlug);
    usedCantripByInvocation.set(pick.slug, used);
  }

  for (const binding of input.bindings) {
    const pick = input.picks.find(
      (row) => row.instanceIndex === binding.instanceIndex,
    );
    if (!pick || !isBlastInvocationSlug(pick.slug)) {
      errors.push(
        `Vínculo de truque órfão no slot ${binding.instanceIndex} ('${binding.cantripSlug}')`,
      );
    }
  }

  return errors;
}

export function validateEldritchOriginFeatBindings(input: {
  picks: readonly { slug: string; instanceIndex: number }[];
  bindings: readonly EldritchOriginFeatBinding[];
  originFeatSlugs: ReadonlySet<string>;
  occupiedFeatSlugs?: ReadonlySet<string>;
}): string[] {
  const errors: string[] = [];
  const bindingByIndex = new Map(
    input.bindings.map((binding) => [binding.instanceIndex, binding]),
  );
  const usedFeats = new Set<string>();

  for (const pick of input.picks) {
    if (!isLessonsOfTheFirstOnesSlug(pick.slug)) continue;
    const binding = bindingByIndex.get(pick.instanceIndex);
    if (!binding) {
      errors.push(
        `Invocação '${LESSONS_OF_THE_FIRST_ONES_SLUG}' (slot ${pick.instanceIndex}) requer um talento de Origem`,
      );
      continue;
    }
    if (!input.originFeatSlugs.has(binding.featSlug)) {
      errors.push(
        `Talento '${binding.featSlug}' não é um talento de Origem válido`,
      );
      continue;
    }
    if (usedFeats.has(binding.featSlug)) {
      errors.push(
        `Talento de Origem '${binding.featSlug}' já escolhido em outra Lições dos Primeiros`,
      );
      continue;
    }
    if (input.occupiedFeatSlugs?.has(binding.featSlug)) {
      errors.push(
        `Talento de Origem '${binding.featSlug}' já está na ficha; escolha outro`,
      );
      continue;
    }
    usedFeats.add(binding.featSlug);
  }

  for (const binding of input.bindings) {
    const pick = input.picks.find(
      (row) => row.instanceIndex === binding.instanceIndex,
    );
    if (!pick || !isLessonsOfTheFirstOnesSlug(pick.slug)) {
      errors.push(
        `Vínculo de talento órfão no slot ${binding.instanceIndex} ('${binding.featSlug}')`,
      );
    }
  }

  return errors;
}
