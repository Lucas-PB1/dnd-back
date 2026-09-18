import {
  loadDtoTableActionSlugsByClass,
  loadEconomyTableActionsByClass,
  loadOnTableActionEffectSlugs,
  loadPanelActionSlugsByClass,
  loadSubclassTableActionSlugs,
  unionCatalogForClass,
} from './parse-table-action-slug-catalog';

/**
 * Catálogo economy com table_action ainda sem entrada no DTO @IsIn.
 * Aceito enquanto a rota HTTP não expõe o slug (painel/GH bulk / lembrete).
 * Remover da allowlist ao wirear no DTO.
 */
const ECONOMY_TABLE_ACTION_WITHOUT_DTO: Readonly<
  Record<string, readonly string[]>
> = {
  barbarian: ['beast-kinship'],
  cleric: [
    'create-void',
    'planar-reach',
    'purify-with-fire',
    'spatial-exchange',
    'witch-hunters-strike',
  ],
  druid: ['exsanguinate'],
  monk: [
    'soul-searching-strike',
    'stabilizing-focus',
    'stabilizing-focus-bonus',
  ],
  paladin: ['burning-spirit', 'burning-weapon', 'spend-resource'],
  ranger: ['magic-snare', 'poison-control', 'tripped-defenses'],
  rogue: [
    'escape-invisibility',
    'impressionist-supplies',
    'rune-hexxus',
    'rune-mark',
    'steal-blood',
  ],
  sorcerer: [
    'create-ice',
    'cryomancy-freeze',
    'flash-freeze',
    'spend-resource',
  ],
  warlock: [
    'astral-clarity',
    'creature-of-the-night',
    'hag-s-craft',
    'hag-s-eye',
    'planar-escape',
    'pocketeer-shunt',
    'spend-resource',
  ],
  wizard: [
    'blood-for-blood',
    'cube-detonation',
    'dismiss-cubes',
    'material-enhancement',
    'red-renewal',
    'rematerialize',
  ],
  bard: [],
  fighter: [],
  gunslinger: [],
};

describe('DTO actionSlug vs catálogo (drift)', () => {
  const dtoByClass = loadDtoTableActionSlugsByClass();
  /** Union completa (inclui GH bulk) — DTO ⊆ catálogo. */
  const economyAll = loadEconomyTableActionsByClass();
  /** Economy “wireável” (sem Cap.2 bulk) — catálogo ⊆ DTO ∪ allowlist. */
  const economyWired = loadEconomyTableActionsByClass({
    excludeGrimHollowBulk: true,
  });
  const panel = loadPanelActionSlugsByClass();
  const effects = loadOnTableActionEffectSlugs();
  const subclassActions = loadSubclassTableActionSlugs();

  it('carrega DTOs das 13 classes com rota tipada', () => {
    expect([...dtoByClass.keys()].sort()).toEqual([
      'barbarian',
      'bard',
      'cleric',
      'druid',
      'fighter',
      'gunslinger',
      'monk',
      'paladin',
      'ranger',
      'rogue',
      'sorcerer',
      'warlock',
      'wizard',
    ]);
  });

  it('todo actionSlug do DTO existe no catálogo (economy∪panel∪effect∪subclass_table_action)', () => {
    const missing: string[] = [];
    for (const [classSlug, dtoSlugs] of [...dtoByClass.entries()].sort()) {
      const catalog = unionCatalogForClass(
        classSlug,
        economyAll,
        panel,
        effects,
        subclassActions,
      );
      for (const slug of [...dtoSlugs].sort()) {
        if (!catalog.has(slug)) {
          missing.push(`${classSlug}:${slug}`);
        }
      }
    }
    expect(missing).toEqual([]);
  });

  it('todo table_action de economy wireável está no DTO ou na allowlist explícita', () => {
    const missing: string[] = [];
    for (const [classSlug, catSlugs] of [...economyWired.entries()].sort()) {
      if (!dtoByClass.has(classSlug)) {
        // classes sem DTO tipado (ex. monster-hunter) — fora deste gate
        continue;
      }
      const dto = dtoByClass.get(classSlug)!;
      const allow = new Set(ECONOMY_TABLE_ACTION_WITHOUT_DTO[classSlug] ?? []);
      for (const slug of [...catSlugs].sort()) {
        if (!dto.has(slug) && !allow.has(slug)) {
          missing.push(`${classSlug}:${slug}`);
        }
      }
    }
    expect(missing).toEqual([]);
  });

  it('allowlist só cita slugs que existem no economy wireável e não no DTO', () => {
    const stale: string[] = [];
    for (const [classSlug, allowed] of Object.entries(
      ECONOMY_TABLE_ACTION_WITHOUT_DTO,
    )) {
      const cat = economyWired.get(classSlug) ?? new Set();
      const dto = dtoByClass.get(classSlug) ?? new Set();
      for (const slug of allowed) {
        if (!cat.has(slug) || dto.has(slug)) {
          stale.push(`${classSlug}:${slug}`);
        }
      }
    }
    expect(stale).toEqual([]);
  });
});
