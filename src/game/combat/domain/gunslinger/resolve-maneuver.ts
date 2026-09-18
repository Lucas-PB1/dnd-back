import { rollDie } from '@game/dice/domain/dice';
import { riskDieFaces } from '@game/session/domain/risk-die';
import type { GunslingerManeuver } from './maneuvers';

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
  tempHpGained?: number;
  missDamage?: number;
  acBonus?: number;
  checkBonus?: number;
  blindsenseMeters?: number;
  damageBonus?: number;
  note: string;
};

/** Resolve efeito tipado pelo `effectKind` do catálogo (sem switch por slug). */
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

  switch (maneuver.effectKind) {
    case 'temp_hp': {
      const tempHpGained = riskRoll.value + gunslingerLevel;
      return {
        ...base,
        tempHpGained,
        note: `+${tempHpGained} PV Temporários`,
      };
    }
    case 'miss_damage': {
      const missDamage = Math.max(1, riskRoll.value + dexterityModifier);
      return {
        ...base,
        missDamage,
        note: `${missDamage} de dano (Tiro Rasante)`,
      };
    }
    case 'ac_bonus':
      return {
        ...base,
        acBonus: riskRoll.value,
        note: `+${riskRoll.value} CA contra este ataque`,
      };
    case 'ability_check_bonus':
      return {
        ...base,
        checkBonus: riskRoll.value,
        note: `+${riskRoll.value} no teste/salvaguarda`,
      };
    case 'reload_move':
      return {
        ...base,
        note: 'Mova até 4,5 m e recarregue a arma à distância (Rolamento Evasivo)',
      };
    case 'blindsense_until_eot':
      return {
        ...base,
        blindsenseMeters: 9,
        note: 'Visão Cega 9 m até o fim do turno',
      };
    case 'attack_damage_bonus':
      return {
        ...base,
        damageBonus: riskRoll.value,
        note: `+${riskRoll.value} dano no próximo acerto à distância (Confronto); passe gunslingerRiskDamageBonus no ataque`,
      };
    case 'descriptive':
      return {
        ...base,
        note: maneuver.description,
      };
  }
}
