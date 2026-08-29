import { Injectable } from '@nestjs/common';
import { GameActor } from '../infrastructure/game-actor.entity';
import { ActorSheetLoader } from '../infrastructure/actor-sheet.loader';
import { TemplateImageResolver } from '../application/template-image.resolver';
import {
  ActorResponseDto,
  ActorSummaryResponseDto,
} from '../dto/actor.dto';

@Injectable()
export class ActorMapper {
  constructor(
    private readonly sheetLoader: ActorSheetLoader,
    private readonly templateImages: TemplateImageResolver,
  ) {}

  toSummary(actor: GameActor): ActorSummaryResponseDto {
    return {
      id: actor.id,
      name: actor.name,
      actorKind: actor.actorKind,
      parentCharacterId: actor.parentCharacterId,
      templateSlug: actor.templateSlug,
      campaignId: actor.campaignId,
      hitPointsCurrent: actor.hitPointsCurrent,
      hitPointsMax: actor.hitPointsMax,
      armorClass: actor.armorClass,
      createdAt: actor.createdAt.toISOString(),
      updatedAt: actor.updatedAt.toISOString(),
    };
  }

  async toDto(actor: GameActor): Promise<ActorResponseDto> {
    const sheet = await this.sheetLoader.load(actor.id);
    const imageUrl = await this.templateImages.resolve(actor.templateSlug);
    return {
      ...this.toSummary(actor),
      parentCharacterId: actor.parentCharacterId,
      templateSlug: actor.templateSlug,
      imageUrl,
      initiativeModifier: actor.initiativeModifier,
      proficiencyBonus: actor.proficiencyBonus,
      abilityScores: actor.abilityScores,
      sizeSlug: actor.sizeSlug,
      notes: actor.notes,
      spellcastingAbilitySlug: actor.spellcastingAbilitySlug,
      spellSaveDc: actor.spellSaveDc,
      spellAttackBonus: actor.spellAttackBonus,
      damageThreshold: actor.damageThreshold,
      crewCapacity: actor.crewCapacity,
      passengerCapacity: actor.passengerCapacity,
      cargoCapacityLb: actor.cargoCapacityLb,
      speeds: sheet.speeds,
      actions: sheet.actions as ActorResponseDto['actions'],
      spells: sheet.spells as ActorResponseDto['spells'],
      state: sheet.state,
    };
  }
}
