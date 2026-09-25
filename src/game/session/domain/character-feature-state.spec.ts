import { readFeature, writeFeature } from './character-feature-state';
import { PlayerCharacterState } from '../infrastructure/player-character-state.entity';

describe('character feature state', () => {
  it('reads defaults for missing keys', () => {
    expect(readFeature({}, 'rageActive')).toBe(false);
    expect(readFeature(undefined, 'wildShapeFormSwapAvailable')).toBe(true);
    expect(readFeature(null, 'stellarConstellation')).toBeNull();
    expect(readFeature({}, 'personaMasks')).toEqual([]);
  });

  it('returns fresh copies of collection defaults', () => {
    const a = readFeature({}, 'wildShapeKnownSlugs');
    a.push('wolf');
    expect(readFeature({}, 'wildShapeKnownSlugs')).toEqual([]);
  });

  it('stores only non-default values', () => {
    let s = writeFeature({}, 'rageActive', true);
    expect(s).toEqual({ rageActive: true });
    s = writeFeature(s, 'wildShapeFormSwapAvailable', false);
    expect(s).toEqual({ rageActive: true, wildShapeFormSwapAvailable: false });
    s = writeFeature(s, 'rageActive', false);
    s = writeFeature(s, 'wildShapeFormSwapAvailable', true);
    s = writeFeature(s, 'personaMasks', []);
    expect(s).toEqual({});
  });

  it('does not mutate the stored map', () => {
    const stored = { rageActive: true };
    writeFeature(stored, 'rageActive', false);
    expect(stored).toEqual({ rageActive: true });
  });

  it('entity accessors round-trip through featureState', () => {
    const state = new PlayerCharacterState();
    expect(state.rageActive).toBe(false);
    state.rageActive = true;
    state.stellarConstellation = 'dragon';
    state.bestialAspectLevel = 3;
    expect(state.featureState).toEqual({
      rageActive: true,
      stellarConstellation: 'dragon',
      bestialAspectLevel: 3,
    });
    state.stellarConstellation = null;
    expect(state.featureState).toEqual({ rageActive: true, bestialAspectLevel: 3 });
  });
});
