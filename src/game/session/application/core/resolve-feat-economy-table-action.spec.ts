import { BadRequestException } from '@nestjs/common';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { resolveFeatEconomyTableAction } from './resolve-feat-economy-table-action';

const character = { id: 'c1', level: 10 } as PlayerCharacter;

const transformation = {
  slug: 'gh-transformation-fiend',
  stage: 2,
  choices: [
    { choiceKind: 'stage1Boon', choiceSlug: 'infernal-smite' },
    { choiceKind: 'stage2Boon', choiceSlug: 'daemonic-brand' },
  ],
};

const economyActions: ClassEconomyActionRecord[] = [
  {
    id: 'infernal-smite-activate',
    name: 'Punição Infernal',
    economy: 'bonus',
    featSlug: 'gh-transformation-fiend',
    minLevel: 1,
    resourceSlug: 'infernal-smite-uses',
    alwaysSpendsResource: true,
    tableAction: 'gh-transformation-fiend/infernal-smite',
    summary: 'Punição Infernal',
    description: 'Nota de mesa.',
  },
  {
    id: 'daemonic-brand-activate',
    name: 'Marca Demoníaca',
    economy: 'bonus',
    featSlug: 'gh-transformation-fiend',
    minLevel: 2,
    resourceSlug: 'daemonic-brand-uses',
    alwaysSpendsResource: true,
    tableAction: 'gh-transformation-fiend/daemonic-brand',
    requiresOptionKey: 'stage2Boon',
    requiresOptionValue: 'daemonic-brand',
    summary: 'Marca Demoníaca',
  },
  {
    id: 'wrong-boon',
    name: 'Outro',
    economy: 'bonus',
    featSlug: 'gh-transformation-fiend',
    minLevel: 2,
    tableAction: 'gh-transformation-fiend/other',
    requiresOptionKey: 'stage2Boon',
    requiresOptionValue: 'other-boon',
  },
  {
    id: 'hybrid-wolf-form-activate',
    name: 'Hybrid Wolf Form',
    economy: 'action',
    featSlug: 'gh-transformation-lycanthrope',
    minLevel: 1,
    resourceSlug: undefined,
    alwaysSpendsResource: false,
    tableAction: 'gh-transformation-lycanthrope/hybrid-wolf-form',
    requiresOptionKey: 'stage1Boon',
    requiresOptionValue: 'hybrid-wolf-form',
    summary: 'Hybrid Wolf Form',
    description: 'Declare hybrid wolf.',
  },
];

describe('resolveFeatEconomyTableAction', () => {
  const mechanicalCatalog = {
    load: async () => ({ economyActions, panelActions: [] }),
  };
  const state = {
    useClassResource: jest.fn(async () => ({
      state: { resources: [] },
    })),
    buildResponse: jest.fn(async () => ({ resources: [] })),
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('gasta recurso e devolve nota quando ação existe', async () => {
    const result = await resolveFeatEconomyTableAction(
      { state: state as never, mechanicalCatalog: mechanicalCatalog as never },
      character,
      transformation.slug,
      'gh-transformation-fiend/infernal-smite',
      transformation,
    );

    expect(state.useClassResource).toHaveBeenCalledWith(
      character,
      'infernal-smite-uses',
      1,
    );
    expect(result.actionName).toBe('Punição Infernal');
    expect(result.resourceSpent).toBe(true);
    expect(result.note).toContain('Nota de mesa');
  });

  it('rejeita estágio insuficiente', async () => {
    await expect(
      resolveFeatEconomyTableAction(
        { state: state as never, mechanicalCatalog: mechanicalCatalog as never },
        character,
        transformation.slug,
        'gh-transformation-fiend/daemonic-brand',
        { ...transformation, stage: 1 },
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejeita quando choice não casa com requires_option', async () => {
    await expect(
      resolveFeatEconomyTableAction(
        { state: state as never, mechanicalCatalog: mechanicalCatalog as never },
        character,
        transformation.slug,
        'gh-transformation-fiend/other',
        transformation,
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('declara Licantropo sem gastar recurso e anexa table_note', async () => {
    const effectCatalog = {
      load: jest.fn().mockResolvedValue([
        {
          id: '1',
          kind: 'table_note',
          ownerKind: 'feat',
          ownerId: '1',
          ownerSlug: 'gh-transformation-lycanthrope',
          trigger: 'on_table_action',
          unlockLevel: 1,
          sortOrder: 0,
          minTraitTakes: 1,
          actionSlug: 'gh-transformation-lycanthrope/hybrid-wolf-form',
          resourceSlug: null,
          label: 'Forma Híbrida — Lobo',
          requiresOptionKey: null,
          requiresOptionValue: null,
          spell: null,
          castEconomy: null,
          numeric: null,
          note: {
            note: 'Declare forma híbrida de lobo na mesa (1 h × estágio).',
          },
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
        },
      ]),
    };

    const result = await resolveFeatEconomyTableAction(
      {
        state: state as never,
        mechanicalCatalog: mechanicalCatalog as never,
        effectCatalog: effectCatalog as never,
      },
      character,
      'gh-transformation-lycanthrope',
      'gh-transformation-lycanthrope/hybrid-wolf-form',
      {
        slug: 'gh-transformation-lycanthrope',
        stage: 1,
        choices: [{ choiceKind: 'stage1Boon', choiceSlug: 'hybrid-wolf-form' }],
      },
    );

    expect(state.useClassResource).not.toHaveBeenCalled();
    expect(result.resourceSpent).toBe(false);
    expect(result.note).toContain('Declare forma híbrida de lobo');
  });
});
