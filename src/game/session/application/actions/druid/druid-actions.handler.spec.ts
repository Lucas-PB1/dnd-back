import { BadRequestException } from '@nestjs/common';
import type { CatalogEffect } from '@game/effects';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { DruidActionsHandler } from './druid-actions.handler';

const DRUID_ECONOMY = [
  {
    id: 'druid-wild-shape',
    name: 'Forma Selvagem',
    economy: 'bonus' as const,
    classSlug: 'druid',
    minLevel: 2,
    resourceSlug: 'wildShape',
    alwaysSpendsResource: true,
    tableAction: 'wild-shape',
    itemSlug: null,
    featSlug: null,
    description: 'WS',
  },
  {
    id: 'druid-wild-shape-end',
    name: 'Encerrar Forma Selvagem',
    economy: 'free' as const,
    classSlug: 'druid',
    minLevel: 2,
    resourceSlug: undefined,
    alwaysSpendsResource: false,
    tableAction: 'wild-shape-end',
    itemSlug: null,
    featSlug: null,
    description: 'End WS',
  },
  {
    id: 'druid-set-known',
    name: 'Definir Formas Conhecidas',
    economy: 'free' as const,
    classSlug: 'druid',
    minLevel: 2,
    resourceSlug: undefined,
    alwaysSpendsResource: false,
    tableAction: 'set-wild-shape-known-forms',
    itemSlug: null,
    featSlug: null,
    description: 'Known',
  },
  {
    id: 'druid-replace-known',
    name: 'Trocar Forma Conhecida',
    economy: 'free' as const,
    classSlug: 'druid',
    minLevel: 2,
    resourceSlug: undefined,
    alwaysSpendsResource: false,
    tableAction: 'replace-wild-shape-known-form',
    itemSlug: null,
    featSlug: null,
    description: 'Replace',
  },
  {
    id: 'druid-wild-companion',
    name: 'Companheiro Selvagem',
    economy: 'action' as const,
    classSlug: 'druid',
    minLevel: 2,
    resourceSlug: undefined,
    alwaysSpendsResource: false,
    tableAction: 'wild-companion',
    itemSlug: null,
    featSlug: null,
    description: 'WC',
  },
  {
    id: 'druid-wild-resurgence-slot',
    name: 'Ressurgimento (Forma → Slot)',
    economy: 'free' as const,
    classSlug: 'druid',
    minLevel: 5,
    resourceSlug: 'wildShape',
    alwaysSpendsResource: true,
    tableAction: 'wild-resurgence-slot',
    itemSlug: null,
    featSlug: null,
    description: 'Resurgence',
  },
  {
    id: 'druid-starry-archer',
    name: 'Forma Estelar: Arqueiro',
    economy: 'bonus' as const,
    classSlug: 'druid',
    subclassSlug: 'stars',
    minLevel: 3,
    resourceSlug: 'wildShape',
    alwaysSpendsResource: true,
    tableAction: 'starry-form-archer',
    itemSlug: null,
    featSlug: null,
    description: 'Archer',
  },
  {
    id: 'druid-moon-combat',
    name: 'Forma Selvagem de Combate',
    economy: 'bonus' as const,
    classSlug: 'druid',
    subclassSlug: 'moon',
    minLevel: 3,
    resourceSlug: 'wildShape',
    alwaysSpendsResource: true,
    tableAction: 'moon-combat-wild-shape',
    itemSlug: null,
    featSlug: null,
    description: 'Moon',
  },
  {
    id: 'druid-land-aid',
    name: 'Auxílio da Terra',
    economy: 'action' as const,
    classSlug: 'druid',
    subclassSlug: 'land',
    minLevel: 3,
    resourceSlug: 'wildShape',
    alwaysSpendsResource: true,
    tableAction: 'land-aid',
    itemSlug: null,
    featSlug: null,
    description: 'Auxílio da Terra',
  },
  {
    id: 'druid-natural-recovery-2',
    name: 'Recuperação Natural (2º)',
    economy: 'free' as const,
    classSlug: 'druid',
    subclassSlug: 'land',
    minLevel: 6,
    resourceSlug: 'natural-recovery',
    alwaysSpendsResource: false,
    tableAction: 'natural-recovery-2',
    itemSlug: null,
    featSlug: null,
    description: 'Recovery',
  },
];

