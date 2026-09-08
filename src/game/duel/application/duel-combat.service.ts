import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CharacterRollsService } from '@game/dice/application/character-rolls.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { computeAbilityModifiers } from '@game/sheet/domain/stats/character-derived-stats';
import { loadSpellcastingAbilitySlug } from '@game/spellcasting/application/resolve-character-spellcasting-slice';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { DUEL_MAX_MEMBERS } from '../domain/duel-status';
import { appendCombatLog } from '../domain/combat-log';
import {
  clearMagicalDarkness,
  MAGICAL_DARKNESS_SPELL_SLUG,
  setMagicalDarkness,
} from '../domain/arena-effects';
import {
  assertCanTakeDuelAction,
  characterSeesInMagicalDarkness,
  resolveDuelAttackVisionMode,
} from '../domain/duel-combat-gates';
import {
  assertValidDuelConditionSlug,
  mergeConditions,
  resolveDuelSpellEffect,
} from '../domain/duel-spell-resolve';
import { DuelRepository } from '../infrastructure/duel.repository';
import type { Duel } from '../infrastructure/duel.entity';
import type { DuelMember } from '../infrastructure/duel-member.entity';
import { hitPointsOf } from './to-dto';
import { DuelCombatSnapshot } from './duel-combat-snapshot';
import { applyDuelDamageToTarget } from '../domain/apply-duel-damage';

@Injectable()
export class DuelCombatService {
  constructor(
    private readonly repo: DuelRepository,
    private readonly rolls: CharacterRollsService,
    private readonly state: CharacterStateRepository,
    private readonly snapshot: DuelCombatSnapshot,
    private readonly sheet: CharacterSheetRepository,
    private readonly domain: CharacterDomainService,
    private readonly access: PlayerCharacterAccessService,
    private readonly dataSource: DataSource,
  ) {}

  async setReady(
    userId: string,
    duelId: string,
    ready: boolean,
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    const { duel, members } = await this.repo.getForMember(userId, duelId);
    this.repo.assertStatus(duel, ['open', 'ready']);

    const mine = members.find((m) => m.userId === userId);
    if (!mine) {
      throw new BadRequestException('Not a duel member');
    }

    mine.ready = ready;
    await this.repo.saveMember(mine);

    const refreshed = await this.repo.getForMember(userId, duelId);
    const bothReady =
      refreshed.members.length === DUEL_MAX_MEMBERS &&
      refreshed.members.every((m) => m.ready);

    if (!bothReady) {
      refreshed.duel.status = 'open';
      await this.repo.saveDuel(refreshed.duel);
      return refreshed;
    }

    return this.startCombat(refreshed.duel, refreshed.members);
  }

  private async startCombat(
    duel: Duel,
    members: DuelMember[],
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    const characters = await this.repo.findCharactersByIds(
      members.map((m) => m.characterId),
    );
    const byId = new Map(characters.map((c) => [c.id, c]));

    for (const member of members) {
      const character = byId.get(member.characterId);
      const hp = hitPointsOf(character);
      if (hp.current <= 0) {
        throw new BadRequestException(
          `${character?.name ?? 'Personagem'} está a 0 PV — cure antes do duelo`,
        );
      }
    }

    const initiativeRows: Array<{ member: DuelMember; total: number }> = [];
    for (const member of members) {
      const roll = await this.rolls.rollInitiative(
        member.userId,
        member.characterId,
        {},
      );
      member.initiative = roll.total;
      initiativeRows.push({ member, total: roll.total });
    }
    await this.repo.saveMembers(members);

    initiativeRows.sort((a, b) => b.total - a.total);
    const first = initiativeRows[0]!;
    const second = initiativeRows[1]!;
    const firstName = byId.get(first.member.characterId)?.name ?? 'A';
    const secondName = byId.get(second.member.characterId)?.name ?? 'B';

    duel.status = 'active';
    duel.round = 1;
    duel.turnCharacterId = first.member.characterId;
    duel.winnerUserId = null;
    duel.winnerCharacterId = null;
    duel.endReason = null;
    duel.arenaEffects = [];
    duel.arenaEffectSourceCharacterId = null;
    duel.combatLog = appendCombatLog(
      [],
      `Combate iniciado. Iniciativa: ${firstName} ${first.total}, ${secondName} ${second.total}. Turno de ${firstName}.`,
    );

    const saved = await this.repo.saveDuel(duel);
    return { duel: saved, members };
  }

  private async loadConditions(characterId: string): Promise<string[]> {
    const character = await this.repo.findCharacterById(characterId);
    if (!character) return [];
    const state = await this.state.buildResponse(character);
    return state.conditions ?? [];
  }

