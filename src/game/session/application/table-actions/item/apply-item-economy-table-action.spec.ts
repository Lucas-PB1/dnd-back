import { BadRequestException } from '@nestjs/common';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { loadActiveItemSlugs } from '@game/session/infrastructure/queries/class-resource-character.queries';
import { applyItemEconomyTableAction } from './apply-item-economy-table-action';

jest.mock(
  '@game/session/infrastructure/queries/class-resource-character.queries',
  () => ({
    loadActiveItemSlugs: jest.fn(),
  }),
);

const loadActive = loadActiveItemSlugs as jest.MockedFunction<
  typeof loadActiveItemSlugs
>;

const character = {
  id: 'c1',
  level: 5,
  hitPointsCurrent: 10,
  hitPointsMax: 40,
} as PlayerCharacter;

const economyActions: ClassEconomyActionRecord[] = [
  {
    id: 'item-pocao-de-cura-usar',
    name: 'Beber · Poção de Cura',
    economy: 'bonus',
    itemSlug: 'pocao-de-cura',
    minLevel: 1,
    alwaysSpendsResource: false,
    summary: 'Beber: 2d4 + 2 PV',
  },
  {
    id: 'item-anel-de-evasao-usar',
    name: 'Anel de Evasão · Sucesso',
    economy: 'reaction',
    itemSlug: 'anel-de-evasao',
    minLevel: 1,
    resourceSlug: 'anelEvasaoCharges',
    alwaysSpendsResource: true,
    tableAction: 'spend-resource',
    spendAmount: 1,
    summary: 'Gastar 1 carga',
  },
  {
    id: 'item-pocao-da-saude-usar',
    name: 'Beber · Poção da Saúde',
    economy: 'bonus',
    itemSlug: 'pocao-da-saude',
    minLevel: 1,
    alwaysSpendsResource: false,
    summary: 'Beber: limpa condições',
  },
];

function baseEffect(partial: Record<string, unknown>) {
  return {
    ownerKind: 'item',
    ownerId: '1',
    trigger: 'on_table_action',
    unlockLevel: 1,
    sortOrder: 0,
    minTraitTakes: 1,
    resourceSlug: null,
    label: null,
    requiresOptionKey: null,
    requiresOptionValue: null,
    spell: null,
    castEconomy: null,
    numeric: null,
    note: null,
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
    dice: null,
    ...partial,
  };
}

describe('applyItemEconomyTableAction', () => {
  const mechanicalCatalog = {
    load: async () => ({ economyActions, panelActions: [] }),
  };
  const state = {
    useClassResource: jest.fn(async () => ({
      state: { classResources: [], conditions: [] },
    })),
    buildResponse: jest.fn(async () => ({
      classResources: [],
      tempHp: 0,
      conditions: ['blinded', 'poisoned'],
    })),
    applyCurrentHitPoints: jest.fn(async (_c, hp: number) => ({
      classResources: [],
      hitPointsCurrent: hp,
      conditions: [],
    })),
    patch: jest.fn(async (_c, dto: { conditions?: string[]; tempHp?: number }) => ({
      classResources: [],
      conditions: dto.conditions ?? [],
      tempHp: dto.tempHp ?? 0,
    })),
  };
  const items = {
    findOne: jest.fn(),
    save: jest.fn(),
    remove: jest.fn(),
  };

  beforeEach(() => {
    jest.clearAllMocks();
    items.findOne.mockResolvedValue({
      characterId: 'c1',
      itemSlug: 'pocao-de-cura',
      quantity: 2,
    });
  });

  it('cura com poção, consome 1 de quantidade e não gasta pool', async () => {
    const effectCatalog = {
      load: jest.fn().mockResolvedValue([
        baseEffect({
          id: 'heal-1',
          kind: 'heal',
          ownerSlug: 'pocao-de-cura',
          actionSlug: 'item-pocao-de-cura-usar',
          numeric: { amountFormula: 'fixed', flat: 2 },
          dice: { die: '2d4', dieAtLevel: null, atLevel: null, damageTypeSlug: null },
          note: { note: 'Poção de Cura.' },
        }),
      ]),
    };

    const result = await applyItemEconomyTableAction(
      {
        state: state as never,
        mechanicalCatalog: mechanicalCatalog as never,
        effectCatalog: effectCatalog as never,
        items: items as never,
      },
      character,
      'pocao-de-cura',
      'item-pocao-de-cura-usar',
    );

    expect(state.useClassResource).not.toHaveBeenCalled();
    expect(state.applyCurrentHitPoints).toHaveBeenCalled();
    expect(result.resourceSpent).toBe(false);
    expect(result.total).toBeGreaterThanOrEqual(4);
    expect(result.total).toBeLessThanOrEqual(10);
    expect(items.save).toHaveBeenCalledWith(
      expect.objectContaining({ quantity: 1 }),
    );
  });

  it('gasta carga de item ativo sem consumir quantidade', async () => {
    loadActive.mockResolvedValue(['anel-de-evasao']);
    const effectCatalog = { load: jest.fn().mockResolvedValue([]) };

    const result = await applyItemEconomyTableAction(
      {
        state: state as never,
        mechanicalCatalog: mechanicalCatalog as never,
        effectCatalog: effectCatalog as never,
        dataSource: {} as never,
      },
      character,
      'anel-de-evasao',
      'item-anel-de-evasao-usar',
    );

    expect(state.useClassResource).toHaveBeenCalledWith(
      character,
      'anelEvasaoCharges',
      1,
    );
    expect(result.resourceSpent).toBe(true);
    expect(items.findOne).not.toHaveBeenCalled();
    expect(items.save).not.toHaveBeenCalled();
  });

  it('recusa carga se o item não está ativo', async () => {
    loadActive.mockResolvedValue([]);
    await expect(
      applyItemEconomyTableAction(
        {
          state: state as never,
          mechanicalCatalog: mechanicalCatalog as never,
          dataSource: {} as never,
        },
        character,
        'anel-de-evasao',
        'item-anel-de-evasao-usar',
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('limpa condições da Poção da Saúde e consome o frasco', async () => {
    items.findOne.mockResolvedValue({
      characterId: 'c1',
      itemSlug: 'pocao-da-saude',
      quantity: 1,
    });
    const effectCatalog = {
      load: jest.fn().mockResolvedValue([
        baseEffect({
          id: 'c1',
          kind: 'clear_condition',
          ownerSlug: 'pocao-da-saude',
          actionSlug: 'item-pocao-da-saude-usar',
          condition: { conditionSlug: 'blinded', pendingKind: null },
        }),
        baseEffect({
          id: 'c2',
          kind: 'clear_condition',
          ownerSlug: 'pocao-da-saude',
          actionSlug: 'item-pocao-da-saude-usar',
          condition: { conditionSlug: 'poisoned', pendingKind: null },
        }),
      ]),
    };

    const result = await applyItemEconomyTableAction(
      {
        state: state as never,
        mechanicalCatalog: mechanicalCatalog as never,
        effectCatalog: effectCatalog as never,
        items: items as never,
      },
      character,
      'pocao-da-saude',
      'item-pocao-da-saude-usar',
    );

    expect(state.patch).toHaveBeenCalled();
    expect(items.remove).toHaveBeenCalled();
    expect(result.note).toContain('Condição encerrada');
  });
});
