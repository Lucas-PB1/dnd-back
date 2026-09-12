import { scaleCompanionCombatStats } from './scale-companion-stats';

describe('scaleCompanionCombatStats', () => {
  const scores = {
    forca: 10,
    destreza: 10,
    constituicao: 10,
    inteligencia: 10,
    sabedoria: 14,
    carisma: 10,
  };

  it('HP = base + per_level × nível; CA += mod do atributo', () => {
    expect(
      scaleCompanionCombatStats(
        {
          armorClass: 13,
          hpBase: 5,
          hpPerLevel: 5,
          acAbilitySlug: 'sabedoria',
        },
        3,
        scores,
      ),
    ).toEqual({ hitPointsMax: 20, armorClass: 15 });
  });

  it('sem atributo de CA: só HP escala', () => {
    expect(
      scaleCompanionCombatStats(
        {
          armorClass: 14,
          hpBase: 4,
          hpPerLevel: 4,
          acAbilitySlug: null,
        },
        2,
        scores,
      ),
    ).toEqual({ hitPointsMax: 12, armorClass: 14 });
  });
});
