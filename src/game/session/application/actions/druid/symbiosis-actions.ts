import { BadRequestException } from '@nestjs/common';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { assertCharacterLevel } from '@game/session/application/core/table-action-guards';
import type {
  DruidActionDeps,
  DruidTableActionResult,
  PlayerCharacter,
} from './druid-action-deps';
import { spendWildShape } from './druid-action-deps';

export type SymbiosisActionDeps = DruidActionDeps & {
  mechanicalCatalog: LoadCombatMechanicalCatalog;
};

/** Nota de mesa do Beemote (H003); shard die sobe no L10. */
export function wickerboneBehemothNote(level: number): string {
  const shard = level >= 10 ? '2d4' : '1d4';
  const parts = [
    'Beemote de Osso-Vime (10 min ou até Forma Selvagem de novo)',
    'braços = Porrete com Bordão Místico (maestria); Desvantagem em Prestidigitação',
    'Pele-Casca (sem Concentração)',
    `retaliação ${shard} Perfurante a 1,5 m ao ser atingido`,
    'início do turno: regenera metade do dano sofrido desde o turno anterior (máx. 5×PB; não se Inconsciente)',
  ];
  if (level >= 10) {
    parts.push(
      'Ira da Natureza: tamanho Grande; ao Atacar, Resistência Contundente/Perfurante/Cortante até o fim do próximo turno (acaba cedo com Fogo)',
    );
  }
  if (level >= 14) {
    parts.push('braços: maestria Nick além de Slow');
  }
  return `${parts.join(' · ')}. Sem armadura/escudo.`;
}

export async function resolveWickerboneBehemoth(
  deps: SymbiosisActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterLevel(character, 3, 'Druida', 'Beemote de Osso-Vime');

  const catalog = await deps.mechanicalCatalog.load();
  const economy = catalog.economyActions.find(
    (row) =>
      row.classSlug === character.classSlug &&
      row.tableAction === 'wickerbone-behemoth' &&
      row.itemSlug == null &&
      row.featSlug == null,
  );
  if (!economy || character.subclassSlug !== economy.subclassSlug) {
    throw new BadRequestException('Beemote de Osso-Vime não disponível');
  }

  const state = await spendWildShape(deps, character);

  return {
    state,
    actionName: economy.name,
    resourceSpent: true,
    total: 1,
    note: wickerboneBehemothNote(character.level),
  };
}
