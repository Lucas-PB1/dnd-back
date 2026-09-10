import {
  addPendingEffect,
  consumePendingEffect,
  hasPendingEffect,
  pendingEffectToken,
  removePendingEffect,
} from './pending-combat-effect';

describe('pending combat effect', () => {
  it('builds kind:characterId tokens', () => {
    expect(pendingEffectToken('blood-withering', 'c1')).toBe(
      'blood-withering:c1',
    );
  });

  it('rejects kind with colon', () => {
    expect(() => pendingEffectToken('a:b', 'c1')).toThrow(/Invalid pending/);
  });

  it('adds once and consumes', () => {
    const withMark = addPendingEffect([], 'blood-withering', 'char-1');
    expect(hasPendingEffect(withMark, 'blood-withering', 'char-1')).toBe(true);
    expect(addPendingEffect(withMark, 'blood-withering', 'char-1')).toEqual(
      withMark,
    );

    const consumed = consumePendingEffect(
      withMark,
      'blood-withering',
      'char-1',
    );
    expect(consumed.consumed).toBe(true);
    expect(
      hasPendingEffect(consumed.effects, 'blood-withering', 'char-1'),
    ).toBe(false);
  });

  it('remove without consume', () => {
    const withMark = addPendingEffect([], 'blood-exile', 'c2');
    expect(removePendingEffect(withMark, 'blood-exile', 'c2')).toEqual([]);
  });
});
