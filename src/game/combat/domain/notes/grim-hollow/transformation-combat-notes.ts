import { CAP6_CHOICE_RULES } from '@game/sheet/domain/transformation/cap6-choice-rules';
import {
  CAP6_BOON_COMBAT_NOTES,
  CAP6_ECONOMY_LABEL_PT,
} from './transformation-combat-notes-data';

export type TransformationCombatInput = {
  slug: string;
  stage: number;
  choices?: readonly { choiceKind: string; choiceSlug: string }[];
};

export function transformationCombatNotes(
  input: TransformationCombatInput | null | undefined,
): string[] {
  if (!input?.slug?.trim()) return [];
  const slug = input.slug.trim();
  const stage = Number(input.stage);
  if (!Number.isInteger(stage) || stage < 1) return [];

  const rules = CAP6_CHOICE_RULES[slug];
  if (!rules) return [];

  const active = new Set<string>();
  for (let s = 1; s <= stage; s += 1) {
    const stageRule = rules.stages[String(s)];
    if (!stageRule) continue;
    for (const auto of stageRule.autoBoons) active.add(auto);
  }

  for (const choice of input.choices ?? []) {
    const kind = choice.choiceKind?.trim() ?? '';
    if (!/^stage\d+Boon(?:2)?$/.test(kind)) continue;
    const value = choice.choiceSlug?.trim();
    if (value) active.add(value);
  }

  const notes: string[] = [];
  for (const boonId of active) {
    const meta = CAP6_BOON_COMBAT_NOTES[boonId];
    if (!meta) {
      notes.push(`Transformação: ${boonId}.`);
      continue;
    }
    const name = stripStageBoonPrefix(meta.namePt);
    const tags = meta.economy
      .map((tag) => CAP6_ECONOMY_LABEL_PT[tag] ?? tag)
      .filter(Boolean);
    const detail = meta.notePt?.trim();
    if (tags.length > 0) {
      notes.push(`${name} (${tags.join(' · ')}).`);
    } else if (detail) {
      notes.push(`${name}: ${detail}`);
    } else {
      notes.push(`${name}.`);
    }
  }
  return notes;
}

function stripStageBoonPrefix(name: string): string {
  return name
    .replace(/^Bênção do estágio\s*\d+\s*:\s*/i, '')
    .replace(/^Stage\s*\d+\s*Boon:\s*/i, '')
    .trim();
}
