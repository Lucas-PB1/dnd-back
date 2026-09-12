import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { CharacterSpellLookup } from '@game/sheet/application/character-spell-lookup';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { LoadEffectCatalog } from '@game/effects';
import {
  CastSpellDto,
  PatchCharacterStateDto,
  RestResponseDto,
} from '../../dto/core/session-commands.dto';
import { CharacterStateResponseDto } from '../../dto/core/character-state-response.dto';
import { PhbCondition } from '../phb-condition.entity';
import { PlayerCharacterState } from '../player-character-state.entity';
import {
  applyLongRestOp,
  applyShortRestOp,
  castSpellOp,
  patchStateOp,
  syncHitDiceOnLevelChangeOp,
} from '../character-state/core/core-session-ops';
import { findOrCreateCharacterState } from '../character-state/core/ensure-state';
import { MartialSessionFacade } from '../character-state/martial/martial-session.facade';
import { ResourceSessionFacade } from '../character-state/resources/resource-session.facade';
import {
  buildCoreDeps,
  buildMartialDeps,
  buildResourceDeps,
  type CharacterStateRepoPorts,
} from './build-deps';
import { CharacterStateResourceApi } from './resource-api';
import {
  applyCurrentHitPointsOp,
  buildResponseOp,
  setAberrantMutationOp,
  setMissileMageArmedFlagsOp,
  setStarryFormOp,
} from './session-character-ops';
import type { AberrantMutationSlug } from '@game/session/domain/transformation/aberrant-mutation';

@Injectable()
export class CharacterStateRepository extends CharacterStateResourceApi {
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
    private readonly effectCatalog: LoadEffectCatalog,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly dataSource: DataSource,
  ) {
    super();
    this.martial = new MartialSessionFacade(() => this.martialDeps());
    this.resources = new ResourceSessionFacade(() => this.resourceDeps());
  }

  protected ports(): CharacterStateRepoPorts {
    return {
      stateRepo: this.state,
      classSlots: this.classSlots,
      subclassSlots: this.subclassSlots,
      conditions: this.conditions,
      catalogLookup: this.catalogLookup,
      characters: this.characters,
      spellLookup: this.spellLookup,
      sheetRepository: this.sheetRepository,
      grantedSpellCatalog: this.grantedSpellCatalog,
      effectCatalog: this.effectCatalog,
      mechanicalCatalog: this.mechanicalCatalog,
      dataSource: this.dataSource,
      findOrCreate: (id, level) => this.findOrCreate(id, level),
      buildResponse: (c, s) => this.buildResponse(c, s),
    };
  }

  private coreDeps() {
    return buildCoreDeps(this.ports());
  }

  private resourceDeps() {
    return buildResourceDeps(this.ports());
  }

  private martialDeps() {
    return buildMartialDeps(this.ports());
  }

  findOrCreate(characterId: string, level = 1): Promise<PlayerCharacterState> {
    return findOrCreateCharacterState(this.state, characterId, level);
  }

  buildResponse(
    character: PlayerCharacter,
    stateRow?: PlayerCharacterState,
  ): Promise<CharacterStateResponseDto> {
    return buildResponseOp(this.ports(), character, stateRow);
  }

  patch(character: PlayerCharacter, dto: PatchCharacterStateDto) {
    return patchStateOp(this.coreDeps(), character, dto);
  }

  applyCurrentHitPoints(
    character: PlayerCharacter,
    hitPointsCurrent: number,
  ): Promise<CharacterStateResponseDto> {
    return applyCurrentHitPointsOp(this.ports(), character, hitPointsCurrent);
  }

  castSpell(character: PlayerCharacter, dto: CastSpellDto) {
    return castSpellOp(this.coreDeps(), character, dto);
  }

  applyLongRest(character: PlayerCharacter): Promise<RestResponseDto> {
    return applyLongRestOp(this.coreDeps(), character);
  }

  applyShortRest(character: PlayerCharacter, hitDiceSpent = 0) {
    return applyShortRestOp(this.coreDeps(), character, hitDiceSpent);
  }

  setMissileMageArmedFlags(
    character: PlayerCharacter,
    flags: {
      missileShieldArmed?: boolean;
      gigaMissileArmed?: boolean;
    },
  ) {
    return setMissileMageArmedFlagsOp(this.ports(), character, flags);
  }

  setStarryForm(
    character: PlayerCharacter,
    input: {
      active: boolean;
      constellation?: 'archer' | 'chalice' | 'dragon' | null;
    },
  ) {
    return setStarryFormOp(this.ports(), character, input);
  }

  setAberrantMutation(
    character: PlayerCharacter,
    mutationSlug: AberrantMutationSlug | null,
  ) {
    return setAberrantMutationOp(this.ports(), character, mutationSlug);
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
