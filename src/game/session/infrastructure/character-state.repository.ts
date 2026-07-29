import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { VClassSpellSlots } from '../../../entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '../../../entities/views/v-subclass-spell-slots.entity';
import { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { CharacterSpellLookup } from '../../sheet/application/character-spell-lookup';
import { CharacterSheetRepository } from '../../sheet/infrastructure/character-sheet.repository';
import { LoadGrantedSpellCatalog } from '../../spellcasting/application/load-granted-spell-catalog';
import { PhbCondition } from './phb-condition.entity';
import { PlayerCharacterState } from './player-character-state.entity';
import {
  CastSpellDto,
  CharacterStateResponseDto,
  PatchCharacterStateDto,
  RestResponseDto,
  UseClassResourceResponseDto,
  UseManeuverResponseDto,
} from '../dto/character-state.dto';
import { grantHitDiceOnLevelUp } from '../domain/hit-dice-rest';
import { applyCastSpell } from './character-state/cast-spell';
import { buildCharacterStateResponse } from './character-state/build-response';
import {
  applyFireChamber,
  applyRecoverClassResource,
  applyReloadFirearm,
  applyUseClassResource,
  applyUseManeuver,
  applyPatchState,
  listAvailableManeuvers,
} from './character-state/mutations';
import { applyLongRestState, applyShortRestState } from './character-state/rest';

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
    private readonly sheetRepository: CharacterSheetRepository,
    private readonly grantedSpellCatalog: LoadGrantedSpellCatalog,
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
        grantedSpellUses: {},
        highElfCantripSwapAvailable: false,
        conditions: [],
        tempHp: 0,
        concentratingOn: null,
        hitDiceCurrent: level,
        deathSaveSuccesses: 0,
        deathSaveFailures: 0,
        inspiration: false,
        firearmChambers: {},
      });
      await this.state.save(row);
    }
    if (!row.resourcesUsed) {
      row.resourcesUsed = {};
    }
    if (!row.grantedSpellUses) {
      row.grantedSpellUses = {};
    }
    if (!row.firearmChambers) {
      row.firearmChambers = {};
    }
    return row;
  }

  async buildResponse(
    character: PlayerCharacter,
    stateRow?: PlayerCharacterState,
  ): Promise<CharacterStateResponseDto> {
    const state =
      stateRow ?? (await this.findOrCreate(character.id, character.level));
    return buildCharacterStateResponse({
      character,
      state,
      stateRepo: this.state,
      classSlots: this.classSlots,
      subclassSlots: this.subclassSlots,
      catalogLookup: this.catalogLookup,
      dataSource: this.dataSource,
      sheetRepository: this.sheetRepository,
      grantedSpellCatalog: this.grantedSpellCatalog,
    });
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
      sheetRepository: this.sheetRepository,
      grantedSpellCatalog: this.grantedSpellCatalog,
      buildResponse: (c, s) => this.buildResponse(c, s),
    });
  }

  async useClassResource(
    character: PlayerCharacter,
    resourceSlug: string,
    amount = 1,
  ): Promise<UseClassResourceResponseDto> {
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

  async recoverClassResource(
    character: PlayerCharacter,
    resourceSlug: string,
    amount = 1,
  ): Promise<CharacterStateResponseDto> {
    const state = await this.findOrCreate(character.id, character.level);
    return applyRecoverClassResource({
      character,
      state,
      resourceSlug,
      amount,
      stateRepo: this.state,
      dataSource: this.dataSource,
      buildResponse: (c, s) => this.buildResponse(c, s),
    });
  }

  async useManeuver(
    character: PlayerCharacter,
    maneuverSlug: string,
  ): Promise<UseManeuverResponseDto> {
    const state = await this.findOrCreate(character.id, character.level);
    const result = await applyUseManeuver({
      character,
      state,
      maneuverSlug,
      stateRepo: this.state,
      dataSource: this.dataSource,
      buildResponse: (c, s) => this.buildResponse(c, s),
    });
    if (result.effectKind === 'reload_move') {
      await this.reloadAllFirearms(character);
      result.state = await this.buildResponse(
        character,
        await this.findOrCreate(character.id, character.level),
      );
    }
    return result;
  }

  listManeuvers(character: PlayerCharacter) {
    return listAvailableManeuvers(character);
  }

  async reloadFirearm(
    character: PlayerCharacter,
    itemSlug: string,
  ): Promise<CharacterStateResponseDto> {
    const capacity = await this.loadReloadCapacity(itemSlug);
    const state = await this.findOrCreate(character.id, character.level);
    return applyReloadFirearm({
      character,
      state,
      itemSlug,
      capacity,
      stateRepo: this.state,
      buildResponse: (c, s) => this.buildResponse(c, s),
    });
  }

  async fireChamber(
    character: PlayerCharacter,
    itemSlug: string,
    shots = 1,
  ): Promise<CharacterStateResponseDto> {
    const capacity = await this.loadReloadCapacity(itemSlug);
    const state = await this.findOrCreate(character.id, character.level);
    return applyFireChamber({
      character,
      state,
      itemSlug,
      capacity,
      shots,
      stateRepo: this.state,
      buildResponse: (c, s) => this.buildResponse(c, s),
    });
  }

  private async reloadAllFirearms(character: PlayerCharacter): Promise<void> {
    const state = await this.findOrCreate(character.id, character.level);
    const slugs = Object.keys(state.firearmChambers ?? {});
    for (const itemSlug of slugs) {
      const capacity = await this.loadReloadCapacity(itemSlug);
      if (capacity > 0) {
        state.firearmChambers = {
          ...(state.firearmChambers ?? {}),
          [itemSlug]: capacity,
        };
      }
    }
    await this.state.save(state);
  }

  private async loadReloadCapacity(itemSlug: string): Promise<number> {
    const rows = await this.dataSource.query<{ reload: number | null }[]>(
      `SELECT CASE
         WHEN jsonb_typeof(i.properties->'reload') = 'number'
           THEN (i.properties->>'reload')::int
         ELSE NULL
       END AS reload
       FROM rpg.phb_item i
       WHERE i.slug = $1
       LIMIT 1`,
      [itemSlug],
    );
    return Number(rows[0]?.reload ?? 0);
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
