import { assertCharacterLevel } from '../../core/table-action-guards';
import type { PaladinTableActionResult } from './paladin-action-deps';
import {
  CHANNEL_DIVINITY_SLUG,
  paladinSaveDc,
  type PaladinActionDeps,
  type PlayerCharacter,
} from './paladin-action-deps';

function oathChannelName(subclassSlug: string | null): string {
  switch (subclassSlug) {
    case 'devotion':
      return 'Arma Sagrada';
    case 'glory':
      return 'Destruição Inspiradora';
    case 'ancients':
      return 'A Ira da Natureza';
    case 'vengeance':
      return 'Voto de Inimizade';
    case 'oath-of-revelry':
      return 'Conjurar Bebida';
    default:
      return 'Canalizar Divindade do Juramento';
  }
}

function oathChannelNote(subclassSlug: string | null): string {
  switch (subclassSlug) {
    case 'devotion':
      return 'Arma Sagrada: por 10 min, some o mod. de Carisma aos ataques da arma e ela emite luz Radiante';
    case 'glory':
      return 'Destruição Inspiradora: após acertar, cause dano Radiante extra e conceda PV temporários';
    case 'ancients':
      return 'A Ira da Natureza: vinhas espectrais Imobilizam criaturas próximas em uma falha de Força ou Destreza';
    case 'vengeance':
      return 'Voto de Inimizade: por 1 min, tenha Vantagem nos ataques contra o alvo escolhido';
    case 'oath-of-revelry':
      return 'Conjurar Bebida: crie bebida mágica que fortalece aliados na área';
    default:
      return 'Use uma opção de Canalizar Divindade do seu juramento';
  }
}

export async function resolveOathChannel(
  deps: PaladinActionDeps,
  character: PlayerCharacter,
): Promise<PaladinTableActionResult> {
  assertCharacterLevel(character, 3, 'Paladin', 'Canalizar Divindade do Juramento');
  const saveDc = await paladinSaveDc(deps, character);
  const state = (
    await deps.state.useClassResource(character, CHANNEL_DIVINITY_SLUG, 1)
  ).state;
  return {
    state,
    actionName: oathChannelName(character.subclassSlug),
    saveDc,
    resourceSpent: true,
    note: `${oathChannelNote(character.subclassSlug)} (1 uso de Canalizar Divindade; CD ${saveDc} quando houver salvaguarda).`,
  };
}
