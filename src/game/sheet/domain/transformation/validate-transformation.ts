import { BadRequestException } from '@nestjs/common';
import { assertUnique } from '@common/assert';
import type { SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';

export const GH_TRANSFORMATION_CATEGORY = 'gh-transformation';

export type CharacterTransformation = {
  slug: string;
  stage: number;
  choices: readonly SpeciesChoiceDto[];
};

export function isGhTransformationFeatSlug(featSlug: string): boolean {
  return featSlug.startsWith('gh-transformation-');
}

/** Shape + regras mínimas (slug/stage/kinds). Choices: validateTransformationChoices. */
export function validateTransformationShape(
  transformation: CharacterTransformation,
): void {
  const slug = transformation.slug?.trim();
  if (!slug) {
    throw new BadRequestException('transformation.slug is required');
  }
  if (!isGhTransformationFeatSlug(slug)) {
    throw new BadRequestException(
      `transformation.slug '${slug}' must be a Cap. 6 transformation`,
    );
  }

  const stage = Number(transformation.stage);
  if (!Number.isInteger(stage) || stage < 1 || stage > 4) {
    throw new BadRequestException('transformation.stage must be an integer from 1 to 4');
  }

  const choices = transformation.choices ?? [];
  for (const choice of choices) {
    if (!choice.choiceKind?.trim()) {
      throw new BadRequestException('transformation choiceKind is required');
    }
    if (!choice.choiceSlug?.trim()) {
      throw new BadRequestException(
        `transformation choiceSlug is required for '${choice.choiceKind}'`,
      );
    }
  }
  assertUnique(
    choices.map((choice) => choice.choiceKind.trim()),
    'Duplicate transformation choiceKind is not allowed',
  );
}

export function assertFeatIsNotTransformationCatalog(featSlug: string): void {
  if (isGhTransformationFeatSlug(featSlug)) {
    throw new BadRequestException(
      `Feat '${featSlug}' is a Cap. 6 transformation — use transformation, not characterFeats`,
    );
  }
}
