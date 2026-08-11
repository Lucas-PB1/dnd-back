import {
  itemIsCursed,
  instanceCurseBroken,
  mayEndCursedAttunement,
  withCurseBroken,
} from './cursed-item';

describe('cursed-item', () => {
  it('detects cursed catalog flag', () => {
    expect(itemIsCursed({ cursed: true })).toBe(true);
    expect(itemIsCursed({ cursed: false })).toBe(false);
    expect(itemIsCursed(null)).toBe(false);
  });

  it('blocks voluntary unattune until curseBroken', () => {
    expect(
      mayEndCursedAttunement({
        properties: { cursed: true },
        instanceProperties: null,
      }),
    ).toBe(false);
    expect(
      mayEndCursedAttunement({
        properties: { cursed: true },
        instanceProperties: { curseBroken: true },
      }),
    ).toBe(true);
    expect(
      mayEndCursedAttunement({
        properties: {},
        instanceProperties: null,
      }),
    ).toBe(true);
  });

  it('sets curseBroken on instance', () => {
    expect(withCurseBroken({ artifactRandom: {} })).toEqual({
      artifactRandom: {},
      curseBroken: true,
    });
    expect(instanceCurseBroken(withCurseBroken(null))).toBe(true);
  });
});
