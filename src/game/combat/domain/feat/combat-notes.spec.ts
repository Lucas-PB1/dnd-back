import { featCombatNotes } from './combat-notes';

describe('featCombatNotes', () => {
  it('returns passive notes for Lucky is empty (economy only)', () => {
    expect(featCombatNotes({ featSlugs: ['lucky'] })).toEqual([]);
  });

  it('lists Alert and Sharpshooter passives', () => {
    const notes = featCombatNotes({
      featSlugs: ['alert', 'sharpshooter', 'alert'],
    });
    expect(notes.some((n) => n.includes('Iniciativa'))).toBe(true);
    expect(notes.some((n) => n.includes('Cobertura'))).toBe(true);
    // Dedup by feat slug: Alert contributes exactly its passive lines once.
    expect(notes.filter((n) => n.includes('Proficiência em Iniciativa')).length).toBe(
      1,
    );
  });

  it('ignores unknown slugs', () => {
    expect(featCombatNotes({ featSlugs: ['not-a-feat'] })).toEqual([]);
  });
});
