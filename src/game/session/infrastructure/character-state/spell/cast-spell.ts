import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../../../catalog/catalog-lookup.service';
import { VClassSpellSlots } from '../../../../../entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '../../../../../entities/views/v-subclass-spell-slots.entity';
import {
  GIGA_MISSILE_RESOURCE,
  MAGIC_MISSILE_FREE_RESOURCE,
  MAGIC_MISSILE_SPELL_SLUG,
  MISSILE_SHIELD_RESOURCE,
  buildMagicMissileCastNote,
  isMagicMissileMage,
  isSpellMasterySpell,
} from '../../../../combat/domain/wizard-features';
import { PlayerCharacter } from '../../../../shared/infrastructure/player-character.entity';
import { CharacterSpellLookup } from '../../../../sheet/application/character-spell-lookup';
import { CharacterSheetRepository } from '../../../../sheet/infrastructure/character-sheet.repository';
import { abilityModifier } from '../../../../sheet/domain/stats/ability-modifier';
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
import { applyResourceSpend } from '../../../domain/class-resources';
import {
  CastSpellDto,
  CharacterStateResponseDto,
} from '../../../dto/character-state.dto';
import { PlayerCharacterState } from '../../player-character-state.entity';
import { resolveClassResources } from '../resources/class-resources';
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
  dataSource: DataSource;
  buildResponse: BuildResponse;
}): Promise<{
  slotLevelUsed: number | null;
  note: string | null;
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

  const knowsSpell = await spellLookup.hasSpell(character.id, dto.spellSlug);
  if (!knowsSpell) {
    throw new BadRequestException(
      `Spell '${dto.spellSlug}' is not on this character's list`,
    );
  }

  const spell = await catalogLookup.findSpellOrFail(dto.spellSlug);
  let slotLevelUsed: number | null = null;
  let usedFreeResource = false;
  let usedSpellMastery = false;

  const sheet = await sheetRepository.load(
    character.id,
    character.backgroundSlug,
  );
  const masteryFree =
    !dto.freeCastResourceSlug &&
    !dto.useFreeCast &&
    isSpellMasterySpell(dto.spellSlug, sheet.classOptions);

  if (dto.freeCastResourceSlug) {
    await spendFreeCastResource({
      character,
      state,
      dataSource,
      resourceSlug: dto.freeCastResourceSlug,
      spellSlug: dto.spellSlug,
    });
    usedFreeResource = true;
  } else if (dto.useFreeCast) {
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
  } else if (masteryFree) {
    usedSpellMastery = true;
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

  let note = await applyMagicMissileMageOnCast({
    character,
    state,
    dataSource,
    spellSlug: dto.spellSlug,
    slotLevelUsed,
    usedFreeResource,
  });
  if (usedSpellMastery) {
    const masteryNote = 'Dominância de Magias: conjurada sem espaço.';
    note = note ? `${note} · ${masteryNote}` : masteryNote;
  }

  if (spell.concentration) {
    state.concentratingOn = dto.spellSlug;
  }

  await stateRepo.save(state);
  return {
    slotLevelUsed,
    note,
    state: await buildResponse(character, state),
  };
}

async function spendFreeCastResource(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  dataSource: DataSource;
  resourceSlug: string;
  spellSlug: string;
}): Promise<void> {
  const { character, state, dataSource, resourceSlug, spellSlug } = input;

  if (
    resourceSlug !== MAGIC_MISSILE_FREE_RESOURCE ||
    spellSlug !== MAGIC_MISSILE_SPELL_SLUG ||
    !isMagicMissileMage(character.subclassSlug)
  ) {
    throw new BadRequestException(
      `Resource free cast '${resourceSlug}' is not valid for '${spellSlug}'`,
    );
  }

  const resources = await resolveClassResources(dataSource, character);
  const resource = resources.find((item) => item.slug === resourceSlug);
  if (!resource) {
    throw new BadRequestException(
      `Resource '${resourceSlug}' is not available for this character`,
    );
  }
  try {
    state.resourcesUsed = applyResourceSpend(
      state.resourcesUsed ?? {},
      resourceSlug,
      resource.max,
      1,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot spend free cast resource',
    );
  }
}

async function applyMagicMissileMageOnCast(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  dataSource: DataSource;
  spellSlug: string;
  slotLevelUsed: number | null;
  usedFreeResource: boolean;
}): Promise<string | null> {
  const {
    character,
    state,
    dataSource,
    spellSlug,
    slotLevelUsed,
    usedFreeResource,
  } = input;

  if (
    spellSlug !== MAGIC_MISSILE_SPELL_SLUG ||
    !isMagicMissileMage(character.subclassSlug)
  ) {
    return null;
  }

  const resources = await resolveClassResources(dataSource, character);
  let missileShield = false;
  let gigaMissile = false;

  if (state.missileShieldArmed) {
    await spendArmedResource({
      state,
      resources,
      resourceSlug: MISSILE_SHIELD_RESOURCE,
      label: 'Escudo de Mísseis',
    });
    missileShield = true;
    state.missileShieldArmed = false;
  }

  if (state.gigaMissileArmed) {
    await spendArmedResource({
      state,
      resources,
      resourceSlug: GIGA_MISSILE_RESOURCE,
      label: 'Giga-Míssil',
    });
    gigaMissile = true;
    state.gigaMissileArmed = false;
  }

  const intModifier = abilityModifier(character.abilityScores.inteligencia);
  return buildMagicMissileCastNote({
    level: character.level,
    slotLevelUsed,
    usedFreeResource,
    missileShield,
    gigaMissile,
    intModifier,
  });
}

async function spendArmedResource(input: {
  state: PlayerCharacterState;
  resources: { slug: string; max: number }[];
  resourceSlug: string;
  label: string;
}): Promise<void> {
  const resource = input.resources.find((item) => item.slug === input.resourceSlug);
  if (!resource) {
    throw new BadRequestException(
      `${input.label} is not available for this character`,
    );
  }
  try {
    input.state.resourcesUsed = applyResourceSpend(
      input.state.resourcesUsed ?? {},
      input.resourceSlug,
      resource.max,
      1,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error
        ? `${input.label}: ${error.message}`
        : `Cannot spend ${input.label}`,
    );
  }
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
