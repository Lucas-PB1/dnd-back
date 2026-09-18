import { addFlatDamage } from './damage-accumulator';
import type { DamageEffect } from './damage-roll-context';

/** Bônus flat de Risk já gasto (ex. Confronto / showdown). */
export const applyGunslingerExtras: DamageEffect = (ctx, acc) => {
  const bonus = ctx.dto.gunslingerRiskDamageBonus;
  if (bonus == null || bonus <= 0) return;
  if (ctx.character.classSlug !== 'gunslinger') return;
  addFlatDamage(acc, bonus, `Pistoleiro: +${bonus} dano (Risk)`);
};
