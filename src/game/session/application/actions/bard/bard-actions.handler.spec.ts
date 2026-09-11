import { BadRequestException } from '@nestjs/common';
import { FIXTURE_PERSONA_MASK_SLUGS } from '@game/combat/domain/__fixtures__/mechanical-catalog';
import type { CatalogEffect } from '@game/effects';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { BardActionsHandler } from './bard-actions.handler';

const BARD_ECONOMY = [
  {
    id: 'bard-grant-inspiration',
    name: 'Conceder Inspiração',
    economy: 'bonus' as const,
    classSlug: 'bard',
    minLevel: 1,
    resourceSlug: 'bardicInspiration',
    alwaysSpendsResource: true,
    tableAction: 'grant-inspiration',
    itemSlug: null,
    featSlug: null,
    description: 'Conceder.',
  },
  {
    id: 'bard-cutting-words',
    name: 'Palavras de Interrupção',
    economy: 'reaction' as const,
    classSlug: 'bard',
    subclassSlug: 'lore',
    minLevel: 3,
    resourceSlug: 'bardicInspiration',
    alwaysSpendsResource: true,
    tableAction: 'cutting-words',
    itemSlug: null,
    featSlug: null,
    description: 'Cutting.',
  },
  {
    id: 'bard-peerless-skill',
    name: 'Perícia Inigualável',
    economy: 'free' as const,
    classSlug: 'bard',
    subclassSlug: 'lore',
    minLevel: 14,
    resourceSlug: 'bardicInspiration',
    alwaysSpendsResource: true,
    tableAction: 'peerless-skill',
    itemSlug: null,
    featSlug: null,
    description: 'Peerless.',
  },
  {
    id: 'bard-mantle-of-inspiration',
    name: 'Manto de Inspiração',
    economy: 'bonus' as const,
    classSlug: 'bard',
    subclassSlug: 'glamour',
    minLevel: 3,
    resourceSlug: 'bardicInspiration',
    alwaysSpendsResource: true,
    tableAction: 'mantle-of-inspiration',
    itemSlug: null,
    featSlug: null,
    description: 'Manto.',
  },
  {
    id: 'bard-mantle-of-majesty',
    name: 'Manto de Majestade',
    economy: 'bonus' as const,
    classSlug: 'bard',
    subclassSlug: 'glamour',
    minLevel: 6,
    resourceSlug: 'mantle-of-majesty',
    alwaysSpendsResource: true,
    tableAction: 'mantle-of-majesty',
    itemSlug: null,
    featSlug: null,
    description: 'Majestade.',
  },
  {
    id: 'bard-unarmed-dance',
    name: 'Ataque Desarmado (Dança)',
    economy: 'action' as const,
    classSlug: 'bard',
    subclassSlug: 'dance',
    minLevel: 3,
    alwaysSpendsResource: false,
    tableAction: 'unarmed-dance',
    itemSlug: null,
    featSlug: null,
    description: 'Dança.',
  },
  {
    id: 'bard-coordinated-movement',
    name: 'Movimento Coordenado',
    economy: 'free' as const,
    classSlug: 'bard',
    subclassSlug: 'dance',
    minLevel: 6,
    resourceSlug: 'bardicInspiration',
    alwaysSpendsResource: true,
    tableAction: 'coordinated-movement',
    itemSlug: null,
    featSlug: null,
    description: 'Coordenado.',
  },
  {
    id: 'bard-skald-bragi-rune',
    name: 'Runa da Fala de Bragi',
    economy: 'bonus' as const,
    classSlug: 'bard',
    subclassSlug: 'skald',
    minLevel: 6,
    resourceSlug: 'bardicInspiration',
    alwaysSpendsResource: true,
    tableAction: 'bragi-rune',
    itemSlug: null,
    featSlug: null,
    description: 'Bragi.',
  },
  {
    id: 'bard-persona-angel',
    name: 'Máscara — Anjo',
    economy: 'free' as const,
    classSlug: 'bard',
    subclassSlug: 'college-of-masks',
    minLevel: 3,
    resourceSlug: 'bardicInspiration',
    alwaysSpendsResource: true,
    tableAction: 'persona-angel',
    itemSlug: null,
    featSlug: null,
    description: 'Anjo.',
  },
  {
    id: 'bard-superior-inspiration',
    name: 'Inspiração Superior',
    economy: 'free' as const,
    classSlug: 'bard',
    minLevel: 18,
    resourceSlug: 'bardicInspiration',
    alwaysSpendsResource: false,
    tableAction: 'superior-inspiration',
    itemSlug: null,
    featSlug: null,
    description: 'Superior.',
  },
  {
    id: 'bard-set-persona-masks',
    name: 'Vestir Máscaras de Persona',
    economy: 'free' as const,
    classSlug: 'bard',
    subclassSlug: 'college-of-masks',
    minLevel: 3,
    alwaysSpendsResource: false,
    tableAction: 'set-persona-masks',
    itemSlug: null,
    featSlug: null,
    description: 'Máscaras.',
  },
];

