import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectDataSource, InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { CharacterRollsService } from '@game/dice/application/character-rolls.service';
import { rollD20Check, rollExpression } from '@game/dice/domain/dice';
import { computeAbilityModifiers } from '@game/shared/domain/ability-scores';
import { ActorPersistenceService } from '@game/actor/infrastructure/actor-persistence.service';
import { ActorStateRepository } from '@game/actor/infrastructure/actor-state.repository';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import { GameActorAction } from '@game/actor/infrastructure/game-actor-action.entity';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import { PhbCreatureTemplate } from '@entities/template/phb-creature-template.entity';
import { ResolveEquippedArmorClass } from '@game/combat/application/resolve-equipped-armor-class';
import { applyCombatantHpDamage } from '@game/combat/application/apply-combatant-hp-damage';
import { resolveCombatantArmorClass } from '@game/combat/application/resolve-combatant-armor-class';
import {
  rollActorCombatAttack,
  rollPcCombatAttack,
  type CombatAttackRoll,
} from '@game/combat/application/roll-combat-attack';
import { pickActorAttackAction } from '@game/combat/application/combat-attack-weapons';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { LoadSpellCombat } from '@game/combat/application/load-spell-combat';
import { resolveCombatSpell } from '@game/combat/domain/resolve-combat-spell';
import {
  abilityModifierFromSlug,
  spellSaveDcFromMods,
} from '@game/combat/domain/spell-save-dc';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { loadSpellcastingAbilitySlug } from '@game/spellcasting/application/resolve-character-spellcasting-slice';
import {
  isFighterClass,
  secondWindHealDice,
} from '@game/combat/domain/fighter';
import { assertCanTakeDuelAction } from '@game/duel/domain/duel-combat-gates';
import { applyHealHitPoints } from '@game/session/application/table-actions/primitives/apply-heal-hit-points';
import {
  assertValidDuelConditionSlug,
  mergeConditions,
} from '@game/duel/domain/duel-spell-resolve';
import { resolveSkirmishAttackBudget } from './skirmish-attack-budget';
import { formatSkirmishAttackLogLine } from '../domain/format-skirmish-attack-log';
import { SkirmishRepository } from '../infrastructure/skirmish.repository';
import { Skirmish } from '../infrastructure/skirmish.entity';
import { SkirmishCombatant } from '../infrastructure/skirmish-combatant.entity';
import type { SkirmishCombatLogEntry } from '../domain/skirmish-status';
import { runAutomaticActorTurns } from '../domain/run-automatic-actor-turns';
import {
  skirmishForfeitPatch,
  skirmishWinnerFromHitPoints,
} from '../domain/skirmish-outcome';
import {
  CastSkirmishSpellDto,
  CreateSkirmishDto,
  PatchSkirmishConditionDto,
  ResolveSkirmishAttackDto,
  SkirmishAttackResultDto,
  SkirmishDetailDto,
  SkirmishSummaryDto,
} from '../dto/skirmish.dto';
import {
  equippedWeaponOptions,
  resolvePcArmorClass,
  toSkirmishDetail,
  toSkirmishSummary,
} from './to-dto';

@Injectable()
export class SkirmishService {
  constructor(
    private readonly repo: SkirmishRepository,
    private readonly access: PlayerCharacterAccessService,
    private readonly characters: CharacterRepository,
    private readonly rolls: CharacterRollsService,
    private readonly actorPersistence: ActorPersistenceService,
    private readonly actorState: ActorStateRepository,
    private readonly characterState: CharacterStateRepository,
    private readonly armorClass: ResolveEquippedArmorClass,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly spellCombat: LoadSpellCombat,
    private readonly sheet: CharacterSheetRepository,
    private readonly domain: CharacterDomainService,
    @InjectDataSource()
    private readonly dataSource: DataSource,
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
    @InjectRepository(GameActorAction)
    private readonly actorActions: Repository<GameActorAction>,
    @InjectRepository(PlayerCharacterItem)
    private readonly inventoryItems: Repository<PlayerCharacterItem>,
    @InjectRepository(PhbCreatureTemplate)
    private readonly templates: Repository<PhbCreatureTemplate>,
  ) {}

