import { BadRequestException } from '@nestjs/common';
import { In, type Repository } from 'typeorm';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import { GameActorAction } from '@game/actor/infrastructure/game-actor-action.entity';
import {
  parseDiceExpression,
  rollDamageParts,
  type DamageRollResult,
} from '@game/dice/domain/dice';

export async function pickEquippedWeaponItemSlug(
  items: Repository<PlayerCharacterItem>,
  characterId: string,
  requested?: string,
): Promise<string> {
  if (requested) return requested;
  const equipped = await items.find({
    where: {
      characterId,
      location: 'equipped',
      equipmentSlot: In(['main_hand', 'off_hand']),
    },
  });
  const slug = equipped[0]?.itemSlug;
  if (!slug) {
    throw new BadRequestException('No equipped weapon to attack with');
  }
  return slug;
}

export async function pickActorAttackAction(
  actions: Repository<GameActorAction>,
  actorId: string,
  actionId?: string,
): Promise<GameActorAction> {
  if (actionId) {
    const action = await actions.findOne({
      where: { id: actionId, actorId },
    });
    if (!action) {
      throw new BadRequestException('Action not found on this actor');
    }
    if (action.attackBonus == null) {
      throw new BadRequestException('Action has no attack bonus');
    }
    return action;
  }
  const rows = await actions.find({
    where: { actorId },
    order: { sortOrder: 'ASC' },
  });
  const action = rows.find((row) => row.attackBonus != null);
  if (!action || action.attackBonus == null) {
    throw new BadRequestException('Actor has no attack action');
  }
  return action;
}

export function rollActorEncounterDamage(
  damageExpression: string | null,
  critical: boolean,
): DamageRollResult | null {
  if (!damageExpression || damageExpression.trim() === '') return null;
  const normalized = damageExpression.replace(/\s+/g, '').toLowerCase();
  if (!normalized.includes('d')) {
    const flat = Number(normalized);
    if (!Number.isFinite(flat)) {
      throw new BadRequestException('Unsupported actor damage expression');
    }
    return {
      expression: String(flat),
      total: flat,
      modifier: flat,
      critical,
      dice: [],
    };
  }
  const parsed = parseDiceExpression(normalized);
  return rollDamageParts(`${parsed.count}d${parsed.sides}`, parsed.modifier, {
    critical,
  });
}
