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
  {
    id: 'divine-clemency-activate',
    name: 'Clemência Divina',
    economy: 'reaction',
    featSlug: 'gh-transformation-seraph',
    minLevel: 2,
    resourceSlug: 'divine-clemency-uses',
    alwaysSpendsResource: true,
    tableAction: 'gh-transformation-seraph/divine-clemency',
    requiresOptionKey: 'stage2Boon',
    requiresOptionValue: 'divine-clemency',
    summary: 'Clemência Divina',
    description: 'Palavra Curativa.',
  },
  {
    id: 'unholy-healing-activate',
    name: 'Cura Profana',
    economy: 'action',
    featSlug: 'gh-transformation-lich',
    minLevel: 3,
    resourceSlug: 'unholy-healing-uses',
    alwaysSpendsResource: true,
    tableAction: 'gh-transformation-lich/unholy-healing',
    requiresOptionKey: 'stage3Boon',
    requiresOptionValue: 'unholy-healing',
    summary: 'Cura Profana',
    description: 'Regeneração do vaso.',
  },
  {
    id: 'aberrant-mutation-activate',
    name: 'Mutação Aberrante',
    economy: 'bonus',
    featSlug: 'gh-transformation-aberrant-horror',
    minLevel: 1,
    resourceSlug: 'aberrant-mutation-uses',
    alwaysSpendsResource: true,
    tableAction: 'gh-transformation-aberrant-horror/aberrant-mutation',
    summary: 'Mutação Aberrante',
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
    applyCurrentHitPoints: jest.fn(async () => ({
      resources: [],
      hitPointsCurrent: 12,
    })),
    setAberrantMutation: jest.fn(async (_c, slug) => ({
      resources: [],
      aberrantMutationActive: slug,
    })),
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
    condition: null,
    save: null,
    forcedMovement: null,
    dice: null,
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

  it('cura Clemência Divina com 2d4 + mod de conjuração', async () => {
    const seraph = {
      id: 'c-seraph',
      level: 5,
      hitPointsCurrent: 10,
      hitPointsMax: 40,
      abilityScores: {
        forca: 10,
        destreza: 10,
        constituicao: 10,
        inteligencia: 10,
        sabedoria: 14,
        carisma: 16,
      },
    } as PlayerCharacter;

    const effectCatalog = {
      load: jest.fn().mockResolvedValue([
        {
          id: '1',
          kind: 'heal',
          ownerKind: 'feat',
          ownerId: '1',
          ownerSlug: 'gh-transformation-seraph',
          trigger: 'on_table_action',
          unlockLevel: 2,
          sortOrder: 0,
          minTraitTakes: 1,
          actionSlug: 'gh-transformation-seraph/divine-clemency',
          resourceSlug: null,
          label: 'Clemência Divina',
          requiresOptionKey: null,
          requiresOptionValue: null,
          spell: null,
          castEconomy: null,
          numeric: {
            amountFormula: 'dice_2d4_plus_flat',
            flat: null,
          },
          note: {
            note: 'Reação: Palavra Curativa (nível 1) — 2d4 + atributo de conjuração.',
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
    condition: null,
    save: null,
    forcedMovement: null,
    dice: null,
        },
      ]),
    };

    const result = await resolveFeatEconomyTableAction(
      {
        state: state as never,
        mechanicalCatalog: mechanicalCatalog as never,
        effectCatalog: effectCatalog as never,
      },
      seraph,
      'gh-transformation-seraph',
      'gh-transformation-seraph/divine-clemency',
      {
        slug: 'gh-transformation-seraph',
        stage: 2,
        choices: [
          { choiceKind: 'stage2Boon', choiceSlug: 'divine-clemency' },
        ],
      },
    );

    expect(state.useClassResource).toHaveBeenCalledWith(
      seraph,
      'divine-clemency-uses',
      1,
    );
    expect(state.applyCurrentHitPoints).toHaveBeenCalled();
    expect(result.total).toBeGreaterThanOrEqual(2 + 3);
    expect(result.total).toBeLessThanOrEqual(8 + 3);
    expect(result.note).toContain('Cura aplicada neste PC');
    expect(result.expression).toContain('d4');
  });

  it('Cura Profana declara 10 PV/turno tipados sem aplicar cura', async () => {
    const effectCatalog = {
      load: jest.fn().mockResolvedValue([
        {
          id: '1',
          kind: 'table_note',
          ownerKind: 'feat',
          ownerId: '1',
          ownerSlug: 'gh-transformation-lich',
          trigger: 'on_table_action',
          unlockLevel: 3,
          sortOrder: 0,
          minTraitTakes: 1,
          actionSlug: 'gh-transformation-lich/unholy-healing',
          resourceSlug: null,
          label: 'Cura Profana',
          requiresOptionKey: null,
          requiresOptionValue: null,
          spell: null,
          castEconomy: null,
          numeric: { amountFormula: 'fixed', flat: 10 },
          note: {
            note: 'No início de cada turno por 1 minuto, recupera 10 PV.',
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
    condition: null,
    save: null,
    forcedMovement: null,
    dice: null,
        },
      ]),
    };

    const lich = { id: 'c-lich', level: 10 } as PlayerCharacter;
    const result = await resolveFeatEconomyTableAction(
      {
        state: state as never,
        mechanicalCatalog: mechanicalCatalog as never,
        effectCatalog: effectCatalog as never,
      },
      lich,
      'gh-transformation-lich',
      'gh-transformation-lich/unholy-healing',
      {
        slug: 'gh-transformation-lich',
        stage: 3,
        choices: [
          { choiceKind: 'stage3Boon', choiceSlug: 'unholy-healing' },
        ],
      },
    );

    expect(state.useClassResource).toHaveBeenCalledWith(
      lich,
      'unholy-healing-uses',
      1,
    );
    expect(state.applyCurrentHitPoints).not.toHaveBeenCalled();
    expect(result.total).toBe(10);
    expect(result.note).toContain('10 PV');
    expect(result.note).toContain('Valor tipado');
  });

  it('ativa Mutação Aberrante com mutationSlug e gasta uso', async () => {
    const horror = { id: 'c-horror', level: 5 } as PlayerCharacter;
    const result = await resolveFeatEconomyTableAction(
      {
        state: state as never,
        mechanicalCatalog: mechanicalCatalog as never,
      },
      horror,
      'gh-transformation-aberrant-horror',
      'gh-transformation-aberrant-horror/aberrant-mutation',
      {
        slug: 'gh-transformation-aberrant-horror',
        stage: 1,
        choices: [],
      },
      { mutationSlug: 'chitinous-shell' },
    );

    expect(state.useClassResource).toHaveBeenCalledWith(
      horror,
      'aberrant-mutation-uses',
      1,
    );
    expect(state.setAberrantMutation).toHaveBeenCalledWith(
      horror,
      'chitinous-shell',
    );
    expect(result.resourceSpent).toBe(true);
    expect(result.note).toContain('Casca Quitinosa');
    expect(result.state.aberrantMutationActive).toBe('chitinous-shell');
  });

  it('encerra Mutação Aberrante sem gastar uso', async () => {
    const horror = { id: 'c-horror', level: 5 } as PlayerCharacter;
    const result = await resolveFeatEconomyTableAction(
      {
        state: state as never,
        mechanicalCatalog: mechanicalCatalog as never,
      },
      horror,
      'gh-transformation-aberrant-horror',
      'gh-transformation-aberrant-horror/aberrant-mutation',
      {
        slug: 'gh-transformation-aberrant-horror',
        stage: 1,
        choices: [],
      },
      { mutationSlug: null },
    );

    expect(state.useClassResource).not.toHaveBeenCalled();
    expect(state.setAberrantMutation).toHaveBeenCalledWith(horror, null);
    expect(result.resourceSpent).toBe(false);
    expect(result.note).toContain('encerrada');
  });
});