  async list(userId: string): Promise<SkirmishSummaryDto[]> {
    const rows = await this.repo.listByUser(userId);
    const result: SkirmishSummaryDto[] = [];
    for (const skirmish of rows) {
      result.push(await this.summaryOf(skirmish));
    }
    return result;
  }

  async getDetail(userId: string, id: string): Promise<SkirmishDetailDto> {
    const skirmish = await this.requireOwned(userId, id);
    return this.detailOf(skirmish);
  }

  async create(
    userId: string,
    dto: CreateSkirmishDto,
  ): Promise<SkirmishDetailDto> {
    const existing = await this.repo.findActiveByUser(userId);
    if (existing) {
      throw new BadRequestException('Já existe um skirmish ativo');
    }
    const character = await this.access.findOwnedOrFail(
      userId,
      dto.characterId,
    );
    const templateSlug = dto.templateSlug.trim();
    const template = await this.templates.findOne({
      where: { slug: templateSlug },
    });
    if (!template) {
      throw new BadRequestException(
        `Creature template '${templateSlug}' not found`,
      );
    }
    const actorId = await this.actorPersistence.spawnFromTemplate({
      templateSlug,
      ownerUserId: userId,
      actorKind: 'creature',
      parentCharacterId: character.id,
      nameOverride: template.name,
    });
    const actor = await this.actors.findOne({ where: { id: actorId } });
    if (!actor) {
      throw new BadRequestException('Failed to spawn creature');
    }

    const pcInit = await this.rolls.rollInitiative(userId, character.id, {
      advantage: 'normal',
    });
    const actorMod =
      actor.initiativeModifier ??
      computeAbilityModifiers(actor.abilityScores).destreza;
    const actorInit = rollD20Check(actorMod, 'normal');

    let skirmish = this.repo.createSkirmish({
      userId,
      characterId: character.id,
      status: 'active',
      round: 1,
      currentCombatantId: null,
      combatLog: [
        {
          at: new Date().toISOString(),
          text: `${character.name} enfrenta ${actor.name}`,
        },
      ],
    });
    skirmish = await this.repo.saveSkirmish(skirmish);

    const pcRow = this.repo.createCombatant({
      skirmishId: skirmish.id,
      kind: 'pc',
      characterId: character.id,
      actorId: null,
      displayName: character.name,
      initiativeTotal: pcInit.total,
      initiativeModifier: pcInit.modifier,
      sortOrder: 0,
      isActive: true,
    });
    const actorRow = this.repo.createCombatant({
      skirmishId: skirmish.id,
      kind: 'actor',
      characterId: null,
      actorId: actor.id,
      displayName: actor.name,
      initiativeTotal: actorInit.total,
      initiativeModifier: actorMod,
      sortOrder: 1,
      isActive: true,
    });
    const saved = await this.repo.saveCombatants([pcRow, actorRow]);
    const ordered = await this.repo.listCombatants(skirmish.id);
    skirmish.currentCombatantId = ordered[0]?.id ?? saved[0].id;
    skirmish = await this.repo.saveSkirmish(skirmish);

    await this.resolvePendingActorTurns(userId, skirmish);
    await this.syncPcAttackBudget(skirmish);
    return this.detailOf(skirmish);
  }