const DRUID_EFFECTS: CatalogEffect[] = [
  {
    kind: 'wild_shape',
    ownerKind: 'class',
    ownerSlug: 'druid',
    unlockLevel: 2,
    trigger: 'on_table_action',
    actionSlug: 'wild-shape',
    note: { note: 'Forma Selvagem' },
  } as CatalogEffect,
  {
    kind: 'wild_shape',
    ownerKind: 'class',
    ownerSlug: 'druid',
    unlockLevel: 2,
    trigger: 'on_table_action',
    actionSlug: 'wild-shape-end',
    note: { note: 'Encerrar Forma Selvagem' },
  } as CatalogEffect,
  {
    kind: 'wild_shape',
    ownerKind: 'class',
    ownerSlug: 'druid',
    unlockLevel: 2,
    trigger: 'on_table_action',
    actionSlug: 'set-wild-shape-known-forms',
    note: { note: 'Definir Formas Conhecidas' },
  } as CatalogEffect,
  {
    kind: 'wild_shape',
    ownerKind: 'class',
    ownerSlug: 'druid',
    unlockLevel: 2,
    trigger: 'on_table_action',
    actionSlug: 'replace-wild-shape-known-form',
    note: { note: 'Trocar Forma Conhecida' },
  } as CatalogEffect,
  {
    kind: 'wild_companion',
    ownerKind: 'class',
    ownerSlug: 'druid',
    unlockLevel: 2,
    trigger: 'on_table_action',
    actionSlug: 'wild-companion',
    note: { note: 'Companheiro Selvagem' },
  } as CatalogEffect,
  {
    kind: 'recover_spell_slot',
    ownerKind: 'subclass',
    ownerSlug: 'land',
    unlockLevel: 6,
    trigger: 'on_table_action',
    actionSlug: 'natural-recovery-2',
    spell: { spellLevel: 2, optionKey: 'fixed_slot' },
    note: { note: 'Recuperação Natural slot 2º' },
  } as CatalogEffect,
  {
    kind: 'table_roll',
    ownerKind: 'subclass',
    ownerSlug: 'land',
    unlockLevel: 3,
    trigger: 'on_table_action',
    actionSlug: 'land-aid',
    numeric: null,
    dice: { die: '2d6' },
    note: {
      note: 'Auxílio da Terra: Esfera 3 m — {total} Necrótico ({expression}) ou metade; cura aliado na área.',
    },
  } as CatalogEffect,
  {
    kind: 'heal',
    ownerKind: 'subclass',
    ownerSlug: 'land',
    unlockLevel: 3,
    trigger: 'on_table_action',
    actionSlug: 'land-aid',
    dice: { die: '2d6' },
  } as CatalogEffect,
  {
    kind: 'moon_combat_wild_shape',
    ownerKind: 'subclass',
    ownerSlug: 'moon',
    unlockLevel: 3,
    trigger: 'on_table_action',
    actionSlug: 'moon-combat-wild-shape',
    note: { note: 'Forma Selvagem de Combate' },
  } as CatalogEffect,
  {
    kind: 'wild_resurgence',
    ownerKind: 'class',
    ownerSlug: 'druid',
    unlockLevel: 5,
    trigger: 'on_table_action',
    actionSlug: 'wild-resurgence-slot',
  } as CatalogEffect,
  {
    kind: 'set_starry_form',
    ownerKind: 'subclass',
    ownerSlug: 'stars',
    unlockLevel: 3,
    trigger: 'on_table_action',
    actionSlug: 'starry-form-archer',
  } as CatalogEffect,
];

