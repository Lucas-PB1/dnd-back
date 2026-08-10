import { BadRequestException } from '@nestjs/common';
import type { CharacterInventoryRepository } from '@game/inventory/infrastructure/character-inventory.repository';
import type { AssertCanBindPactWeaponService } from '@game/inventory/application/assert-can-bind-pact-weapon.service';
import type { WarlockTableActionResult } from './warlock-action-deps';
import type { PlayerCharacter, WarlockActionDeps } from './warlock-action-deps';

export type PactBladeActionDeps = WarlockActionDeps & {
  inventory: CharacterInventoryRepository;
  assertCanBindPact: AssertCanBindPactWeaponService;
};

/**
 * Invoca / vincula arma de pacto (Ação Bônus · Pacto da Lâmina).
 * Marca a arma, equipa em main_hand e emite nota PHB.
 */
export async function resolveInvokePactWeapon(
  deps: PactBladeActionDeps,
  character: PlayerCharacter,
  itemSlug: string | undefined,
): Promise<WarlockTableActionResult> {
  await deps.assertCanBindPact.assertCharacterCanUsePactBlade(character);

  const resolvedSlug =
    itemSlug?.trim() ||
    (await deps.inventory.findPactWeaponSlug(character.id));

  if (!resolvedSlug) {
    throw new BadRequestException(
      'Escolha uma arma corpo a corpo do inventário para invocar como Arma de Pacto',
    );
  }

  await deps.assertCanBindPact.assertItemIsMeleeWeapon(resolvedSlug);

  const strength = character.abilityScores?.forca ?? 10;
  const bound = await deps.inventory.bindAndEquipPactWeapon(
    character.id,
    resolvedSlug,
    strength,
    {
      classSlug: character.classSlug,
      speciesSlug: character.speciesSlug ?? null,
    },
  );

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Invocar Arma de Pacto',
    resourceSpent: false,
    note:
      `Invocar Arma de Pacto (Ação Bônus): ${bound.itemName} vinculada e equipada. ` +
      'Use Carisma no ataque e dano desta arma; ao atacar, pode causar Necrótico, Psíquico ou Radiante em vez do tipo normal.',
  };
}
