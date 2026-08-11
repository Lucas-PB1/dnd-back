import { BadRequestException, Injectable } from '@nestjs/common';
import type { InventoryActionDto } from '../dto/inventory-action.dto';
import type { InventoryItemResponseDto } from '../dto/inventory.dto';
import { AttachCoverageHandler } from './attach-coverage.handler';
import { AttachWeaponCharmHandler } from './attach-weapon-charm.handler';
import { ArtifactRegenAccessHandler } from './artifact-regen-access.handler';
import type { ArtifactRegenResult } from './apply-artifact-regen.handler';
import {
  ApplyArtifactPolishHandler,
  type SentientConflictResult,
} from './apply-artifact-polish.handler';

export type InventoryActionResult =
  | InventoryItemResponseDto
  | ArtifactRegenResult
  | SentientConflictResult;

@Injectable()
export class InventoryActionsHandler {
  constructor(
    private readonly weaponCharm: AttachWeaponCharmHandler,
    private readonly coverage: AttachCoverageHandler,
    private readonly artifactRegen: ArtifactRegenAccessHandler,
    private readonly artifactPolish: ApplyArtifactPolishHandler,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: InventoryActionDto,
  ): Promise<InventoryActionResult> {
    switch (dto.actionSlug) {
      case 'attach-weapon-charm':
        return this.weaponCharm.attach(userId, characterId, {
          weaponSlug: requireField(dto.weaponSlug, 'weaponSlug'),
          charmSlug: requireField(dto.charmSlug, 'charmSlug'),
        });
      case 'detach-weapon-charm':
        return this.weaponCharm.detach(userId, characterId, {
          weaponSlug: requireField(dto.weaponSlug, 'weaponSlug'),
        });
      case 'attach-coverage':
        return this.coverage.attach(userId, characterId, {
          baseItemSlug: requireField(dto.baseItemSlug, 'baseItemSlug'),
          coverageSlug: requireField(dto.coverageSlug, 'coverageSlug'),
          bonus: dto.bonus,
          spellSlug: dto.spellSlug,
        });
      case 'detach-coverage':
        return this.coverage.detach(userId, characterId, {
          baseItemSlug: requireField(dto.baseItemSlug, 'baseItemSlug'),
        });
      case 'artifact-regen':
        return this.artifactRegen.execute(
          userId,
          characterId,
          requireField(dto.itemSlug, 'itemSlug'),
        );
      case 'sentient-conflict':
        return this.artifactPolish.conflict(
          userId,
          characterId,
          requireField(dto.itemSlug, 'itemSlug'),
        );
      case 'artifact-reroll':
        return this.artifactPolish.reroll(
          userId,
          characterId,
          requireField(dto.itemSlug, 'itemSlug'),
        );
      default:
        throw new BadRequestException(
          `Unknown inventory actionSlug '${String((dto as InventoryActionDto).actionSlug)}'`,
        );
    }
  }
}

function requireField(value: string | undefined, name: string): string {
  if (!value?.trim()) {
    throw new BadRequestException(`${name} is required for this action`);
  }
  return value;
}
