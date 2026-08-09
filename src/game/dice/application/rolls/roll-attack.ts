import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { ResolveEquippedWeaponAttacks } from '@game/combat/application/resolve-equipped-weapon-attacks';
import type { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  rollD20Check,
  type AdvantageMode,
} from '@game/dice/domain/dice';
import type { CharacterRollResponseDto, RollAttackDto } from '@game/dice/dto/character-roll.dto';
import type { ResolveActivePermanentItemEffects } from '@game/inventory/application/resolve-active-permanent-item-effects';
import type { CharacterResourceSpender } from '@game/session/domain/character-resource-spender';
import {
  findEquippedWeaponAttack,
  loadAccessibleCharacter,
} from './roll-weapon-context';
import {
  forceAdvantageIfNormal,
  upgradeTowardAdvantage,
} from './advantage-mode';
import { applyStrokeOfLuckIfRequested } from './stroke-of-luck';
import { hasPreciseHunter, isRangerClass } from '@game/combat/domain/ranger-features';

export async function executeRollAttack(input: {
  access: PlayerCharacterAccessService;
  sheet: CharacterSheetRepository;
  domain: CharacterDomainService;
  weaponAttacks: ResolveEquippedWeaponAttacks;
  permanentItemEffects: ResolveActivePermanentItemEffects;
  dataSource: DataSource;
  resourceSpender: CharacterResourceSpender;
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
    attack.abilitySlug === 'forca'
  ) {
    mode = forceAdvantageIfNormal(mode);
  }
  if (
    input.dto.studiedAttack &&
    character.classSlug === 'fighter' &&
    character.level >= 13
  ) {
    mode = forceAdvantageIfNormal(mode);
  }
  if (
    input.dto.doorKick &&
    character.subclassSlug === 'dungeoneer' &&
    character.level >= 3
  ) {
    mode = forceAdvantageIfNormal(mode);
  }
  if (input.dto.steadyAim) {
    if (character.classSlug !== 'rogue' || character.level < 3) {
      throw new BadRequestException('Steady Aim requires Rogue level 3');
    }
    mode = upgradeTowardAdvantage(mode);
  }
  if (input.dto.assassinate) {
    if (character.subclassSlug !== 'assassin' || character.level < 3) {
      throw new BadRequestException('Assassinate requires Assassin level 3');
    }
    mode = upgradeTowardAdvantage(mode);
  }
  if (input.dto.preciseHunter) {
    if (
      !isRangerClass(character.classSlug) ||
      !hasPreciseHunter(character.level)
    ) {
      throw new BadRequestException('Precise Hunter requires Ranger level 17');
    }
    mode = upgradeTowardAdvantage(mode);
  }
  let result = rollD20Check(attack.attackBonus, mode);
  const notes: string[] = [];
  result = await applyStrokeOfLuckIfRequested({
    requested: input.dto.strokeOfLuck,
    spender: input.resourceSpender,
    character,
    result,
    notes,
  });
  const kept = result.d20.kept[0] ?? 0;
  const critical = kept >= (attack.critThreshold ?? 20);
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
  if (input.dto.preciseHunter) {
    notes.push(
      'Caçador Preciso: vantagem contra a criatura marcada pela Marca do Predador',
    );
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
