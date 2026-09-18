import { CampaignEncounterCastService } from './campaign-encounter-cast.service';
import { resolveCombatSpell } from '@game/combat/domain/resolve-combat-spell';
import { loadSpellcastingAbilitySlug } from '@game/spellcasting/application/resolve-character-spellcasting-slice';
import { combatantFixture as combatant } from '@common/testing/combatant.fixture';

jest.mock('@game/combat/domain/resolve-combat-spell', () => ({
  resolveCombatSpell: jest.fn(),
}));
jest.mock(
  '@game/spellcasting/application/resolve-character-spellcasting-slice',
  () => ({
    loadSpellcastingAbilitySlug: jest.fn(),
  }),
);

const mockResolve = resolveCombatSpell as jest.MockedFunction<
  typeof resolveCombatSpell
>;
const mockAbilitySlug = loadSpellcastingAbilitySlug as jest.MockedFunction<
  typeof loadSpellcastingAbilitySlug
>;

describe('CampaignEncounterCastService (PVE-8)', () => {
  const encounter = {
    id: 'e1',
    campaignId: 'c1',
    status: 'active',
    playersCanView: true,
  };
  const loaded = { id: 'e1', combatants: [] };

  beforeEach(() => {
    mockResolve.mockReset();
    mockAbilitySlug.mockReset();
    mockAbilitySlug.mockResolvedValue('inteligencia');
  });

  it('resolves auto_damage (MM) and applies HP to the target', async () => {
    const caster = combatant({
      id: 'caster',
      kind: 'pc',
      characterId: 'char-c',
      actorId: null,
    });
    const target = combatant({
      id: 'tgt',
      kind: 'actor',
      actorId: 'actor-t',
      characterId: null,
    });
    const character = {
      id: 'char-c',
      name: 'Mago',
      level: 5,
      classSlug: 'wizard',
      abilityScores: {
        forca: 10,
        destreza: 14,
        constituicao: 12,
        inteligencia: 16,
        sabedoria: 10,
        carisma: 8,
      },
      userId: 'u1',
    };
    const campaigns = {
      requireMember: jest.fn().mockResolvedValue({ role: 'dm', userId: 'u1' }),
      findCharactersByIds: jest.fn().mockResolvedValue([character]),
    };
    const encounters = {
      findEncounterInCampaignOrFail: jest.fn().mockResolvedValue(encounter),
      findCombatantByIdOrFail: jest
        .fn()
        .mockImplementation(async (_eid: string, id: string) =>
          id === caster.id ? caster : target,
        ),
    };
    const loadDto = { load: jest.fn().mockResolvedValue(loaded) };
    const characterState = {
      castSpell: jest.fn().mockResolvedValue({
        slotLevelUsed: 1,
        note: 'slot',
        spellSaveDcOverride: null,
        spellAttackBonusOverride: null,
        state: {},
      }),
      useClassResource: jest.fn(),
      buildResponse: jest.fn(),
      patch: jest.fn(),
      applyCurrentHitPoints: jest.fn(),
    };
    const actorState = {
      ensureState: jest.fn().mockResolvedValue({ tempHp: 0 }),
      patch: jest.fn(),
    };
    const enrichPcs = { enrich: jest.fn() };
    const spellCombat = {
      bySlug: jest.fn().mockResolvedValue({
        spellSlug: 'misseis-magicos',
        resolution: 'auto_damage',
        label: 'Mísseis Mágicos',
        damageDie: 4,
        flatPerDie: 1,
        autoUnitBase: 3,
        autoUnitPerSlotAboveBase: 1,
        diceCountBase: null,
        dicePerSlotAboveBase: null,
        spellLevel: 1,
        cantripScale: false,
        perDieAttack: false,
        includeSpellcastingMod: false,
        saveSuccessOutcome: null,
        saveAbilitySlug: null,
        conditionSlug: null,
        damageTypeSlug: 'force',
      }),
    };
    const domain = { getProficiencyBonus: jest.fn().mockResolvedValue(3) };
    const actors = {
      findOne: jest.fn().mockResolvedValue({
        id: 'actor-t',
        armorClass: 12,
        hitPointsCurrent: 20,
        abilityScores: character.abilityScores,
      }),
    };

    mockResolve.mockReturnValue({
      kind: 'auto_damage',
      damage: 14,
      label: 'Mísseis Mágicos',
    });

    const service = new CampaignEncounterCastService(
      campaigns as never,
      encounters as never,
      loadDto as never,
      characterState as never,
      actorState as never,
      enrichPcs as never,
      spellCombat as never,
      domain as never,
      {} as never,
      actors as never,
    );

    const result = await service.cast('u1', 'c1', 'e1', {
      casterCombatantId: caster.id,
      targetCombatantId: target.id,
      spellSlug: 'misseis-magicos',
      slotLevel: 1,
    });

    expect(result.resolutionKind).toBe('auto_damage');
    expect(result.damageTotal).toBe(14);
    expect(result.note).toContain('Mísseis Mágicos');
    expect(characterState.castSpell).toHaveBeenCalled();
    expect(actorState.patch).toHaveBeenCalled();
    expect(loadDto.load).toHaveBeenCalled();
  });

  it('resolves spell_attack miss without applying damage', async () => {
    const caster = combatant({
      id: 'caster',
      kind: 'pc',
      characterId: 'char-c',
      actorId: null,
    });
    const target = combatant({
      id: 'tgt',
      kind: 'actor',
      actorId: 'actor-t',
      characterId: null,
    });
    const character = {
      id: 'char-c',
      name: 'Mago',
      level: 3,
      classSlug: 'wizard',
      abilityScores: {
        forca: 10,
        destreza: 14,
        constituicao: 12,
        inteligencia: 16,
        sabedoria: 10,
        carisma: 8,
      },
      userId: 'u1',
    };
    const campaigns = {
      requireMember: jest.fn().mockResolvedValue({ role: 'dm', userId: 'u1' }),
      findCharactersByIds: jest.fn().mockResolvedValue([character]),
    };
    const encounters = {
      findEncounterInCampaignOrFail: jest.fn().mockResolvedValue(encounter),
      findCombatantByIdOrFail: jest
        .fn()
        .mockImplementation(async (_eid: string, id: string) =>
          id === caster.id ? caster : target,
        ),
    };
    const characterState = {
      castSpell: jest.fn().mockResolvedValue({
        slotLevelUsed: 0,
        note: null,
        spellSaveDcOverride: null,
        spellAttackBonusOverride: null,
        state: {},
      }),
      useClassResource: jest.fn(),
    };
    const actorState = { ensureState: jest.fn(), patch: jest.fn() };
    const spellCombat = {
      bySlug: jest.fn().mockResolvedValue({
        spellSlug: 'raio-de-fogo',
        resolution: 'spell_attack',
        label: 'Raio de Fogo',
        damageDie: 10,
        flatPerDie: 0,
        autoUnitBase: null,
        autoUnitPerSlotAboveBase: null,
        diceCountBase: 1,
        dicePerSlotAboveBase: 0,
        spellLevel: 0,
        cantripScale: true,
        perDieAttack: false,
        includeSpellcastingMod: false,
        saveSuccessOutcome: null,
        saveAbilitySlug: null,
        conditionSlug: null,
        damageTypeSlug: 'fire',
      }),
    };
    mockResolve.mockReturnValue({
      kind: 'spell_attack',
      damage: 0,
      label: 'Raio de Fogo',
      attackTotal: 8,
      hit: false,
      critical: false,
    });

    const service = new CampaignEncounterCastService(
      campaigns as never,
      encounters as never,
      { load: jest.fn().mockResolvedValue(loaded) } as never,
      characterState as never,
      actorState as never,
      { enrich: jest.fn() } as never,
      spellCombat as never,
      { getProficiencyBonus: jest.fn().mockResolvedValue(2) } as never,
      {} as never,
      {
        findOne: jest.fn().mockResolvedValue({
          id: 'actor-t',
          armorClass: 15,
          abilityScores: character.abilityScores,
        }),
      } as never,
    );

    const result = await service.cast('u1', 'c1', 'e1', {
      casterCombatantId: caster.id,
      targetCombatantId: target.id,
      spellSlug: 'raio-de-fogo',
    });

    expect(result.resolutionKind).toBe('spell_attack');
    expect(result.damageTotal).toBe(0);
    expect(result.note).toContain('erro');
    expect(actorState.patch).not.toHaveBeenCalled();
  });
});
