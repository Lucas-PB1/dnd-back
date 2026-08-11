/** Barding PHB Cap. 6 — armadura de montaria (custo ×4, peso ×2). */

export const BARDING_SLUG_PREFIX = 'barding-';

export function parseBardingBaseArmorSlug(itemSlug: string): string | null {
  if (!itemSlug.startsWith(BARDING_SLUG_PREFIX)) return null;
  const base = itemSlug.slice(BARDING_SLUG_PREFIX.length).trim();
  return base || null;
}

export function bardingSlugForArmor(armorSlug: string): string {
  return `${BARDING_SLUG_PREFIX}${armorSlug}`;
}

/** Multiplica peso textual (ex. `6,5 kg` → `13 kg`). */
export function scaleWeightText(weight: string | null, factor: number): string | null {
  if (!weight?.trim() || weight.trim() === '—') return weight;
  const match = weight.trim().match(/^([\d.,]+)\s*(.*)$/);
  if (!match) return weight;
  const n = Number(match[1].replace(/\./g, '').replace(',', '.'));
  if (!Number.isFinite(n)) return weight;
  const scaled = n * factor;
  const formatted = Number.isInteger(scaled)
    ? String(scaled)
    : String(scaled).replace('.', ',');
  const unit = match[2]?.trim() ?? '';
  return unit ? `${formatted} ${unit}` : formatted;
}

export function scaleCostGpText(costText: string, factor: number): string {
  const match = costText.trim().match(/^([\d.]+)\s*(PO|PP|PC|PE|PL)$/i);
  if (!match) return costText;
  const amount = Number(match[1].replace(/\./g, ''));
  if (!Number.isFinite(amount)) return costText;
  const scaled = amount * factor;
  const formatted = scaled.toLocaleString('pt-BR').replace(/\u00a0/g, '.');
  return `${formatted} ${match[2].toUpperCase()}`;
}
