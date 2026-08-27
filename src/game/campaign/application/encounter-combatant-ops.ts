import { BadRequestException, ForbiddenException } from '@nestjs/common';
import type { CampaignMember } from '../infrastructure/campaign-member.entity';
import type { CampaignEncounter } from '../infrastructure/campaign-encounter.entity';
import type { CampaignEncounterCombatant } from '../infrastructure/campaign-encounter-combatant.entity';
import type { EncounterViewer } from '../domain/build-encounter-dto';
import type { PatchEncounterCombatantDto } from '../dto/encounter.dto';
import type { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import { clampHitPointsCurrent } from '@game/shared/domain/combat-vitals';

export function viewerFromMember(member: CampaignMember): EncounterViewer {
  return member.role === 'dm' || member.role === 'assistant' ? 'dm' : 'player';
}

export function assertPlayerCanViewEncounter(
  member: CampaignMember,
  encounter: CampaignEncounter,
): void {
  if (member.role === 'dm' || member.role === 'assistant') return;
  if (!encounter.playersCanView) {
    throw new ForbiddenException(
      'DM has not shared this encounter with players',
    );
  }
}

export function applyCombatantPatch(
  combatant: CampaignEncounterCombatant,
  dto: PatchEncounterCombatantDto,
  actor?: GameActor | null,
): void {
  if (dto.initiativeTotal !== undefined) {
    combatant.initiativeTotal = dto.initiativeTotal;
  }
  if (dto.initiativeModifier !== undefined) {
    combatant.initiativeModifier = dto.initiativeModifier;
  }
  if (dto.isActive !== undefined) combatant.isActive = dto.isActive;

  if (combatant.kind !== 'actor') {
    if (
      dto.displayName !== undefined ||
      dto.hpCurrent !== undefined ||
      dto.hpMax !== undefined ||
      dto.armorClass !== undefined
    ) {
      throw new BadRequestException(
        'displayName/hp/armorClass patches apply only to actor combatants',
      );
    }
    return;
  }

  if (!actor) {
    throw new BadRequestException('Actor combatant is missing linked actor');
  }

  if (dto.displayName !== undefined) {
    actor.name = dto.displayName.trim();
  }
  if (dto.hpCurrent !== undefined) actor.hitPointsCurrent = dto.hpCurrent;
  if (dto.hpMax !== undefined) actor.hitPointsMax = dto.hpMax;
  if (dto.armorClass !== undefined) actor.armorClass = dto.armorClass;
  actor.hitPointsCurrent = clampHitPointsCurrent(
    actor.hitPointsCurrent,
    actor.hitPointsMax,
  ) as number | null;
}
