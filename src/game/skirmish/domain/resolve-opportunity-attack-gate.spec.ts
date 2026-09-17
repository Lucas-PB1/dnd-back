import { resolveOpportunityAttackGate } from './resolve-opportunity-attack-gate';

describe('resolveOpportunityAttackGate', () => {
  const base = {
    currentTurnIsActor: true,
    reactionAvailable: true,
    opportunityAvailable: true,
    conditions: [] as string[],
  };

  it('allows OA when actor turn + reaction + not used', () => {
    expect(resolveOpportunityAttackGate(base)).toEqual({ ok: true });
  });

  it('rejects when not actor turn', () => {
    const r = resolveOpportunityAttackGate({
      ...base,
      currentTurnIsActor: false,
    });
    expect(r.ok).toBe(false);
  });

  it('rejects when reaction spent', () => {
    const r = resolveOpportunityAttackGate({
      ...base,
      reactionAvailable: false,
    });
    expect(r.ok).toBe(false);
    if (!r.ok) expect(r.reason).toMatch(/Reação/i);
  });

  it('rejects when OA already used this turn', () => {
    const r = resolveOpportunityAttackGate({
      ...base,
      opportunityAvailable: false,
    });
    expect(r.ok).toBe(false);
    if (!r.ok) expect(r.reason).toMatch(/OA já usada/i);
  });

  it('rejects when incapacitated', () => {
    const r = resolveOpportunityAttackGate({
      ...base,
      conditions: ['incapacitated'],
    });
    expect(r.ok).toBe(false);
    if (!r.ok) expect(r.reason).toMatch(/incapacitated/);
  });
});
