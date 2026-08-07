import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { VClassSpellSlots } from '../../../entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '../../../entities/views/v-subclass-spell-slots.entity';
import { LoadCombatMechanicalCatalog } from '../../combat/application/load-combat-mechanical-catalog';
import { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { CharacterSpellLookup } from '../../sheet/application/character-spell-lookup';
import { CharacterSheetRepository } from '../../sheet/infrastructure/character-sheet.repository';
import { LoadGrantedSpellCatalog } from '../../spellcasting/application/load-granted-spell-catalog';
import {
  CastSpellDto,
  CharacterStateResponseDto,
  PatchCharacterStateDto,
  RestResponseDto,
  UseClassResourceResponseDto,
} from '../dto/character-state.dto';
import { PhbCondition } from './phb-condition.entity';
import { PlayerCharacterState } from './player-character-state.entity';
import { buildCharacterStateResponse } from './character-state/core/build-response';
import {
  applyLongRestOp,
  applyShortRestOp,
  castSpellOp,
  patchStateOp,
  syncHitDiceOnLevelChangeOp,
  type CoreSessionDeps,
} from './character-state/core/core-session-ops';
import { findOrCreateCharacterState } from './character-state/core/ensure-state';
import { MartialSessionFacade } from './character-state/martial/martial-session.facade';
import type { MartialSessionDeps } from './character-state/martial/martial-deps';
import { ResourceSessionFacade } from './character-state/resources/resource-session.facade';
import type { ResourceSessionDeps } from './character-state/resources/resource-session-ops';

@Injectable()
export class CharacterStateRepository {
  /** Ops marciais (gunslinger / bárbaro / fighter / máscaras / beastborne). */
  readonly martial: MartialSessionFacade;
  readonly resources: ResourceSessionFacade;

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
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly dataSource: DataSource,
  ) {
    this.martial = new MartialSessionFacade(() => this.martialDeps());
    this.resources = new ResourceSessionFacade(() => this.resourceDeps());
  }

  findOrCreate(characterId: string, level = 1): Promise<PlayerCharacterState> {
    return findOrCreateCharacterState(this.state, characterId, level);
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

  private bindResponse() {
    return (c: PlayerCharacter, s?: PlayerCharacterState) =>
      this.buildResponse(c, s);
  }

  private coreDeps(): CoreSessionDeps {
    return {
      stateRepo: this.state,
      conditions: this.conditions,
      classSlots: this.classSlots,
      subclassSlots: this.subclassSlots,
      catalogLookup: this.catalogLookup,
      characters: this.characters,
      spellLookup: this.spellLookup,
      sheetRepository: this.sheetRepository,
      grantedSpellCatalog: this.grantedSpellCatalog,
      dataSource: this.dataSource,
      findOrCreate: (id, level) => this.findOrCreate(id, level),
      buildResponse: this.bindResponse(),
    };
  }

  private resourceDeps(): ResourceSessionDeps {
    return {
      stateRepo: this.state,
      classSlots: this.classSlots,
      subclassSlots: this.subclassSlots,
      dataSource: this.dataSource,
      findOrCreate: (id, level) => this.findOrCreate(id, level),
      buildResponse: this.bindResponse(),
    };
  }

  private martialDeps(): MartialSessionDeps {
    return {
      stateRepo: this.state,
      dataSource: this.dataSource,
      characters: this.characters,
      findOrCreate: (id, level) => this.findOrCreate(id, level),
      buildResponse: this.bindResponse(),
      loadMechanicalCatalog: () => this.mechanicalCatalog.load(),
    };
  }

  patch(character: PlayerCharacter, dto: PatchCharacterStateDto) {
    return patchStateOp(this.coreDeps(), character, dto);
  }

  castSpell(character: PlayerCharacter, dto: CastSpellDto) {
    return castSpellOp(this.coreDeps(), character, dto);
  }

  /** Aliases de recurso (porta CharacterResourceSpender + handlers). */
  useClassResource(
    character: PlayerCharacter,
    resourceSlug: string,
    amount = 1,
  ): Promise<UseClassResourceResponseDto> {
    return this.resources.useClassResource(character, resourceSlug, amount);
  }

  spendClassResource(
    character: PlayerCharacter,
    resourceSlug: string,
    amount = 1,
  ) {
    return this.resources.spendClassResource(character, resourceSlug, amount);
  }

  consumeSpellSlotLevel(character: PlayerCharacter, slotLevel: number) {
    return this.resources.consumeSpellSlotLevel(character, slotLevel);
  }

  recoverSpellSlotLevel(character: PlayerCharacter, slotLevel: number) {
    return this.resources.recoverSpellSlotLevel(character, slotLevel);
  }

  recoverClassResource(
    character: PlayerCharacter,
    resourceSlug: string,
    amount = 1,
  ) {
    return this.resources.recoverClassResource(
      character,
      resourceSlug,
      amount,
    );
  }

  applyLongRest(character: PlayerCharacter): Promise<RestResponseDto> {
    return applyLongRestOp(this.coreDeps(), character);
  }

  applyShortRest(character: PlayerCharacter, hitDiceSpent = 0) {
    return applyShortRestOp(this.coreDeps(), character, hitDiceSpent);
  }

  async setMissileMageArmedFlags(
    character: PlayerCharacter,
    flags: {
      missileShieldArmed?: boolean;
      gigaMissileArmed?: boolean;
    },
  ): Promise<PlayerCharacterState> {
    const state = await this.findOrCreate(character.id, character.level);
    if (flags.missileShieldArmed !== undefined) {
      state.missileShieldArmed = flags.missileShieldArmed;
    }
    if (flags.gigaMissileArmed !== undefined) {
      state.gigaMissileArmed = flags.gigaMissileArmed;
    }
    return this.state.save(state);
  }

  syncHitDiceOnLevelChange(
    characterId: string,
    previousLevel: number,
    newLevel: number,
  ) {
    return syncHitDiceOnLevelChangeOp(
      this.coreDeps(),
      characterId,
      previousLevel,
      newLevel,
    );
  }
}