function effect(
  partial: Partial<CatalogEffect> &
    Pick<CatalogEffect, 'kind' | 'actionSlug' | 'ownerKind'>,
): CatalogEffect {
  return {
    id: partial.id ?? `${partial.kind}-${partial.actionSlug}`,
    ownerId: '1',
    minTraitTakes: 0,
    requiresOptionKey: partial.requiresOptionKey ?? null,
    requiresOptionValue: partial.requiresOptionValue ?? null,
    spell: null,
    castEconomy: null,
    resource: null,
    combatMod: null,
    proficiency: null,
    purchaseDiscount: null,
    damageDie: null,
    weapon: null,
    feat: null,
    saveAdvantage: null,
    sense: null,
    damageType: null,
    language: null,
    checkAdvantage: null,
    reach: null,
    restQuirk: null,
    environmentalImmunity: null,
    condition: null,
    save: null,
    forcedMovement: null,
    kind: partial.kind,
    ownerKind: partial.ownerKind,
    ownerSlug:
      partial.ownerSlug ??
      (partial.ownerKind === 'subclass' ? 'lore' : 'bard'),
    trigger: 'on_table_action',
    actionSlug: partial.actionSlug,
    unlockLevel: partial.unlockLevel ?? 1,
    sortOrder: partial.sortOrder ?? 1,
    label: partial.label ?? partial.actionSlug,
    resourceSlug: partial.resourceSlug ?? null,
    numeric: partial.numeric ?? null,
    note: partial.note ?? null,
    dice: partial.dice ?? null,
    combatFlag: partial.combatFlag ?? null,
    companion: partial.companion ?? null,
  };
}