  async attack(
    userId: string,
    id: string,
    dto: ResolveSkirmishAttackDto,
  ): Promise<SkirmishAttackResultDto> {
    const skirmish = await this.requireOwned(userId, id);
    this.assertActive(skirmish);
    const combatants = await this.repo.listCombatants(skirmish.id);
    const attacker = combatants.find(
      (row) => row.id === dto.attackerCombatantId,
    );
    const target = combatants.find((row) => row.id === dto.targetCombatantId);
    if (!attacker || !target) {
      throw new BadRequestException('Combatant not in this skirmish');
    }
    if (attacker.id === target.id) {
      throw new BadRequestException('Cannot attack self');
    }
    if (attacker.id !== skirmish.currentCombatantId) {
      throw new ForbiddenException('Not this combatant turn');
    }
    if (attacker.kind !== 'pc') {
      throw new ForbiddenException('Wait for the creature turn to resolve');
    }
    await this.assertPcCanAct(skirmish);
    if ((skirmish.turnAttacksRemaining ?? 1) <= 0) {
      throw new BadRequestException('Sem ataques restantes neste turno');
    }
    const rolled = await this.resolveAttack(userId, attacker, target, dto);
    skirmish.turnAttacksRemaining = Math.max(
      0,
      (skirmish.turnAttacksRemaining ?? 1) - 1,
    );
    await this.repo.saveSkirmish(skirmish);
    await this.appendLog(
      skirmish,
      this.attackLogLine(attacker.displayName, target.displayName, rolled),
    );
    await this.maybeFinish(skirmish);
    const detail = await this.detailOf(skirmish);
    return {
      skirmish: detail,
      hit: rolled.hit,
      critical: rolled.critical,
      attackTotal: rolled.attackTotal,
      attackExpression: rolled.attackExpression,
      attackRolls: rolled.attackRolls,
      targetAc: rolled.targetAc,
      damageTotal: rolled.hit ? rolled.damageTotal : null,
      damageExpression: rolled.hit ? rolled.damageExpression : null,
      damageRolls: rolled.hit ? rolled.damageRolls : [],
      note: rolled.note,
      attackerCombatantId: attacker.id,
      targetCombatantId: target.id,
    };
  }

  async endTurn(userId: string, id: string): Promise<SkirmishDetailDto> {
    const skirmish = await this.requireOwned(userId, id);
    this.assertActive(skirmish);
    const current = await this.currentCombatant(skirmish);
    if (current.kind === 'pc') {
      await this.advanceTurn(skirmish);
    }
    await this.resolvePendingActorTurns(userId, skirmish);
    await this.syncPcAttackBudget(skirmish);
    return this.detailOf(skirmish);
  }

  async finish(userId: string, id: string): Promise<SkirmishDetailDto> {
    const skirmish = await this.requireOwned(userId, id);
    this.assertActive(skirmish);
    Object.assign(skirmish, skirmishForfeitPatch());
    await this.appendLog(skirmish, 'Combate encerrado');
    return this.detailOf(skirmish);
  }

  async remove(userId: string, id: string): Promise<void> {
    const deleted = await this.repo.deleteOwned(userId, id);
    if (!deleted) {
      throw new NotFoundException(`Skirmish '${id}' not found`);
    }
  }

