import {
  heritageCombatNotes,
  loadHeritageHitPointsBonus,
} from './heritage-combat-notes';
import { asDep } from '@common/testing/as-dep';

describe('heritageCombatNotes', () => {
  it('notes extra-tough HP per take', () => {
    const notes = heritageCombatNotes({
      heritageChoices: [
        { choiceKind: 'heritage_trait_1', choiceSlug: 'extra-tough' },
        { choiceKind: 'heritage_trait_2', choiceSlug: 'extra-tough' },
      ],
    });
    expect(notes).toContain('+2 PV máx. por nível (Robustez).');
  });

  it('notes improved darkvision at 2×', () => {
    const notes = heritageCombatNotes({
      heritageChoices: [
        { choiceKind: 'heritage_trait_1', choiceSlug: 'improved-darkvision' },
        { choiceKind: 'heritage_trait_2', choiceSlug: 'improved-darkvision' },
      ],
    });
    expect(notes).toContain('Visão no Escuro 36 m.');
  });

  it('notes damage-immunity tier by takes', () => {
    const one = heritageCombatNotes({
      heritageChoices: [
        { choiceKind: 'heritage_trait_1', choiceSlug: 'damage-immunity' },
      ],
    });
    const two = heritageCombatNotes({
      heritageChoices: [
        { choiceKind: 'heritage_trait_1', choiceSlug: 'damage-immunity' },
        { choiceKind: 'heritage_trait_2', choiceSlug: 'damage-immunity' },
      ],
    });
    expect(one[0]).toMatch(/Resistência/);
    expect(two[0]).toMatch(/imunidade temporária/);
  });
});

describe('loadHeritageHitPointsBonus', () => {
  const dataSource = {
    query: jest.fn().mockResolvedValue([
      {
        trait_slug: 'extra-tough',
        per_level_bonus: 1,
        flat_bonus: 0,
        min_trait_takes: 1,
        from_level: 1,
      },
    ]),
  };

  it('scales per level and take count', async () => {
    await expect(
      loadHeritageHitPointsBonus(
        asDep(dataSource),
        [{ choiceKind: 'heritage_trait_1', choiceSlug: 'extra-tough' }],
        5,
      ),
    ).resolves.toBe(5);

    await expect(
      loadHeritageHitPointsBonus(
        asDep(dataSource),
        [
          { choiceKind: 'heritage_trait_1', choiceSlug: 'extra-tough' },
          { choiceKind: 'heritage_trait_2', choiceSlug: 'extra-tough' },
        ],
        5,
      ),
    ).resolves.toBe(10);
  });
});
