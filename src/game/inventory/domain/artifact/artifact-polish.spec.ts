import {
  artifactSpellSuppressedUntilRest,
  rollArtifactSpellD6,
} from './artifact-spell-d6';
import { resolveSentientConflict } from './sentient-conflict';
import { clearArtifactRandomForReroll } from './artifact-reroll';

describe('artifact polish domain', () => {
  it('suppresses spell on d6 1–5 only', () => {
    expect(artifactSpellSuppressedUntilRest(1)).toBe(true);
    expect(artifactSpellSuppressedUntilRest(5)).toBe(true);
    expect(artifactSpellSuppressedUntilRest(6)).toBe(false);
    expect(rollArtifactSpellD6(() => 0)).toBe(1);
    expect(rollArtifactSpellD6(() => 0.99)).toBe(6);
  });

  it('computes conflict DC from item CHA', () => {
    const result = resolveSentientConflict({
      itemSlug: 'onda',
      instanceProperties: {
        sentience: { carisma: 18, inteligencia: 14, sabedoria: 10 },
      },
    });
    expect(result.saveDc).toBe(16); // 12 + 4
    expect(result.note).toMatch(/CD 16/);
  });

  it('clears random props for reroll', () => {
    const next = clearArtifactRandomForReroll({
      artifactRandom: { minorBeneficial: [] },
      abilityPenalties: { forca: -2 },
      sentience: { carisma: 16 },
    });
    expect(next.artifactRandom).toBeUndefined();
    expect(next.abilityPenalties).toBeUndefined();
    expect(next.sentience).toEqual({ carisma: 16 });
  });
});
