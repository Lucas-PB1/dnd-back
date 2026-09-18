import { findDeclaredEconomyAction } from './find-economy-action';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';

describe('findDeclaredEconomyAction (PVE-9a)', () => {
  const rows = [
    {
      id: 'vengeance',
      classSlug: 'paladin',
      subclassSlug: 'vengeance',
      tableAction: 'oath-channel',
      itemSlug: null,
      featSlug: null,
      speciesSlug: null,
    },
    {
      id: 'devotion',
      classSlug: 'paladin',
      subclassSlug: 'devotion',
      tableAction: 'oath-channel',
      itemSlug: null,
      featSlug: null,
      speciesSlug: null,
    },
    {
      id: 'lay',
      classSlug: 'paladin',
      subclassSlug: null,
      tableAction: 'lay-on-hands',
      itemSlug: null,
      featSlug: null,
      speciesSlug: null,
    },
  ] as ClassEconomyActionRecord[];

  it('prefers the economy row matching the character subclass', () => {
    const found = findDeclaredEconomyAction(
      rows,
      'paladin',
      'oath-channel',
      'devotion',
    );
    expect(found?.id).toBe('devotion');
  });

  it('falls back to class-only when no subclass row matches', () => {
    const found = findDeclaredEconomyAction(
      rows,
      'paladin',
      'lay-on-hands',
      'devotion',
    );
    expect(found?.id).toBe('lay');
  });
});
