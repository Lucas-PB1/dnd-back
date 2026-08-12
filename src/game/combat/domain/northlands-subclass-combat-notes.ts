/**
 * Passivas / lembretes de subclasses Northlands (painel Passivas).
 * Economia C052–C054 cobre os botões Usar; aqui ficam efeitos contínuos e features sem botão.
 */
import {
  fenrisSubclassNotes,
  nornboundSubclassNotes,
  skaldSubclassNotes,
  spiritCallerSubclassNotes,
  tricksterSubclassNotes,
} from './northlands-subclass-notes-caster';
import {
  titanSubclassNotes,
  valhallaSubclassNotes,
  vikingSubclassNotes,
} from './northlands-subclass-notes-martial';

type NoteFn = (level: number) => string[];

const BY_SUBCLASS: Record<string, NoteFn> = {
  'path-of-the-titan': titanSubclassNotes,
  skald: skaldSubclassNotes,
  nornbound: nornboundSubclassNotes,
  'circle-of-fenris': fenrisSubclassNotes,
  viking: vikingSubclassNotes,
  'oath-of-valhalla': valhallaSubclassNotes,
  'spirit-caller': spiritCallerSubclassNotes,
  trickster: tricksterSubclassNotes,
};

export function northlandsSubclassCombatNotes(input: {
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  const slug = input.subclassSlug;
  if (!slug) return [];
  const fn = BY_SUBCLASS[slug];
  if (!fn) return [];
  return fn(input.level ?? 1);
}
