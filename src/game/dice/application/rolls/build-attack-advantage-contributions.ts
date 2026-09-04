import type { AdvantageContribution } from '@game/dice/domain/resolve-net-advantage-mode';
import {
  advantageModeFromManual,
  resolveNetAdvantageMode,
} from '@game/dice/domain/resolve-net-advantage-mode';
import type { AdvantageMode } from '@game/dice/domain/dice';
import type { RollAttackDto } from '@game/dice/dto/character-roll.dto';
import type { WeaponCombatFlags } from './roll-weapon-context';
import {
  ignoresRangedRangePenalties,
} from '@game/dice/domain/attack-cover';
import { hasPreciseHunter, isRangerClass } from '@game/combat/domain/ranger';

type AttackRollContext = {
  dto: RollAttackDto;
  classSlug: string;
  subclassSlug: string | null;
  level: number;
  attackDisadvantage: boolean;
  masteryActive: boolean;
  masterySlug?: string | null;
  abilitySlug: string;
  combatFlags: WeaponCombatFlags;
  featSlugs: readonly string[];
};

export function buildAttackAdvantageContributions(
  ctx: AttackRollContext,
): { mode: AdvantageMode; notes: string[] } {
  const contributions: AdvantageContribution[] = [
    ...advantageModeFromManual(ctx.dto.advantage),
  ];
  const notes: string[] = [];

  if (ctx.attackDisadvantage) {
    contributions.push('disadvantage');
  }
  if (
    ctx.dto.automatic &&
    ctx.masteryActive &&
    ctx.masterySlug === 'automatic'
  ) {
    contributions.push('disadvantage');
  }
  if (
    ctx.dto.longRange &&
    ctx.dto.mode === 'ranged' &&
    !ignoresRangedRangePenalties(ctx.featSlugs, ctx.dto.mode)
  ) {
    contributions.push('disadvantage');
    notes.push('Alcance longo: desvantagem no ataque');
  }
  if (
    ctx.dto.meleeWithRanged &&
    ctx.dto.mode === 'ranged' &&
    !ignoresRangedRangePenalties(ctx.featSlugs, ctx.dto.mode)
  ) {
    contributions.push('disadvantage');
    notes.push('Ataque à distância a 1,5 m: desvantagem');
  }
  if (
    ctx.combatFlags.recklessActive &&
    ctx.classSlug === 'barbarian' &&
    ctx.dto.mode === 'melee' &&
    ctx.abilitySlug === 'forca' &&
    !ctx.dto.brutalStrike
  ) {
    contributions.push('advantage');
  }
  if (
    ctx.dto.studiedAttack &&
    ctx.classSlug === 'fighter' &&
    ctx.level >= 13
  ) {
    contributions.push('advantage');
    notes.push('Ataques Estudados: vantagem contra o mesmo alvo');
  }
  if (
    ctx.dto.doorKick &&
    ctx.subclassSlug === 'dungeoneer' &&
    ctx.level >= 3
  ) {
    contributions.push('advantage');
    notes.push('Chute na Porta: vantagem na primeira rodada');
  }
  if (ctx.dto.steadyAim) {
    contributions.push('advantage');
    notes.push(
      ctx.subclassSlug === 'assassin' && ctx.level >= 9
        ? 'Mira Móvel: Mira Firme concede vantagem sem reduzir o Deslocamento'
        : 'Mira Firme: vantagem; Deslocamento 0 até o fim do turno',
    );
  }
  if (ctx.dto.assassinate) {
    contributions.push('advantage');
    notes.push(
      'Assassinar: vantagem contra criatura que ainda não agiu na primeira rodada',
    );
  }
  if (
    ctx.dto.preciseHunter &&
    isRangerClass(ctx.classSlug) &&
    hasPreciseHunter(ctx.level)
  ) {
    contributions.push('advantage');
    notes.push(
      'Caçador Preciso: vantagem contra a criatura marcada pela Marca do Predador',
    );
  }

  const mode = resolveNetAdvantageMode(contributions);
  if (mode === 'advantage' && ctx.combatFlags.recklessActive) {
    notes.push(
      'Imprudente: vantagem ofensiva; ataques contra você têm vantagem',
    );
  }
  if (ctx.dto.automatic) {
    notes.push('Automática: 2 ataques / 2× munição');
  }

  return { mode, notes };
}
