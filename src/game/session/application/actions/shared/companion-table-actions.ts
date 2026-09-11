import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  formatCompanionCommandNote,
  isCompanionCommandSlug,
} from '@game/companion/domain/companion-commands';
import { resolveCompanionConfig } from '@game/companion/domain/companion-profiles';
import { loadCompanionCommands } from '@game/companion/infrastructure/companion-command.queries';
import {
  loadCompanionProfileBySubclass,
  loadCompanionTemplateMaps,
} from '@game/companion/infrastructure/companion-profile.queries';
import { loadCharacterSheet } from '@game/sheet/infrastructure/character-sheet/load-character-sheet';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { SyncCharacterCompanionHandler } from '@game/actor/application/sync-character-companion.handler';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '../../table-actions/primitives/table-action-guards';

export type CompanionTableActionDeps = {
  state: CharacterStateRepository;
  dataSource: DataSource;
  syncCompanion: SyncCharacterCompanionHandler;
};

export async function applyCompanionSummon(
  deps: CompanionTableActionDeps,
  userId: string,
  character: PlayerCharacter,
  subclassSlug: string,
  subclassLabel: string,
  actionName: string,
  restoreHp = false,
): Promise<TableActionResponseDto> {
  assertCharacterSubclass(character, subclassSlug, subclassLabel);
  assertCharacterLevel(character, 3, character.classSlug ?? 'classe', actionName);

  const synced = await deps.syncCompanion.execute(userId, character.id, {
    restoreHp,
  });
  const hp =
    synced.hitPointsCurrent != null && synced.hitPointsMax != null
      ? `${synced.hitPointsCurrent}/${synced.hitPointsMax} PV`
      : 'PV na ficha do companheiro';

  return {
    state: await deps.state.buildResponse(character),
    actionName,
    resourceSpent: false,
    note: `${actionName}: ${synced.name} (${synced.variantLabel}) — ${hp}.${synced.reused ? ' Companheiro já ativo; ficha atualizada.' : ''}`,
  };
}

export async function applyCompanionCommand(
  deps: CompanionTableActionDeps,
  character: PlayerCharacter,
  subclassSlug: string,
  subclassLabel: string,
  actionName: string,
  command?: string,
): Promise<TableActionResponseDto> {
  assertCharacterSubclass(character, subclassSlug, subclassLabel);
  assertCharacterLevel(character, 3, character.classSlug ?? 'classe', actionName);

  if (!command || !isCompanionCommandSlug(command)) {
    throw new BadRequestException(
      'Informe companionCommand: strike, help, dash, disengage ou dodge',
    );
  }

  const sheet = await loadCharacterSheet(
    { dataSource: deps.dataSource },
    character.id,
    character.backgroundSlug,
  );
  const profile = await loadCompanionProfileBySubclass(
    deps.dataSource,
    character.subclassSlug,
  );
  const maps = profile
    ? await loadCompanionTemplateMaps(deps.dataSource, profile.profileId)
    : [];
  const config = resolveCompanionConfig(
    profile,
    maps,
    sheet.subclassOptions,
  );
  const commands = await loadCompanionCommands(deps.dataSource);

  return {
    state: await deps.state.buildResponse(character),
    actionName,
    resourceSpent: false,
    note: formatCompanionCommandNote(
      command,
      commands,
      config?.variantLabel,
    ),
  };
}