describe('BardActionsHandler', () => {
  const bard = createTestCharacter({
    id: 'bard-1',
    classSlug: 'bard',
    subclassSlug: 'lore',
    level: 5,
    abilityScores: createTestAbilityScores({
      forca: 8,
      destreza: 14,
      constituicao: 12,
      inteligencia: 10,
      sabedoria: 12,
      carisma: 16,
    }),
  });
  const ctx = createTableActionHandlerTestContext({
    stateResponse: { tempHp: 0, personaMasks: [] as string[] },
    defaultCharacter: bard,
    mechanicalCatalogLoad: {
      economyActions: BARD_ECONOMY,
      personaMasks: FIXTURE_PERSONA_MASK_SLUGS.map((slug) => ({
        slug,
        name: slug,
      })),
      personaMaskSlugs: [...FIXTURE_PERSONA_MASK_SLUGS],
    },
  });
  const effectCatalog = {
    load: jest.fn().mockResolvedValue([] as CatalogEffect[]),
  };
  let handler: BardActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    effectCatalog.load.mockResolvedValue([]);
    handler = new BardActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep(effectCatalog),
    );
  });

  it('spends Bardic Inspiration and returns correct die for level 5', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_roll',
        actionSlug: 'grant-inspiration',
        ownerKind: 'class',
        numeric: { amountFormula: 'schedule_die_plus_flat', flat: null },
        note: {
          note: 'Inspiração de Bardo ({expression}): concedida.',
        },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'grant-inspiration',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      'bardicInspiration',
      1,
    );
    expect(result.expression).toBe('1d8');
    expect(result.note).toContain('Inspiração de Bardo (1d8)');
  });

  it('resolves Cutting Words for Lore Bard', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_roll',
        actionSlug: 'cutting-words',
        ownerKind: 'subclass',
        ownerSlug: 'lore',
        unlockLevel: 3,
        numeric: { amountFormula: 'schedule_die_plus_flat', flat: null },
        note: { note: 'Palavras de Interrupção: {total} ({expression}).' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'cutting-words',
    });

    expect(result.expression).toBe('1d8');
    expect(result.note).toContain('Palavras de Interrupção');
  });

  it('resolves Peerless Skill for Lore Bard at level 14+', async () => {
    ctx.mockCharacterOnce({ ...bard, subclassSlug: 'lore', level: 14 });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_roll',
        actionSlug: 'peerless-skill',
        ownerKind: 'subclass',
        ownerSlug: 'lore',
        unlockLevel: 14,
        numeric: { amountFormula: 'schedule_die_plus_flat', flat: null },
        note: { note: 'Perícia Inigualável: +{total} ({expression}).' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'peerless-skill',
    });

    expect(result.expression).toBe('1d10');
    expect(result.note).toContain('Perícia Inigualável');
    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      'bardicInspiration',
      1,
    );
  });

  it('resolves Mantle of Inspiration for Glamour Bard (PHB 2024)', async () => {
    ctx.mockCharacterOnce({ ...bard, subclassSlug: 'glamour' });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'temp_hp',
        actionSlug: 'mantle-of-inspiration',
        ownerKind: 'subclass',
        ownerSlug: 'glamour',
        unlockLevel: 3,
        numeric: { amountFormula: 'schedule_die_double_plus_flat', flat: null },
        note: { note: 'Manto de Inspiração: {total} PV temp. ({expression}).' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'mantle-of-inspiration',
    });

    expect(result.expression).toBe('2d8');
    expect(result.note).toContain('Manto de Inspiração');
    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      expect.objectContaining({ tempHp: result.total }),
    );
  });

  it('resolves Bragi Rune Vitalidade for Skald at level 6+', async () => {
    ctx.mockCharacterOnce({ ...bard, subclassSlug: 'skald', level: 6 });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'temp_hp',
        actionSlug: 'bragi-rune',
        ownerKind: 'subclass',
        ownerSlug: 'skald',
        unlockLevel: 6,
        numeric: { amountFormula: 'schedule_die_plus_flat', flat: null },
        note: { note: 'Vitalidade: {total} PV temp. ({expression}).' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'bragi-rune',
    });

    expect(result.expression).toBe('1d8');
    expect(result.resourceSpent).toBe(true);
    expect(result.note).toContain('Vitalidade');
    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      'bardicInspiration',
      1,
    );
    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      expect.objectContaining({ tempHp: result.total }),
    );
  });

  it('resolves Mantle of Majesty spending resource for Glamour Bard at level 6+', async () => {
    ctx.mockCharacterOnce({ ...bard, subclassSlug: 'glamour', level: 6 });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'mantle-of-majesty',
        ownerKind: 'subclass',
        ownerSlug: 'glamour',
        unlockLevel: 6,
        note: { note: 'Manto de Majestade: Comando.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'mantle-of-majesty',
    });

    expect(result.resourceSpent).toBe(true);
    expect(result.note).toContain('Comando');
    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      'mantle-of-majesty',
      1,
    );
  });

  it('resolves Unarmed Dance with Dexterity for Dance Bard', async () => {
    ctx.mockCharacterOnce({ ...bard, subclassSlug: 'dance' });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_roll',
        actionSlug: 'unarmed-dance',
        ownerKind: 'subclass',
        ownerSlug: 'dance',
        unlockLevel: 3,
        numeric: { amountFormula: 'schedule_die_plus_flat', flat: null },
        note: {
          note: 'Ataque Desarmado (Dança): usa Destreza; dano {total} ({expression}).',
        },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'unarmed-dance',
    });

    expect(result.note).toContain('Destreza');
    expect(result.resourceSpent).toBe(false);
    expect(result.expression).toMatch(/^1d8\+/);
  });

  it('resolves Coordinated Movement for Dance Bard at level 6+', async () => {
    ctx.mockCharacterOnce({ ...bard, subclassSlug: 'dance', level: 6 });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_roll',
        actionSlug: 'coordinated-movement',
        ownerKind: 'subclass',
        ownerSlug: 'dance',
        unlockLevel: 6,
        numeric: { amountFormula: 'schedule_die_plus_flat', flat: null },
        note: { note: 'Movimento Coordenado: +{total} ({expression}).' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'coordinated-movement',
    });

    expect(result.note).toContain('Movimento Coordenado');
    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      'bardicInspiration',
      1,
    );
  });

  it('rejects persona mask action without equipped mask', async () => {
    ctx.mockCharacterOnce({
      ...bard,
      subclassSlug: 'college-of-masks',
      level: 3,
    });
    ctx.state.buildResponse.mockResolvedValue({
      ...ctx.stateResponse,
      personaMasks: [],
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_roll',
        actionSlug: 'persona-angel',
        ownerKind: 'subclass',
        ownerSlug: 'college-of-masks',
        unlockLevel: 3,
        requiresOptionKey: 'equipped_persona_mask',
        requiresOptionValue: 'persona-mask-angel',
        numeric: { amountFormula: 'schedule_die_plus_flat', flat: null },
        note: { note: 'Anjo.' },
      }),
    ]);

    await expect(
      handler.useTableAction('user-1', 'bard-1', {
        actionSlug: 'persona-angel',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('resolves persona angel when mask is equipped', async () => {
    ctx.mockCharacterOnce({
      ...bard,
      subclassSlug: 'college-of-masks',
      level: 3,
    });
    ctx.state.buildResponse.mockResolvedValue({
      ...ctx.stateResponse,
      personaMasks: ['persona-mask-angel'],
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_roll',
        actionSlug: 'persona-angel',
        ownerKind: 'subclass',
        ownerSlug: 'college-of-masks',
        unlockLevel: 3,
        requiresOptionKey: 'equipped_persona_mask',
        requiresOptionValue: 'persona-mask-angel',
        numeric: { amountFormula: 'schedule_die_plus_flat', flat: null },
        note: { note: 'Anjo: +{total} ({expression}).' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'persona-angel',
    });

    expect(result.note).toContain('Anjo');
    expect(result.expression).toBe('1d6');
  });

  it('recovers 1 inspiration for Superior Inspiration (level 18)', async () => {
    ctx.mockCharacterOnce({ ...bard, level: 18 });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'recover_resource',
        actionSlug: 'superior-inspiration',
        ownerKind: 'class',
        unlockLevel: 18,
        resourceSlug: 'bardicInspiration',
        note: { note: 'Inspiração Superior.' },
      }),
    ]);

    await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'superior-inspiration',
    });

    expect(ctx.state.recoverClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      'bardicInspiration',
      1,
    );
  });

  it('rejects Bard actions for non-bard characters', async () => {
    ctx.mockCharacterOnce({ ...bard, classSlug: 'fighter' });

    await expect(
      handler.useTableAction('user-1', 'bard-1', {
        actionSlug: 'grant-inspiration',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
