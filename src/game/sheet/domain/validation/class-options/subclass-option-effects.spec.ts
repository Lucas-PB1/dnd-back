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

  it('collects Blade holy revelation cantrips at level 13', () => {
    const unlock = new Map([
      ['holyRevelationCantrip1', 13],
      ['holyRevelationCantrip2', 13],
    ]);
    expect(
      collectSubclassOptionGrantedSpellSlugs(
        13,
        [
          { optionKey: 'holyRevelationCantrip1', valueId: 'luz' },
          { optionKey: 'holyRevelationCantrip2', valueId: 'taumaturgia' },
        ],
        unlock,
      ),
    ).toEqual(new Set(['luz', 'taumaturgia']));
    expect(
      collectSubclassOptionGrantedSpellSlugs(
        12,
        [{ optionKey: 'holyRevelationCantrip1', valueId: 'luz' }],
        unlock,
      ),
    ).toEqual(new Set());
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
