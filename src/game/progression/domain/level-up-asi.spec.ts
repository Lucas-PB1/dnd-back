import { BadRequestException } from '@nestjs/common';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import {
  applyLevelUpAsiBoost,
  resolveLevelUpAsiFromDto,
} from './level-up-asi';

describe('level-up-asi', () => {
  const base: AbilityScores = {
    forca: 15,
    destreza: 14,
    constituicao: 13,
    inteligencia: 12,
    sabedoria: 10,
    carisma: 8,
  };

  it('applies plus2 to primary ability', () => {
    const result = applyLevelUpAsiBoost(base, {
      distributionMode: 'plus2',
      primaryAbilitySlug: 'forca',
    });
    expect(result.forca).toBe(17);
    expect(result.destreza).toBe(14);
  });

  it('applies plus1plus1 to two different abilities', () => {
    const result = applyLevelUpAsiBoost(base, {
      distributionMode: 'plus1plus1',
      primaryAbilitySlug: 'destreza',
      secondaryAbilitySlug: 'constituicao',
    });
    expect(result.destreza).toBe(15);
    expect(result.constituicao).toBe(14);
    expect(result.forca).toBe(15);
  });

  it('rejects same ability for plus1plus1', () => {
    expect(() =>
      applyLevelUpAsiBoost(base, {
        distributionMode: 'plus1plus1',
        primaryAbilitySlug: 'forca',
        secondaryAbilitySlug: 'forca',
      }),
    ).toThrow(BadRequestException);
  });

  it('rejects invalid ability slug', () => {
    expect(() =>
      applyLevelUpAsiBoost(base, {
        distributionMode: 'plus2',
        primaryAbilitySlug: 'strength',
      }),
    ).toThrow(BadRequestException);
  });

  it('respects ability score cap of 20', () => {
    const nearCap: AbilityScores = { ...base, inteligencia: 19 };
    const result = applyLevelUpAsiBoost(nearCap, {
      distributionMode: 'plus2',
      primaryAbilitySlug: 'inteligencia',
    });
    expect(result.inteligencia).toBe(20);
  });

  it('resolveLevelUpAsiFromDto returns null when ASI fields absent', () => {
    expect(resolveLevelUpAsiFromDto({})).toBeNull();
  });

  it('resolveLevelUpAsiFromDto requires mode and primary when any field set', () => {
    expect(() =>
      resolveLevelUpAsiFromDto({ asiPrimaryAbilitySlug: 'forca' }),
    ).toThrow(BadRequestException);
  });
});
