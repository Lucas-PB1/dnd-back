import {
  companionIsDefeated,
  pickCommandCompanion,
  toCompanionTracker,
} from './companion-tracker';

describe('companion-tracker', () => {
  const land = toCompanionTracker({
    id: 'a1',
    name: 'Fera',
    templateSlug: 'primal-companion-earth',
    hitPointsCurrent: 12,
    hitPointsMax: 20,
    armorClass: 13,
  });
  const down = toCompanionTracker({
    id: 'a2',
    name: 'Familiar',
    templateSlug: 'coruja',
    hitPointsCurrent: 0,
    hitPointsMax: 4,
    armorClass: 11,
  });

  it('marca derrotado em 0 PV', () => {
    expect(companionIsDefeated(0)).toBe(true);
    expect(land.defeated).toBe(false);
    expect(down.defeated).toBe(true);
  });

  it('escolhe o companheiro vivo do template, senão qualquer vivo', () => {
    expect(pickCommandCompanion([down, land], 'primal-companion-earth')?.actorId).toBe(
      'a1',
    );
    expect(pickCommandCompanion([down], 'primal-companion-earth')?.defeated).toBe(
      true,
    );
    expect(pickCommandCompanion([])).toBeNull();
  });
});
