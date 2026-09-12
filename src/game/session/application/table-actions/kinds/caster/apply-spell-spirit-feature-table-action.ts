import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { loadSpellcastingAbilitySlug } from '@game/spellcasting/application/resolve-character-spellcasting-slice';
import type { SyncSpellSpiritHandler } from '@game/spirit/application/sync-spell-spirit.handler';
import { despawnSpiritsOnConcentrationChange } from '@game/spirit/application/despawn-spell-spirits';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';

const SPECTRAL_SPELLS = {
  'invocar-fera': 2,
  'invocar-feerico': 3,
} as const;

type SpectralSpellSlug = keyof typeof SPECTRAL_SPELLS;

export async function applySpellSpiritFeatureTableAction(input: {
  state: CharacterStateRepository;
  dataSource: DataSource;
  syncSpellSpirit: SyncSpellSpiritHandler;
  userId: string;
  character: PlayerCharacter;
  actionSlug: 'spectral-summon' | 'fey-reinforcements';
  actionName: string;
  resourceSpent: boolean;
  baseNote: string;
  currentState: TableActionResponseDto['state'];
  spellSlug?: string;
  spiritVariantKey?: string;
  slotLevel?: number;
}): Promise<TableActionResponseDto> {
  const {
    actionSlug,
    character,
    syncSpellSpirit,
    dataSource,
    state: stateRepo,
    userId,
  } = input;

  let spellSlug: string;
  let slotLevel: number;
  let hpMultiplier = 1;
  let setConcentration = false;

  if (actionSlug === 'spectral-summon') {
    if (
      input.spellSlug !== 'invocar-fera' &&
      input.spellSlug !== 'invocar-feerico'
    ) {
      throw new BadRequestException(
        'Criaturas Espectrais: informe spellSlug invocar-fera ou invocar-feerico',
      );
    }
    spellSlug = input.spellSlug;
    slotLevel =
      input.slotLevel ?? SPECTRAL_SPELLS[spellSlug as SpectralSpellSlug];
    hpMultiplier = 0.5;
    setConcentration = true;
  } else {
    spellSlug = 'invocar-feerico';
    slotLevel = input.slotLevel ?? 3;
  }

  if (!input.spiritVariantKey) {
    throw new BadRequestException(
      `${input.actionName}: spiritVariantKey é obrigatório`,
    );
  }

  const abilitySlug = await loadSpellcastingAbilitySlug(
    dataSource,
    character.classSlug,
  );
  const scores = character.abilityScores;
  const castingAbilityMod =
    abilitySlug && scores
      ? abilityModifier(scores[abilitySlug] ?? 10)
      : null;

  if (setConcentration) {
    const previous = input.currentState.concentratingOn ?? null;
    await despawnSpiritsOnConcentrationChange(
      dataSource,
      character.id,
      previous,
      spellSlug,
    );
    await stateRepo.patch(character, { concentratingOn: spellSlug });
  }

  const spirit = await syncSpellSpirit.execute({
    ownerUserId: userId,
    characterId: character.id,
    spellSlug,
    variantKey: input.spiritVariantKey,
    slotLevel,
    castingAbilityMod,
    hpMultiplier,
  });

  if (!spirit) {
    throw new BadRequestException(
      `Magia '${spellSlug}' não está mapeada em phb_spell_spirit`,
    );
  }

  const durationNote =
    actionSlug === 'fey-reinforcements'
      ? ' Sem Concentração (duração 1 minuto nesta conjuração).'
      : ' PV pela metade (versão Ilusão).';

  return {
    state: await stateRepo.buildResponse(character),
    actionName: input.actionName,
    resourceSpent: input.resourceSpent,
    note: `${input.baseNote} · Espírito: ${spirit.variantLabel} (${spirit.hitPointsMax ?? '?'} PV).${durationNote}`,
  };
}
