import {
  collectSubclassOptionGrantedSpellSlugs,
  collectSubclassSpellbookBonusSlugs,
} from './subclass-option-effects';

describe('subclass-option-effects', () => {
  it('collects lore magical discoveries at level', () => {
    const unlock = new Map([
      ['magicalDiscovery1', 6],
      ['magicalDiscovery2', 6],
    ]);
    const slugs = collectSubclassOptionGrantedSpellSlugs(
      6,
      [
        { optionKey: 'magicalDiscovery1', valueId: 'auxilio' },
        { optionKey: 'magicalDiscovery2', valueId: 'curar-ferimentos' },
      ],
      unlock,
    );
    expect(slugs).toEqual(new Set(['auxilio', 'curar-ferimentos']));
  });

  it('collects wizard versatility spellbook picks', () => {
    expect(
      collectSubclassSpellbookBonusSlugs([
        { optionKey: 'abjurationVersatility1', valueId: 'escudo' },
        { optionKey: 'abjurationVersatility2', valueId: 'armadura-arcana' },
      ]),
    ).toEqual(new Set(['escudo', 'armadura-arcana']));
  });
});
