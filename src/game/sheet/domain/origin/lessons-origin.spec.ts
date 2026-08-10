import {
  resolveLessonsOriginCharacterFeats,
  syncLessonsOriginCharacterFeats,
} from './lessons-origin';

describe('lessons-origin', () => {
  const optionsWithLucky = [
    {
      optionKey: 'eldritch-invocation',
      valueId: 'lessons-of-the-first-ones',
      instanceIndex: 0,
    },
    {
      optionKey: 'eldritch-invocation-origin-feat',
      valueId: 'lucky',
      instanceIndex: 0,
    },
  ];

  it('adds lessons origin feats without duplicating', () => {
    expect(
      resolveLessonsOriginCharacterFeats(optionsWithLucky, [
        { featSlug: 'magic-initiate', instanceIndex: 0 },
      ]),
    ).toEqual([
      { featSlug: 'magic-initiate', instanceIndex: 0 },
      { featSlug: 'lucky', instanceIndex: 0 },
    ]);

    expect(
      resolveLessonsOriginCharacterFeats(optionsWithLucky, [
        { featSlug: 'lucky', instanceIndex: 0 },
      ]),
    ).toEqual([{ featSlug: 'lucky', instanceIndex: 0 }]);
  });

  it('syncs removals without touching protected feats', () => {
    const previous = optionsWithLucky;
    const next = [
      {
        optionKey: 'eldritch-invocation',
        valueId: 'lessons-of-the-first-ones',
        instanceIndex: 0,
      },
      {
        optionKey: 'eldritch-invocation-origin-feat',
        valueId: 'alert',
        instanceIndex: 0,
      },
    ];

    expect(
      syncLessonsOriginCharacterFeats({
        previousClassOptions: previous,
        nextClassOptions: next,
        characterFeats: [
          { featSlug: 'magic-initiate', instanceIndex: 0 },
          { featSlug: 'lucky', instanceIndex: 0 },
        ],
        protectedFeatSlugs: new Set(['magic-initiate']),
      }),
    ).toEqual([
      { featSlug: 'magic-initiate', instanceIndex: 0 },
      { featSlug: 'alert', instanceIndex: 0 },
    ]);
  });
});