  private async seesMagicalDarkness(characterId: string): Promise<boolean> {
    const sheet = await this.sheet.load(characterId);
    return characterSeesInMagicalDarkness({
      classOptions: sheet.classOptions,
    });
  }

  private async spellAttackBonus(characterId: string): Promise<number> {
    const character = await this.repo.findCharacterById(characterId);
    if (!character) return 0;
    const pb = await this.domain.getProficiencyBonus(character.level);
    const abilitySlug = await loadSpellcastingAbilitySlug(
      this.dataSource,
      character.classSlug,
    );
    const mods = computeAbilityModifiers(character.abilityScores);
    const abilityMod = abilitySlug ? (mods[abilitySlug] ?? 0) : 0;
    return pb + abilityMod;
  }

  async attack(
    userId: string,
    duelId: string,
    input: { itemSlug: string; mode: 'melee' | 'ranged' },
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    const { duel, members } = await this.repo.getForMember(userId, duelId);
    this.repo.assertStatus(duel, ['active']);

    const attacker = members.find((m) => m.userId === userId);
    const defender = members.find((m) => m.userId !== userId);
    if (!attacker || !defender) {
      throw new BadRequestException('Duel needs two participants');
    }
    if (duel.turnCharacterId !== attacker.characterId) {
      throw new BadRequestException('Not your turn');
    }

    assertCanTakeDuelAction(await this.loadConditions(attacker.characterId));

    const characters = await this.repo.findCharactersByIds([
      attacker.characterId,
      defender.characterId,
    ]);
    const byId = new Map(characters.map((c) => [c.id, c]));
    const attackerPc = byId.get(attacker.characterId);
    const defenderPc = byId.get(defender.characterId);
    if (!attackerPc || !defenderPc) {
      throw new BadRequestException('Character not found');
    }

    const [armorMap, attackerSees, defenderSees] = await Promise.all([
      this.snapshot.resolveArmorByCharacter([defenderPc]),
      this.seesMagicalDarkness(attacker.characterId),
      this.seesMagicalDarkness(defender.characterId),
    ]);
    const targetAc = armorMap.get(defenderPc.id) ?? 10;
    const advantage = resolveDuelAttackVisionMode({
      arenaEffects: duel.arenaEffects,
      attackerSeesMagicalDarkness: attackerSees,
      defenderSeesMagicalDarkness: defenderSees,
    });

    const attackRoll = await this.rolls.rollAttack(
      userId,
      attacker.characterId,
      {
        itemSlug: input.itemSlug,
        mode: input.mode,
        targetAc,
        advantage,
      },
    );

    let log = duel.combatLog ?? [];
    const attackLabel = attackRoll.label ?? 'Ataque';
    const hit = attackRoll.hit === true;
    const critical = attackRoll.critical === true;
    const visionNote =
      advantage !== 'normal' ? ` [${advantage}]` : '';

    if (!hit) {
      log = appendCombatLog(
        log,
        `${attackerPc.name}: ${attackLabel}${visionNote} — errou (total ${attackRoll.total} vs CA ${attackRoll.effectiveTargetAc ?? targetAc}).`,
      );
      this.advanceTurn(duel, members, attacker.characterId);
      duel.combatLog = log;
      const saved = await this.repo.saveDuel(duel);
      return { duel: saved, members };
    }

    const damageRoll = await this.rolls.rollDamage(
      userId,
      attacker.characterId,
      {
        itemSlug: input.itemSlug,
        mode: input.mode,
        critical,
      },
    );
    const applied = await applyDuelDamageToTarget({
      state: this.state,
      target: defenderPc,
      damage: Math.max(0, damageRoll.total),
    });

    const tempNote =
      applied.absorbedByTempHp > 0
        ? ` (${applied.absorbedByTempHp} absorvido por PV temp.)`
        : '';
    log = appendCombatLog(
      log,
      `${attackerPc.name}: ${attackLabel}${visionNote} — acerto${critical ? ' crítico' : ''}! Dano ${applied.damageTotal}${tempNote}. ${defenderPc.name}: ${applied.hitPointsBefore} → ${applied.hitPointsAfter} PV.`,
    );

    return this.afterDamage({
      duel,
      members,
      log,
      attacker,
      attackerName: attackerPc.name,
      defenderName: defenderPc.name,
      hitPointsAfter: applied.hitPointsAfter,
    });
  }

