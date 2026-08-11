/**
 * Regras Treasure (DMG Cap. 7) para conjuração a partir de item.
 * SSOT numérico (CD / ataque / círculo) vem de `phb_item.properties`.
 */

export type ItemCastSlotRule =
  | { mode: 'charge-upcast' }
  | { mode: 'fixed'; slotLevel: number }
  | {
      mode: 'fixed-by-spend';
      spendAmount: number;
      spellLevel: number;
      slotLevel: number;
    };

export type ParsedItemCastProperties = {
  spellSaveDc: number | null;
  spellAttackBonus: number | null;
  requiresComponents: boolean;
  /** Item usa atributo de conjuração do portador (Treasure +0+PB se não tiver). */
  useCasterAbility: boolean;
  /** Regra única do item (ex. varinha Relâmpagos). */
  itemCastSlotRule: ItemCastSlotRule | null;
  /** Regras por resource_slug (ex. ondaGloboUse / órbes). */
  itemCastSlotRules: Readonly<Record<string, ItemCastSlotRule>>;
};

export type ItemCastTreasureNotesInput = {
  spellRequiresConcentration: boolean;
  requiresComponents?: boolean;
  spellSaveDc?: number | null;
  spellAttackBonus?: number | null;
  casterHasSpellcastingAbility: boolean;
  /** Só emite nota +0+PB quando o item pede atributo do portador. */
  useCasterAbility: boolean;
};

export type ItemCastTreasureNotes = {
  lines: string[];
  spellSaveDcOverride: number | null;
  spellAttackBonusOverride: number | null;
};

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === 'object' && value !== null && !Array.isArray(value);
}

function parseSlotRule(raw: unknown): ItemCastSlotRule | null {
  if (!isRecord(raw) || typeof raw.mode !== 'string') return null;
  if (raw.mode === 'charge-upcast') return { mode: 'charge-upcast' };
  if (
    raw.mode === 'fixed' &&
    typeof raw.slotLevel === 'number' &&
    Number.isFinite(raw.slotLevel)
  ) {
    return { mode: 'fixed', slotLevel: raw.slotLevel };
  }
  if (
    raw.mode === 'fixed-by-spend' &&
    typeof raw.spendAmount === 'number' &&
    typeof raw.spellLevel === 'number' &&
    typeof raw.slotLevel === 'number' &&
    Number.isFinite(raw.spendAmount) &&
    Number.isFinite(raw.spellLevel) &&
    Number.isFinite(raw.slotLevel)
  ) {
    return {
      mode: 'fixed-by-spend',
      spendAmount: raw.spendAmount,
      spellLevel: raw.spellLevel,
      slotLevel: raw.slotLevel,
    };
  }
  return null;
}

function parseSlotRulesMap(
  raw: unknown,
): Readonly<Record<string, ItemCastSlotRule>> {
  if (!isRecord(raw)) return {};
  const out: Record<string, ItemCastSlotRule> = {};
  for (const [key, value] of Object.entries(raw)) {
    const rule = parseSlotRule(value);
    if (rule) out[key] = rule;
  }
  return out;
}

/** Lê CD / ataque / componentes / slot de `phb_item.properties`. */
export function parseItemCastProperties(
  properties: Record<string, unknown> | null | undefined,
): ParsedItemCastProperties {
  if (!isRecord(properties)) {
    return {
      spellSaveDc: null,
      spellAttackBonus: null,
      requiresComponents: false,
      useCasterAbility: false,
      itemCastSlotRule: null,
      itemCastSlotRules: {},
    };
  }
  const dc =
    typeof properties.spellSaveDc === 'number' &&
    Number.isFinite(properties.spellSaveDc)
      ? properties.spellSaveDc
      : null;
  const attack =
    typeof properties.spellAttackBonus === 'number' &&
    Number.isFinite(properties.spellAttackBonus)
      ? properties.spellAttackBonus
      : null;
  return {
    spellSaveDc: dc,
    spellAttackBonus: attack,
    requiresComponents: properties.requiresComponents === true,
    useCasterAbility: properties.useCasterAbility === true,
    itemCastSlotRule: parseSlotRule(properties.itemCastSlotRule),
    itemCastSlotRules: parseSlotRulesMap(properties.itemCastSlotRules),
  };
}

/** Escolhe regra de círculo: mapa por resource → regra do item → null (default). */
export function pickItemCastSlotRule(
  parsed: ParsedItemCastProperties,
  resourceSlug?: string | null,
): ItemCastSlotRule | null {
  if (resourceSlug && parsed.itemCastSlotRules[resourceSlug]) {
    return parsed.itemCastSlotRules[resourceSlug];
  }
  return parsed.itemCastSlotRule;
}

export function buildItemCastTreasureNotes(
  input: ItemCastTreasureNotesInput,
): ItemCastTreasureNotes {
  const lines: string[] = [];
  if (!input.requiresComponents) {
    lines.push(
      'Item: sem componentes materiais/verbais/somáticos além do item.',
    );
  }
  if (input.spellRequiresConcentration) {
    lines.push('Item: concentração da magia se aplica normalmente.');
  }
  if (input.useCasterAbility && !input.casterHasSpellcastingAbility) {
    lines.push(
      'Item: sem atributo de conjuração do usuário — use modificador +0 + PB.',
    );
  }
  const spellSaveDcOverride =
    input.spellSaveDc != null && Number.isFinite(input.spellSaveDc)
      ? input.spellSaveDc
      : null;
  const spellAttackBonusOverride =
    input.spellAttackBonus != null && Number.isFinite(input.spellAttackBonus)
      ? input.spellAttackBonus
      : null;
  if (spellSaveDcOverride != null) {
    lines.push(`Item: CD ${spellSaveDcOverride}.`);
  }
  if (spellAttackBonusOverride != null) {
    lines.push(`Item: ataque mágico +${spellAttackBonusOverride}.`);
  }
  return {
    lines,
    spellSaveDcOverride,
    spellAttackBonusOverride,
  };
}
