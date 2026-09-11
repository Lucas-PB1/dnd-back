import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { rageDamageBonus } from '@game/combat/domain/barbarian';
import { isWarlockClass } from '@game/combat/domain/warlock';
import { findDungeoneerPrecautionSpell } from '@game/combat/domain/fighter';
import { isBardClass } from '@game/combat/domain/bard';
import { isMonkClass } from '@game/combat/domain/monk';
import {
  magicalCunningSlotRecoveryCount,
  warlockPactSlotLevel,
} from '@game/combat/domain/warlock';
import { isWizardClass } from '@game/combat/domain/wizard';
import { psiEnergyDieFaces } from '@game/combat/domain/fighter';
import {
  FEATURE_SCHEDULE_KEYS,
  featureSchedulesFromCatalog,
  scheduleIntAtLevel,
} from '@game/combat/domain/feature-schedule';
import type { LoadEffectCatalog } from '@game/effects';
import { executeCatalogEffect, type CatalogEffect } from '@game/effects';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type { SyncCharacterCompanionHandler } from '@game/actor/application/sync-character-companion.handler';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  applyCompanionCommand,
  applyCompanionSummon,
  type CompanionTableActionDeps,
} from '../actions/shared/companion-table-actions';
import { applyCatalogManeuverTableAction } from './apply-catalog-maneuver-table-action';
import { applyCheckBoostTableAction } from './apply-check-boost-table-action';
import { applyHealHitPoints } from './apply-heal-hit-points';
import { applySetBestialAspectTableAction } from './apply-set-bestial-aspect-table-action';
import { applySetPersonaMasksTableAction } from './apply-set-persona-masks-table-action';
import { applyStrikeSelfCostTableAction } from './apply-strike-self-cost-table-action';
import { applyTemporaryHitPoints } from './apply-temporary-hit-points';
import { spellcastingAbilityModifier } from './apply-feat-economy-executed-effect';
import { assertCharacterLevel } from './table-action-guards';

export type DeclaredEconomyTableActionDeps = {
  state: CharacterStateRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
  effectCatalog?: LoadEffectCatalog;
  sheet?: CharacterSheetRepository;
  getProficiencyBonus?: (level: number) => Promise<number>;
  companion?: {
    dataSource: DataSource;
    syncCompanion: SyncCharacterCompanionHandler;
  };
};

export type DeclaredEconomyTableActionOptions = {
  userId?: string;
  diceCount?: number;
  companionCommand?: string;
  checkTotal?: number;
  dc?: number;
  usePsiDie?: boolean;
  maneuverSlug?: string;
  useRelentless?: boolean;
  spellSlug?: string;
  optionSlug?: string;
  takeLowerBloodCost?: boolean;
  amount?: number;
  masks?: string[];
  level?: number;
};

type SpendPlan = {
  resourceSlug: string | null;
  amount: number;
};

/**
 * SSOT mesa: `phb_class_economy_action` (botão/gasto) + `phb_effect` on_table_action (apply).
 */
