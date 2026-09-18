import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectDataSource, InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import { ActorStateRepository } from '@game/actor/infrastructure/actor-state.repository';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { loadSpellcastingAbilitySlug } from '@game/spellcasting/application/resolve-character-spellcasting-slice';
import { computeAbilityModifiers } from '@game/shared/domain/ability-scores';
import { LoadSpellCombat } from '@game/combat/application/load-spell-combat';
import { pickCombatSurfaceCastCommand } from '@game/combat/application/pick-combat-surface-cast-command';
import { resolveCombatSpell } from '@game/combat/domain/resolve-combat-spell';
import { spendCombatMetamagic } from '@game/combat/application/spend-combat-metamagic';
import { spellCombatBonusesFromCast } from '@game/combat/application/spell-combat-bonuses-from-cast';
import {
  abilityModifierFromSlug,
  spellSaveDcFromMods,
} from '@game/combat/domain/spell-save-dc';
import { applyHealHitPoints } from '@game/session/application/table-actions/primitives/apply-heal-hit-points';
import {
  assertValidDuelConditionSlug,
  mergeConditions,
} from '@game/duel/domain/duel-spell-resolve';
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
  CastEncounterSpellDto,
  EncounterCastResponseDto,
} from '../dto/encounter.dto';

@Injectable()
export class CampaignEncounterCastService {
  constructor(
    private readonly campaigns: CampaignRepository,
    private readonly encounters: CampaignEncounterRepository,
    private readonly loadDto: LoadEncounterDto,
    private readonly characterState: CharacterStateRepository,
    private readonly actorState: ActorStateRepository,
    private readonly enrichPcs: EnrichEncounterPcs,
    private readonly spellCombat: LoadSpellCombat,
    private readonly domain: CharacterDomainService,
    @InjectDataSource()
    private readonly dataSource: DataSource,
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
  ) {}

  async cast(
    userId: string,
    campaignId: string,
    encounterId: string,
    dto: CastEncounterSpellDto,
  ): Promise<EncounterCastResponseDto> {
    const member = await this.campaigns.requireMember(campaignId, userId);
    const encounter = await requireActiveEncounter(
      this.encounters,
      campaignId,
      encounterId,
    );
    assertPlayerCanViewEncounter(member, encounter);

    const caster = await this.encounters.findCombatantByIdOrFail(
      encounter.id,
      dto.casterCombatantId,
    );
    const target = await this.encounters.findCombatantByIdOrFail(
      encounter.id,
      dto.targetCombatantId,
    );
    await assertCanResolveEncounterAttack({
      campaigns: this.campaigns,
      userId,
      role: member.role,
      attacker: caster,
      target,
    });
    if (caster.kind !== 'pc' || !caster.characterId) {
      throw new BadRequestException('Caster must be a PC combatant');
    }

    const [character] = await this.campaigns.findCharactersByIds([
      caster.characterId,
    ]);
    if (!character) {
      throw new BadRequestException('Caster character not found');
    }

    const cast = await this.characterState.castSpell(
      character,
      pickCombatSurfaceCastCommand(dto),
    );

    let metamagicNote: string | null = null;
    if (dto.metamagicSlug?.trim()) {
      const spent = await spendCombatMetamagic({
        dataSource: this.dataSource,
        useClassResource: (pc, slug, amount) =>
          this.characterState.useClassResource(pc, slug, amount),
        character,
        metamagicSlug: dto.metamagicSlug,
      });
      metamagicNote = spent.note;
    }

    const pb = await this.domain.getProficiencyBonus(character.level);
    const abilitySlug = await loadSpellcastingAbilitySlug(
      this.dataSource,
      character.classSlug,
    );
    const mods = computeAbilityModifiers(character.abilityScores);
    const castingMod = abilityModifierFromSlug(mods, abilitySlug);
    const bonuses = spellCombatBonusesFromCast({
      spellAttackBonus: pb + castingMod,
      spellSaveDc: spellSaveDcFromMods(pb, castingMod),
      spellSaveDcOverride: cast.spellSaveDcOverride,
      spellAttackBonusOverride: cast.spellAttackBonusOverride,
    });

    const targetAc = await this.resolveTargetArmorClass(target);
    const combatRow = await this.spellCombat.bySlug(dto.spellSlug);
    const targetSaveBonus = await this.resolveTargetSaveBonus(
      target,
      combatRow?.saveAbilitySlug,
    );
    const resolved = resolveCombatSpell({
      row: combatRow,
      slotLevel: cast.slotLevelUsed ?? dto.slotLevel ?? 0,
      characterLevel: character.level,
      spellAttackBonus: bonuses.spellAttackBonus,
      spellSaveDc: bonuses.spellSaveDc,
      spellcastingAbilityMod: castingMod,
      targetAc,
      targetSaveBonus,
      advantage: 'normal',
      castNote: cast.note ?? undefined,
      metamagicSlug: dto.metamagicSlug?.trim() || null,
    });

    const mmSuffix = metamagicNote ? ` · ${metamagicNote}` : '';
    let note: string | null = null;
    let damageTotal: number | null = null;

    if (
      resolved.kind === 'auto_damage' ||
      resolved.kind === 'spell_attack' ||
      resolved.kind === 'save_damage'
    ) {
      const damage =
        resolved.kind === 'spell_attack' && !resolved.hit
          ? 0
          : resolved.damage;
      damageTotal = damage;
      if (damage > 0) {
        await applyEncounterAttackDamage({
          campaigns: this.campaigns,
          characterState: this.characterState,
          actorState: this.actorState,
          actors: this.actors,
          target,
          damage,
          damageTypeSlug: combatRow?.damageTypeSlug,
          dataSource: this.dataSource,
        });
      }
      if (resolved.kind === 'spell_attack') {
        note = `${character.name}: ${resolved.label} (${resolved.hit ? 'acerto' : 'erro'} ${resolved.attackTotal} vs CA ${targetAc})${damage ? ` · dano ${damage}` : ''}${mmSuffix}`;
      } else if (resolved.kind === 'save_damage') {
        note = `${character.name}: ${resolved.label} (CD ${resolved.dc} · save ${resolved.saveTotal}${resolved.saved ? ' sucesso' : ' falha'})${damage ? ` · dano ${damage}` : ''}${mmSuffix}`;
      } else {
        note = `${character.name}: ${resolved.label} · dano ${damage}${mmSuffix}`;
      }
    } else if (resolved.kind === 'heal') {
      const healed = await applyHealHitPoints(
        this.characterState,
        character,
        resolved.amount,
      );
      note = `${character.name}: ${resolved.label} · curou ${healed.healed} PV${mmSuffix}`;
    } else if (resolved.kind === 'arena_darkness') {
      note = `${character.name}: Escuridão — encontro sem arena tipada; concentração aplicada.${mmSuffix}`;
    } else if (resolved.kind === 'apply_condition') {
      assertValidDuelConditionSlug(resolved.conditionSlug);
      if (resolved.applied) {
        await this.applyConditionToTarget(target, resolved.conditionSlug);
      }
      note = `${character.name}: ${resolved.label} (CD ${resolved.dc} · save ${resolved.saveTotal}${resolved.saved ? ' sucesso' : ' falha'})${resolved.applied ? ` · ${resolved.conditionSlug}` : ''}${mmSuffix}`;
    } else {
      note = `${character.name}: ${resolved.note}${mmSuffix}`;
    }

    const loaded = await this.loadDto.load(
      encounter,
      viewerFromMember(member),
    );
    return {
      encounter: loaded,
      resolutionKind: resolved.kind,
      damageTotal,
      note,
      casterCombatantId: caster.id,
      targetCombatantId: target.id,
    };
  }

