import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { SyncSpellSpiritHandler } from '@game/spirit/application/sync-spell-spirit.handler';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { GameActor } from '@game/actor/infrastructure/game-actor.entity';

const FIND_FAMILIAR_SPELL = 'convocar-familiar';

/**
 * PHB 2024 Companheiro Selvagem: ação Mágica; gasta Forma Selvagem ou espaço;
 * Convocar Familiar sem Material; familiar é Fey; some no Descanso Longo.
 */
export async function applyWildCompanionTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  dataSource: DataSource;
  syncSpellSpirit: SyncSpellSpiritHandler;
  ownerUserId: string;
  spiritVariantKey: string | undefined;
  slotLevel: number | undefined;
}): Promise<TableActionResponseDto> {
  const variant = input.spiritVariantKey?.trim();
  if (!variant) {
    throw new BadRequestException(
      'Companheiro Selvagem exige spiritVariantKey (forma do familiar)',
    );
  }

  let costNote: string;
  if (input.slotLevel != null) {
    const level = Math.floor(input.slotLevel);
    if (level < 1) {
      throw new BadRequestException(
        'Companheiro Selvagem com espaço exige slotLevel ≥ 1',
      );
    }
    await input.state.consumeSpellSlotLevel(input.character, level);
    costNote = `espaço de ${level}º`;
  } else {
    await input.state.useClassResource(input.character, 'wildShape', 1);
    costNote = '1 Forma Selvagem';
  }

  const spirit = await input.syncSpellSpirit.execute({
    ownerUserId: input.ownerUserId,
    characterId: input.character.id,
    spellSlug: FIND_FAMILIAR_SPELL,
    variantKey: variant,
    slotLevel: 1,
  });
  if (!spirit) {
    throw new BadRequestException(
      `Magia '${FIND_FAMILIAR_SPELL}' não está mapeada em phb_spell_spirit`,
    );
  }

  const actors = input.dataSource.getRepository(GameActor);
  for (const spawned of spirit.actors) {
    const actor = await actors.findOne({ where: { id: spawned.actorId } });
    if (!actor) continue;
    const feyNote =
      'Tipo: Fey (Companheiro Selvagem). Desaparece no Descanso Longo.';
    actor.notes = actor.notes ? `${actor.notes}\n${feyNote}` : feyNote;
    actor.name = `Familiar: ${spawned.variantLabel}`;
    await actors.save(actor);
  }

  return {
    state: await input.state.buildResponse(input.character),
    actionName: 'Companheiro Selvagem',
    resourceSpent: true,
    note:
      `Companheiro Selvagem: ${spirit.variantLabel} (Fey) · gastou ${costNote}. ` +
      `Desaparece no Descanso Longo.`,
  };
}
