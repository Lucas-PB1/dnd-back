import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CharacterRollsService } from '@game/dice/application/character-rolls.service';
import { findEquippedWeaponAttack } from '@game/dice/application/rolls/roll-weapon-context';
import { rollExpression } from '@game/dice/domain/dice';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { computeAbilityModifiers } from '@game/sheet/domain/stats/character-derived-stats';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { BLOOD_STRIKE_OPTION_KEY_RE } from '@game/sheet/domain/validation/class-options/subclass-option-effects';
import { loadSpellcastingAbilitySlug } from '@game/spellcasting/application/resolve-character-spellcasting-slice';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  BLOOD_CONDITION_CONSTRAIN,
  BLOOD_CONDITION_EXILE,
  BLOOD_CONDITION_WITHERING,
  BLOOD_STRIKE_RESOURCE_SLUG,
  BLOOD_STRIKE_TABLE_ACTION,
  canBloodSymphonyRefund,
  canUseBloodArmament,
  canUseBloodExplosion,
  hasStudiedAttacks,
  hasTacticalMaster,
  hasTacticalShift,
  isBloodHoundSubclass,
  isFighterClass,
  secondWindHealDice,
} from '@game/combat/domain/fighter';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { ResolveEquippedWeaponAttacks } from '@game/combat/application/resolve-equipped-weapon-attacks';
import {
  findStrikeOptionForTableAction,
  strikeSaveDc,
  type StrikeOption,
} from '@game/combat/domain/strike-option';
import { LoadEffectCatalog } from '@game/effects';
import { DUEL_MAX_MEMBERS } from '../domain/duel-status';
import { appendCombatLog } from '../domain/combat-log';
import {
  clearMagicalDarkness,
  MAGICAL_DARKNESS_SPELL_SLUG,
  asArenaEffects,
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
import {
  addPendingEffect,
  consumePendingEffect,
  hasPendingEffect,
  removePendingEffect,
} from '@game/combat/domain/pending-combat-effect';
import {
  formatStrikeSelfCostNote,
  spendStrikeSelfCost,
} from '@game/combat/application/strike/spend-strike-self-cost';
import {
  halfDamage,
  resolveStrikeHitPackage,
  rollStrikeSecondaryDice,
  unarmoredDexArmorClass,
  type StrikeHitPackage,
} from '@game/combat/domain/resolve-strike-hit-package';
import { DuelRepository } from '../infrastructure/duel.repository';
import type { Duel } from '../infrastructure/duel.entity';
import type { DuelMember } from '../infrastructure/duel-member.entity';
import { hitPointsOf } from './to-dto';
import { DuelCombatSnapshot } from './duel-combat-snapshot';
import { applyDuelDamageToTarget } from '../domain/apply-duel-damage';
import {
  healMemberVitals,
  snapshotMemberVitalsFromCharacter,
} from '../domain/duel-member-vitals';
import {
  mapSaveAbilityToSheetSlug,
  resolveMasteryCombatEffects,
} from '../domain/resolve-mastery-combat-effects';
import type { AdvantageMode } from '@game/dice/domain/dice';

const TACTICAL_MASTER_OVERRIDES = new Set(['push', 'sap', 'slow']);

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
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly weaponAttacks: ResolveEquippedWeaponAttacks,
    private readonly effectCatalog: LoadEffectCatalog,
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
      const character = byId.get(member.characterId)!;
      const state = await this.state.buildResponse(character);
      snapshotMemberVitalsFromCharacter(
        member,
        character,
        state.tempHp ?? 0,
        state.conditions ?? [],
      );
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
    const firstPc = byId.get(first.member.characterId);
    const firstName = firstPc?.name ?? 'A';
    const secondName = byId.get(second.member.characterId)?.name ?? 'B';

    duel.status = 'active';
    duel.round = 1;
    duel.turnCharacterId = first.member.characterId;
    duel.turnAttacksRemaining = await this.snapshot.resolveTurnAttackBudget(
      firstPc,
    );
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

  private loadConditionsFromMembers(
    characterId: string,
    members: DuelMember[],
  ): string[] | null {
    const member = members.find((m) => m.characterId === characterId);
    if (member != null && member.hitPointsCurrent != null) {
      return member.conditions ?? [];
    }
    return null;
  }

  private async loadConditions(
    characterId: string,
    members?: DuelMember[],
  ): Promise<string[]> {
    if (members) {
      const fromMember = this.loadConditionsFromMembers(characterId, members);
      if (fromMember) return fromMember;
    }
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
    input: {
      itemSlug: string;
      mode: 'melee' | 'ranged';
      bloodStrike?: { optionSlug: string; takeLowerBloodCost?: boolean };
      damageTypeOverride?: 'acid' | 'necrotic' | 'poison';
      bloodExplosionOnMiss?: boolean;
      masteryOverrideSlug?: 'push' | 'sap' | 'slow';
      graze?: boolean;
    },
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    const { duel, members } = await this.repo.getForMember(userId, duelId);
    this.repo.assertStatus(duel, ['active']);

    await this.maybeSkipPendingExileTurn(duel, members);

    const attacker = members.find((m) => m.userId === userId);
    const defender = members.find((m) => m.userId !== userId);
    if (!attacker || !defender) {
      throw new BadRequestException('Duel needs two participants');
    }
    if (duel.turnCharacterId !== attacker.characterId) {
      throw new BadRequestException('Not your turn');
    }
    if ((duel.turnAttacksRemaining ?? 1) <= 0) {
      throw new BadRequestException('Sem ataques restantes neste turno');
    }

    assertCanTakeDuelAction(await this.loadConditions(attacker.characterId, members));

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

    let advantage = await this.resolveAttackAdvantage(duel, attacker, defender);
    const pendingAdv = consumePendingEffect(
      duel.arenaEffects,
      'attack-advantage',
      attacker.characterId,
    );
    duel.arenaEffects = asArenaEffects(pendingAdv.effects);
    if (pendingAdv.consumed) {
      advantage = advantage === 'disadvantage' ? 'normal' : 'advantage';
    }
    const pendingDis = consumePendingEffect(
      duel.arenaEffects,
      'attack-disadvantage',
      attacker.characterId,
    );
    duel.arenaEffects = asArenaEffects(pendingDis.effects);
    if (pendingDis.consumed) {
      advantage = advantage === 'advantage' ? 'normal' : 'disadvantage';
    }

    const constrain = consumePendingEffect(
      duel.arenaEffects,
      BLOOD_CONDITION_CONSTRAIN,
      attacker.characterId,
    );
    duel.arenaEffects = asArenaEffects(constrain.effects);
    if (constrain.consumed) {
      advantage = advantage === 'advantage' ? 'normal' : 'disadvantage';
    }

    let bloodStrikeDamaged = false;
    let bloodCostNote: string | null = null;
    let strikePkg: StrikeHitPackage | null = null;
    let strikeOption: StrikeOption | null = null;

    if (input.bloodStrike) {
      strikeOption = await this.assertStrikeOptionReady(
        attackerPc,
        input.bloodStrike.optionSlug,
      );
      try {
        const spent = await spendStrikeSelfCost({
          character: attackerPc,
          option: strikeOption,
          takeLowerCost: input.bloodStrike.takeLowerBloodCost,
          ports: {
            useClassResource: async (slug, amount) => {
              await this.state.useClassResource(attackerPc, slug, amount);
            },
            applyCurrentHitPoints: async (hitPointsCurrent) => {
              if (attacker.hitPointsCurrent != null) {
                attacker.hitPointsCurrent = hitPointsCurrent;
              } else {
                await this.state.applyCurrentHitPoints(
                  attackerPc,
                  hitPointsCurrent,
                );
                attackerPc.hitPointsCurrent = hitPointsCurrent;
              }
            },
          },
        });
        bloodCostNote = formatStrikeSelfCostNote(spent, 'duel');
      } catch (err) {
        throw new BadRequestException(
          err instanceof Error ? err.message : 'Golpe de Sangue inválido',
        );
      }
      strikePkg = resolveStrikeHitPackage({
        option: strikeOption,
        level: attackerPc.level,
      });
    }

    if (input.damageTypeOverride) {
      if (
        !isBloodHoundSubclass(attackerPc.subclassSlug) ||
        !canUseBloodArmament(attackerPc.level)
      ) {
        throw new BadRequestException(
          'Armamento de Sangue exige Sabujo de Sangue nível 7+',
        );
      }
    }

    if (input.bloodExplosionOnMiss) {
      if (
        !isBloodHoundSubclass(attackerPc.subclassSlug) ||
        !canUseBloodExplosion(attackerPc.level)
      ) {
        throw new BadRequestException(
          'Explosão de Sangue exige Sabujo de Sangue nível 7+',
        );
      }
    }

    if (
      input.masteryOverrideSlug &&
      (!hasTacticalMaster(attackerPc.level) ||
        !TACTICAL_MASTER_OVERRIDES.has(input.masteryOverrideSlug))
    ) {
      throw new BadRequestException(
        'Mestre Tático exige Guerreiro nível 9+ (Empurrar, Drenar ou Lento)',
      );
    }

    const saveDc = strikeSaveDc(
      abilityModifier(attackerPc.abilityScores.constituicao),
      await this.domain.getProficiencyBonus(attackerPc.level),
    );

    // Bloodshard: DEX save em vez de attack roll
    if (strikePkg?.replacesAttackWithSave) {
      return this.resolveBloodshardAttack({
        duel,
        members,
        attacker,
        defender,
        attackerPc,
        defenderPc,
        input,
        strikePkg,
        strikeOption: strikeOption!,
        saveDc,
        bloodCostNote,
      });
    }

    let targetAc =
      (
        await this.snapshot.resolveArmorByCharacter([defenderPc])
      ).get(defenderPc.id) ?? 10;
    if (strikePkg?.ignoreTargetArmor) {
      targetAc = unarmoredDexArmorClass(
        abilityModifier(defenderPc.abilityScores.destreza),
      );
    }

    const { attack: weaponAttack } = await findEquippedWeaponAttack(
      {
        sheet: this.sheet,
        domain: this.domain,
        weaponAttacks: this.weaponAttacks,
        dataSource: this.dataSource,
        effectCatalog: this.effectCatalog,
      },
      attackerPc,
      input.itemSlug,
      input.mode,
    );

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
    if (bloodCostNote) {
      log = appendCombatLog(log, `${attackerPc.name}: ${bloodCostNote}`);
    }
    const attackLabel = attackRoll.label ?? 'Ataque';
    const hit = attackRoll.hit === true;
    const critical = attackRoll.critical === true;
    const visionNote = advantage !== 'normal' ? ` [${advantage}]` : '';

    const masterySlug = this.resolveActiveMasterySlug(
      weaponAttack.masterySlug,
      input.masteryOverrideSlug,
      attackerPc,
    );
    const attackAbilityMod = abilityModifier(
      attackerPc.abilityScores[weaponAttack.abilitySlug],
    );
    const proficiencyBonus = await this.domain.getProficiencyBonus(
      attackerPc.level,
    );

    if (!hit) {
      log = appendCombatLog(
        log,
        `${attackerPc.name}: ${attackLabel}${visionNote} — errou (total ${attackRoll.total} vs CA ${attackRoll.effectiveTargetAc ?? targetAc}).`,
      );

      if (hasStudiedAttacks(attackerPc.level)) {
        duel.arenaEffects = asArenaEffects(
          addPendingEffect(
            duel.arenaEffects,
            'attack-advantage',
            attacker.characterId,
          ),
        );
        log = appendCombatLog(
          log,
          `${attackerPc.name}: Ataques Estudados — vantagem no próximo ataque.`,
        );
      }

      if (masterySlug) {
        const masteryLog = await this.applyMasteryEffects({
          duel,
          masterySlug,
          trigger: 'on_miss',
          attackAbilityMod,
          proficiencyBonus,
          attacker,
          defender,
          damaged: false,
        });
        for (const line of masteryLog) {
          log = appendCombatLog(log, line);
        }
        if ((defender.hitPointsCurrent ?? 1) <= 0) {
          return this.afterDamage({
            duel,
            members,
            log,
            attacker,
            attackerName: attackerPc.name,
            defenderName: defenderPc.name,
            hitPointsAfter: 0,
            attackerPc,
          });
        }
      }

      if (input.bloodExplosionOnMiss) {
        const explosion = await this.resolveBloodExplosion({
          attackerUserId: attacker.userId,
          defenderUserId: defender.userId,
          attackerCharacterId: attacker.characterId,
          defenderCharacterId: defender.characterId,
          itemSlug: input.itemSlug,
          mode: input.mode,
          saveDc,
        });
        log = appendCombatLog(log, explosion.note);
        if (explosion.damage > 0) {
          bloodStrikeDamaged = false;
          const applied = await applyDuelDamageToTarget({
            state: this.state,
            member: defender,
            target: defenderPc,
            damage: explosion.damage,
            damageType: input.damageTypeOverride ?? null,
          });
          log = appendCombatLog(
            log,
            `Explosão: ${applied.damageTotal} de dano. ${defenderPc.name}: ${applied.hitPointsBefore} → ${applied.hitPointsAfter} PV.`,
          );
          return this.afterDamage({
            duel,
            members,
            log,
            attacker,
            attackerName: attackerPc.name,
            defenderName: defenderPc.name,
            hitPointsAfter: applied.hitPointsAfter,
            bloodStrikeDamaged,
            attackerPc,
          });
        }
      }

      return this.afterAttackAction({
        duel,
        members,
        log,
        attackerPc,
      });
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

    let weaponDamage = Math.max(0, damageRoll.total);
    const withering = consumePendingEffect(
      duel.arenaEffects,
      BLOOD_CONDITION_WITHERING,
      attacker.characterId,
    );
    duel.arenaEffects = asArenaEffects(withering.effects);
    if (withering.consumed) {
      weaponDamage = halfDamage(weaponDamage);
    }

    let totalDamage = weaponDamage;
    const damageNotes: string[] = [];
    if (strikePkg) {
      totalDamage += strikePkg.extraDamage;
      if (strikePkg.extraExpression) {
        damageNotes.push(
          `+${strikePkg.extraExpression} ${strikePkg.damageType}`,
        );
      }
      bloodStrikeDamaged = totalDamage > 0;
    }

    const damageType =
      input.damageTypeOverride ??
      (strikePkg && strikePkg.extraDamage > 0 ? strikePkg.damageType : null);

    const applied = await applyDuelDamageToTarget({
      state: this.state,
      member: defender,
      target: defenderPc,
      damage: totalDamage,
      damageType,
    });

    const tempNote =
      applied.absorbedByTempHp > 0
        ? ` (${applied.absorbedByTempHp} absorvido por PV temp.)`
        : '';
    const typeNote = input.damageTypeOverride
      ? ` [${input.damageTypeOverride}]`
      : '';
    const extraNote =
      damageNotes.length > 0 ? ` (${damageNotes.join(', ')})` : '';
    log = appendCombatLog(
      log,
      `${attackerPc.name}: ${attackLabel}${visionNote} — acerto${critical ? ' crítico' : ''}! Dano ${applied.damageTotal}${typeNote}${extraNote}${tempNote}. ${defenderPc.name}: ${applied.hitPointsBefore} → ${applied.hitPointsAfter} PV.`,
    );

    if (strikePkg) {
      const effectLog = await this.applyStrikeOnHitEffects({
        duel,
        members,
        strikePkg,
        saveDc,
        attackerPc,
        defender,
        defenderPc,
      });
      for (const line of effectLog) {
        log = appendCombatLog(log, line);
      }
    }

    if (masterySlug) {
      const masteryLog = await this.applyMasteryEffects({
        duel,
        masterySlug,
        trigger: 'on_hit',
        attackAbilityMod,
        proficiencyBonus,
        attacker,
        defender,
        damaged: applied.damageTotal > 0,
      });
      for (const line of masteryLog) {
        log = appendCombatLog(log, line);
      }
    }

    return this.afterDamage({
      duel,
      members,
      log,
      attacker,
      attackerName: attackerPc.name,
      defenderName: defenderPc.name,
      hitPointsAfter:
        defender.hitPointsCurrent ?? applied.hitPointsAfter,
      bloodStrikeDamaged,
      attackerPc,
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

    await this.maybeSkipPendingExileTurn(duel, members);
    if (duel.turnCharacterId !== caster.characterId) {
      throw new BadRequestException('Not your turn');
    }

    assertCanTakeDuelAction(await this.loadConditions(caster.characterId, members));

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
      await this.advanceTurnFully(duel, members, caster.characterId);
      duel.combatLog = log;
      return { duel: await this.repo.saveDuel(duel), members };
    }

    if (resolution.kind === 'auto_damage') {
      const applied = await applyDuelDamageToTarget({
        state: this.state,
        member: opponent,
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
        hitPointsAfter: opponent.hitPointsCurrent ?? applied.hitPointsAfter,
        spendAttack: false,
      });
    }

    if (resolution.kind === 'spell_attack') {
      if (!resolution.hit) {
        log = appendCombatLog(
          log,
          `${casterName}: ${resolution.label} — errou (total ${resolution.attackTotal}).`,
        );
        await this.advanceTurnFully(duel, members, caster.characterId);
        duel.combatLog = log;
        return { duel: await this.repo.saveDuel(duel), members };
      }
      const applied = await applyDuelDamageToTarget({
        state: this.state,
        member: opponent,
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
        hitPointsAfter: opponent.hitPointsCurrent ?? applied.hitPointsAfter,
        spendAttack: false,
      });
    }

    log = appendCombatLog(
      log,
      `${casterName} conjurou ${input.spellSlug}: ${resolution.note}`,
    );
    await this.advanceTurnFully(duel, members, caster.characterId);
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

    assertCanTakeDuelAction(await this.loadConditions(actor.characterId, members));
    assertValidDuelConditionSlug(input.condition);

    const targetMember = input.target === 'self' ? actor : opponent;
    const targetPc = await this.repo.findCharacterById(targetMember.characterId);
    if (!targetPc) {
      throw new BadRequestException('Target not found');
    }

    const current = await this.loadConditions(targetPc.id, members);
    const next = mergeConditions({
      current,
      action: input.action,
      condition: input.condition,
    });
    if (targetMember.hitPointsCurrent != null) {
      targetMember.conditions = next;
      await this.repo.saveMember(targetMember);
    } else {
      await this.state.patch(targetPc, { conditions: next });
    }

    const actorPc = await this.repo.findCharacterById(actor.characterId);
    const log = appendCombatLog(
      duel.combatLog,
      `${actorPc?.name ?? 'Jogador'} ${input.action === 'add' ? 'aplicou' : 'removeu'} ${input.condition} em ${targetPc.name}.`,
    );
    await this.advanceTurnFully(duel, members, actor.characterId);
    duel.combatLog = log;
    return { duel: await this.repo.saveDuel(duel), members };
  }

  async useSecondWind(
    userId: string,
    duelId: string,
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    const { duel, members } = await this.repo.getForMember(userId, duelId);
    this.repo.assertStatus(duel, ['active']);
    const actor = members.find((m) => m.userId === userId);
    if (!actor) throw new BadRequestException('Not a duel member');
    if (duel.turnCharacterId !== actor.characterId) {
      throw new BadRequestException('Not your turn');
    }
    assertCanTakeDuelAction(await this.loadConditions(actor.characterId, members));

    const character = await this.access.findOwnedOrFail(
      userId,
      actor.characterId,
    );
    if (!isFighterClass(character.classSlug)) {
      throw new BadRequestException('Recuperar Fôlego exige Guerreiro');
    }

    await this.state.useClassResource(character, 'secondWind', 1);
    const healRoll = rollExpression(secondWindHealDice(character.level));
    const healed = healMemberVitals(actor, healRoll.total);
    await this.repo.saveMember(actor);

    let note = `${character.name}: Recuperar Fôlego (${healRoll.expression}) — ${healed.before} → ${healed.after} PV.`;
    if (hasTacticalShift(character.level)) {
      note += ' Ajuste Tático: mova-se até metade do Deslocamento sem provocar AO.';
    }
    duel.combatLog = appendCombatLog(duel.combatLog, note);
    const saved = await this.repo.saveDuel(duel);
    return { duel: saved, members };
  }

  async useActionSurge(
    userId: string,
    duelId: string,
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    const { duel, members } = await this.repo.getForMember(userId, duelId);
    this.repo.assertStatus(duel, ['active']);
    const actor = members.find((m) => m.userId === userId);
    if (!actor) throw new BadRequestException('Not a duel member');
    if (duel.turnCharacterId !== actor.characterId) {
      throw new BadRequestException('Not your turn');
    }
    assertCanTakeDuelAction(await this.loadConditions(actor.characterId, members));

    const character = await this.access.findOwnedOrFail(
      userId,
      actor.characterId,
    );
    if (!isFighterClass(character.classSlug) || character.level < 2) {
      throw new BadRequestException('Surto de Ação exige Guerreiro nível 2+');
    }

    await this.state.useClassResource(character, 'actionSurge', 1);
    const extra = await this.snapshot.resolveTurnAttackBudget(character);
    duel.turnAttacksRemaining = (duel.turnAttacksRemaining ?? 0) + extra;
    duel.combatLog = appendCombatLog(
      duel.combatLog,
      `${character.name}: Surto de Ação — +${extra} ataque(s) neste turno (restantes: ${duel.turnAttacksRemaining}).`,
    );
    const saved = await this.repo.saveDuel(duel);
    return { duel: saved, members };
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
    bloodStrikeDamaged?: boolean;
    attackerPc?: PlayerCharacter;
    /** false = ação completa (magia); default true = gasta 1 ataque */
    spendAttack?: boolean;
  }): Promise<{ duel: Duel; members: DuelMember[] }> {
    let { log } = input;
    await this.repo.saveMembers(input.members);

    if (input.hitPointsAfter <= 0) {
      if (
        input.bloodStrikeDamaged &&
        input.attackerPc &&
        canBloodSymphonyRefund(input.attackerPc.level)
      ) {
        try {
          await this.state.recoverClassResource(
            input.attackerPc,
            BLOOD_STRIKE_RESOURCE_SLUG,
            1,
          );
          log = appendCombatLog(
            log,
            `${input.attackerName}: Sinfonia de Sangue — recupera 1 Golpe de Sangue.`,
          );
        } catch {
          // pool já cheia — ignora
        }
      }
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

    if (input.spendAttack === false) {
      await this.advanceTurnFully(
        input.duel,
        input.members,
        input.attacker.characterId,
      );
    } else {
      await this.consumeAttackOrAdvance(
        input.duel,
        input.members,
        input.attackerPc,
      );
    }
    await this.maybeSkipPendingExileTurn(input.duel, input.members);
    input.duel.combatLog = log;
    const saved = await this.repo.saveDuel(input.duel);
    return { duel: saved, members: input.members };
  }

  private async afterAttackAction(input: {
    duel: Duel;
    members: DuelMember[];
    log: Duel['combatLog'];
    attackerPc: PlayerCharacter;
  }): Promise<{ duel: Duel; members: DuelMember[] }> {
    await this.repo.saveMembers(input.members);
    await this.consumeAttackOrAdvance(
      input.duel,
      input.members,
      input.attackerPc,
    );
    await this.maybeSkipPendingExileTurn(input.duel, input.members);
    input.duel.combatLog = input.log;
    const saved = await this.repo.saveDuel(input.duel);
    return { duel: saved, members: input.members };
  }

  private async consumeAttackOrAdvance(
    duel: Duel,
    members: DuelMember[],
    attackerPc: PlayerCharacter | undefined,
  ): Promise<void> {
    const remaining = (duel.turnAttacksRemaining ?? 1) - 1;
    duel.turnAttacksRemaining = Math.max(0, remaining);
    if (duel.turnAttacksRemaining <= 0) {
      await this.advanceTurnFully(
        duel,
        members,
        attackerPc?.id ?? duel.turnCharacterId!,
      );
    }
  }

  private async advanceTurnFully(
    duel: Duel,
    members: DuelMember[],
    currentCharacterId: string,
  ): Promise<void> {
    this.advanceTurn(duel, members, currentCharacterId);
    const nextId = duel.turnCharacterId;
    if (!nextId) return;
    const nextPc = await this.repo.findCharacterById(nextId);
    duel.turnAttacksRemaining = await this.snapshot.resolveTurnAttackBudget(
      nextPc ?? undefined,
    );
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

  private resolveActiveMasterySlug(
    weaponMasterySlug: string | null,
    override: 'push' | 'sap' | 'slow' | undefined,
    attackerPc: PlayerCharacter,
  ): string | null {
    if (
      override &&
      hasTacticalMaster(attackerPc.level) &&
      TACTICAL_MASTER_OVERRIDES.has(override)
    ) {
      return override;
    }
    return weaponMasterySlug;
  }

  private async applyMasteryEffects(input: {
    duel: Duel;
    masterySlug: string;
    trigger: 'on_hit' | 'on_miss';
    attackAbilityMod: number;
    proficiencyBonus: number;
    attacker: DuelMember;
    defender: DuelMember;
    damaged: boolean;
  }): Promise<string[]> {
    const effects = await this.effectCatalog.load({
      ownerKind: 'weapon_mastery',
      ownerSlugs: [input.masterySlug],
    });
    if (effects.length === 0) return [];

    let defenderSaveTotal: number | null = null;
    const needsSave = effects.some(
      (e) => e.trigger === input.trigger && e.kind === 'feature_save',
    );
    if (needsSave && input.trigger === 'on_hit') {
      const saveEffect = effects.find(
        (e) => e.trigger === 'on_hit' && e.kind === 'feature_save',
      );
      const abilitySlug = mapSaveAbilityToSheetSlug(
        saveEffect?.save?.saveAbility ?? 'constitution',
      );
      const save = await this.rolls.rollSavingThrow(
        input.defender.userId,
        input.defender.characterId,
        { abilitySlug },
      );
      defenderSaveTotal = save.total;
    }

    const result = resolveMasteryCombatEffects({
      effects,
      trigger: input.trigger,
      attackAbilityMod: input.attackAbilityMod,
      proficiencyBonus: input.proficiencyBonus,
      defenderSaveTotal,
      attackerMember: input.attacker,
      defenderMember: input.defender,
      arenaEffects: input.duel.arenaEffects,
      damaged: input.damaged,
    });
    input.duel.arenaEffects = asArenaEffects(result.arenaEffects);
    return result.logLines;
  }

  private async resolveAttackAdvantage(
    duel: Duel,
    attacker: DuelMember,
    defender: DuelMember,
  ): Promise<AdvantageMode> {
    const [attackerSees, defenderSees] = await Promise.all([
      this.seesMagicalDarkness(attacker.characterId),
      this.seesMagicalDarkness(defender.characterId),
    ]);
    return resolveDuelAttackVisionMode({
      arenaEffects: duel.arenaEffects,
      attackerSeesMagicalDarkness: attackerSees,
      defenderSeesMagicalDarkness: defenderSees,
    });
  }

  private async assertStrikeOptionReady(
    character: PlayerCharacter,
    optionSlug: string,
  ): Promise<StrikeOption> {
    if (!isBloodHoundSubclass(character.subclassSlug) || character.level < 3) {
      throw new BadRequestException('Golpe de Sangue não disponível');
    }
    const catalog = await this.mechanicalCatalog.load();
    const option = findStrikeOptionForTableAction(
      catalog.strikeOptions,
      optionSlug,
      BLOOD_STRIKE_TABLE_ACTION,
    );
    if (!option?.costDice) {
      throw new BadRequestException(
        `Opção de Golpe de Sangue desconhecida: ${optionSlug}`,
      );
    }
    const sheet = await this.sheet.load(character.id);
    const known = (sheet.subclassOptions ?? []).some(
      (opt) =>
        BLOOD_STRIKE_OPTION_KEY_RE.test(opt.optionKey) &&
        opt.valueId === optionSlug,
    );
    if (!known) {
      throw new BadRequestException(
        'Personagem não conhece esta opção de Golpe de Sangue',
      );
    }
    return option;
  }

  private async resolveBloodExplosion(input: {
    attackerUserId: string;
    defenderUserId: string;
    attackerCharacterId: string;
    defenderCharacterId: string;
    itemSlug: string;
    mode: 'melee' | 'ranged';
    saveDc: number;
  }): Promise<{ damage: number; note: string }> {
    const damageRoll = await this.rolls.rollDamage(
      input.attackerUserId,
      input.attackerCharacterId,
      {
        itemSlug: input.itemSlug,
        mode: input.mode,
        critical: false,
      },
    );
    const full = Math.max(0, damageRoll.total);
    const save = await this.rolls.rollSavingThrow(
      input.defenderUserId,
      input.defenderCharacterId,
      { abilitySlug: 'constituicao' },
    );
    const success = save.total >= input.saveDc;
    const damage = success ? halfDamage(full) : full;
    return {
      damage,
      note: `Explosão de Sangue: CON ${save.total} vs CD ${input.saveDc} — ${success ? 'sucesso (metade)' : 'falha'} (${full} arma).`,
    };
  }

  private async resolveBloodshardAttack(input: {
    duel: Duel;
    members: DuelMember[];
    attacker: DuelMember;
    defender: DuelMember;
    attackerPc: PlayerCharacter;
    defenderPc: PlayerCharacter;
    input: {
      itemSlug: string;
      mode: 'melee' | 'ranged';
      damageTypeOverride?: 'acid' | 'necrotic' | 'poison';
    };
    strikePkg: StrikeHitPackage;
    strikeOption: StrikeOption;
    saveDc: number;
    bloodCostNote: string | null;
  }): Promise<{ duel: Duel; members: DuelMember[] }> {
    const damageRoll = await this.rolls.rollDamage(
      input.attacker.userId,
      input.attacker.characterId,
      {
        itemSlug: input.input.itemSlug,
        mode: input.input.mode,
        critical: false,
      },
    );
    const piercing = rollStrikeSecondaryDice({
      option: input.strikeOption,
      level: input.attackerPc.level,
    });
    let full = Math.max(0, damageRoll.total) + piercing.total;
    const withering = consumePendingEffect(
      input.duel.arenaEffects,
      BLOOD_CONDITION_WITHERING,
      input.attacker.characterId,
    );
    input.duel.arenaEffects = asArenaEffects(withering.effects);
    if (withering.consumed) {
      full = halfDamage(full);
    }

    const save = await this.rolls.rollSavingThrow(
      input.defender.userId,
      input.defender.characterId,
      { abilitySlug: 'destreza' },
    );
    const success = save.total >= input.saveDc;
    const damage = success ? halfDamage(full) : full;

    let log = input.duel.combatLog ?? [];
    if (input.bloodCostNote) {
      log = appendCombatLog(
        log,
        `${input.attackerPc.name}: ${input.bloodCostNote}`,
      );
    }
    log = appendCombatLog(
      log,
      `${input.attackerPc.name}: ${input.strikePkg.label} (linha) — DEX ${save.total} vs CD ${input.saveDc}: ${success ? 'sucesso (metade)' : 'falha'}. Dano ${full} (arma+${piercing.expression}).`,
    );

    const applied = await applyDuelDamageToTarget({
      state: this.state,
      member: input.defender,
      target: input.defenderPc,
      damage,
      damageType: input.input.damageTypeOverride ?? 'piercing',
    });
    log = appendCombatLog(
      log,
      `${input.defenderPc.name}: ${applied.hitPointsBefore} → ${applied.hitPointsAfter} PV (${applied.damageTotal} aplicado).`,
    );

    return this.afterDamage({
      duel: input.duel,
      members: input.members,
      log,
      attacker: input.attacker,
      attackerName: input.attackerPc.name,
      defenderName: input.defenderPc.name,
      hitPointsAfter:
        input.defender.hitPointsCurrent ?? applied.hitPointsAfter,
      bloodStrikeDamaged: applied.damageTotal > 0,
      attackerPc: input.attackerPc,
    });
  }

  private async applyStrikeOnHitEffects(input: {
    duel: Duel;
    members: DuelMember[];
    strikePkg: StrikeHitPackage;
    saveDc: number;
    attackerPc: PlayerCharacter;
    defender: DuelMember;
    defenderPc: PlayerCharacter;
  }): Promise<string[]> {
    const lines: string[] = [];
    const { strikePkg, saveDc, defender, defenderPc, duel, members } = input;

    if (strikePkg.addsArenaEffect) {
      duel.arenaEffects = setMagicalDarkness(duel.arenaEffects);
      duel.arenaEffectSourceCharacterId = input.attackerPc.id;
      lines.push(
        `${strikePkg.label}: névoa de escuridão mágica na arena.`,
      );
    }

    if (strikePkg.onHitPendingKind) {
      duel.arenaEffects = asArenaEffects(
        addPendingEffect(
          duel.arenaEffects,
          strikePkg.onHitPendingKind,
          defenderPc.id,
        ),
      );
      lines.push(
        `${defenderPc.name}: efeito pendente (${strikePkg.onHitPendingKind}).`,
      );
    }

    if (strikePkg.noteOnly && strikePkg.saveAbility) {
      const save = await this.rolls.rollSavingThrow(
        defender.userId,
        defender.characterId,
        { abilitySlug: strikePkg.saveAbility },
      );
      const success = save.total >= saveDc;
      lines.push(
        `${strikePkg.label}: SAB ${save.total} vs CD ${saveDc} — ${success ? 'sucesso' : 'falha'} (1v1: sem aliado para enfeitiçar).`,
      );
      return lines;
    }

    if (!strikePkg.saveAbility) {
      return lines;
    }

    const save = await this.rolls.rollSavingThrow(
      defender.userId,
      defender.characterId,
      { abilitySlug: strikePkg.saveAbility },
    );
    const success = save.total >= saveDc;
    const abilityLabel = strikePkg.saveAbility;
    if (success) {
      lines.push(
        `${strikePkg.label}: ${abilityLabel} ${save.total} vs CD ${saveDc} — sucesso.`,
      );
      return lines;
    }

    lines.push(
      `${strikePkg.label}: ${abilityLabel} ${save.total} vs CD ${saveDc} — falha.`,
    );

    if (strikePkg.onFailCondition) {
      const current = await this.loadConditions(defenderPc.id, members);
      const next = mergeConditions({
        current,
        action: 'add',
        condition: strikePkg.onFailCondition,
      });
      if (defender.hitPointsCurrent != null) {
        defender.conditions = next;
      } else {
        await this.state.patch(defenderPc, { conditions: next });
      }
      lines.push(`${defenderPc.name} fica ${strikePkg.onFailCondition}.`);
    }

    if (strikePkg.onFailPendingKind) {
      duel.arenaEffects = asArenaEffects(
        addPendingEffect(
          duel.arenaEffects,
          strikePkg.onFailPendingKind,
          defenderPc.id,
        ),
      );
      lines.push(
        `${defenderPc.name}: efeito pendente (${strikePkg.onFailPendingKind}).`,
      );
    }

    return lines;
  }

  /**
   * Pending `blood-exile` + incapacitado: perde o turno e limpa a condição.
   * Kind vem do catálogo (`on_fail_pending_kind`); o skip ainda é produto Sabujo.
   */
  private async maybeSkipPendingExileTurn(
    duel: Duel,
    members: DuelMember[],
  ): Promise<void> {
    const turnId = duel.turnCharacterId;
    if (!turnId || duel.status !== 'active') return;
    if (!hasPendingEffect(duel.arenaEffects, BLOOD_CONDITION_EXILE, turnId)) {
      return;
    }
    const conditions = await this.loadConditions(turnId, members);
    if (!conditions.includes('incapacitated')) {
      duel.arenaEffects = asArenaEffects(
        removePendingEffect(
          duel.arenaEffects,
          BLOOD_CONDITION_EXILE,
          turnId,
        ),
      );
      return;
    }

    const pc = await this.repo.findCharacterById(turnId);
    const member = members.find((m) => m.characterId === turnId);
    const next = mergeConditions({
      current: conditions,
      action: 'remove',
      condition: 'incapacitated',
    });
    if (member != null && member.hitPointsCurrent != null) {
      member.conditions = next;
      await this.repo.saveMember(member);
    } else if (pc) {
      await this.state.patch(pc, { conditions: next });
    }
    duel.arenaEffects = asArenaEffects(
      removePendingEffect(duel.arenaEffects, BLOOD_CONDITION_EXILE, turnId),
    );
    duel.combatLog = appendCombatLog(
      duel.combatLog,
      `${pc?.name ?? 'Alvo'} perde o turno (Exílio) e deixa de estar incapacitado.`,
    );
    await this.advanceTurnFully(duel, members, turnId);
  }
}