  private async resolveTargetArmorClass(
    target: CampaignEncounterCombatant,
  ): Promise<number> {
    if (target.kind === 'actor' && target.actorId) {
      const actor = await this.actors.findOne({
        where: { id: target.actorId },
      });
      return actor?.armorClass ?? 10;
    }
    if (target.kind === 'pc' && target.characterId) {
      const [character] = await this.campaigns.findCharactersByIds([
        target.characterId,
      ]);
      if (!character) return 10;
      const enrichment = await this.enrichPcs.enrich([character]);
      return enrichment.get(character.id)?.armorClass ?? 10;
    }
    return 10;
  }

  private async resolveTargetSaveBonus(
    target: CampaignEncounterCombatant,
    saveAbilitySlug: string | null | undefined,
  ): Promise<number> {
    if (!saveAbilitySlug) return 0;
    if (target.kind === 'actor' && target.actorId) {
      const actor = await this.actors.findOne({
        where: { id: target.actorId },
      });
      if (!actor) return 0;
      return abilityModifierFromSlug(
        computeAbilityModifiers(actor.abilityScores),
        saveAbilitySlug,
      );
    }
    if (target.kind === 'pc' && target.characterId) {
      const [character] = await this.campaigns.findCharactersByIds([
        target.characterId,
      ]);
      if (!character) return 0;
      return abilityModifierFromSlug(
        computeAbilityModifiers(character.abilityScores),
        saveAbilitySlug,
      );
    }
    return 0;
  }

  private async applyConditionToTarget(
    target: CampaignEncounterCombatant,
    conditionSlug: string,
  ): Promise<void> {
    if (target.kind === 'pc' && target.characterId) {
      const [character] = await this.campaigns.findCharactersByIds([
        target.characterId,
      ]);
      if (!character) return;
      const state = await this.characterState.buildResponse(character);
      const next = mergeConditions({
        current: state.conditions ?? [],
        action: 'add',
        condition: conditionSlug,
      });
      await this.characterState.patch(character, { conditions: next });
      return;
    }
    if (target.kind === 'actor' && target.actorId) {
      const actor = await this.actors.findOne({
        where: { id: target.actorId },
      });
      if (!actor) return;
      const state = await this.actorState.ensureState(actor.id);
      const next = mergeConditions({
        current: state.conditions ?? [],
        action: 'add',
        condition: conditionSlug,
      });
      await this.actorState.patch(actor, { conditions: next }, this.actors);
    }
  }
}
