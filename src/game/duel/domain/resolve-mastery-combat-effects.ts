/**
 * Resolve effects de maestria no acerto/erro (genérico — Guerreiro é consumidor).
 */

import type { CatalogEffect } from '@game/effects/domain/catalog-effect';
import {
  addPendingEffect,
} from '@game/combat/domain/pending-combat-effect';
import type { DuelMember } from '../infrastructure/duel-member.entity';
import { asArenaEffects } from './arena-effects';
import {
  addMemberCondition,
  applyDamageToMemberVitals,
} from './duel-member-vitals';

export type MasteryResolveContext = {
  effects: CatalogEffect[];
  trigger: 'on_hit' | 'on_miss';
  attackAbilityMod: number;
  proficiencyBonus: number;
  defenderSaveTotal?: number | null;
  attackerMember: DuelMember;
  defenderMember: DuelMember;
  arenaEffects: string[];
  damaged: boolean;
};

export type MasteryResolveResult = {
  logLines: string[];
  missDamage: number;
  arenaEffects: string[];
};

export function featureSaveDc(
  abilityMod: number,
  proficiencyBonus: number,
): number {
  return 8 + abilityMod + proficiencyBonus;
}

export function mapSaveAbilityToSheetSlug(raw: string): string {
  const map: Record<string, string> = {
    strength: 'forca',
    dexterity: 'destreza',
    constitution: 'constituicao',
    intelligence: 'inteligencia',
    wisdom: 'sabedoria',
    charisma: 'carisma',
  };
  return map[raw] ?? raw;
}

export function resolveMasteryCombatEffects(
  input: MasteryResolveContext,
): MasteryResolveResult {
  const logLines: string[] = [];
  let missDamage = 0;
  let arenaEffects = [...input.arenaEffects];

  const relevant = input.effects.filter((e) => e.trigger === input.trigger);

  for (const effect of relevant) {
    const label = effect.label ?? effect.ownerSlug ?? effect.kind;

    if (effect.kind === 'ability_mod_damage' && input.trigger === 'on_miss') {
      const amount = Math.max(0, input.attackAbilityMod);
      missDamage += amount;
      logLines.push(`${label}: ${amount} de dano no erro.`);
      continue;
    }

    if (
      effect.kind === 'advantage_until_consumed' &&
      input.trigger === 'on_hit'
    ) {
      if (!input.damaged) continue;
      arenaEffects = asArenaEffects(
        addPendingEffect(
          arenaEffects,
          'attack-advantage',
          input.attackerMember.characterId,
        ),
      );
      logLines.push(
        `${label}: vantagem no próximo ataque contra este alvo.`,
      );
      continue;
    }

    if (effect.kind === 'attack_disadvantage' && input.trigger === 'on_hit') {
      arenaEffects = asArenaEffects(
        addPendingEffect(
          arenaEffects,
          'attack-disadvantage',
          input.defenderMember.characterId,
        ),
      );
      logLines.push(`${label}: desvantagem no próximo ataque do alvo.`);
      continue;
    }

    if (
      effect.kind === 'reduce_target_speed_on_hit' &&
      input.trigger === 'on_hit'
    ) {
      if (!input.damaged) continue;
      const meters = effect.numeric?.flat ?? 3;
      input.defenderMember.speedPenaltyM = Math.min(
        meters,
        Math.max(input.defenderMember.speedPenaltyM ?? 0, meters),
      );
      logLines.push(
        `${label}: deslocamento −${meters} m (sem mapa — marca no combatente).`,
      );
      continue;
    }

    if (effect.kind === 'forced_movement' && input.trigger === 'on_hit') {
      const distance = effect.forcedMovement?.distanceM ?? 3;
      logLines.push(`${label}: empurrado ${distance} m (sem grid).`);
      continue;
    }

    if (effect.kind === 'feature_save' && input.trigger === 'on_hit') {
      const dc = featureSaveDc(
        input.attackAbilityMod,
        input.proficiencyBonus,
      );
      const saveTotal = input.defenderSaveTotal;
      if (saveTotal == null) {
        logLines.push(`${label}: salvaguarda CD ${dc} (pendente).`);
        continue;
      }
      const success = saveTotal >= dc;
      const ability = effect.save?.saveAbility ?? 'constitution';
      logLines.push(
        `${label}: ${ability} ${saveTotal} vs CD ${dc} — ${success ? 'sucesso' : 'falha'}.`,
      );
      if (!success && effect.condition?.conditionSlug) {
        addMemberCondition(
          input.defenderMember,
          effect.condition.conditionSlug,
        );
        logLines.push(
          `Condição aplicada: ${effect.condition.conditionSlug}.`,
        );
      }
      continue;
    }

    if (effect.kind === 'combat_note' && effect.note?.note) {
      logLines.push(`${label}: ${effect.note.note}`);
    }
  }

  if (missDamage > 0) {
    applyDamageToMemberVitals(input.defenderMember, missDamage);
  }

  return { logLines, missDamage, arenaEffects };
}