  async cast(
    userId: string,
    id: string,
    dto: CastSkirmishSpellDto,
  ): Promise<SkirmishDetailDto> {
    const skirmish = await this.requireOwned(userId, id);
    this.assertActive(skirmish);
    await this.assertPcCanAct(skirmish);
    const character = await this.access.findOwnedOrFail(
      userId,
      skirmish.characterId,
    );
    const combatants = await this.repo.listCombatants(skirmish.id);
    const actorRow = combatants.find((row) => row.kind === 'actor');
    const actor = actorRow?.actorId
      ? await this.actors.findOne({ where: { id: actorRow.actorId } })
      : null;
    if (!actor || !actorRow) {
      throw new BadRequestException('Creature missing');
    }
    const cast = await this.characterState.castSpell(character, {
      spellSlug: dto.spellSlug,
      slotLevel: dto.slotLevel,
    });
    const pb = await this.domain.getProficiencyBonus(character.level);
    const abilitySlug = await loadSpellcastingAbilitySlug(
      this.dataSource,
      character.classSlug,
    );
    const mods = computeAbilityModifiers(character.abilityScores);
    const castingMod = abilityModifierFromSlug(mods, abilitySlug);
    const spellAttackBonus = pb + castingMod;
    const spellSaveDc = spellSaveDcFromMods(pb, castingMod);
    const targetAc = actor.armorClass ?? 10;
    const actorMods = computeAbilityModifiers(actor.abilityScores);
    const combatRow = await this.spellCombat.bySlug(dto.spellSlug);
    const targetSaveBonus = abilityModifierFromSlug(
      actorMods,
      combatRow?.saveAbilitySlug,
    );
    const resolved = resolveCombatSpell({
      row: combatRow,
      slotLevel: cast.slotLevelUsed ?? dto.slotLevel ?? 0,
      characterLevel: character.level,
      spellAttackBonus,
      spellSaveDc,
      spellcastingAbilityMod: castingMod,
      targetAc,
      targetSaveBonus,
      advantage: 'normal',
      castNote: cast.note ?? undefined,
    });
    if (
      resolved.kind === 'auto_damage' ||
      resolved.kind === 'spell_attack' ||
      resolved.kind === 'save_damage'
    ) {
      const damage =
        resolved.kind === 'spell_attack' && !resolved.hit
          ? 0
          : resolved.damage;
      if (damage > 0) {
        await applyCombatantHpDamage({
          loadCharacter: () => Promise.resolve(null),
          characterState: this.characterState,
          actorState: this.actorState,
          actors: this.actors,
          target: actorRow,
          damage,
        });
      }
      if (resolved.kind === 'spell_attack') {
        await this.appendLog(
          skirmish,
          `${character.name}: ${resolved.label} (${resolved.hit ? 'acerto' : 'erro'} ${resolved.attackTotal} vs CA ${targetAc})${damage ? ` · dano ${damage}` : ''}`,
        );
      } else if (resolved.kind === 'save_damage') {
        await this.appendLog(
          skirmish,
          `${character.name}: ${resolved.label} (CD ${resolved.dc} · save ${resolved.saveTotal}${resolved.saved ? ' sucesso' : ' falha'})${damage ? ` · dano ${damage}` : ''}`,
        );
      } else {
        await this.appendLog(
          skirmish,
          `${character.name}: ${resolved.label} · dano ${damage}`,
        );
      }
    } else if (resolved.kind === 'heal') {
      const healed = await applyHealHitPoints(
        this.characterState,
        character,
        resolved.amount,
      );
      await this.appendLog(
        skirmish,
        `${character.name}: ${resolved.label} · curou ${healed.healed} PV`,
      );
    } else if (resolved.kind === 'arena_darkness') {
      await this.appendLog(
        skirmish,
        `${character.name}: Escuridão (sem arena no skirmish — slot gasto)`,
      );
    } else {
      await this.appendLog(
        skirmish,
        `${character.name}: ${resolved.note}`,
      );
    }
    await this.maybeFinish(skirmish);
    return this.detailOf(skirmish);
  }

  async patchCondition(
    userId: string,
    id: string,
    dto: PatchSkirmishConditionDto,
  ): Promise<SkirmishDetailDto> {
    const skirmish = await this.requireOwned(userId, id);
    this.assertActive(skirmish);
    assertValidDuelConditionSlug(dto.condition);
    const combatants = await this.repo.listCombatants(skirmish.id);
    if (dto.target === 'self') {
      const character = await this.access.findOwnedOrFail(
        userId,
        skirmish.characterId,
      );
      const state = await this.characterState.buildResponse(character);
      const next = mergeConditions({
        current: state.conditions ?? [],
        action: dto.action,
        condition: dto.condition,
      });
      await this.characterState.patch(character, { conditions: next });
    } else {
      const actorRow = combatants.find((row) => row.kind === 'actor');
      const actor = actorRow?.actorId
        ? await this.actors.findOne({ where: { id: actorRow.actorId } })
        : null;
      if (!actor) throw new BadRequestException('Creature missing');
      const state = await this.actorState.ensureState(actor.id);
      const next = mergeConditions({
        current: state.conditions ?? [],
        action: dto.action,
        condition: dto.condition,
      });
      await this.actorState.patch(actor, { conditions: next }, this.actors);
    }
    await this.appendLog(
      skirmish,
      `${dto.action === 'add' ? 'Aplica' : 'Remove'} ${dto.condition} (${dto.target === 'self' ? 'você' : 'criatura'})`,
    );
    return this.detailOf(skirmish);
  }

