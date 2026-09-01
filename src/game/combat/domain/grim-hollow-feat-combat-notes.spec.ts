import { grimHollowFeatCombatNotes } from './grim-hollow-feat-combat-notes';
import { featCombatNotes } from './feat/combat-notes';

describe('grimHollowFeatCombatNotes', () => {
  it('returns blood-hound passives', () => {
    const notes = grimHollowFeatCombatNotes({ featSlugs: ['blood-hound'] });
    expect(notes.some((n) => n.includes('Sensor de Movimento'))).toBe(true);
    expect(notes.some((n) => n.includes('Sem Esconderijo'))).toBe(true);
  });

  it('deduplicates feat slugs', () => {
    const notes = grimHollowFeatCombatNotes({
      featSlugs: ['survivor', 'survivor'],
    });
    expect(notes.filter((n) => n.includes('Resistente'))).toHaveLength(1);
  });

  it('ignores economy-only feats without passive lines', () => {
    expect(
      grimHollowFeatCombatNotes({ featSlugs: ['dual-shot'] }),
    ).toEqual([]);
  });
});

describe('featCombatNotes with GH', () => {
  it('merges PHB and GH notes', () => {
    const notes = featCombatNotes({
      featSlugs: ['alert', 'blood-hound'],
    });
    expect(notes.some((n) => n.includes('Iniciativa'))).toBe(true);
    expect(notes.some((n) => n.includes('Sensor de Movimento'))).toBe(true);
  });
});
