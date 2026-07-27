export type Rng = () => number;

export type AdvantageMode = 'normal' | 'advantage' | 'disadvantage';

export type DieRollDetail = {
  count: number;
  sides: number;
  rolls: number[];
  kept: number[];
};

export type CheckRollResult = {
  expression: string;
  total: number;
  modifier: number;
  mode: AdvantageMode;
  d20: DieRollDetail;
};

export type DamageRollResult = {
  expression: string;
  total: number;
  modifier: number;
  critical: boolean;
  dice: DieRollDetail[];
};

/** Uma face: 1..sides inclusive. */
export function rollDie(sides: number, rng: Rng = Math.random): number {
  if (!Number.isInteger(sides) || sides < 2) {
    throw new Error(`Invalid die sides: ${sides}`);
  }
  return 1 + Math.floor(rng() * sides);
}

export function rollDice(
  count: number,
  sides: number,
  rng: Rng = Math.random,
): number[] {
  if (!Number.isInteger(count) || count < 1) {
    throw new Error(`Invalid die count: ${count}`);
  }
  return Array.from({ length: count }, () => rollDie(sides, rng));
}

/**
 * Parseia expressões simples: NdM, NdM+K, NdM-K (ex.: 2d6+3, 1d8, 1d10-1).
 * Não cobre dados compostos tipo 2d6+1d4.
 */
export function parseDiceExpression(expression: string): {
  count: number;
  sides: number;
  modifier: number;
} {
  const normalized = expression.replace(/\s+/g, '').toLowerCase();
  const match = /^(\d+)d(\d+)([+-]\d+)?$/.exec(normalized);
  if (!match) {
    throw new Error(`Unsupported dice expression: ${expression}`);
  }
  return {
    count: Number(match[1]),
    sides: Number(match[2]),
    modifier: match[3] ? Number(match[3]) : 0,
  };
}

export function rollExpression(
  expression: string,
  rng: Rng = Math.random,
): DamageRollResult {
  const parsed = parseDiceExpression(expression);
  const rolls = rollDice(parsed.count, parsed.sides, rng);
  const diceSum = rolls.reduce((a, b) => a + b, 0);
  return {
    expression,
    total: diceSum + parsed.modifier,
    modifier: parsed.modifier,
    critical: false,
    dice: [
      {
        count: parsed.count,
        sides: parsed.sides,
        rolls,
        kept: rolls,
      },
    ],
  };
}

export function rollDamageParts(
  diceExpr: string,
  modifier: number,
  options: { critical?: boolean; rng?: Rng } = {},
): DamageRollResult {
  const rng = options.rng ?? Math.random;
  const critical = Boolean(options.critical);
  const base = diceExpr.replace(/\s+/g, '').replace(/[+-]\d+$/i, '');
  const parsed = parseDiceExpression(base.includes('d') ? base : `1d${base}`);
  const count = critical ? parsed.count * 2 : parsed.count;
  const rolls = rollDice(count, parsed.sides, rng);
  const diceSum = rolls.reduce((a, b) => a + b, 0);
  const expression = `${count}d${parsed.sides}${formatSigned(modifier)}`;
  return {
    expression,
    total: diceSum + modifier,
    modifier,
    critical,
    dice: [
      {
        count,
        sides: parsed.sides,
        rolls,
        kept: rolls,
      },
    ],
  };
}

export function rollD20Check(
  modifier: number,
  mode: AdvantageMode = 'normal',
  rng: Rng = Math.random,
): CheckRollResult {
  const first = rollDie(20, rng);
  const second = mode === 'normal' ? first : rollDie(20, rng);
  const rolls = mode === 'normal' ? [first] : [first, second];
  let kept: number[];
  if (mode === 'advantage') {
    kept = [Math.max(first, second)];
  } else if (mode === 'disadvantage') {
    kept = [Math.min(first, second)];
  } else {
    kept = [first];
  }
  const d20Value = kept[0];
  const modeSuffix =
    mode === 'advantage' ? ' (vantagem)' : mode === 'disadvantage' ? ' (desvantagem)' : '';
  return {
    expression: `1d20${formatSigned(modifier)}${modeSuffix}`,
    total: d20Value + modifier,
    modifier,
    mode,
    d20: {
      count: mode === 'normal' ? 1 : 2,
      sides: 20,
      rolls,
      kept,
    },
  };
}

function formatSigned(n: number): string {
  if (n === 0) return '';
  return n > 0 ? `+${n}` : String(n);
}
