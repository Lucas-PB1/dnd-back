import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { VPhbCharacterThreadBundle } from '@entities/views/v-phb-character-thread-bundle.entity';

export async function resolveThreadGoal(
  bundles: Repository<VPhbCharacterThreadBundle>,
  threadSlug: string,
  goalIndex: number | null | undefined,
  goalText: string | null | undefined,
): Promise<{ goalIndex: number | null; goalText: string | null }> {
  if (goalIndex == null) {
    return {
      goalIndex: null,
      goalText: goalText?.trim() ? goalText.trim() : null,
    };
  }

  const bundle = await bundles.findOne({ where: { slug: threadSlug } });
  const goal = (bundle?.goals ?? []).find((row) => row.sortOrder === goalIndex);
  if (!goal) {
    throw new BadRequestException(
      `Goal ${goalIndex} não existe no thread '${threadSlug}'`,
    );
  }

  return {
    goalIndex,
    goalText: goalText?.trim() ? goalText.trim() : goal.text,
  };
}
