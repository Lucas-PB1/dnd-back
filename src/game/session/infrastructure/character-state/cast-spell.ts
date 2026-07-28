import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '../../../../catalog/catalog-lookup.service';
import { VClassSpellSlots } from '../../../../entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '../../../../entities/views/v-subclass-spell-slots.entity';
import { PlayerCharacter } from '../../../shared/infrastructure/player-character.entity';
import { CharacterSpellLookup } from '../../../sheet/application/character-spell-lookup';
import {
  CastSpellDto,
  CharacterStateResponseDto,
} from '../../dto/character-state.dto';
import { PlayerCharacterState } from '../player-character-state.entity';
import { consumeSpellSlot, loadMaxSlots } from './spell-slots';

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
  buildResponse: BuildResponse;
}): Promise<{ slotLevelUsed: number | null; state: CharacterStateResponseDto }> {
  const {
    character,
    state,
    dto,
    stateRepo,
    classSlots,
    subclassSlots,
    catalogLookup,
    spellLookup,
    buildResponse,
  } = input;

  const knowsSpell = await spellLookup.hasSpell(character.id, dto.spellSlug);
  if (!knowsSpell) {
    throw new BadRequestException(
      `Spell '${dto.spellSlug}' is not on this character's list`,
    );
  }

  const spell = await catalogLookup.findSpellOrFail(dto.spellSlug);
  let slotLevelUsed: number | null = null;

  if (spell.level > 0) {
    const maxSlots = await loadMaxSlots(
      classSlots,
      subclassSlots,
      character.classSlug,
      character.level,
      character.subclassSlug,
    );
    slotLevelUsed = consumeSpellSlot(state, maxSlots, spell.level, dto.slotLevel);
  }

  if (spell.concentration) {
    state.concentratingOn = dto.spellSlug;
  }

  await stateRepo.save(state);
  return {
    slotLevelUsed,
    state: await buildResponse(character, state),
  };
}
