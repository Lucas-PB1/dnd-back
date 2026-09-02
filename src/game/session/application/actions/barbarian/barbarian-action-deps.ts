import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  UseBarbarianTableActionDto,
} from '@game/session/dto/table-actions/table-actions-martial.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { RAGE_RESOURCE_SLUG } from '@game/session/domain/resource-slugs';

export type BarbarianActionDeps = {
  access: PlayerCharacterAccessService;
  state: CharacterStateRepository;
  domain: CharacterDomainService;
};

export type BarbarianTableActionResult = TableActionResponseDto;
export type { PlayerCharacter, UseBarbarianTableActionDto };

export const RAGE_RESOURCE = RAGE_RESOURCE_SLUG;
export const DIVINE_FURY_DICE = 'divine-fury-dice';
export const INTIMIDATING_PRESENCE = 'intimidating-presence';
export const ZEALOUS_PRESENCE = 'zealous-presence';
export const RAGE_OF_THE_GODS = 'rage-of-the-gods';
export const SHAPE_OF_THE_WILD = 'shape-of-the-wild';
