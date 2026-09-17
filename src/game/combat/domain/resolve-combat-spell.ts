import { rollDie, rollD20Check } from '@game/dice/domain/dice';
import type { AdvantageMode } from '@game/dice/domain/dice';
import type {
  SpellCombatResolutionKind,
  SpellCombatSaveSuccessOutcome,
} from '@entities/spell/phb-spell-combat.entity';
import {
  saveAdvantageForMetamagic,
  wantsSeekingSpell,
} from './sorcerer/combat-metamagic';

export type SpellCombatRow = {
  spellSlug: string;
  resolution: SpellCombatResolutionKind;
  label: string;
  damageDie: number | null;
  flatPerDie: number;
  autoUnitBase: number | null;
  autoUnitPerSlotAboveBase: number | null;
  diceCountBase: number | null;
  dicePerSlotAboveBase: number | null;
  spellLevel: number;
  cantripScale: boolean;
  perDieAttack: boolean;
  includeSpellcastingMod: boolean;
  saveSuccessOutcome: SpellCombatSaveSuccessOutcome | null;
  saveAbilitySlug: string | null;
  conditionSlug: string | null;
  damageTypeSlug: string | null;
};

export type CombatSpellResolution =
  | { kind: 'arena_darkness' }
  | { kind: 'auto_damage'; damage: number; label: string }
  | {
      kind: 'spell_attack';
      damage: number;
      label: string;
      attackTotal: number;
      hit: boolean;
      critical: boolean;
    }
  | {
      kind: 'save_damage';
      damage: number;
      label: string;
      saveTotal: number;
      saved: boolean;
      dc: number;
    }
  | {
      kind: 'apply_condition';
      conditionSlug: string;
      label: string;
      saveTotal: number;
      saved: boolean;
      dc: number;
      applied: boolean;
    }
  | { kind: 'heal'; amount: number; label: string }
  | { kind: 'slot_only'; note: string };

function cantripDiceCount(characterLevel: number): number {
  if (characterLevel >= 17) return 4;
  if (characterLevel >= 11) return 3;
  if (characterLevel >= 5) return 2;
  return 1;
}

function rollDiceTotal(die: number, count: number, flatPerDie: number): number {
  let total = 0;
  for (let i = 0; i < count; i += 1) {
    total += rollDie(die) + flatPerDie;
  }
  return total;
}

function leveledDiceCount(
  row: SpellCombatRow,
  characterLevel: number,
  slotLevel: number,
): number {
  if (row.cantripScale) return cantripDiceCount(characterLevel);
  const base = row.diceCountBase ?? 1;
  const per = row.dicePerSlotAboveBase ?? 0;
  return base + Math.max(0, slotLevel - row.spellLevel) * per;
}

function applySaveOutcome(
  damage: number,
  saved: boolean,
  outcome: SpellCombatSaveSuccessOutcome | null,
): number {
  if (!saved) return damage;
  if (outcome === 'full') return damage;
  if (outcome === 'half') return Math.floor(damage / 2);
  return 0;
}

function withSpellcastingMod(
  row: SpellCombatRow,
  total: number,
  spellcastingAbilityMod: number,
): number {
  if (!row.includeSpellcastingMod) return total;
  return total + spellcastingAbilityMod;
}

function resolveSpellAttack(input: {
  row: SpellCombatRow;
  die: number;
  characterLevel: number;
  slotLevel: number;
  spellAttackBonus: number;
  spellcastingAbilityMod: number;
  targetAc: number;
  advantage: AdvantageMode;
  seekingSpell: boolean;
}): Extract<CombatSpellResolution, { kind: 'spell_attack' }> {
  const { row, die } = input;
  const dice = leveledDiceCount(row, input.characterLevel, input.slotLevel);
  const beams = row.perDieAttack ? dice : 1;
  const dicePerHit = row.perDieAttack ? 1 : dice;

  let damage = 0;
  let anyHit = false;
  let anyCrit = false;
  let lastTotal = 0;

  for (let i = 0; i < beams; i += 1) {
    let attack = rollD20Check(input.spellAttackBonus, input.advantage);
    lastTotal = attack.total;
    let kept = attack.d20.kept[0] ?? 0;
    let hit = attack.total >= input.targetAc;
    if (!hit && input.seekingSpell) {
      attack = rollD20Check(input.spellAttackBonus, input.advantage);
      lastTotal = attack.total;
      kept = attack.d20.kept[0] ?? 0;
      hit = attack.total >= input.targetAc;
    }
    if (!hit) continue;
    anyHit = true;
    const critical = kept === 20;
    if (critical) anyCrit = true;
    const count = critical ? dicePerHit * 2 : dicePerHit;
    damage += rollDiceTotal(die, count, row.flatPerDie);
  }

  return {
    kind: 'spell_attack',
    damage: withSpellcastingMod(row, damage, input.spellcastingAbilityMod),
    label: row.label,
    attackTotal: lastTotal,
    hit: anyHit,
    critical: anyCrit,
  };
}

