import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { CharacterResourceSpender } from '@game/session/domain/character-resource-spender';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CunningStrikeEffect } from '@game/combat/domain/rogue/types';
import type { RollDamageDto } from '@game/dice/dto/character-roll.dto';
import type { findEquippedWeaponAttack } from '../roll-weapon-context';
import type { DamageAccumulator } from './damage-accumulator';

export type DamageWeaponAttack = Awaited<
  ReturnType<typeof findEquippedWeaponAttack>
>['attack'];

export type DamageCombatFlags = Awaited<
  ReturnType<typeof findEquippedWeaponAttack>
>['combatFlags'];

export type DamageRollContext = {
  character: PlayerCharacter;
  attack: DamageWeaponAttack;
  combatFlags: DamageCombatFlags;
  dto: RollDamageDto;
  domain: CharacterDomainService;
  resourceSpender: CharacterResourceSpender;
  cunningStrikeEffects: readonly CunningStrikeEffect[];
  dungeoneerSlayerLabels: readonly string[];
};

export type DamageEffect = (
  ctx: DamageRollContext,
  acc: DamageAccumulator,
) => Promise<void> | void;
