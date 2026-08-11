import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { ARTIFACT_RANDOM_SPELL_SAVE_DC } from '@game/inventory/domain/artifact/artifact-instance.types';
import {
  markArtifactSpellSpent,
  readArtifactSpellProp,
} from '@game/inventory/domain/artifact/artifact-instance-ops';
import {
  artifactSpellSuppressedUntilRest,
  rollArtifactSpellD6,
} from '@game/inventory/domain/artifact/artifact-spell-d6';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import { loadActiveItemSlugs } from '../resources/class-resources';

export async function spendArtifactRandomSpellCast(input: {
  character: PlayerCharacter;
  dataSource: DataSource;
  itemSlug: string;
  bucket:
    | 'minorBeneficial'
    | 'majorBeneficial'
    | 'minorDetrimental'
    | 'majorDetrimental';
  index: number;
  spellSlug: string;
  rng?: () => number;
}): Promise<{
  itemSlug: string;
  summaryPt: string;
  spellSaveDc: number;
  d6: number;
  suppressedUntilLongRest: boolean;
}> {
  const { character, dataSource, itemSlug, bucket, index, spellSlug } = input;
  const activeItemSlugs = await loadActiveItemSlugs(dataSource, character.id);
  if (!activeItemSlugs.includes(itemSlug)) {
    throw new BadRequestException(
      `Item '${itemSlug}' is not active for artifact spell cast`,
    );
  }

  const items = dataSource.getRepository(PlayerCharacterItem);
  const row = await items.findOne({
    where: { characterId: character.id, itemSlug },
  });
  if (!row?.attuned) {
    throw new BadRequestException(
      `Item '${itemSlug}' must be attuned to cast artifact spells`,
    );
  }

  let bound;
  try {
    bound = readArtifactSpellProp({
      instance: row.instanceProperties,
      bucket,
      index,
    });
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Invalid artifact spell prop',
    );
  }
  if (bound.effect.spellSlug !== spellSlug) {
    throw new BadRequestException(
      `Artifact prop spell is '${bound.effect.spellSlug}', not '${spellSlug}'`,
    );
  }
  if (bound.effect.spentUntilLongRest) {
    throw new BadRequestException(
      'Artifact random spell already used until Long Rest',
    );
  }

  const d6 = rollArtifactSpellD6(input.rng ?? Math.random);
  const suppressedUntilLongRest = artifactSpellSuppressedUntilRest(d6);
  if (suppressedUntilLongRest) {
    try {
      row.instanceProperties = markArtifactSpellSpent({
        instance: row.instanceProperties,
        bucket,
        index,
      });
    } catch (error) {
      throw new BadRequestException(
        error instanceof Error ? error.message : 'Cannot spend artifact spell',
      );
    }
  }
  await items.save(row);

  return {
    itemSlug,
    summaryPt: bound.prop.summaryPt,
    spellSaveDc: bound.effect.spellSaveDc ?? ARTIFACT_RANDOM_SPELL_SAVE_DC,
    d6,
    suppressedUntilLongRest,
  };
}
