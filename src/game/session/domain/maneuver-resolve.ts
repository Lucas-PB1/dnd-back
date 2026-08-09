import { rollDie } from '@game/dice/domain/dice';
import { riskDieFaces } from '../domain/risk-die';
import type { GunslingerManeuver } from '@game/combat/domain/gunslinger';

export type ResourceDieRoll = {
  resourceSlug: string;
  faces: number;
  value: number;
  expression: string;
};

export function rollRiskDie(level: number): ResourceDieRoll | null {
  const faces = riskDieFaces(level);
  if (faces == null) return null;
  const value = rollDie(faces);
  return {
    resourceSlug: 'risk',
    faces,
    value,
    expression: `1d${faces}`,
  };
}

export type ManeuverResolveResult = {
  maneuverSlug: string;
  maneuverName: string;
  effectKind: GunslingerManeuver['effectKind'];
  riskRoll: ResourceDieRoll;
  /** PV temporários concedidos (Morda a Bala). */
  tempHpGained?: number;
  /** Dano no erro (Tiro Rasante). */
  missDamage?: number;
  /** Bônus de CA (Por um Triz). */
  acBonus?: number;
  /** Bônus a somar ao teste (Espírito Independente). */
  checkBonus?: number;
  /** Texto descritivo para a mesa. */
  note: string;
};

export function resolveManeuverEffect(input: {
  maneuver: GunslingerManeuver;
  riskRoll: ResourceDieRoll;
  gunslingerLevel: number;
  dexterityModifier: number;
}): ManeuverResolveResult {
  const { maneuver, riskRoll, gunslingerLevel, dexterityModifier } = input;
  const base = {
    maneuverSlug: maneuver.slug,
    maneuverName: maneuver.name,
    effectKind: maneuver.effectKind,
    riskRoll,
  };

  if (maneuver.effectKind === 'temp_hp') {
    const tempHpGained = riskRoll.value + gunslingerLevel;
    return {
      ...base,
      tempHpGained,
      note: `+${tempHpGained} PV Temporários`,
    };
  }
  if (maneuver.effectKind === 'miss_damage') {
    const missDamage = Math.max(1, riskRoll.value + dexterityModifier);
    return {
      ...base,
      missDamage,
      note: `${missDamage} de dano (Tiro Rasante)`,
    };
  }
  if (maneuver.effectKind === 'ac_bonus') {
    return {
      ...base,
      acBonus: riskRoll.value,
      note: `+${riskRoll.value} CA contra este ataque`,
    };
  }
  if (maneuver.effectKind === 'ability_check_bonus') {
    return {
      ...base,
      checkBonus: riskRoll.value,
      note: `+${riskRoll.value} no teste/salvaguarda`,
    };
  }
  if (maneuver.effectKind === 'reload_move') {
    return {
      ...base,
      note: 'Mova até 4,5 m e recarregue a arma à distância (Rolamento Evasivo)',
    };
  }
  return {
    ...base,
    note: maneuver.description,
  };
}
