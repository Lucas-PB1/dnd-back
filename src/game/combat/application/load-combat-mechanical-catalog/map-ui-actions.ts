import type { PhbClassPanelAction } from '@entities/class/phb-class-panel-action.entity';
import type { VPhbClassEconomyAction } from '@entities/views/v-phb-class-economy-action.entity';
import type {
  ActionEconomyBucket,
  ClassEconomyActionRecord,
  ClassPanelActionRecord,
  PanelActionSection,
} from '../../domain/class-action-ui-catalog';

const ECONOMY_BUCKETS = new Set<ActionEconomyBucket>([
  'action',
  'bonus',
  'reaction',
  'free',
]);

const PANEL_SECTIONS = new Set<PanelActionSection>([
  'base',
  'subclass',
  'metamagic',
  'channel',
]);

function asEconomyBucket(value: string): ActionEconomyBucket {
  return ECONOMY_BUCKETS.has(value as ActionEconomyBucket)
    ? (value as ActionEconomyBucket)
    : 'free';
}

function asPanelSection(value: string): PanelActionSection {
  return PANEL_SECTIONS.has(value as PanelActionSection)
    ? (value as PanelActionSection)
    : 'base';
}

function pickPlayableText(
  ...candidates: Array<string | null | undefined>
): string | undefined {
  let best: string | undefined;
  for (const candidate of candidates) {
    const text = candidate?.trim();
    if (!text) continue;
    if (!best || text.length > best.length) best = text;
  }
  return best;
}

export function mapEconomyActions(
  economyRows: VPhbClassEconomyAction[],
): ClassEconomyActionRecord[] {
  return economyRows.map((row) => ({
    id: row.actionId,
    name: row.name,
    economy: asEconomyBucket(row.economy),
    classSlug: row.classSlug ?? undefined,
    minLevel: Number(row.unlockLevel),
    subclassSlug: row.subclassSlug ?? undefined,
    speciesSlug: row.speciesSlug ?? undefined,
    featSlug: row.featSlug ?? undefined,
    itemSlug: row.itemSlug ?? undefined,
    heritageTraitSlug: row.heritageTraitSlug ?? undefined,
    threadSlug: row.threadSlug ?? undefined,
    minTraitTakes:
      row.minTraitTakes == null ? undefined : Number(row.minTraitTakes),
    requiresOptionKey: row.requiresOptionKey ?? undefined,
    requiresOptionValue: row.requiresOptionValue ?? undefined,
    resourceSlug: row.resourceSlug ?? undefined,
    freeResourceSlug: row.freeResourceSlug ?? undefined,
    alwaysSpendsResource: Boolean(row.alwaysSpendsResource) || undefined,
    summary: row.summary ?? undefined,
    description: row.description ?? undefined,
    tableAction: row.tableAction ?? undefined,
    spendAmount: row.spendAmount == null ? undefined : Number(row.spendAmount),
    spellSlug: row.spellSlug ?? undefined,
  }));
}

export function mapPanelActions(
  economyRows: VPhbClassEconomyAction[],
  panelRows: PhbClassPanelAction[],
): ClassPanelActionRecord[] {
  const economyTextByKey = new Map<string, string>();
  for (const row of economyRows) {
    if (!row.classSlug || !row.tableAction) continue;
    const text = pickPlayableText(row.description, row.summary);
    if (!text) continue;
    economyTextByKey.set(`${row.classSlug}|${row.tableAction}`, text);
  }
  return panelRows.map((row) => ({
    panelKey: row.panelKey,
    classSlug: row.klass.slug,
    subclassSlug: row.subclass?.slug ?? undefined,
    slug: row.slug,
    name: row.name,
    title: row.title ?? undefined,
    description: pickPlayableText(
      economyTextByKey.get(`${row.klass.slug}|${row.slug}`),
      row.title,
    ),
    minLevel: Number(row.unlockLevel),
    resourceSlug: row.resourceSlug ?? undefined,
    section: asPanelSection(row.section),
    spendsFocus: Boolean(row.spendsFocus),
    sortOrder: Number(row.sortOrder),
  }));
}
