import { DataSource } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  buildItemCastTreasureNotes,
  parseItemCastProperties,
} from '@game/session/domain/item-cast-rules';
import { loadSpellcastingAbilitySlug } from '@game/spellcasting/application/resolve-character-spellcasting-slice';
import {
  buildEnspelledCastNote,
  getEnspelledSpellStats,
  isEnspelledEconomyItemSlug,
} from '@game/inventory/domain/coverage/enspelled-weapon';
import { CastSpellDto } from '@game/session/dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';

/** Notas Treasure + overrides CD/ataque após gasto de cast de item. */
export async function appendItemCastTreasureNotes(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  dto: CastSpellDto;
  catalogLookup: CatalogLookupService;
  dataSource: DataSource;
  spell: { level: number; concentration: boolean };
  note: string | null;
  itemCastItemSlug: string | null;
  artifactSpellNote: string | null;
  artifactSpellSaveDc: number | null;
}): Promise<{
  note: string | null;
  spellSaveDcOverride: number | null;
  spellAttackBonusOverride: number | null;
}> {
  const {
    character,
    state,
    dto,
    catalogLookup,
    dataSource,
    spell,
    itemCastItemSlug,
    artifactSpellNote,
    artifactSpellSaveDc,
  } = input;

  let note = input.note;
  const itemNote = artifactSpellNote
    ? artifactSpellNote
    : dto.itemCastResourceSlug
      ? `Item: conjurada com carga (${dto.itemCastResourceSlug}).`
      : `Item: conjurada sem carga (${dto.itemCastItemSlug}).`;
  note = note ? `${note} · ${itemNote}` : itemNote;

  let spellSaveDc: number | null = artifactSpellSaveDc;
  let spellAttackBonus: number | null = null;
  let requiresComponents = false;
  let useCasterAbility = false;

  if (itemCastItemSlug) {
    const catalogItem =
      await catalogLookup.assertItemInCatalog(itemCastItemSlug);
    const itemProps = parseItemCastProperties(
      (catalogItem.properties ?? null) as Record<string, unknown> | null,
    );
    requiresComponents = itemProps.requiresComponents;
    useCasterAbility = itemProps.useCasterAbility;
    if (itemProps.spellSaveDc != null) spellSaveDc = itemProps.spellSaveDc;
    if (itemProps.spellAttackBonus != null) {
      spellAttackBonus = itemProps.spellAttackBonus;
    }
    if (isEnspelledEconomyItemSlug(itemCastItemSlug)) {
      const enspelled = getEnspelledSpellStats(spell.level);
      spellSaveDc = enspelled.saveDc;
      spellAttackBonus = enspelled.spellAttackBonus;
      note = `${note} · ${buildEnspelledCastNote(spell.level)}`;
    }
  }

  const casterAbilitySlug = useCasterAbility
    ? await loadSpellcastingAbilitySlug(dataSource, character.classSlug)
    : null;

  const treasure = buildItemCastTreasureNotes({
    spellRequiresConcentration: Boolean(spell.concentration),
    requiresComponents,
    spellSaveDc,
    spellAttackBonus,
    useCasterAbility,
    casterHasSpellcastingAbility: casterAbilitySlug != null,
  });
  if (treasure.lines.length) {
    note = `${note} · ${treasure.lines.join(' · ')}`;
  }

  if (spell.concentration) {
    state.concentratingOn = dto.spellSlug;
  }

  return {
    note,
    spellSaveDcOverride: treasure.spellSaveDcOverride,
    spellAttackBonusOverride: treasure.spellAttackBonusOverride,
  };
}