export async function applyDeclaredEconomyTableAction(
  deps: DeclaredEconomyTableActionDeps,
  character: PlayerCharacter,
  actionSlug: string,
  options: DeclaredEconomyTableActionOptions = {},
): Promise<TableActionResponseDto> {
  const catalog = await deps.mechanicalCatalog.load();
  const action = findDeclaredEconomyAction(
    catalog.economyActions,
    character.classSlug,
    actionSlug,
  );
  if (!action) {
    throw new BadRequestException(`Ação de mesa desconhecida: ${actionSlug}`);
  }

  assertCharacterLevel(
    character,
    action.minLevel,
    character.classSlug ?? 'classe',
    action.name,
  );
  if (actionSlug === 'healing-light' && options.diceCount != null) {
    const chaMod = abilityModifier(character.abilityScores?.carisma ?? 10);
    const maxDice = Math.max(1, chaMod);
    if (
      !Number.isInteger(options.diceCount) ||
      options.diceCount < 1 ||
      options.diceCount > maxDice
    ) {
      throw new BadRequestException(
        `Luz Medicinal: escolha de 1 a ${maxDice} d6(s)`,
      );
    }
  }
  if (
    action.subclassSlug != null &&
    character.subclassSlug !== action.subclassSlug
  ) {
    throw new BadRequestException(`${action.name} exige a subclasse correta`);
  }

  const effects = deps.effectCatalog
    ? await deps.effectCatalog.load({
        actionSlug,
        triggers: ['on_table_action'],
      })
    : [];
  const applicable = effects.filter((e) =>
    isTableActionEffectApplicable(e, character),
  );

  const structured = applicable.find((e) =>
    ['check_boost', 'catalog_maneuver', 'strike_self_cost', 'set_tracker'].includes(
      e.kind,
    ),
  );
  if (structured?.kind === 'check_boost') {
    return applyCheckBoostTableAction({
      state: deps.state,
      character,
      resourceSlug: structured.resourceSlug || action.resourceSlug || '',
      actionName: action.name,
      checkTotal: options.checkTotal,
      dc: options.dc,
      note: structured.note?.note,
    });
  }
  if (structured?.kind === 'catalog_maneuver') {
    if (!deps.sheet || !deps.getProficiencyBonus) {
      throw new BadRequestException('Catálogo de manobra indisponível');
    }
    return applyCatalogManeuverTableAction({
      state: deps.state,
      sheet: deps.sheet,
      mechanicalCatalog: deps.mechanicalCatalog,
      character,
      maneuverSlug: options.maneuverSlug ?? '',
      useRelentless: options.useRelentless,
      proficiencyBonus: await deps.getProficiencyBonus(character.level),
    });
  }
  if (structured?.kind === 'strike_self_cost') {
    if (!deps.sheet) {
      throw new BadRequestException('Ficha indisponível para Golpe de Sangue');
    }
    return applyStrikeSelfCostTableAction({
      state: deps.state,
      sheet: deps.sheet,
      mechanicalCatalog: deps.mechanicalCatalog,
      character,
      optionSlug: options.optionSlug ?? '',
      takeLowerBloodCost: options.takeLowerBloodCost,
    });
  }
  if (structured?.kind === 'set_tracker') {
    if (actionSlug === 'set-bestial-aspect') {
      return applySetBestialAspectTableAction({
        state: deps.state,
        mechanicalCatalog: deps.mechanicalCatalog,
        character,
        actionName: action.name,
        level: options.level,
      });
    }
    return applySetPersonaMasksTableAction({
      state: deps.state,
      mechanicalCatalog: deps.mechanicalCatalog,
      character,
      actionName: action.name,
      masks: options.masks ?? [],
    });
  }

  const spend = resolveSpendPlan(action, options);
  let state =
    spend.amount > 0 && spend.resourceSlug
      ? (
          await deps.state.useClassResource(
            character,
            spend.resourceSlug,
            spend.amount,
          )
        ).state
      : await deps.state.buildResponse(character);

  let note =
    action.description?.trim() ||
    action.summary?.trim() ||
    `${action.name}: declare o efeito na mesa.`;
  let total: number | undefined;
  let expression: string | undefined;
  let roll: number | undefined;
  let saveDc: number | undefined;
  let resourceSpent = spend.amount > 0;
  let actionName = action.name;

  if (options.spellSlug) {
    const spell = findDungeoneerPrecautionSpell(
      catalog.precautionSpells,
      options.spellSlug,
    );
    if (!spell) {
      throw new BadRequestException(
        `Magia de precaução desconhecida: ${options.spellSlug}`,
      );
    }
    actionName = spell.name;
    note = `Precauções na Masmorra: conjure ${spell.name} sem gastar espaço de magia; escolha INT, SAB ou CAR como atributo de conjuração.`;
  } else if (actionSlug === 'dungeon-precaution') {
    throw new BadRequestException('spellSlug é obrigatório');
  }

  const bands = featureSchedulesFromCatalog(
    {
      featureSchedulesByClassSlug:
        catalog.featureSchedulesByClassSlug ?? new Map(),
      featureSchedulesBySubclassSlug:
        catalog.featureSchedulesBySubclassSlug ?? new Map(),
    },
    character.classSlug,
    character.subclassSlug,
  );
  const rageBonus = rageDamageBonus(character.level, bands);
  const strMod = abilityModifier(character.abilityScores?.forca ?? 10);
  const intMod = abilityModifier(character.abilityScores?.inteligencia ?? 10);
  const castingMod = spellcastingAbilityModifier(character.abilityScores);
  const scheduleDieFaces = isBardClass(character.classSlug)
    ? scheduleIntAtLevel(
        bands,
        FEATURE_SCHEDULE_KEYS.bardicInspirationDieFaces,
        character.level,
        6,
      )
    : isMonkClass(character.classSlug)
      ? scheduleIntAtLevel(
          bands,
          FEATURE_SCHEDULE_KEYS.martialArtsDieFaces,
          character.level,
          6,
        )
      : (psiEnergyDieFaces(character.level, bands) ?? undefined);
  const pactSlotLevel = isWarlockClass(character.classSlug)
    ? warlockPactSlotLevel(character.level, bands)
    : undefined;
  const pactSlotsRecoveryCount = isWarlockClass(character.classSlug)
    ? magicalCunningSlotRecoveryCount(character.level, bands)
    : undefined;

  const toggleEffects = applicable.filter((e) => e.kind === 'toggle_combat_flag');
  const otherEffects = applicable.filter((e) => e.kind !== 'toggle_combat_flag');

  let toggleEntered: boolean | null = null;

  for (const effect of toggleEffects) {
    const applied = await applyOneEffect({
      deps,
      character,
      action,
      actionSlug,
      effect,
      state,
      note,
      total,
      expression,
      roll,
      saveDc,
      resourceSpent,
      options,
      rageBonus,
      strMod,
      intMod,
      castingMod,
      scheduleDieFaces,
      pactSlotLevel,
      pactSlotsRecoveryCount,
      rageActive: Boolean(state.rageActive),
    });
    state = applied.state;
    note = applied.note;
    total = applied.total;
    expression = applied.expression;
    roll = applied.roll;
    saveDc = applied.saveDc;
    resourceSpent = applied.resourceSpent;
    if (applied.toggleEntered != null) toggleEntered = applied.toggleEntered;
  }

  for (const effect of otherEffects) {
    if (
      toggleEntered === false &&
      (effect.kind === 'temp_hp' || effect.kind === 'table_note')
    ) {
      continue;
    }
    const applied = await applyOneEffect({
      deps,
      character,
      action,
      actionSlug,
      effect,
      state,
      note,
      total,
      expression,
      roll,
      saveDc,
      resourceSpent,
      options,
      rageBonus,
      strMod,
      intMod,
      castingMod,
      scheduleDieFaces,
      pactSlotLevel,
      pactSlotsRecoveryCount,
      rageActive: Boolean(state.rageActive),
    });
    state = applied.state;
    note = applied.note;
    total = applied.total;
    expression = applied.expression;
    roll = applied.roll;
    saveDc = applied.saveDc;
    resourceSpent = applied.resourceSpent;
  }

  return {
    state,
    actionName,
    resourceSpent,
    note,
    ...(total != null ? { total } : {}),
    ...(expression != null ? { expression } : {}),
    ...(roll != null ? { roll } : {}),
    ...(saveDc != null ? { saveDc } : {}),
  };
}

