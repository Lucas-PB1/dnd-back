/** Buckets de tempo de conjuração para filtro do catálogo. */
export type SpellCastingTimeKind =
  | 'action'
  | 'bonus'
  | 'reaction'
  | 'minute'
  | 'hour';

/** Buckets de alcance / área aproximada. */
export type SpellRangeKind =
  | 'self'
  | 'touch'
  | 'short'
  | 'medium'
  | 'long';

export type SpellListExtraFilters = {
  ritual?: boolean;
  concentration?: boolean;
  roll?: 'attack' | 'save';
  castingTime?: SpellCastingTimeKind;
  saveAbility?: string;
  rangeKind?: SpellRangeKind;
};

type QbLike = {
  andWhere: (sql: string, params?: Record<string, unknown>) => unknown;
};

/** Aplica filtros opcionais de magia (ritual, tempo, alcance, teste…). */
export function applySpellListExtraFilters(
  qb: QbLike,
  filters: SpellListExtraFilters,
): void {
  if (filters.ritual !== undefined) {
    qb.andWhere('spell.ritual = :ritual', { ritual: filters.ritual });
  }
  if (filters.concentration !== undefined) {
    qb.andWhere('spell.concentration = :concentration', {
      concentration: filters.concentration,
    });
  }
  if (filters.roll === 'attack') {
    qb.andWhere('spell.requiresAttackRoll = true');
  } else if (filters.roll === 'save') {
    qb.andWhere(
      "spell.saveAbilitySlug IS NOT NULL AND spell.saveAbilitySlug <> ''",
    );
  }

  const saveAbility = filters.saveAbility?.trim();
  if (saveAbility) {
    qb.andWhere('spell.saveAbilitySlug = :saveAbility', { saveAbility });
  }

  applyCastingTimeKind(qb, filters.castingTime);
  applyRangeKind(qb, filters.rangeKind);
}

function applyCastingTimeKind(
  qb: QbLike,
  kind: SpellCastingTimeKind | undefined,
): void {
  if (!kind) return;
  const col = 'spell.castingTime';
  switch (kind) {
    case 'action':
      qb.andWhere(
        `(
          (${col} ILIKE 'Ação%' OR ${col} ILIKE 'Action%' OR ${col} ILIKE 'Uma ação%')
          AND ${col} NOT ILIKE '%Bônus%'
          AND ${col} NOT ILIKE '%Bonus%'
          AND ${col} NOT ILIKE 'Reação%'
          AND ${col} NOT ILIKE 'Reaction%'
          AND ${col} NOT ILIKE '1 Reaction%'
        )`,
      );
      return;
    case 'bonus':
      qb.andWhere(
        `(${col} ILIKE '%Ação Bônus%' OR ${col} ILIKE '%Bonus Action%' OR ${col} ILIKE 'Bonus Action%')`,
      );
      return;
    case 'reaction':
      qb.andWhere(
        `(${col} ILIKE 'Reação%' OR ${col} ILIKE 'Reaction%' OR ${col} ILIKE '1 Reaction%' OR ${col} ILIKE '%Reaction%')`,
      );
      return;
    case 'minute':
      qb.andWhere(`(${col} ILIKE '%minuto%' OR ${col} ILIKE '%minute%')`);
      return;
    case 'hour':
      qb.andWhere(`(${col} ILIKE '%hora%' OR ${col} ILIKE '%hour%')`);
      return;
  }
}

function applyRangeKind(qb: QbLike, kind: SpellRangeKind | undefined): void {
  if (!kind) return;
  const col = 'spell.range';
  switch (kind) {
    case 'self':
      qb.andWhere(`(${col} ILIKE 'Pessoal%' OR ${col} ILIKE 'Self%')`);
      return;
    case 'touch':
      qb.andWhere(`(${col} ILIKE 'Toque%' OR ${col} ILIKE 'Touch%')`);
      return;
    case 'short':
      // Até ~9 m / 30 pés (sem Pessoal/Toque).
      qb.andWhere(
        `(
          ${col} ~* '^(1,?5|3|4,?5|6|9)\\s*(metros?|m)$'
          OR ${col} ~* '^(10|15|30)\\s*pés$'
          OR ${col} ~* '^(10|15|30)\\s*feet$'
        )`,
      );
      return;
    case 'medium':
      qb.andWhere(
        `(
          ${col} ~* '^(13,?5|18|27|30|36)\\s*(metros?|m)$'
          OR ${col} ~* '^(60|90|120)\\s*pés$'
          OR ${col} ~* '^(60|90|120)\\s*feet$'
        )`,
      );
      return;
    case 'long':
      qb.andWhere(
        `(
          ${col} ~* '^(40,?5|45|54|60|90|150)\\s*(metros?|m)$'
          OR ${col} ILIKE '%km%'
          OR ${col} ILIKE '%quilômetro%'
          OR ${col} ILIKE '%quilometro%'
          OR ${col} ILIKE 'Ilimitado%'
          OR ${col} ILIKE 'Unlimited%'
          OR ${col} ~* '^(150|300|500|600|800)\\s*(pés|feet)$'
        )`,
      );
      return;
  }
}