describe('DruidActionsHandler', () => {
  const druid = createTestCharacter({
    id: 'druid-1',
    classSlug: 'druid',
    subclassSlug: 'stars',
    level: 5,
    abilityScores: createTestAbilityScores({
      forca: 8,
      destreza: 14,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 18,
      carisma: 10,
    }),
  });
  const ctx = createTableActionHandlerTestContext({
    stateResponse: {
      starryFormActive: false,
      stellarConstellation: null,
      wildShapeActive: false,
      wildShapeTemplateSlug: null,
      wildShapeKnownSlugs: ['gato'],
      wildShapeFormSwapAvailable: true,
      wildShapeActorId: null,
      aberrantMutationActive: null,
    },
    defaultCharacter: druid,
    mechanicalCatalogLoad: { economyActions: DRUID_ECONOMY },
  });
  const effectCatalog = { load: jest.fn().mockResolvedValue(DRUID_EFFECTS) };
  const dataSource = {
    query: jest.fn().mockImplementation(async (sql: string) => {
      if (String(sql).includes('phb_wild_shape_cr_band')) {
        return [
          { min_level: 2, cr_max: '1/4', allow_fly: false },
          { min_level: 4, cr_max: '1/2', allow_fly: false },
          { min_level: 8, cr_max: '1', allow_fly: true },
        ];
      }
      if (String(sql).includes('WHERE lower(t.creature_type)')) {
        return [
          {
            slug: 'gato',
            name: 'Gato',
            creature_type: 'Beast',
            challenge_rating: '0',
            armor_class: 12,
            has_fly: false,
          },
          {
            slug: 'coruja',
            name: 'Coruja',
            creature_type: 'Beast',
            challenge_rating: '0',
            armor_class: 11,
            has_fly: true,
          },
        ];
      }
      return [
        {
          slug: 'gato',
          name: 'Gato',
          creature_type: 'Beast',
          challenge_rating: '0',
          armor_class: 12,
          has_fly: false,
        },
      ];
    }),
    getRepository: jest.fn().mockReturnValue({
      findOne: jest.fn().mockResolvedValue({
        id: 'familiar-1',
        notes: null,
        name: 'Gato',
      }),
      save: jest.fn().mockResolvedValue(undefined),
    }),
  };
  const syncWildShapeActor = {
    enter: jest.fn().mockResolvedValue({ actorId: 'actor-ws-1' }),
    leave: jest.fn().mockResolvedValue(undefined),
  };
  const syncSpellSpirit = {
    execute: jest.fn().mockResolvedValue({
      actorId: 'familiar-1',
      templateSlug: 'gato',
      variantKey: 'gato',
      variantLabel: 'Gato',
      reused: false,
      armorClass: 12,
      hitPointsMax: 2,
      actors: [
        {
          actorId: 'familiar-1',
          templateSlug: 'gato',
          variantKey: 'gato',
          variantLabel: 'Gato',
          reused: false,
          armorClass: 12,
          hitPointsMax: 2,
        },
      ],
    }),
  };
  let handler: DruidActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    dataSource.query.mockImplementation(async (sql: string) => {
      if (String(sql).includes('phb_wild_shape_cr_band')) {
        return [
          { min_level: 2, cr_max: '1/4', allow_fly: false },
          { min_level: 4, cr_max: '1/2', allow_fly: false },
          { min_level: 8, cr_max: '1', allow_fly: true },
        ];
      }
      if (String(sql).includes('WHERE lower(t.creature_type)')) {
        return [
          {
            slug: 'gato',
            name: 'Gato',
            creature_type: 'Beast',
            challenge_rating: '0',
            armor_class: 12,
            has_fly: false,
          },
          {
            slug: 'coruja',
            name: 'Coruja',
            creature_type: 'Beast',
            challenge_rating: '0',
            armor_class: 11,
            has_fly: true,
          },
        ];
      }
      return [
        {
          slug: 'gato',
          name: 'Gato',
          creature_type: 'Beast',
          challenge_rating: '0',
          armor_class: 12,
          has_fly: false,
        },
      ];
    });
    ctx.state.setStarryForm.mockImplementation(async (_c, dto) => ({
      ...ctx.stateResponse,
      starryFormActive: dto.active,
      stellarConstellation: dto.constellation,
    }));
    ctx.state.setWildShape.mockImplementation(async (_c, dto) => ({
      ...ctx.stateResponse,
      wildShapeActive: dto.active,
      wildShapeTemplateSlug: dto.templateSlug ?? null,
      wildShapeActorId: dto.actorId ?? null,
    }));
    effectCatalog.load.mockImplementation(({ actionSlug }: { actionSlug?: string }) =>
      Promise.resolve(
        DRUID_EFFECTS.filter((effect) => effect.actionSlug === actionSlug),
      ),
    );
    syncWildShapeActor.enter.mockResolvedValue({ actorId: 'actor-ws-1' });
    syncSpellSpirit.execute.mockResolvedValue({
      actorId: 'familiar-1',
      templateSlug: 'gato',
      variantKey: 'gato',
      variantLabel: 'Gato',
      reused: false,
      armorClass: 12,
      hitPointsMax: 2,
      actors: [
        {
          actorId: 'familiar-1',
          templateSlug: 'gato',
          variantKey: 'gato',
          variantLabel: 'Gato',
          reused: false,
          armorClass: 12,
          hitPointsMax: 2,
        },
      ],
    });
    handler = new DruidActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.domain),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep(effectCatalog),
      asHandlerDep(syncWildShapeActor),
      asHandlerDep(syncSpellSpirit),
      asHandlerDep(dataSource),
    );
  });

  it('spends 1 Wild Shape use for base Wild Shape', async () => {
    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'wild-shape',
      templateSlug: 'gato',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      'wildShape',
      1,
    );
    expect(syncWildShapeActor.enter).toHaveBeenCalled();
    expect(ctx.state.setWildShape).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      { active: true, templateSlug: 'gato', actorId: 'actor-ws-1' },
    );
    expect(result.note).toContain('Gato');
    expect(result.total).toBe(5);
  });

  it('rejects Wild Shape when template is not known', async () => {
    await expect(
      handler.useTableAction('user-1', 'druid-1', {
        actionSlug: 'wild-shape',
        templateSlug: 'coruja',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('sets known forms', async () => {
    ctx.state.buildResponse.mockResolvedValueOnce({
      ...ctx.stateResponse,
      wildShapeKnownSlugs: [],
    });
    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'set-wild-shape-known-forms',
      templateSlugs: ['gato'],
    });
    expect(ctx.state.setWildShapeKnownForms).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      { knownSlugs: ['gato'] },
    );
    expect(result.note).toContain('gato');
  });

  it('replaces one known form after long rest', async () => {
    dataSource.query.mockImplementation(async (sql: string) => {
      if (String(sql).includes('phb_wild_shape_cr_band')) {
        return [
          { min_level: 2, cr_max: '1/4', allow_fly: false },
          { min_level: 4, cr_max: '1/2', allow_fly: false },
          { min_level: 8, cr_max: '1', allow_fly: true },
        ];
      }
      return [
        {
          slug: 'rato',
          name: 'Rato',
          creature_type: 'Beast',
          challenge_rating: '0',
          armor_class: 10,
          has_fly: false,
        },
      ];
    });

    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'replace-wild-shape-known-form',
      replaceSlug: 'gato',
      templateSlug: 'rato',
    });

    expect(ctx.state.setWildShapeKnownForms).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      { knownSlugs: ['rato'], formSwapAvailable: false },
    );
    expect(result.note).toContain('gato');
  });

  it('lists eligible beasts for the character', async () => {
    const result = await handler.listEligibleWildShapeBeasts(
      'user-1',
      'druid-1',
    );
    expect(result.maxKnownForms).toBe(6);
    expect(result.knownSlugs).toEqual(['gato']);
    expect(result.beasts.some((b) => b.slug === 'gato' && b.known)).toBe(true);
    // coruja has fly; level 5 → not eligible
    expect(result.beasts.some((b) => b.slug === 'coruja')).toBe(false);
  });

  it('spawns Wild Companion via Find Familiar spending Wild Shape', async () => {
    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'wild-companion',
      spiritVariantKey: 'gato',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      'wildShape',
      1,
    );
    expect(syncSpellSpirit.execute).toHaveBeenCalledWith(
      expect.objectContaining({
        spellSlug: 'convocar-familiar',
        variantKey: 'gato',
      }),
    );
    expect(result.note).toContain('Fey');
  });

  it('spawns Wild Companion spending a spell slot instead', async () => {
    await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'wild-companion',
      spiritVariantKey: 'gato',
      slotLevel: 1,
    });

    expect(ctx.state.consumeSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      1,
    );
    expect(ctx.state.useClassResource).not.toHaveBeenCalled();
  });

  it('converts 1 Wild Shape use into 1st level spell slot', async () => {
    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'wild-resurgence-slot',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      'wildShape',
      1,
    );
    expect(ctx.state.recoverSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      1,
    );
    expect(result.note).toContain('Ressurgimento Selvagem');
  });

  it('resolves Starry Form Archer for Circle of Stars', async () => {
    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'starry-form-archer',
    });

    expect(result.expression).toBe('1d8+4');
    expect(result.note).toContain('Forma Estelar (Arqueiro)');
    expect(ctx.state.setStarryForm).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      { active: true, constellation: 'archer' },
    );
    expect(result.state).toEqual(
      expect.objectContaining({
        starryFormActive: true,
        stellarConstellation: 'archer',
      }),
    );
  });

  it('re-uses Starry Form Archer without spending Wild Shape again', async () => {
    ctx.state.buildResponse.mockResolvedValueOnce({
      ...ctx.stateResponse,
      starryFormActive: true,
      stellarConstellation: 'archer',
    });

    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'starry-form-archer',
    });

    expect(ctx.state.useClassResource).not.toHaveBeenCalled();
    expect(result.note).toContain('ainda ativa');
  });

  it('resolves Moon Combat Wild Shape for Circle of the Moon', async () => {
    ctx.mockCharacterOnce({ ...druid, subclassSlug: 'moon' });

    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'moon-combat-wild-shape',
      templateSlug: 'gato',
    });

    expect(result.total).toBe(15);
    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      'wildShape',
      1,
    );
    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      { tempHp: 15 },
    );
    expect(ctx.state.setWildShape).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      { active: true, templateSlug: 'gato', actorId: 'actor-ws-1' },
    );
    expect(result.note).toContain('Forma Selvagem de Combate');
  });

  it('resolves Land Aid for Circle of the Land', async () => {
    ctx.mockCharacterOnce({ ...druid, subclassSlug: 'land', level: 3 });

    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'land-aid',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      'wildShape',
      1,
    );
    expect(result.note).toContain('Auxílio da Terra');
    expect(result.expression).toMatch(/d6/);
    expect(ctx.state.applyCurrentHitPoints).toHaveBeenCalled();
  });

  it('resolves Natural Recovery slot for Circle of the Land', async () => {
    ctx.mockCharacterOnce({ ...druid, subclassSlug: 'land', level: 6 });

    const result = await handler.useTableAction('user-1', 'druid-1', {
      actionSlug: 'natural-recovery-2',
    });

    expect(ctx.state.recoverSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'druid-1' }),
      2,
    );
    expect(result.note).toContain('Recuperação Natural');
  });

  it('rejects Druid actions for non-druid characters', async () => {
    ctx.mockCharacterOnce({ ...druid, classSlug: 'ranger' });

    await expect(
      handler.useTableAction('user-1', 'druid-1', {
        actionSlug: 'wild-shape',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
