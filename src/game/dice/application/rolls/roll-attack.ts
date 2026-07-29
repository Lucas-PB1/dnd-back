import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import type { CharacterDomainService } from '../../../sheet/domain/core/character-domain.service';
import type { CharacterSheetRepository } from '../../../sheet/infrastructure/character-sheet.repository';
import type { ResolveEquippedWeaponAttacks } from '../../../combat/application/resolve-equipped-weapon-attacks';
import type { PlayerCharacterAccessService } from '../../../shared/player-character-access.service';
import {
  rollD20Check,
  type AdvantageMode,
} from '../../domain/dice';
import type { CharacterRollResponseDto, RollAttackDto } from '../../dto/character-roll.dto';
import type { ResolveActivePermanentItemEffects } from '../../../inventory/application/resolve-active-permanent-item-effects';
import {
  findEquippedWeaponAttack,
  loadAccessibleCharacter,
} from './roll-weapon-context';
import {
  spendStrokeOfLuck,
  turnCheckIntoNaturalTwenty,
} from './stroke-of-luck';

export async function executeRollAttack(input: {
  access: PlayerCharacterAccessService;
  sheet: CharacterSheetRepository;
  domain: CharacterDomainService;
  weaponAttacks: ResolveEquippedWeaponAttacks;
  permanentItemEffects: ResolveActivePermanentItemEffects;
  dataSource: DataSource;
  userId: string;
  characterId: string;
  dto: RollAttackDto;
}): Promise<CharacterRollResponseDto> {
  const character = await loadAccessibleCharacter(
    input.access,
    input.userId,
    input.characterId,
  );
  const { attack, combatFlags } = await findEquippedWeaponAttack(
    {
      sheet: input.sheet,
      domain: input.domain,
      weaponAttacks: input.weaponAttacks,
      permanentItemEffects: input.permanentItemEffects,
      dataSource: input.dataSource,
    },
    character,
    input.dto.itemSlug,
    input.dto.mode,
  );
  let mode: AdvantageMode = input.dto.advantage ?? 'normal';
  if (attack.attackDisadvantage && mode === 'normal') {
    mode = 'disadvantage';
  }
  if (
    input.dto.automatic &&
    attack.masteryActive &&
    attack.masterySlug === 'automatic' &&
    mode === 'normal'
  ) {
    mode = 'disadvantage';
  }
  if (
    combatFlags.recklessActive &&
    character.classSlug === 'barbarian' &&
    input.dto.mode === 'melee' &&
    attack.abilitySlug === 'forca' &&
    mode === 'normal'
  ) {
    mode = 'advantage';
  }
  if (
    input.dto.studiedAttack &&
    character.classSlug === 'fighter' &&
    character.level >= 13 &&
    mode === 'normal'
  ) {
    mode = 'advantage';
  }
  if (
    input.dto.doorKick &&
    character.subclassSlug === 'dungeoneer' &&
    character.level >= 3 &&
    mode === 'normal'
  ) {
    mode = 'advantage';
  }
  if (input.dto.steadyAim) {
    if (character.classSlug !== 'rogue' || character.level < 3) {
      throw new BadRequestException('Steady Aim requires Rogue level 3');
    }
    mode = mode === 'disadvantage' ? 'normal' : 'advantage';
  }
  if (input.dto.assassinate) {
    if (
      character.subclassSlug !== 'assassin' ||
      character.level < 3
    ) {
      throw new BadRequestException('Assassinate requires Assassin level 3');
    }
    mode = mode === 'disadvantage' ? 'normal' : 'advantage';
  }
  let result = rollD20Check(attack.attackBonus, mode);
  if (input.dto.strokeOfLuck) {
    await spendStrokeOfLuck(input.dataSource, character);
    result = turnCheckIntoNaturalTwenty(result);
  }
  const kept = result.d20.kept[0] ?? 0;
  const critical = kept >= (attack.critThreshold ?? 20);
  const notes: string[] = [];
  if (critical && character.classSlug === 'gunslinger' && character.level >= 5) {
    notes.push(
      'Tiro intestinal: Velocidade pela metade e Desvantagem nos ataques (1 min; criatura Grande ou menor)',
    );
  }
  if (input.dto.automatic) {
    notes.push('Automática: 2 ataques / 2× munição');
  }
  if (mode === 'advantage' && combatFlags.recklessActive) {
    notes.push(
      'Imprudente: vantagem ofensiva; ataques contra você têm vantagem',
    );
  }
  if (input.dto.studiedAttack) {
    notes.push('Ataques Estudados: vantagem contra o mesmo alvo');
  }
  if (input.dto.doorKick) {
    notes.push('Chute na Porta: vantagem na primeira rodada');
  }
  if (input.dto.steadyAim) {
    notes.push(
      character.subclassSlug === 'assassin' && character.level >= 9
        ? 'Mira Móvel: Mira Firme concede vantagem sem reduzir o Deslocamento'
        : 'Mira Firme: vantagem; Deslocamento 0 até o fim do turno',
    );
  }
  if (input.dto.assassinate) {
    notes.push(
      'Assassinar: vantagem contra criatura que ainda não agiu na primeira rodada',
    );
  }
  if (input.dto.strokeOfLuck) {
    notes.push('Golpe de Sorte: resultado do d20 transformado em 20');
  }
  return {
    kind: 'attack',
    label: `Ataque — ${attack.itemName} (${input.dto.mode === 'ranged' ? 'à distância' : 'corpo a corpo'})${critical ? ' (crítico)' : ''}`,
    expression: result.expression,
    total: result.total,
    modifier: result.modifier,
    mode: result.mode,
    critical,
    rolls: result.d20.rolls,
    kept: result.d20.kept,
    note: notes.length > 0 ? notes.join(' · ') : undefined,
  };
}
