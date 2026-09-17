import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CharacterRollsService } from '@game/dice/application/character-rolls.service';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import { GameActorAction } from '@game/actor/infrastructure/game-actor-action.entity';
import { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import { ActorStateRepository } from '@game/actor/infrastructure/actor-state.repository';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  rollActorCombatAttack,
  rollPcCombatAttack,
} from '@game/combat/application/roll-combat-attack';
import { resolveCombatantArmorClass } from '@game/combat/application/resolve-combatant-armor-class';
import { CampaignRepository } from '../infrastructure/campaign.repository';
import { CampaignEncounterRepository } from '../infrastructure/campaign-encounter.repository';
import { LoadEncounterDto } from './load-encounter-dto';
import { EnrichEncounterPcs } from './enrich-encounter-pcs';
import { requireActiveEncounter } from './require-active-encounter';
import {
  assertPlayerCanViewEncounter,
  viewerFromMember,
} from './encounter-combatant-ops';
import { assertCanResolveEncounterAttack } from './encounter-attack-auth';
import { applyEncounterAttackDamage } from './apply-encounter-attack-damage';
import type { CampaignEncounterCombatant } from '../infrastructure/campaign-encounter-combatant.entity';
import type {
  EncounterAttackResponseDto,
  ResolveEncounterAttackDto,
} from '../dto/encounter.dto';

@Injectable()
export class CampaignEncounterAttackService {
  constructor(
    private readonly campaigns: CampaignRepository,
    private readonly encounters: CampaignEncounterRepository,
    private readonly loadDto: LoadEncounterDto,
    private readonly rolls: CharacterRollsService,
    private readonly characterState: CharacterStateRepository,
    private readonly actorState: ActorStateRepository,
    private readonly enrichPcs: EnrichEncounterPcs,
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
    @InjectRepository(GameActorAction)
    private readonly actorActions: Repository<GameActorAction>,
    @InjectRepository(PlayerCharacterItem)
    private readonly inventoryItems: Repository<PlayerCharacterItem>,
  ) {}

  async resolve(
    userId: string,
    campaignId: string,
    encounterId: string,
    dto: ResolveEncounterAttackDto,
  ): Promise<EncounterAttackResponseDto> {
    const member = await this.campaigns.requireMember(campaignId, userId);
    const encounter = await requireActiveEncounter(
      this.encounters,
      campaignId,
      encounterId,
    );
    assertPlayerCanViewEncounter(member, encounter);

    const attacker = await this.encounters.findCombatantByIdOrFail(
      encounter.id,
      dto.attackerCombatantId,
    );
    const target = await this.encounters.findCombatantByIdOrFail(
      encounter.id,
      dto.targetCombatantId,
    );
    await assertCanResolveEncounterAttack({
      campaigns: this.campaigns,
      userId,
      role: member.role,
      attacker,
      target,
    });

    const targetAc = await this.resolveTargetArmorClass(target);
    const rolled =
      attacker.kind === 'pc' && attacker.characterId
        ? await rollPcCombatAttack({
            rolls: this.rolls,
            inventoryItems: this.inventoryItems,
            userId,
            characterId: attacker.characterId,
            dto,
            targetAc,
          })
        : await this.rollActorAttack(attacker, dto, targetAc);

    if (rolled.hit && rolled.damageTotal != null && rolled.damageTotal > 0) {
      await applyEncounterAttackDamage({
        campaigns: this.campaigns,
        characterState: this.characterState,
        actorState: this.actorState,
        actors: this.actors,
        target,
        damage: rolled.damageTotal,
      });
    }

    const loaded = await this.loadDto.load(
      encounter,
      viewerFromMember(member),
    );
    return {
      encounter: loaded,
      hit: rolled.hit,
      critical: rolled.critical,
      attackTotal: rolled.attackTotal,
      attackExpression: rolled.attackExpression,
      attackRolls: rolled.attackRolls,
      targetAc,
      damageTotal: rolled.hit ? rolled.damageTotal : null,
      damageExpression: rolled.hit ? rolled.damageExpression : null,
      note: rolled.note,
      attackerCombatantId: attacker.id,
      targetCombatantId: target.id,
    };
  }

  private async resolveTargetArmorClass(
    target: CampaignEncounterCombatant,
  ): Promise<number> {
    return resolveCombatantArmorClass({
      loadPc: async (characterId) => {
        const [character] = await this.campaigns.findCharactersByIds([
          characterId,
        ]);
        return character ?? null;
      },
      resolvePcArmorClass: async (character) => {
        const enrichment = await this.enrichPcs.enrich([character]);
        const armorClass = enrichment.get(character.id)?.armorClass;
        if (armorClass == null) {
          throw new BadRequestException('Target has no armor class');
        }
        return armorClass;
      },
      actors: this.actors,
      target,
    });
  }

  private async rollActorAttack(
    attacker: CampaignEncounterCombatant,
    dto: ResolveEncounterAttackDto,
    targetAc: number,
  ) {
    if (!attacker.actorId) {
      throw new BadRequestException(
        'Attacker combatant is missing linked actor',
      );
    }
    return rollActorCombatAttack({
      actorActions: this.actorActions,
      actorId: attacker.actorId,
      dto,
      targetAc,
    });
  }
}
