import { scaleCompanionCombatStats } from './scale-companion-stats';

describe('scaleCompanionCombatStats', () => {
  const abilities = {
    forca: 10,
    destreza: 10,
    constituicao: 10,
    inteligencia: 10,
    sabedoria: 16,
    carisma: 10,
  };

  it('aplica HP base+nível e AC 13+Wis (Beast of the Land)', () => {
    expect(
      scaleCompanionCombatStats(
        {
          armorClass: 13,
          companionHpBase: 5,
          companionHpPerLevel: 5,
          companionAcAbilitySlug: 'sabedoria',
        },
        3,
        abilities,
      ),
    ).toEqual({ hitPointsMax: 20, armorClass: 16 });
  });

  it('usa fórmula do céu (4+4×nível)', () => {
    expect(
      scaleCompanionCombatStats(
        {
          armorClass: 13,
          companionHpBase: 4,
          companionHpPerLevel: 4,
          companionAcAbilitySlug: 'sabedoria',
        },
        5,
        abilities,
      ),
    ).toEqual({ hitPointsMax: 24, armorClass: 16 });
  });

  it('sem colunas de escala não altera HP', () => {
    expect(
      scaleCompanionCombatStats(
        {
          armorClass: 13,
          companionHpBase: null,
          companionHpPerLevel: null,
          companionAcAbilitySlug: null,
        },
        5,
        abilities,
      ),
    ).toEqual({ hitPointsMax: null, armorClass: 13 });
  });
});