  async castSpell(
    userId: string,
    duelId: string,
    input: { spellSlug: string; slotLevel?: number },
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    const { duel, members } = await this.repo.getForMember(userId, duelId);
    this.repo.assertStatus(duel, ['active']);

    const caster = members.find((m) => m.userId === userId);
    const opponent = members.find((m) => m.userId !== userId);
    if (!caster || !opponent) {
      throw new BadRequestException('Duel needs two participants');
    }
    if (duel.turnCharacterId !== caster.characterId) {
      throw new BadRequestException('Not your turn');
    }

    assertCanTakeDuelAction(await this.loadConditions(caster.characterId));

    const casterPc = await this.access.findOwnedOrFail(
      userId,
      caster.characterId,
    );
    const cast = await this.state.castSpell(casterPc, {
      spellSlug: input.spellSlug,
      slotLevel: input.slotLevel,
    });

    // Concentração mudou: se não for mais Escuridão e este PC era a fonte, limpa arena.
    if (
      duel.arenaEffectSourceCharacterId === caster.characterId &&
      cast.state.concentratingOn !== MAGICAL_DARKNESS_SPELL_SLUG
    ) {
      duel.arenaEffects = clearMagicalDarkness(duel.arenaEffects);
      duel.arenaEffectSourceCharacterId = null;
    }

    const defenderPc = await this.repo.findCharacterById(opponent.characterId);
    if (!defenderPc) {
      throw new BadRequestException('Opponent not found');
    }

    const [armorMap, attackerSees, defenderSees, spellAtk] = await Promise.all([
      this.snapshot.resolveArmorByCharacter([defenderPc]),
      this.seesMagicalDarkness(caster.characterId),
      this.seesMagicalDarkness(opponent.characterId),
      this.spellAttackBonus(caster.characterId),
    ]);
    const advantage = resolveDuelAttackVisionMode({
      arenaEffects: duel.arenaEffects,
      attackerSeesMagicalDarkness: attackerSees,
      defenderSeesMagicalDarkness: defenderSees,
    });

    const resolution = resolveDuelSpellEffect({
      spellSlug: input.spellSlug,
      slotLevel: cast.slotLevelUsed ?? input.slotLevel ?? 0,
      characterLevel: casterPc.level,
      spellAttackBonus: spellAtk,
      targetAc: armorMap.get(defenderPc.id) ?? 10,
      advantage,
      castNote: cast.note ?? undefined,
    });

    let log = duel.combatLog ?? [];
    const casterName = casterPc.name;

    if (resolution.kind === 'arena_darkness') {
      duel.arenaEffects = setMagicalDarkness(duel.arenaEffects);
      duel.arenaEffectSourceCharacterId = caster.characterId;
      log = appendCombatLog(
        log,
        `${casterName} conjurou Escuridão — a arena está em escuridão mágica (Visão no Escuro não atravessa).`,
      );
      this.advanceTurn(duel, members, caster.characterId);
      duel.combatLog = log;
      return { duel: await this.repo.saveDuel(duel), members };
    }

    if (resolution.kind === 'auto_damage') {
      const applied = await applyDuelDamageToTarget({
        state: this.state,
        target: defenderPc,
        damage: resolution.damage,
      });
      log = appendCombatLog(
        log,
        `${casterName}: ${resolution.label} — ${applied.damageTotal} de dano. ${defenderPc.name}: ${applied.hitPointsBefore} → ${applied.hitPointsAfter} PV.`,
      );
      return this.afterDamage({
        duel,
        members,
        log,
        attacker: caster,
        attackerName: casterName,
        defenderName: defenderPc.name,
        hitPointsAfter: applied.hitPointsAfter,
      });
    }

    if (resolution.kind === 'spell_attack') {
      if (!resolution.hit) {
        log = appendCombatLog(
          log,
          `${casterName}: ${resolution.label} — errou (total ${resolution.attackTotal}).`,
        );
        this.advanceTurn(duel, members, caster.characterId);
        duel.combatLog = log;
        return { duel: await this.repo.saveDuel(duel), members };
      }
      const applied = await applyDuelDamageToTarget({
        state: this.state,
        target: defenderPc,
        damage: resolution.damage,
      });
      log = appendCombatLog(
        log,
        `${casterName}: ${resolution.label}${resolution.critical ? ' (crítico)' : ''} — acerto! Dano ${applied.damageTotal}. ${defenderPc.name}: ${applied.hitPointsBefore} → ${applied.hitPointsAfter} PV.`,
      );
      return this.afterDamage({
        duel,
        members,
        log,
        attacker: caster,
        attackerName: casterName,
        defenderName: defenderPc.name,
        hitPointsAfter: applied.hitPointsAfter,
      });
    }

    log = appendCombatLog(
      log,
      `${casterName} conjurou ${input.spellSlug}: ${resolution.note}`,
    );
    this.advanceTurn(duel, members, caster.characterId);
    duel.combatLog = log;
    return { duel: await this.repo.saveDuel(duel), members };
  }

