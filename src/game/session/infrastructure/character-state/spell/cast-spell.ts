import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import {
  GIGA_MISSILE_RESOURCE,
  MAGIC_MISSILE_FREE_RESOURCE,
  MAGIC_MISSILE_SPELL_SLUG,
  MISSILE_SHIELD_RESOURCE,
  buildMagicMissileCastNote,
  isMagicMissileMage,
  isSpellMasterySpell,
} from '@game/combat/domain/wizard';
import {
  buildEldritchCantripCastNote,
  isWarlockClass,
  readEldritchInvocationCantripBindings,
  readEldritchInvocationPicks,
  resolveEldritchInvocationFreeCast,
  type EldritchFreeCastResolution,
} from '@game/combat/domain/warlock';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterSpellLookup } from '@game/sheet/application/character-spell-lookup';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import {
  annotateCharacterSpellSources,
  collectFeatGrantedSpellSlugs,
  collectSpeciesGrantedSpellSlugs,
} from '@game/spellcasting/domain/granted-spells';
import {
  consumeGrantedFreeCast,
  freeCastsRemaining,
  resolveGrantedSpellCastEconomy,
} from '@game/spellcasting/domain/resolve-granted-spell-cast-economy';
import { applyResourceSpend } from '@game/session/domain/class-resources';
import { assertItemCastEconomyAllows } from '@game/session/domain/assert-item-spell-cast';
import { assertItemFreeSpellCastAllows } from '@game/session/domain/assert-item-spell-cast';
import { resolveItemCastSlotLevel } from '@game/session/domain/resolve-item-cast-slot-level';
import {
  buildEnspelledCastNote,
  ENSPELLED_ARMOR_COVERAGE_SLUG,
  ENSPELLED_STAFF_ITEM_SLUG,
  ENSPELLED_WEAPON_COVERAGE_SLUG,
  isEnspelledEconomyItemSlug,
} from '@game/inventory/domain/coverage/enspelled-weapon';
import {
  CastSpellDto,
  CharacterStateResponseDto,
} from '@game/session/dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import {
  loadActiveItemSlugs,
  resolveClassResources,
} from '../resources/class-resources';
import { consumeSpellSlot, loadMaxSlots } from '../resources/spell-slots';
import { loadEldritchInvocationEffectCatalog } from '@game/combat/application/load-eldritch-invocation-effect-catalog';

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

  const sheet = await sheetRepository.load(
    character.id,
    character.backgroundSlug,
  );
  const invocationPicks = isWarlockClass(character.classSlug)
    ? readEldritchInvocationPicks(sheet.classOptions)
    : [];
  const invocationCatalog =
    invocationPicks.length > 0
      ? await loadEldritchInvocationEffectCatalog(dataSource)
      : [];
  const eldritchFreeCast = resolveEldritchInvocationFreeCast({
    spellSlug: dto.spellSlug,
    pickedSlugs: invocationPicks.map((pick) => pick.slug),
    catalog: invocationCatalog,
  });

  const isItemCast = Boolean(
    dto.itemCastResourceSlug || dto.itemCastItemSlug,
  );
  if (dto.itemCastResourceSlug && dto.itemCastItemSlug) {
    throw new BadRequestException(
      'Cannot combine itemCastResourceSlug with itemCastItemSlug',
    );
  }
  if (isItemCast && dto.freeCastResourceSlug) {
    throw new BadRequestException(
      'Cannot combine item cast with freeCastResourceSlug',
    );
  }

  const knowsSpell = await spellLookup.hasSpell(character.id, dto.spellSlug);
  if (!isItemCast && !knowsSpell && !eldritchFreeCast) {
    throw new BadRequestException(
      `Spell '${dto.spellSlug}' is not on this character's list`,
    );
  }

  const spell = await catalogLookup.findSpellOrFail(dto.spellSlug);
  let slotLevelUsed: number | null = null;
  let usedFreeResource = false;
  let usedItemCast = false;
  let itemCastItemSlug: string | null = null;
  let usedSpellMastery = false;
  let usedEldritchFreeCast: EldritchFreeCastResolution | null = null;

  const masteryFree =
    !isItemCast &&
    !dto.freeCastResourceSlug &&
    !dto.useFreeCast &&
    isSpellMasterySpell(dto.spellSlug, sheet.classOptions);

  if (isItemCast) {
    if (dto.itemCastItemSlug) {
      const match = await assertFreeItemCast({
        character,
        dataSource,
        itemSlug: dto.itemCastItemSlug,
        spellSlug: dto.spellSlug,
      });
      usedItemCast = true;
      itemCastItemSlug = match.itemSlug;
      slotLevelUsed = spell.level === 0 ? null : spell.level;
    } else {
      const spendAmount = dto.itemCastSpendAmount ?? 1;
      const match = await spendItemCastResource({
        character,
        state,
        dataSource,
        resourceSlug: dto.itemCastResourceSlug!,
        spendAmount,
        spellSlug: dto.spellSlug,
      });
      usedItemCast = true;
      itemCastItemSlug = match.itemSlug;
      slotLevelUsed = resolveItemCastSlotLevel({
        spellLevel: spell.level,
        spendAmount,
        resourceSlug: dto.itemCastResourceSlug,
      });
    }
  } else if (dto.freeCastResourceSlug) {
    await spendFreeCastResource({
      character,
      state,
      dataSource,
      resourceSlug: dto.freeCastResourceSlug,
      spellSlug: dto.spellSlug,
    });
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
  if (usedItemCast) {
    const itemNote = dto.itemCastResourceSlug
      ? `Item: conjurada com carga (${dto.itemCastResourceSlug}).`
      : `Item: conjurada sem carga (${dto.itemCastItemSlug}).`;
    note = note ? `${note} · ${itemNote}` : itemNote;
    if (itemCastItemSlug && isEnspelledEconomyItemSlug(itemCastItemSlug)) {
      const enspelledNote = buildEnspelledCastNote(spell.level);
      note = `${note} · ${enspelledNote}`;
    }
  }
  if (usedEldritchFreeCast) {
    const freeNote = `${usedEldritchFreeCast.invocationName}: conjurada sem espaço.`;
    note = note ? `${note} · ${freeNote}` : freeNote;
  }
  const blastNote = buildEldritchCantripCastNote({
    spellLevel: spell.level,
    spellSlug: dto.spellSlug,
    bindings: readEldritchInvocationCantripBindings(sheet.classOptions),
    charismaModifier: abilityModifier(character.abilityScores.carisma ?? 10),
    warlockLevel: character.level,
  });
  if (blastNote) {
    note = note ? `${note} · ${blastNote}` : blastNote;
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

async function assertFreeItemCast(input: {
  character: PlayerCharacter;
  dataSource: DataSource;
  itemSlug: string;
  spellSlug: string;
}): Promise<{ itemSlug: string }> {
  const { character, dataSource, itemSlug, spellSlug } = input;
  const activeItemSlugs = await loadActiveItemSlugs(dataSource, character.id);
  if (!activeItemSlugs.includes(itemSlug)) {
    throw new BadRequestException(
      `Item '${itemSlug}' is not active for free item cast`,
    );
  }

  const economyRows = await dataSource.query<
    {
      action_id: string;
      item_slug: string;
      spell_slug: string | null;
      resource_slug: string | null;
      spend_amount: number | null;
    }[]
  >(
    `SELECT
       a.action_id,
       i.slug AS item_slug,
       a.spell_slug,
       a.resource_slug,
       a.spend_amount
     FROM rpg.phb_class_economy_action a
     JOIN rpg.phb_item i ON i.id = a.item_id
     WHERE i.slug = $1
       AND a.spell_slug = $2
       AND a.resource_slug IS NULL
       AND a.table_action = 'cast-item-free'`,
    [itemSlug, spellSlug],
  );

  const match = assertItemFreeSpellCastAllows({
    matches: economyRows.map((row) => ({
      actionId: row.action_id,
      itemSlug: row.item_slug,
      spellSlug: row.spell_slug,
      resourceSlug: row.resource_slug,
      spendAmount:
        row.spend_amount == null ? null : Number(row.spend_amount),
    })),
    spellSlug,
    itemSlug,
  });

  return { itemSlug: match.itemSlug };
}

async function spendItemCastResource(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  dataSource: DataSource;
  resourceSlug: string;
  spendAmount: number;
  spellSlug: string;
}): Promise<{ itemSlug: string }> {
  const {
    character,
    state,
    dataSource,
    resourceSlug,
    spendAmount,
    spellSlug,
  } = input;

  const activeItemSlugs = await loadActiveItemSlugs(dataSource, character.id);
  if (activeItemSlugs.length === 0) {
    throw new BadRequestException(
      'No active magic items available for item cast',
    );
  }

  const economyRows = await dataSource.query<
    {
      action_id: string;
      item_slug: string;
      spell_slug: string | null;
      resource_slug: string;
      spend_amount: number;
    }[]
  >(
    `SELECT
       a.action_id,
       i.slug AS item_slug,
       a.spell_slug,
       a.resource_slug,
       a.spend_amount
     FROM rpg.phb_class_economy_action a
     JOIN rpg.phb_item i ON i.id = a.item_id
     WHERE a.resource_slug = $1
       AND a.spend_amount = $2
       AND i.slug = ANY($3::text[])
       AND a.table_action = 'spend-resource'`,
    [resourceSlug, spendAmount, activeItemSlugs],
  );

  const boundRows = await dataSource.query<{ bound_spell_slug: string }[]>(
    `SELECT bound_spell_slug FROM (
       SELECT pci.attached_coverage_spell_slug AS bound_spell_slug
       FROM rpg.player_character_item pci
       JOIN rpg.phb_item cov ON cov.slug = pci.attached_coverage_slug
       WHERE pci.character_id = $1
         AND pci.location = 'equipped'
         AND pci.attached_coverage_slug = ANY($2::text[])
         AND pci.attached_coverage_spell_slug = $3
         AND (
           COALESCE((cov.properties->>'requiresAttunement')::boolean, false) = false
           OR pci.attached_coverage_attuned = true
         )
       UNION ALL
       SELECT pci.bound_spell_slug
       FROM rpg.player_character_item pci
       JOIN rpg.phb_item i ON i.slug = pci.item_slug
       WHERE pci.character_id = $1
         AND pci.location = 'equipped'
         AND pci.item_slug = ANY($4::text[])
         AND pci.bound_spell_slug = $3
         AND (
           COALESCE((i.properties->>'requiresAttunement')::boolean, false) = false
           OR pci.attuned = true
         )
     ) bound
     LIMIT 1`,
    [
      character.id,
      [ENSPELLED_WEAPON_COVERAGE_SLUG, ENSPELLED_ARMOR_COVERAGE_SLUG],
      spellSlug,
      [ENSPELLED_STAFF_ITEM_SLUG],
    ],
  );

  const match = assertItemCastEconomyAllows({
    matches: economyRows.map((row) => ({
      actionId: row.action_id,
      itemSlug: row.item_slug,
      spellSlug: row.spell_slug,
      resourceSlug: row.resource_slug,
      spendAmount: Number(row.spend_amount),
    })),
    spellSlug,
    resourceSlug,
    spendAmount,
    boundSpellSlug: boundRows[0]?.bound_spell_slug ?? null,
  });

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
      spendAmount,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot spend item cast resource',
    );
  }

  return { itemSlug: match.itemSlug };
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