type ApplyCtx = {
  deps: DeclaredEconomyTableActionDeps;
  character: PlayerCharacter;
  action: ClassEconomyActionRecord;
  actionSlug: string;
  effect: CatalogEffect;
  state: TableActionResponseDto['state'];
  note: string;
  total?: number;
  expression?: string;
  roll?: number;
  saveDc?: number;
  resourceSpent: boolean;
  options: DeclaredEconomyTableActionOptions;
  rageBonus: number;
  strMod: number;
  intMod: number;
  castingMod: number;
  scheduleDieFaces?: number;
  pactSlotLevel?: number;
  pactSlotsRecoveryCount?: number;
  rageActive: boolean;
};

async function applyOneEffect(ctx: ApplyCtx): Promise<{
  state: TableActionResponseDto['state'];
  note: string;
  total?: number;
  expression?: string;
  roll?: number;
  saveDc?: number;
  resourceSpent: boolean;
  toggleEntered?: boolean | null;
}> {
  const {
    deps,
    character,
    action,
    actionSlug,
    effect,
    options,
    rageBonus,
    strMod,
    intMod,
    castingMod,
    scheduleDieFaces,
    pactSlotLevel,
    pactSlotsRecoveryCount,
    rageActive,
  } = ctx;
  let { state, note, total, expression, roll, saveDc, resourceSpent } = ctx;

  if (
    effect.requiresOptionKey === 'equipped_persona_mask' &&
    effect.requiresOptionValue
  ) {
    state = await deps.state.buildResponse(character);
    const equipped = state.personaMasks ?? [];
    if (!equipped.includes(effect.requiresOptionValue)) {
      throw new BadRequestException(
        `Vista a máscara requerida (${effect.requiresOptionValue}) antes de usar este efeito`,
      );
    }
  }

  const needsIntFlat =
    effect.numeric?.amountFormula === 'schedule_die_plus_flat' &&
    !isBardClass(character.classSlug);
  const usesScheduleDieFormula =
    effect.numeric?.amountFormula === 'schedule_die_plus_flat' ||
    effect.numeric?.amountFormula === 'schedule_die_double_plus_flat';
  const wardIntFlat =
    isWizardClass(character.classSlug) &&
    actionSlug === 'arcane-ward' &&
    effect.kind === 'temp_hp';
  const needsCastingFlat =
    !needsIntFlat &&
    !usesScheduleDieFormula &&
    !wardIntFlat &&
    (effect.kind === 'feature_dc' ||
      effect.kind === 'heal' ||
      effect.kind === 'temp_hp' ||
      effect.kind === 'table_roll' ||
      (effect.kind === 'table_note' &&
        effect.numeric?.amountFormula === 'ability_mod') ||
      effect.numeric?.amountFormula === 'ability_mod' ||
      effect.numeric?.amountFormula === 'ability_mod_d8' ||
      effect.numeric?.amountFormula === 'dice_divine_spark_plus_flat' ||
      effect.numeric?.amountFormula === 'dice_2d6_plus_flat' ||
      effect.numeric?.amountFormula === 'eight_plus_mod_plus_pb');
  const needsStrFlat =
    !needsIntFlat &&
    !needsCastingFlat &&
    character.classSlug === 'barbarian' &&
    (effect.numeric?.amountFormula === 'ability_mod' ||
      effect.numeric?.amountFormula === 'eight_plus_mod_plus_pb');
  const needsDexFlat =
    !needsIntFlat &&
    !needsCastingFlat &&
    !needsStrFlat &&
    isBardClass(character.classSlug) &&
    actionSlug === 'unarmed-dance' &&
    effect.numeric?.amountFormula === 'schedule_die_plus_flat';
  const dexMod = abilityModifier(character.abilityScores?.destreza ?? 10);
  const needsMonkDexFlat =
    isMonkClass(character.classSlug) &&
    actionSlug === 'guard-breaker' &&
    effect.numeric?.amountFormula === 'ability_mod';
  const needsScheduleCastingFlat =
    usesScheduleDieFormula &&
    (effect.kind === 'heal' ||
      effect.kind === 'table_roll' ||
      effect.kind === 'temp_hp');

  const executed = executeCatalogEffect(effect, {
    level: character.level,
    rageBonus,
    rageActive,
    diceCount: options.diceCount,
    scheduleDieFaces,
    pactSlotLevel,
    pactSlotsRecoveryCount,
    ...(needsScheduleCastingFlat
      ? { flatOverride: castingMod }
      : needsIntFlat || wardIntFlat
      ? { flatOverride: wardIntFlat ? Math.max(1, intMod) : intMod }
      : needsCastingFlat
          ? {
              flatOverride:
                character.classSlug === 'barbarian' ? strMod : castingMod,
            }
          : needsStrFlat
            ? { flatOverride: strMod }
            : needsDexFlat || needsMonkDexFlat
              ? { flatOverride: dexMod }
              : {}),
  });

  let toggleEntered: boolean | null | undefined;

  if (executed.kind === 'toggle_combat_flag') {
    const before = state;
    if (executed.flag === 'rage') {
      const entering = executed.forceEnter ? true : !before.rageActive;
      state = await deps.state.martial.toggleRage(
        character,
        entering,
        entering ? executed.spendOnEnter : false,
      );
      toggleEntered = entering;
      resourceSpent = resourceSpent || (entering && executed.spendOnEnter);
      if (!entering) {
        note = executed.note?.trim() || 'Fúria encerrada.';
      } else {
        note =
          executed.note?.trim() ||
          `Fúria ativa (+${rageBonus} dano FOR; Resistência Contundente/Cortante/Perfurante).${executed.spendOnEnter ? ' Gasta 1 uso.' : ''}`;
        if (character.subclassSlug === 'wild-heart' && character.level >= 3) {
          note +=
            ' Coração Selvagem: escolha Águia, Lobo ou Urso nesta ativação (mesa).';
        }
        if (character.subclassSlug === 'wild-heart' && character.level >= 14) {
          note += ' Também escolha Carneiro, Falcão ou Leão.';
        }
        if (character.level >= 7) {
          note += ' Bote Instintivo: mova até metade do Deslocamento.';
        }
      }
    } else {
      const next = !before.recklessActive;
      state = await deps.state.martial.toggleReckless(character, next);
      toggleEntered = next;
      note =
        executed.note?.trim() ||
        (next
          ? 'Ataque Imprudente ativo: Vantagem em ataques com Força; ataques contra você têm Vantagem.'
          : 'Ataque Imprudente encerrado.');
    }
  } else if (
    effect.kind === 'heal' &&
    (executed.kind === 'heal' || options.amount != null)
  ) {
    const healAmount =
      options.amount ??
      (executed.kind === 'heal' ? executed.amount : 0);
    const healed = await applyHealHitPoints(deps.state, character, healAmount);
    state = healed.state;
    total = healAmount;
    expression =
      options.amount != null
        ? String(healAmount)
        : executed.kind === 'heal'
          ? executed.expression
          : String(healAmount);
    const healNote =
      executed.kind === 'heal' ? executed.note : effect.note?.note ?? null;
    const effectNote = healNote
      ?.replace(/\{total\}/g, String(healAmount))
      .replace(
        /\{expression\}/g,
        expression ?? String(healAmount),
      );
    note = [
      note,
      effectNote,
      `Cura: ${expression ?? healAmount} → +${healed.healed} PV.`,
    ]
      .filter(Boolean)
      .join(' ');
  } else if (executed.kind === 'survive_at_zero') {
    state = await deps.state.patch(character, {
      deathSaveSuccesses: 0,
      deathSaveFailures: 0,
    });
    total = executed.amount;
    note =
      executed.note?.trim() ||
      `Sentinela Imortal: defina seus PV atuais em ${executed.amount} (1 + 3 × nível, teto = PV máximos) e limpe salvaguardas contra morte.`;
    note = note.replace(/\{total\}/g, String(executed.amount));
  } else if (executed.kind === 'temp_hp') {
    state = await applyTemporaryHitPoints(
      deps.state,
      character,
      executed.amount,
    );
    total = executed.amount;
    expression = executed.expression;
    note = [
      note,
      executed.note?.trim(),
      `PV temporários aplicados: ${executed.amount}.`,
    ]
      .filter(Boolean)
      .join(' ');
  } else if (executed.kind === 'recover_resource' && executed.resourceSlug) {
    state = await deps.state.recoverClassResource(
      character,
      executed.resourceSlug,
      executed.amount,
    );
    total = executed.amount;
    note = executed.note?.trim()
      ? `${note} ${executed.note.trim()}`
      : `${note} Recuperados ${executed.amount} uso(s) de ${executed.resourceSlug}.`;
  } else if (
    executed.kind === 'recover_resource_to_max' &&
    executed.resourceSlug
  ) {
    if (executed.resourceSlug === 'rage') {
      state = await deps.state.martial.recoverAllRage(character);
    } else {
      const pool = state.classResources?.find(
        (r) => r.slug === executed.resourceSlug,
      );
      const missing = pool ? Math.max(0, pool.max - pool.remaining) : 0;
      if (missing > 0) {
        state = await deps.state.recoverClassResource(
          character,
          executed.resourceSlug,
          missing,
        );
      } else {
        state = await deps.state.buildResponse(character);
      }
    }
    note =
      executed.note?.trim() ||
      `Recuperou todos os usos de ${executed.resourceSlug}.`;
  } else if (executed.kind === 'feature_dc') {
    saveDc = executed.saveDc;
    if (executed.note?.trim()) note = `${note} ${executed.note.trim()}`;
    else note = `${note} CD ${executed.saveDc}.`;
  } else if (executed.kind === 'table_roll') {
    total = executed.amount;
    expression = executed.expression;
    roll = executed.amount;
    if (executed.note?.trim()) {
      note = executed.note
        .replace(/\{total\}/g, String(executed.amount))
        .replace(/\{expression\}/g, executed.expression)
        .replace(/\{saveDc\}/g, saveDc != null ? String(saveDc) : '—');
    }
    if (actionSlug === 'feral-howl') {
      state = await deps.state.martial.setBestialAspectLevel(
        character,
        executed.amount,
      );
      note = `Uivo Feral: 1d4 = ${executed.amount}. Aspecto Bestial definido em ${executed.amount}.`;
    }
  } else if (executed.kind === 'start_concentration' && executed.spellSlug) {
    state = await deps.state.patch(character, {
      concentratingOn: executed.spellSlug,
    });
    if (executed.note?.trim()) {
      note = executed.note.trim();
    }
  } else if (
    executed.kind === 'spend_resource' &&
    executed.resourceSlug &&
    executed.amount > 0
  ) {
    state = (
      await deps.state.useClassResource(
        character,
        executed.resourceSlug,
        executed.amount,
      )
    ).state;
    resourceSpent = true;
  } else if (executed.kind === 'heal_from_dice_pool') {
    if (!executed.resourceSlug) {
      throw new BadRequestException('heal_from_dice_pool exige resource_slug');
    }
    state = (
      await deps.state.useClassResource(
        character,
        executed.resourceSlug,
        executed.diceCount,
      )
    ).state;
    resourceSpent = true;
    total = executed.amount;
    expression = executed.expression;
    note =
      executed.note?.trim() ||
      `Campeão dos Deuses: Ação Bônus — recupere ${executed.amount} PV (${executed.expression}). Aplique na ficha.`;
    note = note
      .replace(/\{total\}/g, String(executed.amount))
      .replace(/\{expression\}/g, executed.expression);
    if (executed.resourceSlug === 'healing-light') {
      const healed = await applyHealHitPoints(
        deps.state,
        character,
        executed.amount,
      );
      state = healed.state;
      note = `${note} (+${healed.healed} na ficha — ajuste se for aliado).`;
    }
  } else if (executed.kind === 'recover_spell_slot') {
    for (let i = 0; i < executed.count; i += 1) {
      await deps.state.recoverSpellSlotLevel(character, executed.slotLevel);
    }
    state = await deps.state.buildResponse(character);
    total = executed.count;
    note =
      executed.note?.trim()?.replace(/\{total\}/g, String(executed.count)) ??
      `${note} Recuperou ${executed.count} slot(s) de ${executed.slotLevel}º círculo.`;
  } else if (executed.kind === 'sync_companion') {
    if (!deps.companion || !options.userId) {
      throw new BadRequestException('Companheiro indisponível nesta ação');
    }
    if (!character.subclassSlug) {
      throw new BadRequestException('Companheiro exige subclasse');
    }
    const companionDeps: CompanionTableActionDeps = {
      state: deps.state,
      dataSource: deps.companion.dataSource,
      syncCompanion: deps.companion.syncCompanion,
    };
    const result = await applyCompanionSummon(
      companionDeps,
      options.userId,
      character,
      character.subclassSlug,
      character.subclassSlug,
      action.name,
      executed.restoreHp,
    );
    state = result.state;
    note = result.note;
  } else if (executed.kind === 'companion_command') {
    if (!deps.companion) {
      throw new BadRequestException('Companheiro indisponível nesta ação');
    }
    if (!character.subclassSlug) {
      throw new BadRequestException('Companheiro exige subclasse');
    }
    const companionDeps: CompanionTableActionDeps = {
      state: deps.state,
      dataSource: deps.companion.dataSource,
      syncCompanion: deps.companion.syncCompanion,
    };
    const result = await applyCompanionCommand(
      companionDeps,
      character,
      character.subclassSlug,
      character.subclassSlug,
      action.name,
      options.companionCommand,
    );
    state = result.state;
    note = result.note;
  } else if (executed.kind === 'table_note' && executed.note) {
    if (executed.amount != null) {
      total = executed.amount;
      expression = executed.expression;
    }
    note = `${note} ${executed.note}`
      .replace(/\{total\}/g, total != null ? String(total) : '—')
      .replace(
        /\{expression\}/g,
        expression != null ? String(expression) : '—',
      )
      .replace(/\{saveDc\}/g, saveDc != null ? String(saveDc) : '—');
  } else if (executed.kind === 'grant_inspiration') {
    state = await deps.state.patch(character, { inspiration: true });
    if (executed.note) note = `${note} ${executed.note}`;
  }

  return {
    state,
    note,
    total,
    expression,
    roll,
    saveDc,
    resourceSpent,
    toggleEntered,
  };
}

