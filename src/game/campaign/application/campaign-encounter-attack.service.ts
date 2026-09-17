import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CharacterRollsService } from '@game/dice/application/character-rolls.service';
import { rollD20Check } from '@game/dice/domain/dice';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import { GameActorAction } from '@game/actor/infrastructure/game-actor-action.entity';
import { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import { ActorStateRepository } from '@game/actor/infrastructure/actor-state.repository';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
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
import {
  pickActorAttackAction,
  pickEquippedWeaponItemSlug,
  rollActorEncounterDamage,
} from './encounter-attack-weapons';
import { resolveAttackVsArmorClass } from '../domain/resolve-attack-vs-armor-class';
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
        ? await this.rollPcAttack(userId, attacker.characterId, dto, targetAc)
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
    if (target.kind === 'pc' && target.characterId) {
      const [character] = await this.campaigns.findCharactersByIds([
        target.characterId,
      ]);
      if (!character) {
        throw new BadRequestException('Target character not found');
      }
      const enrichment = await this.enrichPcs.enrich([character]);
      const armorClass = enrichment.get(character.id)?.armorClass;
      if (armorClass == null) {
        throw new BadRequestException('Target has no armor class');
      }
      return armorClass;
    }
    if (!target.actorId) {
      throw new BadRequestException('Target combatant is missing linked actor');
    }
    const actor = await this.actors.findOne({ where: { id: target.actorId } });
    if (actor?.armorClass == null) {
      throw new BadRequestException('Target has no armor class');
    }
    return actor.armorClass;
  }

  private async rollPcAttack(
    userId: string,
    characterId: string,
    dto: ResolveEncounterAttackDto,
    targetAc: number,
  ): Promise<{
    hit: boolean;
    critical: boolean;
    attackTotal: number;
    attackExpression: string;
    attackRolls: number[];
    damageTotal: number | null;
    damageExpression: string | null;
    note: string | null;
  }> {
    const itemSlug = await pickEquippedWeaponItemSlug(
      this.inventoryItems,
      characterId,
      dto.itemSlug,
    );
    const modes: Array<'melee' | 'ranged'> = dto.mode
      ? [dto.mode]
      : ['melee', 'ranged'];
    let usedMode = modes[0];
    let attack;
    try {
      attack = await this.rolls.rollAttack(userId, characterId, {
        itemSlug,
        mode: usedMode,
        advantage: dto.advantage,
      });
    } catch (error) {
      if (!(error instanceof BadRequestException) || !modes[1]) throw error;
      usedMode = modes[1];
      attack = await this.rolls.rollAttack(userId, characterId, {
        itemSlug,
        mode: usedMode,
        advantage: dto.advantage,
      });
    }
    const natural = attack.kept?.[0] ?? 0;
    const vsAc = resolveAttackVsArmorClass({
      attackTotal: attack.total,
      targetAc,
      naturalD20: natural,
      critThreshold: attack.critical ? natural : undefined,
    });
    const notes = [attack.note].filter((row): row is string => Boolean(row));
    if (!vsAc.hit) {
      notes.push('Erro');
      return {
        hit: false,
        critical: false,
        attackTotal: attack.total,
        attackExpression: attack.expression,
        attackRolls: attack.rolls,
        damageTotal: null,
        damageExpression: null,
        note: notes.join(' · ') || null,
      };
    }
    const damage = await this.rolls.rollDamage(userId, characterId, {
      itemSlug,
      mode: usedMode,
      critical: vsAc.critical,
    });
    if (vsAc.critical) notes.push('Crítico');
    else notes.push('Acerto');
    if (damage.note) notes.push(damage.note);
    return {
      hit: true,
      critical: vsAc.critical,
      attackTotal: attack.total,
      attackExpression: attack.expression,
      attackRolls: attack.rolls,
      damageTotal: damage.total,
      damageExpression: damage.expression,
      note: notes.join(' · ') || null,
    };
  }

  private async rollActorAttack(
    attacker: CampaignEncounterCombatant,
    dto: ResolveEncounterAttackDto,
    targetAc: number,
  ): Promise<{
    hit: boolean;
    critical: boolean;
    attackTotal: number;
    attackExpression: string;
    attackRolls: number[];
    damageTotal: number | null;
    damageExpression: string | null;
    note: string | null;
  }> {
    if (!attacker.actorId) {
      throw new BadRequestException('Attacker combatant is missing linked actor');
    }
    const action = await pickActorAttackAction(
      this.actorActions,
      attacker.actorId,
      dto.actionId,
    );
    const roll = rollD20Check(
      action.attackBonus ?? 0,
      dto.advantage ?? 'normal',
    );
    const natural = roll.d20.kept[0] ?? 0;
    const vsAc = resolveAttackVsArmorClass({
      attackTotal: roll.total,
      targetAc,
      naturalD20: natural,
    });
    const notes = [`${action.name}`];
    if (!vsAc.hit) {
      notes.push('Erro');
      return {
        hit: false,
        critical: false,
        attackTotal: roll.total,
        attackExpression: roll.expression,
        attackRolls: roll.d20.rolls,
        damageTotal: null,
        damageExpression: null,
        note: notes.join(' · '),
      };
    }
    const damage = rollActorEncounterDamage(
      action.damageExpression,
      vsAc.critical,
    );
    notes.push(vsAc.critical ? 'Crítico' : 'Acerto');
    return {
      hit: true,
      critical: vsAc.critical,
      attackTotal: roll.total,
      attackExpression: roll.expression,
      attackRolls: roll.d20.rolls,
      damageTotal: damage?.total ?? 0,
      damageExpression: damage?.expression ?? null,
      note: notes.join(' · '),
    };
  }
}
