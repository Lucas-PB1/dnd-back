import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, In, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { VClassSpellSlots } from '../../../entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '../../../entities/views/v-subclass-spell-slots.entity';
import { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { CharacterSpellLookup } from '../../sheet/application/character-spell-lookup';
import { computeAbilityModifiers } from '../../sheet/domain/character-derived-stats';
import { PhbCondition } from './phb-condition.entity';
import {
  PlayerCharacterState,
  SpellSlotsUsed,
} from './player-character-state.entity';
import {
  CastSpellDto,
  CharacterStateResponseDto,
  ClassResourceStateDto,
  PatchCharacterStateDto,
  RestResponseDto,
} from '../dto/character-state.dto';
import {
  grantHitDiceOnLevelUp,
  restoreHitDiceOnLongRest,
  spendHitDice,
} from '../domain/hit-dice-rest';
import {
  applyLongRestResourceRecovery,
  applyResourceSpend,
  applyShortRestResourceRecovery,
  resolveClassResourceMaxima,
  type ClassResourceMax,
  type ClassResourceScheduleRow,
} from '../domain/class-resources';
import { riskDieFaces, riskDieLabel } from '../domain/risk-die';

type ClassResourceDbRow = {
  resource_slug: string;
  resource_name: string;
  unlock_level: number;
  max_formula: string;
  fixed_max: number | null;
  recover_one_on_short: boolean;
  recover_all_on_short: boolean;
  recover_all_on_long: boolean;
};

@Injectable()
export class CharacterStateRepository {
  constructor(
    @InjectRepository(PlayerCharacterState)
    private readonly state: Repository<PlayerCharacterState>,
    @InjectRepository(VClassSpellSlots)
    private readonly classSlots: Repository<VClassSpellSlots>,
    @InjectRepository(VSubclassSpellSlots)
    private readonly subclassSlots: Repository<VSubclassSpellSlots>,
    @InjectRepository(PhbCondition)
    private readonly conditions: Repository<PhbCondition>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly characters: CharacterRepository,
    private readonly spellLookup: CharacterSpellLookup,
    private readonly dataSource: DataSource,
  ) {}

  async findOrCreate(
    characterId: string,
    level = 1,
  ): Promise<PlayerCharacterState> {
    let row = await this.state.findOne({ where: { characterId } });
    if (!row) {
      row = this.state.create({
        characterId,
        spellSlotsUsed: {},
        resourcesUsed: {},
        conditions: [],
        tempHp: 0,
        concentratingOn: null,
        hitDiceCurrent: level,
      });
      await this.state.save(row);
    }
    if (!row.resourcesUsed) {
      row.resourcesUsed = {};
    }
    return row;
  }

  async buildResponse(
    character: PlayerCharacter,
    stateRow?: PlayerCharacterState,
  ): Promise<CharacterStateResponseDto> {
    const state = stateRow ?? (await this.findOrCreate(character.id, character.level));
    await this.clampHitDiceToLevel(state, character.level);
    const spellSlotsMax = await this.loadMaxSlots(
      character.classSlug,
      character.level,
      character.subclassSlug,
    );
    const spellSlotsUsed = state.spellSlotsUsed ?? {};
    const spellSlotsRemaining = this.computeRemaining(spellSlotsMax, spellSlotsUsed);
    const phbClass = await this.catalogLookup.findClassOrFail(character.classSlug);
    const classResources = await this.buildClassResourceState(character, state);

    return {
      spellSlotsMax,
      spellSlotsUsed,
      spellSlotsRemaining,
      classResources,
      concentratingOn: state.concentratingOn,
      conditions: state.conditions ?? [],
      tempHp: state.tempHp,
      hitPointsCurrent: character.hitPointsCurrent,
      hitPointsMax: character.hitPointsMax,
      hitDiceCurrent: state.hitDiceCurrent,
      hitDiceMax: character.level,
      hitDie: phbClass.hitDie,
    };
  }

  async patch(
    character: PlayerCharacter,
    dto: PatchCharacterStateDto,
  ): Promise<CharacterStateResponseDto> {
    const state = await this.findOrCreate(character.id, character.level);

    if (dto.conditions !== undefined) {
      await this.assertValidConditions(dto.conditions);
      state.conditions = dto.conditions;
    }

    if (dto.tempHp !== undefined) {
      state.tempHp = dto.tempHp;
    }

    if (dto.concentratingOn !== undefined) {
      if (dto.concentratingOn !== null) {
        const spell = await this.catalogLookup.assertSpellInCatalog(dto.concentratingOn);
        if (!spell.concentration) {
          throw new BadRequestException(`Spell '${dto.concentratingOn}' is not a concentration spell`);
        }
      }
      state.concentratingOn = dto.concentratingOn;
    }

    await this.state.save(state);
    return this.buildResponse(character, state);
  }

  async castSpell(
    character: PlayerCharacter,
    dto: CastSpellDto,
  ): Promise<{ slotLevelUsed: number | null; state: CharacterStateResponseDto }> {
    const knowsSpell = await this.spellLookup.hasSpell(character.id, dto.spellSlug);
    if (!knowsSpell) {
      throw new BadRequestException(`Spell '${dto.spellSlug}' is not on this character's list`);
    }

    const spell = await this.catalogLookup.findSpellOrFail(dto.spellSlug);

    const state = await this.findOrCreate(character.id, character.level);
    let slotLevelUsed: number | null = null;

    if (spell.level > 0) {
      const slotLevel = dto.slotLevel ?? spell.level;
      if (slotLevel < spell.level) {
        throw new BadRequestException(
          `Slot level ${slotLevel} is below spell level ${spell.level}`,
        );
      }

      const maxSlots = await this.loadMaxSlots(
        character.classSlug,
        character.level,
        character.subclassSlug,
      );
      const key = String(slotLevel);
      const max = maxSlots[key] ?? 0;
      const used = state.spellSlotsUsed[key] ?? 0;

      if (max <= 0) {
        throw new BadRequestException(`No level-${slotLevel} spell slots available for this class`);
      }
      if (used >= max) {
        throw new BadRequestException(`No remaining level-${slotLevel} spell slots`);
      }

      state.spellSlotsUsed = {
        ...state.spellSlotsUsed,
        [key]: used + 1,
      };
      slotLevelUsed = slotLevel;
    }

    if (spell.concentration) {
      state.concentratingOn = dto.spellSlug;
    }

    await this.state.save(state);
    return {
      slotLevelUsed,
      state: await this.buildResponse(character, state),
    };
  }

  async useClassResource(
    character: PlayerCharacter,
    resourceSlug: string,
    amount = 1,
  ): Promise<CharacterStateResponseDto> {
    const state = await this.findOrCreate(character.id, character.level);
    const resources = await this.resolveClassResources(character);
    const resource = resources.find((item) => item.slug === resourceSlug);
    if (!resource) {
      throw new BadRequestException(
        `Resource '${resourceSlug}' is not available for this character`,
      );
    }

    try {
      state.resourcesUsed = applyResourceSpend(
        state.resourcesUsed ?? {},
        resourceSlug,
        resource.max,
        amount,
      );
    } catch (error) {
      throw new BadRequestException(
        error instanceof Error ? error.message : 'Cannot spend resource',
      );
    }

    await this.state.save(state);
    return this.buildResponse(character, state);
  }

  async applyLongRest(character: PlayerCharacter): Promise<RestResponseDto> {
    const state = await this.findOrCreate(character.id, character.level);
    const resources = await this.resolveClassResources(character);
    state.spellSlotsUsed = {};
    state.resourcesUsed = applyLongRestResourceRecovery(
      state.resourcesUsed ?? {},
      resources,
    );
    state.concentratingOn = null;
    state.conditions = [];
    state.tempHp = 0;
    state.hitDiceCurrent = restoreHitDiceOnLongRest(
      state.hitDiceCurrent,
      character.level,
    );
    await this.state.save(state);

    if (character.hitPointsMax !== null) {
      character.hitPointsCurrent = character.hitPointsMax;
      await this.characters.save(character);
    }

    return {
      type: 'long',
      state: await this.buildResponse(character, state),
    };
  }

  async applyShortRest(
    character: PlayerCharacter,
    hitDiceSpent = 0,
  ): Promise<RestResponseDto> {
    const state = await this.findOrCreate(character.id, character.level);
    await this.clampHitDiceToLevel(state, character.level);

    const resources = await this.resolveClassResources(character);
    state.resourcesUsed = applyShortRestResourceRecovery(
      state.resourcesUsed ?? {},
      resources,
    );

    if (hitDiceSpent === 0) {
      await this.state.save(state);
      return {
        type: 'short',
        state: await this.buildResponse(character, state),
        hitDiceSpent: 0,
        hitDiceRolls: [],
        hitPointsHealed: 0,
      };
    }

    if (character.hitPointsMax === null || character.hitPointsCurrent === null) {
      throw new BadRequestException('Character hit points are not set');
    }

    const phbClass = await this.catalogLookup.findClassOrFail(character.classSlug);
    const mods = computeAbilityModifiers(character.abilityScores);

    let spendResult;
    try {
      spendResult = spendHitDice({
        hitDiceCurrent: state.hitDiceCurrent,
        hitDiceMax: character.level,
        hitDiceSpent,
        hitDieLabel: phbClass.hitDie,
        constitutionModifier: mods.constituicao,
        hitPointsCurrent: character.hitPointsCurrent,
        hitPointsMax: character.hitPointsMax,
      });
    } catch (error) {
      throw new BadRequestException(
        error instanceof Error ? error.message : 'Invalid hit dice spend',
      );
    }

    state.hitDiceCurrent = spendResult.hitDiceRemaining;
    character.hitPointsCurrent = spendResult.hitPointsCurrent;
    await this.state.save(state);
    await this.characters.save(character);

    return {
      type: 'short',
      state: await this.buildResponse(character, state),
      hitDiceSpent: spendResult.hitDiceSpent,
      hitDiceRolls: spendResult.rolls,
      hitPointsHealed: spendResult.hitPointsHealed,
    };
  }

  async syncHitDiceOnLevelChange(
    characterId: string,
    previousLevel: number,
    newLevel: number,
  ): Promise<void> {
    const state = await this.findOrCreate(characterId, previousLevel);
    state.hitDiceCurrent = grantHitDiceOnLevelUp(
      state.hitDiceCurrent,
      previousLevel,
      newLevel,
    );
    await this.state.save(state);
  }

  private async buildClassResourceState(
    character: PlayerCharacter,
    state: PlayerCharacterState,
  ): Promise<ClassResourceStateDto[]> {
    const resources = await this.resolveClassResources(character);
    const used = state.resourcesUsed ?? {};
    return resources.map((resource) => {
      const spent = used[resource.slug] ?? 0;
      const isRisk = resource.slug === 'risk';
      return {
        slug: resource.slug,
        name: resource.name,
        max: resource.max,
        used: spent,
        remaining: Math.max(0, resource.max - spent),
        ...(isRisk
          ? {
              dieFaces: riskDieFaces(character.level),
              dieLabel: riskDieLabel(character.level),
            }
          : {}),
      };
    });
  }

  private async resolveClassResources(
    character: PlayerCharacter,
  ): Promise<ClassResourceMax[]> {
    const rows = await this.loadClassResourceSchedule(character.classSlug);
    const progression = await this.loadClassProgressionSnapshot(
      character.classSlug,
      character.level,
    );
    const mods = computeAbilityModifiers(character.abilityScores);

    return resolveClassResourceMaxima({
      rows,
      level: character.level,
      proficiencyBonus: progression?.proficiencyBonus ?? 2,
      abilityModifiers: mods,
      channelDivinityFromProgression: progression?.channelDivinity ?? null,
    });
  }

  private async loadClassProgressionSnapshot(
    classSlug: string,
    level: number,
  ): Promise<{
    proficiencyBonus: number;
    channelDivinity: number | null;
  } | null> {
    const rows = await this.dataSource.query<
      { proficiency_bonus: number; channel_divinity: number | null }[]
    >(
      `SELECT proficiency_bonus, channel_divinity
       FROM rpg.v_phb_class_progression
       WHERE class_slug = $1 AND level = $2
       LIMIT 1`,
      [classSlug, level],
    );
    const row = rows[0];
    if (!row) return null;
    return {
      proficiencyBonus: row.proficiency_bonus,
      channelDivinity: row.channel_divinity,
    };
  }

  private async loadClassResourceSchedule(
    classSlug: string,
  ): Promise<ClassResourceScheduleRow[]> {
    const rows = await this.dataSource.query<ClassResourceDbRow[]>(
      `SELECT
         rd.slug AS resource_slug,
         rd.name AS resource_name,
         cr.unlock_level,
         cr.max_formula::text AS max_formula,
         cr.fixed_max,
         cr.recover_one_on_short,
         cr.recover_all_on_short,
         cr.recover_all_on_long
       FROM rpg.phb_class_resource cr
       JOIN rpg.phb_class c ON c.id = cr.class_id
       JOIN rpg.phb_resource_definition rd ON rd.id = cr.resource_id
       WHERE c.slug = $1
       ORDER BY rd.slug, cr.unlock_level`,
      [classSlug],
    );

    return rows.map((row) => ({
      resourceSlug: row.resource_slug,
      resourceName: row.resource_name,
      unlockLevel: row.unlock_level,
      maxFormula: row.max_formula,
      fixedMax: row.fixed_max,
      recoverOneOnShort: row.recover_one_on_short,
      recoverAllOnShort: row.recover_all_on_short,
      recoverAllOnLong: row.recover_all_on_long,
    }));
  }

  private async clampHitDiceToLevel(
    state: PlayerCharacterState,
    level: number,
  ): Promise<void> {
    if (state.hitDiceCurrent > level) {
      state.hitDiceCurrent = level;
      await this.state.save(state);
    }
  }

  private async loadMaxSlots(
    classSlug: string,
    level: number,
    subclassSlug?: string | null,
  ): Promise<Record<string, number>> {
    if (subclassSlug) {
      const subclassRow = await this.subclassSlots.findOne({
        where: { subclassSlug, classLevel: level },
      });
      if (subclassRow?.spellSlots) {
        return subclassRow.spellSlots;
      }
    }
    const row = await this.classSlots.findOne({
      where: { classSlug, classLevel: level },
    });
    return row?.spellSlots ?? {};
  }

  private computeRemaining(
    max: Record<string, number>,
    used: SpellSlotsUsed,
  ): Record<string, number> {
    const remaining: Record<string, number> = {};
    for (const [level, total] of Object.entries(max)) {
      remaining[level] = Math.max(0, total - (used[level] ?? 0));
    }
    return remaining;
  }

  private async assertValidConditions(slugs: string[]): Promise<void> {
    if (slugs.length === 0) return;
    const rows = await this.conditions.find({ where: { slug: In(slugs) } });
    const found = new Set(rows.map((r) => r.slug));
    const invalid = slugs.filter((s) => !found.has(s));
    if (invalid.length > 0) {
      throw new BadRequestException(`Unknown conditions: ${invalid.join(', ')}`);
    }
  }
}
