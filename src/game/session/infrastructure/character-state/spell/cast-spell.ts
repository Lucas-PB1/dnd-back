import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import { isSpellMasterySpell } from '@game/combat/domain/wizard';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterSpellLookup } from '@game/sheet/application/character-spell-lookup';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import {
  CastSpellDto,
  CharacterStateResponseDto,
} from '@game/session/dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { appendItemCastTreasureNotes } from './cast-item-finish';
import { applyPostCastInventoryEffects } from './cast-inventory-effects';
import { applyMagicMissileMageOnCast } from './cast-magic-missile';
import { resolveEldritchFreeCastForSpell } from './cast-eldritch-prelude';
import { appendNonItemCastNotes } from './cast-notes';
import {
  assertItemCastDtoExclusive,
  resolveCastSpend,
} from './cast-spend';

type BuildResponse = (
  character: PlayerCharacter,
  stateRow?: PlayerCharacterState,
) => Promise<CharacterStateResponseDto>;

export async function applyCastSpell(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  dto: CastSpellDto;
  stateRepo: Repository<PlayerCharacterState>;
  classSlots: Repository<VClassSpellSlots>;
  subclassSlots: Repository<VSubclassSpellSlots>;
  catalogLookup: CatalogLookupService;
  spellLookup: CharacterSpellLookup;
  sheetRepository: CharacterSheetRepository;
  grantedSpellCatalog: LoadGrantedSpellCatalog;
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<{
  slotLevelUsed: number | null;
  note: string | null;
  spellSaveDcOverride: number | null;
  spellAttackBonusOverride: number | null;
  state: CharacterStateResponseDto;
}> {
  const {
    character,
    state,
    dto,
    stateRepo,
    classSlots,
    subclassSlots,
    catalogLookup,
    spellLookup,
    sheetRepository,
    grantedSpellCatalog,
    dataSource,
    buildResponse,
  } = input;

  const sheet = await sheetRepository.load(
    character.id,
    character.backgroundSlug,
  );
  const eldritchFreeCast = await resolveEldritchFreeCastForSpell({
    character,
    dataSource,
    spellSlug: dto.spellSlug,
    classOptions: sheet.classOptions,
  });

  const isArtifactRandomCast = Boolean(dto.artifactRandomCast);
  const isItemCast = Boolean(
    dto.itemCastResourceSlug || dto.itemCastItemSlug || isArtifactRandomCast,
  );
  assertItemCastDtoExclusive(dto, isArtifactRandomCast, isItemCast);

  const knowsSpell = await spellLookup.hasSpell(character.id, dto.spellSlug);
  if (!isItemCast && !knowsSpell && !eldritchFreeCast) {
    throw new BadRequestException(
      `Spell '${dto.spellSlug}' is not on this character's list`,
    );
  }

  const spell = await catalogLookup.findSpellOrFail(dto.spellSlug);
  const masteryFree =
    !isItemCast &&
    !dto.freeCastResourceSlug &&
    !dto.useFreeCast &&
    isSpellMasterySpell(dto.spellSlug, sheet.classOptions);

  const spend = await resolveCastSpend({
    character,
    state,
    dto,
    dataSource,
    catalogLookup,
    sheetRepository,
    grantedSpellCatalog,
    classSlots,
    subclassSlots,
    spellLevel: spell.level,
    isItemCast,
    isArtifactRandomCast,
    masteryFree,
    eldritchFreeCast,
  });

  let note = await applyMagicMissileMageOnCast({
    character,
    state,
    dataSource,
    spellSlug: dto.spellSlug,
    slotLevelUsed: spend.slotLevelUsed,
    usedFreeResource: spend.usedFreeResource,
  });
  if (spend.usedSpellMastery) {
    const masteryNote = 'Dominância de Magias: conjurada sem espaço.';
    note = note ? `${note} · ${masteryNote}` : masteryNote;
  }

  if (spend.usedItemCast) {
    const finished = await appendItemCastTreasureNotes({
      character,
      state,
      dto,
      catalogLookup,
      dataSource,
      spell,
      note,
      itemCastItemSlug: spend.itemCastItemSlug,
      artifactSpellNote: spend.artifactSpellNote,
      artifactSpellSaveDc: spend.artifactSpellSaveDc,
    });
    await applyPostCastInventoryEffects(
      dto.spellSlug,
      dataSource,
      catalogLookup,
      character.id,
    );
    await stateRepo.save(state);
    return {
      slotLevelUsed: spend.slotLevelUsed,
      note: finished.note,
      spellSaveDcOverride: finished.spellSaveDcOverride,
      spellAttackBonusOverride: finished.spellAttackBonusOverride,
      state: await buildResponse(character, state),
    };
  }

  note = appendNonItemCastNotes({
    note,
    usedEldritchFreeCast: spend.usedEldritchFreeCast,
    spell,
    dto,
    sheetClassOptions: sheet.classOptions,
    character,
  });
  if (spell.concentration) {
    state.concentratingOn = dto.spellSlug;
  }
  await applyPostCastInventoryEffects(
    dto.spellSlug,
    dataSource,
    catalogLookup,
    character.id,
  );
  await stateRepo.save(state);
  return {
    slotLevelUsed: spend.slotLevelUsed,
    note,
    spellSaveDcOverride: null,
    spellAttackBonusOverride: null,
    state: await buildResponse(character, state),
  };
}
