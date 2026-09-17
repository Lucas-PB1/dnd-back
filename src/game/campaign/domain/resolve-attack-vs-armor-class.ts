const NATURAL_FUMBLE = 1;
const DEFAULT_CRIT_THRESHOLD = 20;

export type AttackVsArmorClassInput = {
  attackTotal: number;
  targetAc: number;
  naturalD20: number;
  critThreshold?: number;
};

export type AttackVsArmorClassResult = {
  hit: boolean;
  critical: boolean;
};

export function resolveAttackVsArmorClass(
  input: AttackVsArmorClassInput,
): AttackVsArmorClassResult {
  const critThreshold = input.critThreshold ?? DEFAULT_CRIT_THRESHOLD;
  if (input.naturalD20 <= NATURAL_FUMBLE) {
    return { hit: false, critical: false };
  }
  const critical = input.naturalD20 >= critThreshold;
  if (critical) {
    return { hit: true, critical: true };
  }
  return {
    hit: input.attackTotal >= input.targetAc,
    critical: false,
  };
}
