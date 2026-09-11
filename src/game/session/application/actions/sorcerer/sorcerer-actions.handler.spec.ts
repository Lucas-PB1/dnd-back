import { BadRequestException } from '@nestjs/common';
import type { CatalogEffect } from '@game/effects';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { SorcererActionsHandler } from './sorcerer-actions.handler';

const SORCERER_ECONOMY = [
  {
    id: 'sorc-convert-slot-1',
    name: 'Converter Slot 1º',
    economy: 'free' as const,
    classSlug: 'sorcerer',
    minLevel: 2,
    alwaysSpendsResource: false,
    tableAction: 'convert-slot-1-to-points',
    itemSlug: null,
    featSlug: null,
    description: 'Convert',
  },
  {
    id: 'sorc-convert-points-1',
    name: 'Criar Slot 1º',
    economy: 'free' as const,
    classSlug: 'sorcerer',
    minLevel: 2,
    resourceSlug: 'sorceryPoints',
    alwaysSpendsResource: true,
    spendAmount: 2,
    tableAction: 'convert-points-to-slot-1',
    itemSlug: null,
    featSlug: null,
    description: 'Convert',
  },
  {
    id: 'sorc-use-metamagic',
    name: 'Metamagia',
    economy: 'free' as const,
    classSlug: 'sorcerer',
    minLevel: 2,
    resourceSlug: 'sorceryPoints',
    alwaysSpendsResource: false,
    tableAction: 'use-metamagic',
    itemSlug: null,
    featSlug: null,
    description: 'Meta',
  },
  {
    id: 'sorc-innate',
    name: 'Feitiçaria Inata',
    economy: 'bonus' as const,
    classSlug: 'sorcerer',
    minLevel: 1,
    resourceSlug: 'innate-sorcery',
    alwaysSpendsResource: true,
    tableAction: 'innate-sorcery',
    itemSlug: null,
    featSlug: null,
    description: 'Innate',
  },
  {
    id: 'sorc-tides',
    name: 'Marés do Caos',
    economy: 'free' as const,
    classSlug: 'sorcerer',
    subclassSlug: 'wild-magic',
    minLevel: 3,
    resourceSlug: 'tides-of-chaos',
    alwaysSpendsResource: true,
    tableAction: 'tides-of-chaos',
    itemSlug: null,
    featSlug: null,
    description: 'Tides',
  },
  {
    id: 'sorc-bastion',
    name: 'Bastião da Lei',
    economy: 'action' as const,
    classSlug: 'sorcerer',
    subclassSlug: 'clockwork',
    minLevel: 6,
    resourceSlug: 'sorceryPoints',
    alwaysSpendsResource: false,
    tableAction: 'bastion-of-law',
    itemSlug: null,
    featSlug: null,
    description: 'Bastion',
  },
  {
    id: 'sorc-heroic',
    name: 'Alma Heróica',
    economy: 'free' as const,
    classSlug: 'sorcerer',
    subclassSlug: 'heroic-sorcery',
    minLevel: 3,
    resourceSlug: 'sorceryPoints',
    alwaysSpendsResource: true,
    spendAmount: 1,
    tableAction: 'heroic-soul',
    itemSlug: null,
    featSlug: null,
    description: 'Heroic',
  },
];

const SORCERER_EFFECTS: CatalogEffect[] = [
  {
    kind: 'table_note',
    ownerKind: 'subclass',
    ownerSlug: 'wild-magic',
    unlockLevel: 3,
    trigger: 'on_table_action',
    actionSlug: 'tides-of-chaos',
    note: { note: 'Marés do Caos' },
  } as CatalogEffect,
  {
    kind: 'table_note',
    ownerKind: 'subclass',
    ownerSlug: 'clockwork',
    unlockLevel: 6,
    trigger: 'on_table_action',
    actionSlug: 'bastion-of-law',
    note: { note: 'Bastião {total}d8' },
  } as CatalogEffect,
  {
    kind: 'temp_hp',
    ownerKind: 'subclass',
    ownerSlug: 'heroic-sorcery',
    unlockLevel: 3,
    trigger: 'on_table_action',
    actionSlug: 'heroic-soul',
    dice: { die: '1d6' },
    note: { note: 'Alma Heróica {total} PV temp ({expression}) aplicados na ficha.' },
  } as CatalogEffect,
];

