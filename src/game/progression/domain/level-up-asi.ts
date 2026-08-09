import { BadRequestException } from '@nestjs/common';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import { STANDARD_ABILITY_SCORE_CAP } from '@game/sheet/domain/validation/feats/epic-boon-feat-options';

export type LevelUpAsiDistributionMode = 'plus2' | 'plus1plus1';

export type LevelUpAsiInput = {
  distributionMode: LevelUpAsiDistributionMode;
  primaryAbilitySlug: string;
  /** Obrigatório em plus1plus1; deve diferir do primary. */
  secondaryAbilitySlug?: string;
};

const ABILITY_KEYS: (keyof AbilityScores)[] = [
  'forca',
  'destreza',
  'constituicao',
  'inteligencia',
  'sabedoria',
  'carisma',
];

function abilityKey(slug: string): keyof AbilityScores {
  const trimmed = slug.trim();
  if (!ABILITY_KEYS.includes(trimmed as keyof AbilityScores)) {
    throw new BadRequestException(`Invalid ability slug '${slug}'`);
  }
  return trimmed as keyof AbilityScores;
}

function bumpAbility(
  scores: AbilityScores,
  slug: string,
  delta: number,
): AbilityScores {
  const key = abilityKey(slug);
  return {
    ...scores,
    [key]: Math.min(STANDARD_ABILITY_SCORE_CAP, scores[key] + delta),
  };
}

/** Resolve ASI a partir dos campos opcionais do LevelUpDto; null se nenhum campo ASI. */
export function resolveLevelUpAsiFromDto(dto: {
  asiDistributionMode?: LevelUpAsiDistributionMode;
  asiPrimaryAbilitySlug?: string;
  asiSecondaryAbilitySlug?: string;
}): LevelUpAsiInput | null {
  const hasAny =
    dto.asiDistributionMode != null ||
    dto.asiPrimaryAbilitySlug != null ||
    dto.asiSecondaryAbilitySlug != null;
  if (!hasAny) return null;

  if (!dto.asiDistributionMode) {
    throw new BadRequestException('asiDistributionMode is required when applying ASI');
  }
  if (!dto.asiPrimaryAbilitySlug?.trim()) {
    throw new BadRequestException('asiPrimaryAbilitySlug is required when applying ASI');
  }

  if (dto.asiDistributionMode === 'plus1plus1') {
    if (!dto.asiSecondaryAbilitySlug?.trim()) {
      throw new BadRequestException(
        'asiSecondaryAbilitySlug is required when asiDistributionMode is plus1plus1',
      );
    }
    return {
      distributionMode: 'plus1plus1',
      primaryAbilitySlug: dto.asiPrimaryAbilitySlug.trim(),
      secondaryAbilitySlug: dto.asiSecondaryAbilitySlug.trim(),
    };
  }

  return {
    distributionMode: 'plus2',
    primaryAbilitySlug: dto.asiPrimaryAbilitySlug.trim(),
  };
}

/** Aplica ASI de level-up: +2 em um atributo ou +1 em dois distintos (cap 20). */
export function applyLevelUpAsiBoost(
  scores: AbilityScores,
  input: LevelUpAsiInput,
): AbilityScores {
  const primary = abilityKey(input.primaryAbilitySlug);

  if (input.distributionMode === 'plus2') {
    return bumpAbility(scores, primary, 2);
  }

  if (input.distributionMode === 'plus1plus1') {
    if (!input.secondaryAbilitySlug?.trim()) {
      throw new BadRequestException(
        'secondaryAbilitySlug is required when distributionMode is plus1plus1',
      );
    }
    const secondary = abilityKey(input.secondaryAbilitySlug);
    if (secondary === primary) {
      throw new BadRequestException(
        'primaryAbilitySlug and secondaryAbilitySlug must be different',
      );
    }
    return bumpAbility(bumpAbility(scores, primary, 1), secondary, 1);
  }

  throw new BadRequestException(
    `Invalid asiDistributionMode '${String(input.distributionMode)}'`,
  );
}