  async appendNarration(
    userId: string,
    id: string,
    text: string,
  ): Promise<SkirmishDetailDto> {
    const skirmish = await this.requireOwned(userId, id);
    this.assertActive(skirmish);
    const trimmed = text.trim();
    if (!trimmed) {
      throw new BadRequestException('Log text is required');
    }
    await this.appendLog(skirmish, trimmed);
    return this.detailOf(skirmish);
  }

  async secondWind(userId: string, id: string): Promise<SkirmishDetailDto> {
    const skirmish = await this.requireOwned(userId, id);
    this.assertActive(skirmish);
    await this.assertPcCanAct(skirmish);
    const character = await this.access.findOwnedOrFail(
      userId,
      skirmish.characterId,
    );
    if (!isFighterClass(character.classSlug)) {
      throw new BadRequestException('Recuperar Fôlego exige Guerreiro');
    }
    await this.characterState.useClassResource(character, 'secondWind', 1);
    const healRoll = rollExpression(secondWindHealDice(character.level));
    const max = character.hitPointsMax ?? 0;
    const before = character.hitPointsCurrent ?? 0;
    const after = Math.min(max, before + healRoll.total);
    await this.characterState.applyCurrentHitPoints(character, after);
    await this.appendLog(
      skirmish,
      `${character.name}: Recuperar Fôlego (${healRoll.expression}) — ${before} → ${after} PV`,
    );
    return this.detailOf(skirmish);
  }

  async actionSurge(userId: string, id: string): Promise<SkirmishDetailDto> {
    const skirmish = await this.requireOwned(userId, id);
    this.assertActive(skirmish);
    await this.assertPcCanAct(skirmish);
    const character = await this.access.findOwnedOrFail(
      userId,
      skirmish.characterId,
    );
    if (!isFighterClass(character.classSlug) || character.level < 2) {
      throw new BadRequestException('Surto de Ação exige Guerreiro nível 2+');
    }
    await this.characterState.useClassResource(character, 'actionSurge', 1);
    const extra = await resolveSkirmishAttackBudget(
      this.mechanicalCatalog,
      character,
    );
    skirmish.turnAttacksRemaining =
      (skirmish.turnAttacksRemaining ?? 0) + extra;
    await this.repo.saveSkirmish(skirmish);
    await this.appendLog(
      skirmish,
      `${character.name}: Surto de Ação — +${extra} ataque(s) (restantes: ${skirmish.turnAttacksRemaining})`,
    );
    return this.detailOf(skirmish);
  }

  private async resolvePendingActorTurns(
    userId: string,
    skirmish: Skirmish,
  ): Promise<void> {
    await runAutomaticActorTurns({
      isFinished: () => skirmish.status !== 'active',
      currentKind: async () => (await this.currentCombatant(skirmish)).kind,
      resolveActorTurn: async () => {
        const current = await this.currentCombatant(skirmish);
        await this.resolveActorTurn(userId, skirmish, current);
      },
      advanceTurn: () => this.advanceTurn(skirmish),
    });
  }

  private async resolveActorTurn(
    userId: string,
    skirmish: Skirmish,
    attacker: SkirmishCombatant,
  ): Promise<void> {
    const combatants = await this.repo.listCombatants(skirmish.id);
    const target = combatants.find((row) => row.kind === 'pc');
    if (!target || !attacker.actorId) return;
    try {
      await pickActorAttackAction(this.actorActions, attacker.actorId);
    } catch {
      await this.appendLog(
        skirmish,
        `${attacker.displayName} não tem ação de ataque`,
      );
      return;
    }
    const rolled = await this.resolveAttack(userId, attacker, target, {});
    await this.appendLog(
      skirmish,
      this.attackLogLine(attacker.displayName, target.displayName, rolled),
    );
    await this.maybeFinish(skirmish);
  }

