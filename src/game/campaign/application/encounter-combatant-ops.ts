import { BadRequestException, ForbiddenException } from '@nestjs/common';
import type { CampaignMember } from '../infrastructure/campaign-member.entity';
import type { CampaignEncounter } from '../infrastructure/campaign-encounter.entity';
import type { CampaignEncounterCombatant } from '../infrastructure/campaign-encounter-combatant.entity';
import type { EncounterViewer } from '../domain/build-encounter-dto';
import type { PatchEncounterCombatantDto } from '../dto/encounter.dto';

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
): void {
  if (dto.initiativeTotal !== undefined) {
    combatant.initiativeTotal = dto.initiativeTotal;
  }
  if (dto.initiativeModifier !== undefined) {
    combatant.initiativeModifier = dto.initiativeModifier;
  }
  if (dto.isActive !== undefined) combatant.isActive = dto.isActive;

  if (combatant.kind !== 'creature') {
    if (
      dto.displayName !== undefined ||
      dto.hpCurrent !== undefined ||
      dto.hpMax !== undefined ||
      dto.armorClass !== undefined
    ) {
      throw new BadRequestException(
        'displayName/hp/armorClass patches apply only to creatures',
      );
    }
    return;
  }

  if (dto.displayName !== undefined) {
    combatant.displayName = dto.displayName.trim();
  }
  if (dto.hpCurrent !== undefined) combatant.hpCurrent = dto.hpCurrent;
  if (dto.hpMax !== undefined) combatant.hpMax = dto.hpMax;
  if (dto.armorClass !== undefined) combatant.armorClass = dto.armorClass;
  if (
    combatant.hpCurrent != null &&
    combatant.hpMax != null &&
    combatant.hpCurrent > combatant.hpMax
  ) {
    combatant.hpCurrent = combatant.hpMax;
  }
}
