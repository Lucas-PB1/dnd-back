import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '../../../../../catalog/catalog-lookup.service';
import { VClassSpellSlots } from '../../../../../entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '../../../../../entities/views/v-subclass-spell-slots.entity';
import { PlayerCharacter } from '../../../../shared/infrastructure/player-character.entity';
import { CharacterSpellLookup } from '../../../../sheet/application/character-spell-lookup';
import { CharacterSheetRepository } from '../../../../sheet/infrastructure/character-sheet.repository';
import { LoadGrantedSpellCatalog } from '../../../../spellcasting/application/load-granted-spell-catalog';
import {
  annotateCharacterSpellSources,
  collectFeatGrantedSpellSlugs,
  collectSpeciesGrantedSpellSlugs,
} from '../../../../spellcasting/domain/granted-spells';
import {
  consumeGrantedFreeCast,
  freeCastsRemaining,
  resolveGrantedSpellCastEconomy,
} from '../../../../spellcasting/domain/resolve-granted-spell-cast-economy';
import {
  CastSpellDto,
  CharacterStateResponseDto,
} from '../../../dto/character-state.dto';
import { PlayerCharacterState } from '../../player-character-state.entity';
import { consumeSpellSlot, loadMaxSlots } from '../resources/spell-slots';

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
    sheetRepository,
    grantedSpellCatalog,
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

  if (dto.useFreeCast) {
    const economy = await resolveSpellCastEconomyForCharacter(
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
  } else if (spell.level > 0) {
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

async function resolveSpellCastEconomyForCharacter(
  character: PlayerCharacter,
  spellSlug: string,
  sheetRepository: CharacterSheetRepository,
  grantedSpellCatalog: LoadGrantedSpellCatalog,
) {
  const sheet = await sheetRepository.load(character.id, character.backgroundSlug);
  const { speciesCatalog, featFixedSpells } =
    await grantedSpellCatalog.loadMergeCatalog({
      speciesSlugs: [character.speciesSlug],
      featSlugs: sheet.characterFeats.map((f) => f.featSlug),
    });
  const featGrantedSlugs = collectFeatGrantedSpellSlugs(
    sheet.featOptions,
    sheet.characterFeats,
    featFixedSpells,
  );
  const speciesGrantedSlugs = collectSpeciesGrantedSpellSlugs(
    character.speciesSlug,
    sheet.speciesChoices,
    character.level,
    speciesCatalog,
  );
  const [annotated] = annotateCharacterSpellSources(
    [{ spellSlug, listType: 'always_prepared' }],
    { featGrantedSlugs, speciesGrantedSlugs },
  );
  return resolveGrantedSpellCastEconomy({
    spellSlug,
    source: annotated.source,
    featOptions: sheet.featOptions,
    featFixedSpells,
    speciesSlug: character.speciesSlug,
    speciesChoices: sheet.speciesChoices,
    speciesCatalog,
  });
}
