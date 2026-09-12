import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import type { EldritchFreeCastResolution } from '@game/combat/domain/warlock';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { LoadEffectCatalog, hasSlotElevate, hasSlotReduce } from '@game/effects';
import {
  consumeGrantedFreeCast,
  freeCastsRemaining,
} from '@game/spellcasting/domain/resolve-granted-spell-cast-economy';
import {
  CastSpellDto,
} from '@game/session/dto/core/session-commands.dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import {
  consumeSpellSlot,
  loadMaxSlots,
  recoverSpellSlot,
} from '../resources/spell-slots';
import {
  resolveGrantedFreeCastBudget,
} from './cast-granted-economy';

export type SlotConsumeResult = {
  slotLevelUsed: number | null;
  usedFreeResource: boolean;
  usedSpellMastery: boolean;
  usedEldritchFreeCast: EldritchFreeCastResolution | null;
};

export async function consumeNonItemCastCost(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  dto: CastSpellDto;
  spellLevel: number;
  masteryFree: boolean;
  eldritchFreeCast: EldritchFreeCastResolution | null;
  sheetRepository: CharacterSheetRepository;
  grantedSpellCatalog: LoadGrantedSpellCatalog;
  effectCatalog: LoadEffectCatalog;
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
    effectCatalog,
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
    const isEldritchOnce =
      eldritchFreeCast?.economy === 'once_per_long_rest';
    const budget = isEldritchOnce
      ? { economy: eldritchFreeCast.economy, maxUses: 1 as const }
      : await resolveGrantedFreeCastBudget(
          character,
          dto.spellSlug,
          sheetRepository,
          grantedSpellCatalog,
          effectCatalog,
        );
    if (budget.economy !== 'once_per_long_rest') {
      throw new BadRequestException(
        `Spell '${dto.spellSlug}' cannot be cast with a free granted use`,
      );
    }
    const remaining = freeCastsRemaining(
      budget.economy,
      dto.spellSlug,
      state.grantedSpellUses,
      budget.maxUses,
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
    if (isEldritchOnce) {
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
    const grantedBudget = await resolveGrantedFreeCastBudget(
      character,
      dto.spellSlug,
      sheetRepository,
      grantedSpellCatalog,
      effectCatalog,
    );
    if (grantedBudget.economy === 'at_will') {
    } else {
    const maxSlots = await loadMaxSlots(
      classSlots,
      subclassSlots,
      character.classSlug,
      character.level,
      character.subclassSlug,
    );
    if (dto.flexElevateExtraSlots && dto.flexReduce) {
      throw new BadRequestException(
        'Flex elevate and reduce cannot be used together',
      );
    }
    slotLevelUsed = consumeSpellSlot(
      state,
      maxSlots,
      spellLevel,
      dto.slotLevel,
    );
    if (dto.flexElevateExtraSlots || dto.flexReduce) {
      const sheet = await sheetRepository.load(character.id);
      const featSlugs = sheet.characterFeats.map((f) => f.featSlug);
      const effects = await effectCatalog.load({
        ownerKind: 'feat',
        ownerSlugs: featSlugs,
      });
      if (dto.flexElevateExtraSlots) {
        if (!hasSlotElevate(effects, featSlugs)) {
          throw new BadRequestException(
            'Flex elevate requires the Flex Caster feat',
          );
        }
        for (let i = 0; i < dto.flexElevateExtraSlots; i += 1) {
          consumeSpellSlot(state, maxSlots, spellLevel, slotLevelUsed);
        }
      }
      if (dto.flexReduce) {
        if (!hasSlotReduce(effects, featSlugs)) {
          throw new BadRequestException(
            'Flex reduce requires the Flex Caster feat',
          );
        }
        if (slotLevelUsed !== spellLevel) {
          throw new BadRequestException(
            'Flex reduce requires casting at the spell base level',
          );
        }
        recoverSpellSlot(state, 1);
      }
    }
    }
  }

  return {
    slotLevelUsed,
    usedFreeResource,
    usedSpellMastery,
    usedEldritchFreeCast,
  };
}