  private async resolveAttack(
    userId: string,
    attacker: SkirmishCombatant,
    target: SkirmishCombatant,
    dto: ResolveSkirmishAttackDto | Record<string, never>,
  ): Promise<CombatAttackRoll & { targetAc: number }> {
    const targetAc = await resolveCombatantArmorClass({
      loadPc: (characterId) =>
        this.characters.findOwnedOrFail(userId, characterId).catch(() => null),
      resolvePcArmorClass: (character) =>
        resolvePcArmorClass({
          dataSource: this.dataSource,
          armorClass: this.armorClass,
          character,
        }),
      actors: this.actors,
      target,
    });
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
        : await rollActorCombatAttack({
            actorActions: this.actorActions,
            actorId: attacker.actorId!,
            dto,
            targetAc,
          });
    if (rolled.damageTotal != null && rolled.damageTotal > 0) {
      await applyCombatantHpDamage({
        loadCharacter: (characterId) =>
          this.characters
            .findOwnedOrFail(userId, characterId)
            .catch(() => null),
        characterState: this.characterState,
        actorState: this.actorState,
        actors: this.actors,
        target,
        damage: rolled.damageTotal,
      });
    }
    return { ...rolled, targetAc };
  }

  private async maybeFinish(skirmish: Skirmish): Promise<void> {
    const combatants = await this.repo.listCombatants(skirmish.id);
    const pc = combatants.find((row) => row.kind === 'pc');
    const actorRow = combatants.find((row) => row.kind === 'actor');
    if (!pc?.characterId || !actorRow?.actorId) return;
    const character = await this.characters.findOwnedOrFail(
      skirmish.userId,
      pc.characterId,
    );
    const actor = await this.actors.findOne({
      where: { id: actorRow.actorId },
    });
    const pcHp = character.hitPointsCurrent ?? 0;
    const actorHp = actor?.hitPointsCurrent ?? 0;
    const winnerKind = skirmishWinnerFromHitPoints(pcHp, actorHp);
    if (!winnerKind) return;
    skirmish.status = 'finished';
    skirmish.endReason = 'hp';
    skirmish.winnerKind = winnerKind;
    await this.appendLog(
      skirmish,
      skirmish.winnerKind === 'pc'
        ? `${character.name} vence`
        : `${actorRow.displayName} vence`,
    );
  }

  private async advanceTurn(skirmish: Skirmish): Promise<void> {
    const combatants = await this.repo.listCombatants(skirmish.id);
    const active = combatants.filter((row) => row.isActive);
    if (active.length === 0) return;
    const currentId = skirmish.currentCombatantId;
    const index = active.findIndex((row) => row.id === currentId);
    const nextIndex = index < 0 || index + 1 >= active.length ? 0 : index + 1;
    if (nextIndex === 0 && index >= 0) {
      skirmish.round += 1;
    }
    skirmish.currentCombatantId = active[nextIndex].id;
    await this.repo.saveSkirmish(skirmish);
  }

  private async currentCombatant(
    skirmish: Skirmish,
  ): Promise<SkirmishCombatant> {
    if (!skirmish.currentCombatantId) {
      throw new BadRequestException('Skirmish has no current combatant');
    }
    const row = await this.repo.findCombatant(
      skirmish.id,
      skirmish.currentCombatantId,
    );
    if (!row) {
      throw new BadRequestException('Current combatant missing');
    }
    return row;
  }

  private async appendLog(
    skirmish: Skirmish,
    text: string,
  ): Promise<void> {
    const entry: SkirmishCombatLogEntry = {
      at: new Date().toISOString(),
      text,
    };
    skirmish.combatLog = [...skirmish.combatLog, entry];
    await this.repo.saveSkirmish(skirmish);
  }

  private attackLogLine(
    attackerName: string,
    targetName: string,
    rolled: CombatAttackRoll & { targetAc: number },
  ): string {
    return formatSkirmishAttackLogLine(attackerName, targetName, {
      critical: rolled.critical,
      hit: rolled.hit,
      attackExpression: rolled.attackExpression,
      attackRolls: rolled.attackRolls,
      attackTotal: rolled.attackTotal,
      targetAc: rolled.targetAc,
      damageTotal: rolled.damageTotal,
      damageExpression: rolled.damageExpression,
      damageRolls: rolled.damageRolls,
    });
  }

  private assertActive(skirmish: Skirmish): void {
    if (skirmish.status !== 'active') {
      throw new BadRequestException('Skirmish is finished');
    }
  }

