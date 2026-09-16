import { resolveFlatOverride } from './flat-override';
import type { CatalogEffect } from '@game/effects';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

const effect = {
  kind: 'heal',
  numeric: { amountFormula: 'ability_mod', flat: null },
} as CatalogEffect;

describe('resolveFlatOverride pack subclass sheet', () => {
  it('uses Constitution for armor-regen', () => {
    const character = {
      classSlug: 'monster-hunter',
      level: 15,
      abilityScores: { constituicao: 16, inteligencia: 18 },
    } as PlayerCharacter;
    expect(
      resolveFlatOverride({
        effect,
        character,
        actionSlug: 'armor-regen',
        strMod: 1,
        intMod: 4,
        castingMod: 4,
      }),
    ).toEqual({ flatOverride: 3 });
  });

  it('uses class level for wild-recovery 2d6+flat', () => {
    const character = {
      classSlug: 'druid',
      level: 11,
      abilityScores: { sabedoria: 18 },
    } as PlayerCharacter;
    expect(
      resolveFlatOverride({
        effect: {
          kind: 'heal',
          numeric: { amountFormula: 'dice_2d6_plus_flat', flat: null },
        } as CatalogEffect,
        character,
        actionSlug: 'wild-recovery',
        strMod: 0,
        intMod: 0,
        castingMod: 4,
      }),
    ).toEqual({ flatOverride: 11 });
  });
});
