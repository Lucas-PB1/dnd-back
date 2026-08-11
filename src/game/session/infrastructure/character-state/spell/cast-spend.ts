import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import type { EldritchFreeCastResolution } from '@game/combat/domain/warlock';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { CastSpellDto } from '@game/session/dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { spendItemCast } from './cast-item';
import { spendFreeCastResource } from './cast-magic-missile';
import { consumeNonItemCastCost } from './cast-slot-consume';

export type CastSpendResult = {
  usedItemCast: boolean;
  slotLevelUsed: number | null;
  usedFreeResource: boolean;
  usedSpellMastery: boolean;
  usedEldritchFreeCast: EldritchFreeCastResolution | null;
  itemCastItemSlug: string | null;
  artifactSpellNote: string | null;
  artifactSpellSaveDc: number | null;
};

export function assertItemCastDtoExclusive(
  dto: CastSpellDto,
  isArtifactRandomCast: boolean,
  isItemCast: boolean,
): void {
  if (dto.itemCastResourceSlug && dto.itemCastItemSlug) {
    throw new BadRequestException(
      'Cannot combine itemCastResourceSlug with itemCastItemSlug',
    );
  }
  if (
    isArtifactRandomCast &&
    (dto.itemCastResourceSlug || dto.itemCastItemSlug)
  ) {
    throw new BadRequestException(
      'Cannot combine artifactRandomCast with other item cast fields',
    );
  }
  if (isItemCast && dto.freeCastResourceSlug) {
    throw new BadRequestException(
      'Cannot combine item cast with freeCastResourceSlug',
    );
  }
}

export async function resolveCastSpend(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  dto: CastSpellDto;
  dataSource: DataSource;
  catalogLookup: CatalogLookupService;
  sheetRepository: CharacterSheetRepository;
  grantedSpellCatalog: LoadGrantedSpellCatalog;
  classSlots: Repository<VClassSpellSlots>;
  subclassSlots: Repository<VSubclassSpellSlots>;
  spellLevel: number;
  isItemCast: boolean;
  isArtifactRandomCast: boolean;
  masteryFree: boolean;
  eldritchFreeCast: EldritchFreeCastResolution | null;
}): Promise<CastSpendResult> {
  if (input.isItemCast) {
    const spent = await spendItemCast({
      character: input.character,
      state: input.state,
      dto: input.dto,
      dataSource: input.dataSource,
      catalogLookup: input.catalogLookup,
      spellLevel: input.spellLevel,
      isArtifactRandomCast: input.isArtifactRandomCast,
    });
    return {
      usedItemCast: true,
      slotLevelUsed: spent.slotLevelUsed,
      usedFreeResource: false,
      usedSpellMastery: false,
      usedEldritchFreeCast: null,
      itemCastItemSlug: spent.itemCastItemSlug,
      artifactSpellNote: spent.artifactSpellNote,
      artifactSpellSaveDc: spent.artifactSpellSaveDc,
    };
  }
  const consumed = await consumeNonItemCastCost({
    character: input.character,
    state: input.state,
    dto: input.dto,
    spellLevel: input.spellLevel,
    masteryFree: input.masteryFree,
    eldritchFreeCast: input.eldritchFreeCast,
    sheetRepository: input.sheetRepository,
    grantedSpellCatalog: input.grantedSpellCatalog,
    classSlots: input.classSlots,
    subclassSlots: input.subclassSlots,
    spendFreeCastResource: () =>
      spendFreeCastResource({
        character: input.character,
        state: input.state,
        dataSource: input.dataSource,
        resourceSlug: input.dto.freeCastResourceSlug!,
        spellSlug: input.dto.spellSlug,
      }),
  });
  return {
    usedItemCast: false,
    ...consumed,
    itemCastItemSlug: null,
    artifactSpellNote: null,
    artifactSpellSaveDc: null,
  };
}
