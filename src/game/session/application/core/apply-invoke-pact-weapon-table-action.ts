import { BadRequestException } from '@nestjs/common';
import type { AssertCanBindPactWeaponService } from '@game/inventory/application/assert/assert-can-bind-pact-weapon.service';
import type { CharacterInventoryRepository } from '@game/inventory/infrastructure/character-inventory.repository';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export async function applyInvokePactWeaponTableAction(input: {
  state: CharacterStateRepository;
  inventory: CharacterInventoryRepository;
  assertCanBindPact: AssertCanBindPactWeaponService;
  character: PlayerCharacter;
  itemSlug?: string;
}): Promise<TableActionResponseDto> {
  await input.assertCanBindPact.assertCharacterCanUsePactBlade(input.character);

  const resolvedSlug =
    input.itemSlug?.trim() ||
    (await input.inventory.findPactWeaponSlug(input.character.id));

  if (!resolvedSlug) {
    throw new BadRequestException(
      'Escolha uma arma corpo a corpo do inventário para invocar como Arma de Pacto',
    );
  }

  await input.assertCanBindPact.assertItemIsMeleeWeapon(resolvedSlug);

  const strength = input.character.abilityScores?.forca ?? 10;
  const bound = await input.inventory.bindAndEquipPactWeapon(
    input.character.id,
    resolvedSlug,
    strength,
    {
      classSlug: input.character.classSlug,
      speciesSlug: input.character.speciesSlug ?? null,
    },
  );

  return {
    state: await input.state.buildResponse(input.character),
    actionName: 'Invocar Arma de Pacto',
    resourceSpent: false,
    note:
      `Invocar Arma de Pacto (Ação Bônus): ${bound.itemName} vinculada e equipada. ` +
      'Use Carisma no ataque e dano desta arma; ao atacar, pode causar Necrótico, Psíquico ou Radiante em vez do tipo normal.',
  };
}
