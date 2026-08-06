import {
  feyDreadfulStrikesDie,
  gloomDreadAmbusherDie,
  huntersMarkDie,
  hasPreciseHunter,
  isRangerClass,
  rangerAttacksPerAction,
  rangerCombatNotes,
  rangerSpeedBonusMeters,
} from './features';

describe('ranger-features', () => {
  it('identifies the ranger class', () => {
    expect(isRangerClass('ranger')).toBe(true);
    expect(isRangerClass('paladin')).toBe(false);
  });

  it('uses d6 for Hunter\'s Mark and d10 at level 20', () => {
    expect(huntersMarkDie(1)).toBe('1d6');
    expect(huntersMarkDie(19)).toBe('1d6');
    expect(huntersMarkDie(20)).toBe('1d10');
  });

  it('scales Fey Wanderer and Gloom Stalker psychic dice', () => {
    expect(feyDreadfulStrikesDie(3)).toBe('1d4');
    expect(feyDreadfulStrikesDie(11)).toBe('1d6');
    expect(gloomDreadAmbusherDie(3)).toBe('2d6');
    expect(gloomDreadAmbusherDie(11)).toBe('2d8');
  });

  it('grants Extra Attack, speed bonus and Precise Hunter by level', () => {
    expect(rangerAttacksPerAction(4)).toBe(1);
    expect(rangerAttacksPerAction(5)).toBe(2);
    expect(rangerSpeedBonusMeters({ classSlug: 'ranger', level: 5 })).toBe(0);
    expect(rangerSpeedBonusMeters({ classSlug: 'ranger', level: 6 })).toBe(3);
    expect(rangerSpeedBonusMeters({ classSlug: 'fighter', level: 6 })).toBe(0);
    expect(hasPreciseHunter(16)).toBe(false);
    expect(hasPreciseHunter(17)).toBe(true);
  });

  it('lists core and subclass notes', () => {
    const notes = rangerCombatNotes({
      classSlug: 'ranger',
      subclassSlug: 'gloom-stalker',
      level: 11,
    });
    expect(notes.join(' ')).toContain('Inimigo Favorito');
    expect(notes.join(' ')).toContain('Incansável');
    expect(notes.join(' ')).toContain('Emboscador das Sombras');
    expect(notes.join(' ')).toContain('Torrente do Vigilante');
  });
});
