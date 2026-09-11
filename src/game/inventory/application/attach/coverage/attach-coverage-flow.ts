import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbItem } from '@entities/equipment/phb-item.entity';
import { PhbWeapon } from '@entities/equipment/phb-weapon.entity';
import { VPhbArmor } from '@entities/views/v-phb-armor.entity';
import {
  coverageMatchesBase,
  parseItemCoverage,
} from '../../../domain/coverage/item-coverage';
import { assertBaseEligibleForCoverage } from '../../../domain/coverage/coverage-base-eligibility';
import { InventoryItemResponseDto } from '../../../dto/inventory.dto';
import {
  findInventoryItemOrFail,
  inventoryItemToDto,
} from '../../../infrastructure/inventory/inventory-item-ops';
import { PlayerCharacterItem } from '../../../infrastructure/player-character-item.entity';
import {
  consumeCoverageFromBackpack,
  resolveCoverageBaseContext,
  resolveCoverageShouldAttune,
  returnCoverageToBackpack,
} from './attach-coverage-ops';
import {
  assertCoverageBonusAllowed,
  assertCoverageSpellSlugParam,
  assertEnspelledSpellOrThrow,
  isSameCoverageAttachment,
} from './attach-coverage-validate';

export type AttachCoverageFlowDeps = {
  items: Repository<PlayerCharacterItem>;
  catalogItems: Repository<PhbItem>;
  weapons: Repository<PhbWeapon>;
  armorCatalog: Repository<VPhbArmor>;
  catalogLookup: CatalogLookupService;
};

type CharacterAttuneContext = {
  classSlug: string;
  speciesSlug: string | null;
};

export async function runAttachCoverage(
  deps: AttachCoverageFlowDeps,
  characterId: string,
  character: CharacterAttuneContext,
  baseItemSlug: string,
  coverageSlug: string,
  bonus: 1 | 2 | 3 | undefined,
  spellSlug: string | undefined,
): Promise<InventoryItemResponseDto> {
  const baseRow = await findInventoryItemOrFail(
    deps.items,
    characterId,
    baseItemSlug,
  );

  const coverageCatalog =
    await deps.catalogLookup.assertItemInCatalog(coverageSlug);
  const coverageProps = (coverageCatalog.properties ?? null) as Record<
    string,
    unknown
  > | null;
  const coverage = parseItemCoverage(coverageProps);
  if (!coverage) {
    throw new BadRequestException(
      `Item '${coverageSlug}' is not a coverage (kind=coverage)`,
    );
  }

  const { needsTier } = assertCoverageBonusAllowed(
    coverageSlug,
    coverageProps,
    bonus,
  );
  const { isEnspelled } = assertCoverageSpellSlugParam(coverageSlug, spellSlug);
  if (isEnspelled) {
    const spell = await deps.catalogLookup.findSpellOrFail(spellSlug!);
    assertEnspelledSpellOrThrow(coverageSlug, {
      slug: spell.slug,
      level: Number(spell.level),
      schoolSlug: spell.schoolSlug,
    });
  }

  const baseCatalog =
    await deps.catalogLookup.assertItemInCatalog(baseItemSlug);
  assertBaseEligibleForCoverage(
    baseItemSlug,
    (baseCatalog.properties ?? null) as Record<string, unknown> | null,
    coverageProps,
  );

  const baseCtx = await resolveCoverageBaseContext(
    deps.catalogLookup,
    deps.weapons,
    deps.armorCatalog,
    baseItemSlug,
  );
  if (!coverageMatchesBase(coverage, baseCtx)) {
    throw new BadRequestException(
      `Coverage '${coverageSlug}' does not apply to '${baseItemSlug}' (${coverage.appliesFilter})`,
    );
  }

  const coverageRow = await deps.items.findOne({
    where: { characterId, itemSlug: coverageSlug },
  });
  if (
    !coverageRow ||
    coverageRow.location !== 'backpack' ||
    coverageRow.quantity < 1
  ) {
    throw new BadRequestException(
      `Coverage '${coverageSlug}' must be in the backpack`,
    );
  }

  if (isSameCoverageAttachment(baseRow, coverageSlug, bonus, spellSlug)) {
    return inventoryItemToDto(deps.catalogItems, baseRow);
  }

  if (baseRow.attachedCoverageSlug) {
    await returnCoverageToBackpack(
      deps.items,
      deps.catalogLookup,
      characterId,
      baseRow.attachedCoverageSlug,
    );
    baseRow.attachedCoverageAttuned = false;
  }

  const shouldAttune = await resolveCoverageShouldAttune(
    deps.items,
    characterId,
    character,
    coverageSlug,
    coverageProps,
  );

  await consumeCoverageFromBackpack(deps.items, coverageRow);
  baseRow.attachedCoverageSlug = coverageSlug;
  baseRow.attachedCoverageBonus = needsTier ? (bonus ?? null) : null;
  baseRow.attachedCoverageSpellSlug = isEnspelled ? (spellSlug ?? null) : null;
  baseRow.attachedCoverageAttuned = shouldAttune;
  await deps.items.save(baseRow);
  return inventoryItemToDto(deps.catalogItems, baseRow);
}

export async function runDetachCoverage(
  deps: AttachCoverageFlowDeps,
  characterId: string,
  baseItemSlug: string,
): Promise<InventoryItemResponseDto> {
  const baseRow = await findInventoryItemOrFail(
    deps.items,
    characterId,
    baseItemSlug,
  );
  if (!baseRow.attachedCoverageSlug) {
    throw new BadRequestException(
      `Item '${baseItemSlug}' has no attached coverage`,
    );
  }

  await returnCoverageToBackpack(
    deps.items,
    deps.catalogLookup,
    characterId,
    baseRow.attachedCoverageSlug,
  );
  baseRow.attachedCoverageSlug = null;
  baseRow.attachedCoverageBonus = null;
  baseRow.attachedCoverageSpellSlug = null;
  baseRow.attachedCoverageAttuned = false;
  await deps.items.save(baseRow);
  return inventoryItemToDto(deps.catalogItems, baseRow);
}
