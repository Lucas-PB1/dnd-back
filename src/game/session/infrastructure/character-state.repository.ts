import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { VClassSpellSlots } from '../../../entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '../../../entities/views/v-subclass-spell-slots.entity';
import { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { CharacterSpellLookup } from '../../sheet/application/character-spell-lookup';
import { PhbCondition } from './phb-condition.entity';
import { PlayerCharacterState } from './player-character-state.entity';
import {
  CastSpellDto,
  CharacterStateResponseDto,
  PatchCharacterStateDto,
  RestResponseDto,
} from '../dto/character-state.dto';
import { grantHitDiceOnLevelUp } from '../domain/hit-dice-rest';
import { applyCastSpell } from './character-state/cast-spell';
import { buildClassResourceState } from './character-state/class-resources';
import { clampHitDiceToLevel } from './character-state/hit-dice';
import {
  applyPatchState,
  applyUseClassResource,
} from './character-state/mutations';
import { applyLongRestState, applyShortRestState } from './character-state/rest';
import { computeRemaining, loadMaxSlots } from './character-state/spell-slots';

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
    await clampHitDiceToLevel(this.state, state, character.level);
    const spellSlotsMax = await loadMaxSlots(
      this.classSlots,
      this.subclassSlots,
      character.classSlug,
      character.level,
      character.subclassSlug,
    );
    const spellSlotsUsed = state.spellSlotsUsed ?? {};
    const phbClass = await this.catalogLookup.findClassOrFail(character.classSlug);
    const classResources = await buildClassResourceState(
      this.dataSource,
      character,
      state,
    );

    return {
      spellSlotsMax,
      spellSlotsUsed,
      spellSlotsRemaining: computeRemaining(spellSlotsMax, spellSlotsUsed),
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
    return applyPatchState({
      character,
      state,
      dto,
      stateRepo: this.state,
      conditions: this.conditions,
      catalogLookup: this.catalogLookup,
      buildResponse: (c, s) => this.buildResponse(c, s),
    });
  }

  async castSpell(
    character: PlayerCharacter,
    dto: CastSpellDto,
  ): Promise<{ slotLevelUsed: number | null; state: CharacterStateResponseDto }> {
    const state = await this.findOrCreate(character.id, character.level);
    return applyCastSpell({
      character,
      state,
      dto,
      stateRepo: this.state,
      classSlots: this.classSlots,
      subclassSlots: this.subclassSlots,
      catalogLookup: this.catalogLookup,
      spellLookup: this.spellLookup,
      buildResponse: (c, s) => this.buildResponse(c, s),
    });
  }

  async useClassResource(
    character: PlayerCharacter,
    resourceSlug: string,
    amount = 1,
  ): Promise<CharacterStateResponseDto> {
    const state = await this.findOrCreate(character.id, character.level);
    return applyUseClassResource({
      character,
      state,
      resourceSlug,
      amount,
      stateRepo: this.state,
      dataSource: this.dataSource,
      buildResponse: (c, s) => this.buildResponse(c, s),
    });
  }

  async applyLongRest(character: PlayerCharacter): Promise<RestResponseDto> {
    const state = await this.findOrCreate(character.id, character.level);
    return applyLongRestState({
      character,
      state,
      stateRepo: this.state,
      characters: this.characters,
      dataSource: this.dataSource,
      buildResponse: (c, s) => this.buildResponse(c, s),
    });
  }

  async applyShortRest(
    character: PlayerCharacter,
    hitDiceSpent = 0,
  ): Promise<RestResponseDto> {
    const state = await this.findOrCreate(character.id, character.level);
    return applyShortRestState({
      character,
      state,
      hitDiceSpent,
      stateRepo: this.state,
      characters: this.characters,
      catalogLookup: this.catalogLookup,
      dataSource: this.dataSource,
      buildResponse: (c, s) => this.buildResponse(c, s),
    });
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
}