  async changeCondition(
    userId: string,
    duelId: string,
    input: {
      action: 'add' | 'remove';
      target: 'self' | 'opponent';
      condition: string;
    },
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    const { duel, members } = await this.repo.getForMember(userId, duelId);
    this.repo.assertStatus(duel, ['active']);

    const actor = members.find((m) => m.userId === userId);
    const opponent = members.find((m) => m.userId !== userId);
    if (!actor || !opponent) {
      throw new BadRequestException('Duel needs two participants');
    }
    if (duel.turnCharacterId !== actor.characterId) {
      throw new BadRequestException('Not your turn');
    }

    assertCanTakeDuelAction(await this.loadConditions(actor.characterId));
    assertValidDuelConditionSlug(input.condition);

    const targetMember = input.target === 'self' ? actor : opponent;
    const targetPc = await this.repo.findCharacterById(targetMember.characterId);
    if (!targetPc) {
      throw new BadRequestException('Target not found');
    }

    const current = await this.loadConditions(targetPc.id);
    const next = mergeConditions({
      current,
      action: input.action,
      condition: input.condition,
    });
    await this.state.patch(targetPc, { conditions: next });

    const actorPc = await this.repo.findCharacterById(actor.characterId);
    let log = appendCombatLog(
      duel.combatLog,
      `${actorPc?.name ?? 'Jogador'} ${input.action === 'add' ? 'aplicou' : 'removeu'} ${input.condition} em ${targetPc.name}.`,
    );
    this.advanceTurn(duel, members, actor.characterId);
    duel.combatLog = log;
    return { duel: await this.repo.saveDuel(duel), members };
  }

  async forfeit(
    userId: string,
    duelId: string,
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    const { duel, members } = await this.repo.getForMember(userId, duelId);
    this.repo.assertStatus(duel, ['open', 'ready', 'active']);

    const mine = members.find((m) => m.userId === userId);
    const opponent = members.find((m) => m.userId !== userId);
    if (!mine) {
      throw new BadRequestException('Not a duel member');
    }

    if (!opponent) {
      duel.status = 'cancelled';
      duel.endReason = 'cancel';
      duel.turnCharacterId = null;
      duel.arenaEffects = [];
      duel.arenaEffectSourceCharacterId = null;
      duel.combatLog = appendCombatLog(duel.combatLog, 'Duelo cancelado.');
      const saved = await this.repo.saveDuel(duel);
      return { duel: saved, members };
    }

    const characters = await this.repo.findCharactersByIds([
      mine.characterId,
      opponent.characterId,
    ]);
    const byId = new Map(characters.map((c) => [c.id, c]));
    const log = appendCombatLog(
      duel.combatLog,
      `${byId.get(mine.characterId)?.name ?? 'Jogador'} desistiu. Vitória de ${byId.get(opponent.characterId)?.name ?? 'oponente'}.`,
    );

    const finished = await this.repo.finishDuel({
      duel,
      winnerUserId: opponent.userId,
      winnerCharacterId: opponent.characterId,
      endReason: 'forfeit',
      combatLog: log,
    });
    return { duel: finished, members };
  }

  private async afterDamage(input: {
    duel: Duel;
    members: DuelMember[];
    log: Duel['combatLog'];
    attacker: DuelMember;
    attackerName: string;
    defenderName: string;
    hitPointsAfter: number;
  }): Promise<{ duel: Duel; members: DuelMember[] }> {
    let { log } = input;
    if (input.hitPointsAfter <= 0) {
      log = appendCombatLog(
        log,
        `${input.defenderName} caiu. Vitória de ${input.attackerName}!`,
      );
      const finished = await this.repo.finishDuel({
        duel: input.duel,
        winnerUserId: input.attacker.userId,
        winnerCharacterId: input.attacker.characterId,
        endReason: 'hp',
        combatLog: log,
      });
      return { duel: finished, members: input.members };
    }

    this.advanceTurn(input.duel, input.members, input.attacker.characterId);
    input.duel.combatLog = log;
    const saved = await this.repo.saveDuel(input.duel);
    return { duel: saved, members: input.members };
  }

  private advanceTurn(
    duel: Duel,
    members: DuelMember[],
    currentCharacterId: string,
  ): void {
    const other = members.find((m) => m.characterId !== currentCharacterId);
    if (!other) return;

    const sorted = [...members].sort(
      (a, b) => (b.initiative ?? 0) - (a.initiative ?? 0),
    );
    const firstId = sorted[0]?.characterId;
    if (other.characterId === firstId && currentCharacterId !== firstId) {
      duel.round += 1;
    }
    duel.turnCharacterId = other.characterId;
  }
}
