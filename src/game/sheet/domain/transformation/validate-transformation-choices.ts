import { BadRequestException } from '@nestjs/common';
import {
  CAP6_CHOICE_RULES,
  type Cap6TransformationRule,
} from './cap6-choice-rules';
import type { CharacterTransformation } from './validate-transformation';

export type ValidateTransformationChoicesInput = {
  transformation: CharacterTransformation;
  /** option_key → value_ids permitidos no catálogo */
  allowedValuesByKey: ReadonlyMap<string, ReadonlySet<string>>;
  rules?: Cap6TransformationRule;
};

export function validateTransformationChoices(
  input: ValidateTransformationChoicesInput,
): void {
  const { transformation, allowedValuesByKey } = input;
  const slug = transformation.slug.trim();
  const stage = Number(transformation.stage);
  const rules = input.rules ?? CAP6_CHOICE_RULES[slug];
  if (!rules) {
    throw new BadRequestException(`No Cap. 6 choice rules for '${slug}'`);
  }

  const byKind = new Map(
    transformation.choices.map((c) => [c.choiceKind.trim(), c.choiceSlug.trim()]),
  );

  const requiredKeys = new Set<string>();
  for (let s = 1; s <= stage; s += 1) {
    const stageRule = rules.stages[String(s)];
    if (!stageRule) {
      throw new BadRequestException(`Missing Cap. 6 rules for '${slug}' stage ${s}`);
    }
    for (const key of stageRule.pickKeys) {
      requiredKeys.add(key);
      const value = byKind.get(key);
      if (!value) {
        throw new BadRequestException(
          `transformation requires choice '${key}' at stage ${stage}`,
        );
      }
      assertAllowed(allowedValuesByKey, key, value);
    }

    const pickValues = stageRule.pickKeys
      .map((key) => byKind.get(key))
      .filter((v): v is string => Boolean(v));
    if (new Set(pickValues).size !== pickValues.length) {
      throw new BadRequestException(
        `Duplicate boon picks are not allowed for '${slug}' stage ${s}`,
      );
    }
  }

  for (const sub of rules.subOptions) {
    if (stage < sub.fromStage) continue;
    if (sub.whenChoice) {
      const gate = byKind.get(sub.whenChoice.key);
      if (gate !== sub.whenChoice.value) {
        if (byKind.has(sub.key)) {
          throw new BadRequestException(
            `transformation choice '${sub.key}' is only valid with ${sub.whenChoice.key}=${sub.whenChoice.value}`,
          );
        }
        continue;
      }
    }
    requiredKeys.add(sub.key);
    const value = byKind.get(sub.key);
    if (!value) {
      throw new BadRequestException(
        `transformation requires choice '${sub.key}' at stage ${stage}`,
      );
    }
    assertAllowed(allowedValuesByKey, sub.key, value);
  }

  for (const match of rules.requireMatch) {
    if (!requiredKeys.has(match.laterKey) && !byKind.has(match.laterKey)) continue;
    const laterStage = stageOfKey(match.laterKey);
    if (laterStage != null && stage < laterStage) continue;
    const earlier = byKind.get(match.earlierKey);
    const later = byKind.get(match.laterKey);
    if (!earlier || !later) continue;
    const expected = match.pairs[earlier];
    if (!expected) {
      throw new BadRequestException(
        `No Cap. 6 match mapping for ${match.earlierKey}='${earlier}'`,
      );
    }
    if (later !== expected) {
      throw new BadRequestException(
        `transformation '${match.laterKey}' must be '${expected}' for ${match.earlierKey}='${earlier}'`,
      );
    }
  }

  for (const kind of byKind.keys()) {
    if (requiredKeys.has(kind)) continue;
    // Future-stage keys not yet unlocked
    const keyStage = stageOfKey(kind);
    if (keyStage != null && keyStage > stage) {
      throw new BadRequestException(
        `transformation choice '${kind}' requires stage ${keyStage}`,
      );
    }
    throw new BadRequestException(`Unknown transformation choiceKind '${kind}'`);
  }
}

function assertAllowed(
  allowedValuesByKey: ReadonlyMap<string, ReadonlySet<string>>,
  key: string,
  value: string,
): void {
  const allowed = allowedValuesByKey.get(key);
  if (!allowed || !allowed.has(value)) {
    throw new BadRequestException(
      `Invalid transformation choice ${key}='${value}'`,
    );
  }
}

/** stage1Boon / stage2Boon2 → 1 / 2; subOptions → null */
function stageOfKey(key: string): number | null {
  const match = /^stage(\d+)Boon(?:2)?$/.exec(key);
  if (!match) return null;
  return Number(match[1]);
}
