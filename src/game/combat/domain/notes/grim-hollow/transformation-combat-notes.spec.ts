import { transformationCombatNotes } from './transformation-combat-notes';

describe('transformationCombatNotes', () => {
  it('includes auto + picked boons for vampire stage 1', () => {
    const notes = transformationCombatNotes({
      slug: 'gh-transformation-vampire',
      stage: 1,
      choices: [{ choiceKind: 'stage1Boon', choiceSlug: 'soman-bloodline' }],
    });
    expect(notes.some((n) => /Fanged Bite|Mordida|fanged/i.test(n) || n.includes('Fanged'))).toBe(
      true,
    );
    expect(notes.some((n) => /Soman|soman/i.test(n))).toBe(true);
  });

  it('adds stage 2 picks when stage advances', () => {
    const s1 = transformationCombatNotes({
      slug: 'gh-transformation-vampire',
      stage: 1,
      choices: [{ choiceKind: 'stage1Boon', choiceSlug: 'soman-bloodline' }],
    });
    const s2 = transformationCombatNotes({
      slug: 'gh-transformation-vampire',
      stage: 2,
      choices: [
        { choiceKind: 'stage1Boon', choiceSlug: 'soman-bloodline' },
        { choiceKind: 'stage2Boon', choiceSlug: 'eyes-of-the-night' },
        { choiceKind: 'stage2Boon2', choiceSlug: 'undead-resilience' },
      ],
    });
    expect(s2.length).toBeGreaterThan(s1.length);
    expect(s2.some((n) => /Eyes of the Night|Olhos/i.test(n))).toBe(true);
  });

  it('returns empty without transformation', () => {
    expect(transformationCombatNotes(null)).toEqual([]);
    expect(transformationCombatNotes({ slug: '', stage: 1 })).toEqual([]);
  });

  it('ignores subOptions that are not boons', () => {
    const notes = transformationCombatNotes({
      slug: 'gh-transformation-fiend',
      stage: 1,
      choices: [
        { choiceKind: 'stage1Boon', choiceSlug: 'infernal-smite' },
        { choiceKind: 'fiendDamageType', choiceSlug: 'fire' },
      ],
    });
    expect(notes.some((n) => n.includes('fire'))).toBe(false);
    expect(notes.some((n) => /Punição Infernal|Infernal Smite/i.test(n))).toBe(true);
    expect(notes.some((n) => /Alma Corruptora|Fiendish Soul/i.test(n))).toBe(true);
  });
});
