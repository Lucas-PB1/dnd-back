import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  TableActionResponseDto,
  UseBardTableActionDto,
} from '@game/session/dto/character-state.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export const BARDIC_INSPIRATION_SLUG = 'bardicInspiration';

export type BardActionDeps = {
  access: PlayerCharacterAccessService;
  state: CharacterStateRepository;
  domain: CharacterDomainService;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
};

export type BardTableActionResult = TableActionResponseDto;
export type { PlayerCharacter, UseBardTableActionDto };

export async function spendInspiration(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<TableActionResponseDto['state']> {
  try {
    const result = await deps.state.useClassResource(
      character,
      BARDIC_INSPIRATION_SLUG,
      1,
    );
    return result.state;
  } catch {
    // Fallback para slug alternativo com hífen caso o catálogo registre com hífen
    const result = await deps.state.useClassResource(
      character,
      'bardic-inspiration',
      1,
    );
    return result.state;
  }
}
