import { ensureActorAttackBonusFromCaster } from './ensure-actor-attack-bonus';

describe('ensureActorAttackBonusFromCaster (PVE-7a)', () => {
  it('fills null attack bonus on damaging actions', async () => {
    const dilacerar = {
      attackBonus: null as number | null,
      damageExpression: '1d8+4',
    };
    const multi = {
      attackBonus: null as number | null,
      damageExpression: null as string | null,
    };
    const actions = {
      find: jest.fn().mockResolvedValue([dilacerar, multi]),
      save: jest.fn().mockImplementation(async (row) => row),
    };
    const patched = await ensureActorAttackBonusFromCaster({
      actions: actions as never,
      actorId: 'a1',
      spellAttackBonus: 7,
    });
    expect(patched).toBe(1);
    expect(dilacerar.attackBonus).toBe(7);
    expect(multi.attackBonus).toBeNull();
  });
});