describe('SorcererActionsHandler', () => {
  const sorcerer = createTestCharacter({
    id: 'sorc-1',
    classSlug: 'sorcerer',
    subclassSlug: 'wild-magic',
    level: 5,
    abilityScores: createTestAbilityScores({
      forca: 8,
      destreza: 14,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 10,
      carisma: 18,
    }),
  });
  const ctx = createTableActionHandlerTestContext({
    stateResponse: {
      classResources: [
        {
          slug: 'innate-sorcery',
          remaining: 2,
          max: 2,
          used: 0,
          name: 'Feitiçaria Inata',
        },
        {
          slug: 'sorceryPoints',
          remaining: 5,
          max: 5,
          used: 0,
          name: 'Pontos de Feitiçaria',
        },
      ],
      tempHp: 0,
    },
    defaultCharacter: sorcerer,
    mechanicalCatalogLoad: { economyActions: SORCERER_ECONOMY },
  });
  const dataSource = {
    query: jest.fn().mockResolvedValue([{ value_id: 'subtle-spell' }]),
  };
  const effectCatalog = { load: jest.fn().mockResolvedValue(SORCERER_EFFECTS) };
  let handler: SorcererActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    dataSource.query.mockResolvedValue([{ value_id: 'subtle-spell' }]);
    effectCatalog.load.mockImplementation(({ actionSlug }: { actionSlug?: string }) =>
      Promise.resolve(
        SORCERER_EFFECTS.filter((effect) => effect.actionSlug === actionSlug),
      ),
    );
    handler = new SorcererActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.domain),
      asHandlerDep(dataSource),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep(effectCatalog),
    );
  });

  it('converts level 1 spell slot to 1 sorcery point', async () => {
    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'convert-slot-1-to-points',
    });

    expect(ctx.state.consumeSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      1,
    );
    expect(ctx.state.recoverClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      1,
    );
    expect(result.note).toContain('consumiu 1 Slot de 1º círculo');
  });

  it('converts sorcery points to level 1 spell slot (cost 2 points)', async () => {
    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'convert-points-to-slot-1',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      2,
    );
    expect(ctx.state.recoverSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      1,
    );
    expect(result.note).toContain('gastou 2 Pontos de Feitiçaria');
  });

  it('spends sorcery points for a known Metamagic option', async () => {
    dataSource.query
      .mockResolvedValueOnce([
        {
          slug: 'subtle-spell',
          name: 'Magia Sutil',
          description: 'Sem componentes V/S/M',
          cost: 1,
          stacks_with_other: false,
        },
      ])
      .mockResolvedValueOnce([{ value_id: 'subtle-spell' }]);

    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'use-metamagic',
      metamagicSlug: 'subtle-spell',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      1,
    );
    expect(result.actionName).toBe('Magia Sutil');
  });

  it('activates Feitiçaria Inata spending one use', async () => {
    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'innate-sorcery',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'innate-sorcery',
      1,
    );
    expect(result.actionName).toBe('Feitiçaria Inata');
  });

  it('spends tides-of-chaos resource for Marés do Caos', async () => {
    ctx.state.buildResponse.mockResolvedValue({
      ...ctx.stateResponse,
      classResources: [
        {
          slug: 'tides-of-chaos',
          remaining: 1,
          max: 1,
          used: 0,
          name: 'Marés do Caos',
        },
        {
          slug: 'sorceryPoints',
          remaining: 5,
          max: 5,
          used: 0,
          name: 'Pontos de Feitiçaria',
        },
      ],
    });

    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'tides-of-chaos',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'tides-of-chaos',
      1,
    );
    expect(result.actionName).toBe('Marés do Caos');
  });

  it('spends variable sorcery points for Bastião da Lei', async () => {
    ctx.mockCharacter({ ...sorcerer, subclassSlug: 'clockwork', level: 6 });

    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'bastion-of-law',
      pointsSpent: 4,
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      4,
    );
    expect(result.note).toContain('4d8');
  });

  it('rejects bastion cost outside 1–5', async () => {
    ctx.mockCharacter({ ...sorcerer, subclassSlug: 'clockwork', level: 6 });

    await expect(
      handler.useTableAction('user-1', 'sorc-1', {
        actionSlug: 'bastion-of-law',
        pointsSpent: 6,
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects Sorcerer actions for non-sorcerer characters', async () => {
    ctx.mockCharacterOnce({ ...sorcerer, classSlug: 'cleric' });

    await expect(
      handler.useTableAction('user-1', 'sorc-1', {
        actionSlug: 'convert-slot-1-to-points',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rolls and applies temporary HP for Heroic Soul', async () => {
    ctx.mockCharacterOnce({
      ...sorcerer,
      subclassSlug: 'heroic-sorcery',
      level: 5,
    });

    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'heroic-soul',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      1,
    );
    expect(result.expression).toMatch(/^1d6\+5$/);
    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      expect.objectContaining({ tempHp: result.total }),
    );
    expect(result.note).toContain('aplicados na ficha');
  });
});
