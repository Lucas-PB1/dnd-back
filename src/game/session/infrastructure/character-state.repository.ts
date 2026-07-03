import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { VClassSpellSlots } from '../../../entities/views/v-class-spell-slots.entity';
import { VPhbSpell } from '../../../entities/views/v-phb-spell.entity';
import { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { CharacterSpellLookup } from '../../sheet/application/character-spell-lookup';
import { PhbCondition } from './phb-condition.entity';
import {
  PlayerCharacterState,
  SpellSlotsUsed,
} from './player-character-state.entity';
import {
  CastSpellDto,
  CharacterStateResponseDto,
  PatchCharacterStateDto,
} from '../dto/character-state.dto';

@Injectable()
export class CharacterStateRepository {
  constructor(
    @InjectRepository(PlayerCharacterState)
    private readonly state: Repository<PlayerCharacterState>,
    @InjectRepository(VClassSpellSlots)
    private readonly classSlots: Repository<VClassSpellSlots>,
    @InjectRepository(VPhbSpell)
    private readonly spells: Repository<VPhbSpell>,
    @InjectRepository(PhbCondition)
    private readonly conditions: Repository<PhbCondition>,
    private readonly characters: CharacterRepository,
    private readonly spellLookup: CharacterSpellLookup,
  ) {}

  async findOrCreate(characterId: string): Promise<PlayerCharacterState> {
    let row = await this.state.findOne({ where: { characterId } });
    if (!row) {
      row = this.state.create({
        characterId,
        spellSlotsUsed: {},
        conditions: [],
        tempHp: 0,
        concentratingOn: null,
      });
      await this.state.save(row);
    }
    return row;
  }

  async buildResponse(
    character: PlayerCharacter,
    stateRow?: PlayerCharacterState,
  ): Promise<CharacterStateResponseDto> {
    const state = stateRow ?? (await this.findOrCreate(character.id));
    const spellSlotsMax = await this.loadMaxSlots(character.classSlug, character.level);
    const spellSlotsUsed = state.spellSlotsUsed ?? {};
    const spellSlotsRemaining = this.computeRemaining(spellSlotsMax, spellSlotsUsed);

    return {
      spellSlotsMax,
      spellSlotsUsed,
      spellSlotsRemaining,
      concentratingOn: state.concentratingOn,
      conditions: state.conditions ?? [],
      tempHp: state.tempHp,
      hitPointsCurrent: character.hitPointsCurrent,
      hitPointsMax: character.hitPointsMax,
    };
  }

  async patch(
    character: PlayerCharacter,
    dto: PatchCharacterStateDto,
  ): Promise<CharacterStateResponseDto> {
    const state = await this.findOrCreate(character.id);

    if (dto.conditions !== undefined) {
      await this.assertValidConditions(dto.conditions);
      state.conditions = dto.conditions;
    }

    if (dto.tempHp !== undefined) {
      state.tempHp = dto.tempHp;
    }

    if (dto.concentratingOn !== undefined) {
      if (dto.concentratingOn !== null) {
        const spell = await this.spells.findOne({ where: { slug: dto.concentratingOn } });
        if (!spell) {
          throw new BadRequestException(`Spell '${dto.concentratingOn}' not found in catalog`);
        }
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

    const spell = await this.spells.findOne({ where: { slug: dto.spellSlug } });
    if (!spell) {
      throw new NotFoundException(`Spell '${dto.spellSlug}' not found in catalog`);
    }

    const state = await this.findOrCreate(character.id);
    let slotLevelUsed: number | null = null;

    if (spell.level > 0) {
      const slotLevel = dto.slotLevel ?? spell.level;
      if (slotLevel < spell.level) {
        throw new BadRequestException(
          `Slot level ${slotLevel} is below spell level ${spell.level}`,
        );
      }

      const maxSlots = await this.loadMaxSlots(character.classSlug, character.level);
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

  async applyLongRest(character: PlayerCharacter): Promise<CharacterStateResponseDto> {
    const state = await this.findOrCreate(character.id);
    state.spellSlotsUsed = {};
    state.concentratingOn = null;
    state.conditions = [];
    state.tempHp = 0;
    await this.state.save(state);

    if (character.hitPointsMax !== null) {
      character.hitPointsCurrent = character.hitPointsMax;
      await this.characters.save(character);
    }

    return this.buildResponse(character, state);
  }

  async applyShortRest(character: PlayerCharacter): Promise<CharacterStateResponseDto> {
    const state = await this.findOrCreate(character.id);
    return this.buildResponse(character, state);
  }

  private async loadMaxSlots(classSlug: string, level: number): Promise<Record<string, number>> {
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