  private async requireOwned(userId: string, id: string): Promise<Skirmish> {
    const row = await this.repo.findOwned(userId, id);
    if (!row) {
      throw new NotFoundException(`Skirmish '${id}' not found`);
    }
    return row;
  }

  private async summaryOf(skirmish: Skirmish): Promise<SkirmishSummaryDto> {
    const combatants = await this.repo.listCombatants(skirmish.id);
    const pc = combatants.find((row) => row.kind === 'pc');
    const actor = combatants.find((row) => row.kind === 'actor');
    return toSkirmishSummary({
      skirmish,
      characterName: pc?.displayName ?? 'Personagem',
      opponentName: actor?.displayName ?? null,
    });
  }

  private async detailOf(skirmish: Skirmish): Promise<SkirmishDetailDto> {
    const combatants = await this.repo.listCombatants(skirmish.id);
    const character = await this.access.findOwnedOrFail(
      skirmish.userId,
      skirmish.characterId,
    );
    const actorRow = combatants.find((row) => row.kind === 'actor');
    const actor = actorRow?.actorId
      ? await this.actors.findOne({ where: { id: actorRow.actorId } })
      : null;
    const pcArmorClass = await resolvePcArmorClass({
      dataSource: this.dataSource,
      armorClass: this.armorClass,
      character,
    });
    const weapons = await equippedWeaponOptions(
      this.inventoryItems,
      character.id,
    );
    const pcState = await this.characterState.buildResponse(character);
    const actorState = actor
      ? await this.actorState.ensureState(actor.id)
      : null;
    const sheet = await this.sheet.load(character.id);
    const fighter = isFighterClass(character.classSlug)
      ? await this.buildFighterPanel(skirmish, character, pcState)
      : null;
    return toSkirmishDetail({
      skirmish,
      combatants,
      character,
      actor,
      pcArmorClass,
      weapons,
      pcConditions: pcState.conditions ?? [],
      actorConditions: actorState?.conditions ?? [],
      spells: sheet.characterSpells.map((spell) => ({
        spellSlug: spell.spellSlug,
        listType: spell.listType,
      })),
      fighter,
    });
  }

  private async buildFighterPanel(
    skirmish: Skirmish,
    character: import('@game/shared/infrastructure/player-character.entity').PlayerCharacter,
    pcState: { classResources?: Array<{ slug: string; remaining: number; max: number }> },
  ) {
    const budget = await resolveSkirmishAttackBudget(
      this.mechanicalCatalog,
      character,
    );
    const secondWind = pcState.classResources?.find(
      (row) => row.slug === 'secondWind',
    );
    const actionSurge = pcState.classResources?.find(
      (row) => row.slug === 'actionSurge',
    );
    return {
      available: true,
      attacksPerAction: budget,
      turnAttacksRemaining: skirmish.turnAttacksRemaining,
      secondWindRemaining: secondWind?.remaining ?? 0,
      secondWindMax: secondWind?.max ?? 0,
      actionSurgeRemaining: actionSurge?.remaining ?? 0,
      actionSurgeMax: actionSurge?.max ?? 0,
    };
  }

  private async assertPcCanAct(skirmish: Skirmish): Promise<void> {
    const current = await this.currentCombatant(skirmish);
    if (current.kind !== 'pc') {
      throw new ForbiddenException('Not this combatant turn');
    }
    const character = await this.access.findOwnedOrFail(
      skirmish.userId,
      skirmish.characterId,
    );
    const state = await this.characterState.buildResponse(character);
    assertCanTakeDuelAction(state.conditions ?? []);
  }

  private async syncPcAttackBudget(skirmish: Skirmish): Promise<void> {
    if (skirmish.status !== 'active') return;
    const current = await this.currentCombatant(skirmish);
    if (current.kind !== 'pc') return;
    const character = await this.access.findOwnedOrFail(
      skirmish.userId,
      skirmish.characterId,
    );
    skirmish.turnAttacksRemaining = await resolveSkirmishAttackBudget(
      this.mechanicalCatalog,
      character,
    );
    await this.repo.saveSkirmish(skirmish);
  }
}
