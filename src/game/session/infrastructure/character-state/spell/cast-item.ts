import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { DataSource } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  parseItemCastProperties,
  pickItemCastSlotRule,
} from '@game/session/domain/item-cast-rules';
import { resolveItemCastSlotLevel } from '@game/session/domain/resolve-item-cast-slot-level';
import { CastSpellDto } from '@game/session/dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { spendArtifactRandomSpellCast } from './cast-artifact-spell';
import {
  assertFreeItemCast,
  spendItemCastResource,
} from './cast-item-resource';

export type ItemCastSpendResult = {
  itemCastItemSlug: string;
  slotLevelUsed: number | null;
  artifactSpellNote: string | null;
  artifactSpellSaveDc: number | null;
};

/** Gasta carga / free / artefato e resolve círculo do cast de item. */
export async function spendItemCast(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  dto: CastSpellDto;
  dataSource: DataSource;
  catalogLookup: CatalogLookupService;
  spellLevel: number;
  isArtifactRandomCast: boolean;
}): Promise<ItemCastSpendResult> {
  const {
    character,
    state,
    dto,
    dataSource,
    catalogLookup,
    spellLevel,
    isArtifactRandomCast,
  } = input;

  if (isArtifactRandomCast && dto.artifactRandomCast) {
    const spent = await spendArtifactRandomSpellCast({
      character,
      dataSource,
      itemSlug: dto.artifactRandomCast.itemSlug,
      bucket: dto.artifactRandomCast.bucket,
      index: dto.artifactRandomCast.index,
      spellSlug: dto.spellSlug,
    });
    return {
      itemCastItemSlug: spent.itemSlug,
      slotLevelUsed: spellLevel === 0 ? null : spellLevel,
      artifactSpellSaveDc: spent.spellSaveDc,
      artifactSpellNote: spent.suppressedUntilLongRest
        ? `Artefato: ${spent.summaryPt} · CD ${spent.spellSaveDc} · d6=${spent.d6} (1–5: 1× até DL)`
        : `Artefato: ${spent.summaryPt} · CD ${spent.spellSaveDc} · d6=${spent.d6} (6: pode usar de novo)`,
    };
  }

  if (dto.itemCastItemSlug) {
    const match = await assertFreeItemCast({
      character,
      dataSource,
      itemSlug: dto.itemCastItemSlug,
      spellSlug: dto.spellSlug,
    });
    return {
      itemCastItemSlug: match.itemSlug,
      slotLevelUsed: spellLevel === 0 ? null : spellLevel,
      artifactSpellNote: null,
      artifactSpellSaveDc: null,
    };
  }

  const spendAmount = dto.itemCastSpendAmount ?? 1;
  const match = await spendItemCastResource({
    character,
    state,
    dataSource,
    resourceSlug: dto.itemCastResourceSlug!,
    spendAmount,
    spellSlug: dto.spellSlug,
  });
  const catalogItem = await catalogLookup.assertItemInCatalog(match.itemSlug);
  const slotParsed = parseItemCastProperties(
    (catalogItem.properties ?? null) as Record<string, unknown> | null,
  );
  return {
    itemCastItemSlug: match.itemSlug,
    slotLevelUsed: resolveItemCastSlotLevel({
      spellLevel,
      spendAmount,
      slotRule: pickItemCastSlotRule(slotParsed, dto.itemCastResourceSlug),
    }),
    artifactSpellNote: null,
    artifactSpellSaveDc: null,
  };
}