function findDeclaredEconomyAction(
  economyActions: ClassEconomyActionRecord[],
  classSlug: string | null,
  actionSlug: string,
): ClassEconomyActionRecord | undefined {
  if (!classSlug) return undefined;
  return economyActions.find(
    (row) =>
      row.classSlug === classSlug &&
      row.tableAction === actionSlug &&
      row.itemSlug == null &&
      row.featSlug == null &&
      row.speciesSlug == null,
  );
}

function isTableActionEffectApplicable(
  effect: CatalogEffect,
  character: PlayerCharacter,
): boolean {
  if (effect.unlockLevel > character.level) return false;
  if (effect.ownerKind === 'subclass') {
    return (
      effect.ownerSlug != null &&
      effect.ownerSlug === character.subclassSlug
    );
  }
  return true;
}

function resolveSpendPlan(
  action: ClassEconomyActionRecord,
  options: DeclaredEconomyTableActionOptions,
): SpendPlan {
  if (options.amount != null && action.resourceSlug) {
    return { resourceSlug: action.resourceSlug, amount: options.amount };
  }
  const amount = action.spendAmount ?? 1;
  if (action.alwaysSpendsResource && action.resourceSlug) {
    return { resourceSlug: action.resourceSlug, amount };
  }
  if (action.freeResourceSlug) {
    if (options.usePsiDie) {
      if (!action.resourceSlug) {
        throw new BadRequestException(
          `${action.name}: pool pago indisponível`,
        );
      }
      return { resourceSlug: action.resourceSlug, amount };
    }
    return { resourceSlug: action.freeResourceSlug, amount: 1 };
  }
  return { resourceSlug: null, amount: 0 };
}
