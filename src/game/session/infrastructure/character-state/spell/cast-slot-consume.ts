import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import type { EldritchFreeCastResolution } from '@game/combat/domain/warlock';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import {
  consumeGrantedFreeCast,
  freeCastsRemaining,
} from '@game/spellcasting/domain/resolve-granted-spell-cast-economy';
import { CastSpellDto } from '@game/session/dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { consumeSpellSlot, loadMaxSlots } from '../resources/spell-slots';
import { resolveSpellCastEconomyForCharacter } from './cast-granted-economy';

export type SlotConsumeResult = {
  slotLevelUsed: number | null;
  usedFreeResource: boolean;
  usedSpellMastery: boolean;
  usedEldritchFreeCast: EldritchFreeCastResolution | null;
};

/** Gasta free cast / mastery / slot (não item). */
export async function consumeNonItemCastCost(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  dto: CastSpellDto;
  spellLevel: number;
  masteryFree: boolean;
  eldritchFreeCast: EldritchFreeCastResolution | null;
  sheetRepository: CharacterSheetRepository;
  grantedSpellCatalog: LoadGrantedSpellCatalog;
  classSlots: Repository<VClassSpellSlots>;
  subclassSlots: Repository<VSubclassSpellSlots>;
  spendFreeCastResource: () => Promise<void>;
}): Promise<SlotConsumeResult> {
  const {
    character,
    state,
    dto,
    spellLevel,
    masteryFree,
    eldritchFreeCast,
    sheetRepository,
    grantedSpellCatalog,
    classSlots,
    subclassSlots,
  } = input;

  let slotLevelUsed: number | null = null;
  let usedFreeResource = false;
  let usedSpellMastery = false;
  let usedEldritchFreeCast: EldritchFreeCastResolution | null = null;

  if (dto.freeCastResourceSlug) {
    await input.spendFreeCastResource();
    usedFreeResource = true;
  } else if (dto.useFreeCast) {
    const economy =
      eldritchFreeCast?.economy === 'once_per_long_rest'
        ? eldritchFreeCast.economy
        : await resolveSpellCastEconomyForCharacter(
            character,
            dto.spellSlug,
            sheetRepository,
            grantedSpellCatalog,
          );
    if (economy !== 'once_per_long_rest') {
      throw new BadRequestException(
        `Spell '${dto.spellSlug}' cannot be cast with a free granted use`,
      );
    }
    const remaining = freeCastsRemaining(
      economy,
      dto.spellSlug,
      state.grantedSpellUses,
    );
    if (remaining !== null && remaining <= 0) {
      throw new BadRequestException(
        `No free cast remaining for '${dto.spellSlug}' until a Long Rest`,
      );
    }
    state.grantedSpellUses = consumeGrantedFreeCast(
      state.grantedSpellUses,
      dto.spellSlug,
    );
    if (eldritchFreeCast?.economy === 'once_per_long_rest') {
      usedEldritchFreeCast = eldritchFreeCast;
    }
  } else if (eldritchFreeCast?.economy === 'at_will') {
    usedEldritchFreeCast = eldritchFreeCast;
  } else if (
    eldritchFreeCast?.economy === 'once_per_long_rest' &&
    (freeCastsRemaining(
      eldritchFreeCast.economy,
      dto.spellSlug,
      state.grantedSpellUses,
    ) ?? 0) > 0
  ) {
    state.grantedSpellUses = consumeGrantedFreeCast(
      state.grantedSpellUses,
      dto.spellSlug,
    );
    usedEldritchFreeCast = eldritchFreeCast;
  } else if (masteryFree) {
    usedSpellMastery = true;
  } else if (spellLevel > 0) {
    const maxSlots = await loadMaxSlots(
      classSlots,
      subclassSlots,
      character.classSlug,
      character.level,
      character.subclassSlug,
    );
    slotLevelUsed = consumeSpellSlot(
      state,
      maxSlots,
      spellLevel,
      dto.slotLevel,
    );
  }

  return {
    slotLevelUsed,
    usedFreeResource,
    usedSpellMastery,
    usedEldritchFreeCast,
  };
}
