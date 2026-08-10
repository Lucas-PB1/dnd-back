import {
  findGunslingerManeuver,
  listGunslingerManeuvers,
} from './maneuvers';
import { FIXTURE_GUNSLINGER_MANEUVERS } from '../__fixtures__/mechanical-catalog.fixtures';

describe('listGunslingerManeuvers', () => {
  it('returns base maneuvers at level 2 without subclass', () => {
    const listed = listGunslingerManeuvers(FIXTURE_GUNSLINGER_MANEUVERS, {
      level: 2,
    });
    expect(listed.every((m) => !m.subclassSlug)).toBe(true);
    expect(listed.map((m) => m.slug)).toContain('bite-the-bullet');
  });

  it('includes deadeye maneuver and excludes other subclasses', () => {
    const listed = listGunslingerManeuvers(FIXTURE_GUNSLINGER_MANEUVERS, {
      level: 20,
      subclassSlug: 'deadeye',
    });
    const slugs = listed.map((m) => m.slug);
    expect(slugs).toContain('eagle-eye');
    expect(slugs).not.toContain('fan-the-hammer');
    expect(slugs).not.toContain('ricochet');
  });

  it('includes both trick-shot maneuvers at level 10+', () => {
    const listed = listGunslingerManeuvers(FIXTURE_GUNSLINGER_MANEUVERS, {
      level: 10,
      subclassSlug: 'trick-shot',
    });
    const slugs = listed.map((m) => m.slug);
    expect(slugs).toContain('ricochet');
    expect(slugs).toContain('skilled-deflection');
  });
});

describe('findGunslingerManeuver', () => {
  it('finds subclass maneuver by slug', () => {
    expect(
      findGunslingerManeuver(FIXTURE_GUNSLINGER_MANEUVERS, 'lay-down-the-law')
        ?.subclassSlug,
    ).toBe('white-hat');
  });
});
