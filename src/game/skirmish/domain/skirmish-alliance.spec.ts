import {
  findFoeSkirmishCombatant,
  isAlliedSkirmishActor,
  pickAutomaticSkirmishTarget,
  spiritInitiativeAfterPc,
} from './skirmish-alliance';
import type { SkirmishCombatant } from '../infrastructure/skirmish-combatant.entity';

function combatant(
  partial: Partial<SkirmishCombatant> &
    Pick<SkirmishCombatant, 'id' | 'kind' | 'displayName'>,
): SkirmishCombatant {
  return {
    skirmishId: 's1',
    characterId: null,
    actorId: null,
    initiativeTotal: 15,
    initiativeModifier: 2,
    sortOrder: 0,
    isActive: true,
    ...partial,
  } as SkirmishCombatant;
}

describe('skirmish-alliance (PVE-7a)', () => {
  const pc = combatant({
    id: 'pc',
    kind: 'pc',
    characterId: 'char-1',
    displayName: 'Ranger',
  });
  const foe = combatant({
    id: 'foe',
    kind: 'actor',
    actorId: 'actor-goblin',
    displayName: 'Goblin',
  });
  const spirit = combatant({
    id: 'spirit',
    kind: 'actor',
    actorId: 'actor-beast',
    displayName: 'Espírito Bestial',
    initiativeTotal: 15,
    initiativeModifier: 1,
  });

  const hints = [
    { actorId: 'actor-goblin', parentCharacterId: null },
    { actorId: 'actor-beast', parentCharacterId: 'char-1' },
  ];

  it('marks spirit as allied', () => {
    expect(isAlliedSkirmishActor(hints[1]!, 'char-1')).toBe(true);
    expect(isAlliedSkirmishActor(hints[0]!, 'char-1')).toBe(false);
  });

  it('finds the foe among multiple actors', () => {
    expect(
      findFoeSkirmishCombatant({
        combatants: [pc, spirit, foe],
        skirmishCharacterId: 'char-1',
        actorHints: hints,
      })?.id,
    ).toBe('foe');
  });

  it('spirit turn targets the foe (Invocar Fera)', () => {
    expect(
      pickAutomaticSkirmishTarget({
        attacker: spirit,
        combatants: [pc, spirit, foe],
        skirmishCharacterId: 'char-1',
        actorHints: hints,
      })?.id,
    ).toBe('foe');
  });

  it('foe turn targets the PC', () => {
    expect(
      pickAutomaticSkirmishTarget({
        attacker: foe,
        combatants: [pc, spirit, foe],
        skirmishCharacterId: 'char-1',
        actorHints: hints,
      })?.id,
    ).toBe('pc');
  });

  it('spirit initiative shares PC total with lower mod', () => {
    expect(
      spiritInitiativeAfterPc({
        pcInitiativeTotal: 18,
        pcInitiativeModifier: 3,
      }),
    ).toEqual({ initiativeTotal: 18, initiativeModifier: 2 });
  });
});