export function resolveCombatSpell(input: {
  row: SpellCombatRow | null;
  slotLevel: number;
  characterLevel: number;
  spellAttackBonus: number;
  spellSaveDc: number;
  spellcastingAbilityMod: number;
  targetAc: number;
  targetSaveBonus: number;
  advantage: AdvantageMode;
  castNote?: string;
  /** Metamagia tipada (heightened-spell | seeking-spell). */
  metamagicSlug?: string | null;
}): CombatSpellResolution {
  const row = input.row;
  if (!row) {
    return {
      kind: 'slot_only',
      note:
        input.castNote?.trim() ||
        'Magia conjurada (efeito tipado de combate ainda não modelado).',
    };
  }

  if (row.resolution === 'arena_darkness') {
    return { kind: 'arena_darkness' };
  }

  const saveAdv = saveAdvantageForMetamagic(input.metamagicSlug);

  if (row.resolution === 'apply_condition') {
    const conditionSlug = row.conditionSlug?.trim();
    if (!conditionSlug) {
      return {
        kind: 'slot_only',
        note:
          input.castNote?.trim() ||
          `${row.label}: condição tipada ausente.`,
      };
    }
    const save = rollD20Check(input.targetSaveBonus, saveAdv);
    const saved = save.total >= input.spellSaveDc;
    return {
      kind: 'apply_condition',
      conditionSlug,
      label: row.label,
      saveTotal: save.total,
      saved,
      dc: input.spellSaveDc,
      applied: !saved,
    };
  }

  const die = row.damageDie;
  if (die == null) {
    return {
      kind: 'slot_only',
      note: input.castNote?.trim() || `${row.label}: sem dados de dano tipados.`,
    };
  }

  if (row.resolution === 'auto_damage') {
    const base = row.autoUnitBase ?? 1;
    const perSlot = row.autoUnitPerSlotAboveBase ?? 0;
    const units =
      base + Math.max(0, input.slotLevel - row.spellLevel) * perSlot;
    const damage = withSpellcastingMod(
      row,
      rollDiceTotal(die, units, row.flatPerDie),
      input.spellcastingAbilityMod,
    );
    return {
      kind: 'auto_damage',
      damage,
      label: `${row.label} (${units} ${units === 1 ? 'dardo' : 'dardos'})`,
    };
  }

  if (row.resolution === 'heal_combatant') {
    const count = leveledDiceCount(row, input.characterLevel, input.slotLevel);
    const amount = withSpellcastingMod(
      row,
      rollDiceTotal(die, count, row.flatPerDie),
      input.spellcastingAbilityMod,
    );
    return { kind: 'heal', amount, label: row.label };
  }

  if (row.resolution === 'save_damage') {
    const count = leveledDiceCount(row, input.characterLevel, input.slotLevel);
    const rolled = withSpellcastingMod(
      row,
      rollDiceTotal(die, count, row.flatPerDie),
      input.spellcastingAbilityMod,
    );
    const save = rollD20Check(input.targetSaveBonus, saveAdv);
    const saved = save.total >= input.spellSaveDc;
    const damage = applySaveOutcome(rolled, saved, row.saveSuccessOutcome);
    return {
      kind: 'save_damage',
      damage,
      label: row.label,
      saveTotal: save.total,
      saved,
      dc: input.spellSaveDc,
    };
  }

  return resolveSpellAttack({
    row,
    die,
    characterLevel: input.characterLevel,
    slotLevel: input.slotLevel,
    spellAttackBonus: input.spellAttackBonus,
    spellcastingAbilityMod: input.spellcastingAbilityMod,
    targetAc: input.targetAc,
    advantage: input.advantage,
    seekingSpell: wantsSeekingSpell(input.metamagicSlug),
  });
}
