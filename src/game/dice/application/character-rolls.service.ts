import { Inject, Injectable, forwardRef } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { ResolveEquippedWeaponAttacks } from '@game/combat/application/resolve-equipped-weapon-attacks';
import {
  CharacterRollResponseDto,
  RollAttackDto,
  RollDamageDto,
  RollInitiativeDto,
  RollSavingThrowDto,
  RollSkillDto,
} from '../dto/character-roll.dto';
import { executeRollAttack } from './rolls/roll-attack';
import { executeRollDamage } from './rolls/roll-damage';
import { executeRollInitiative } from './rolls/roll-initiative';
import { executeRollSavingThrow } from './rolls/roll-saving-throw';
import { executeRollSkill } from './rolls/roll-skill';
import { ResolveActivePermanentItemEffects } from '@game/inventory/application/resolve-active-permanent-item-effects';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

@Injectable()
export class CharacterRollsService {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly sheet: CharacterSheetRepository,
    private readonly domain: CharacterDomainService,
    private readonly weaponAttacks: ResolveEquippedWeaponAttacks,
    private readonly permanentItemEffects: ResolveActivePermanentItemEffects,
    private readonly dataSource: DataSource,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    @Inject(forwardRef(() => CharacterStateRepository))
    private readonly state: CharacterStateRepository,
  ) {}

  async rollAttack(
    userId: string,
    characterId: string,
    dto: RollAttackDto,
  ): Promise<CharacterRollResponseDto> {
    return executeRollAttack({
      access: this.access,
      sheet: this.sheet,
      domain: this.domain,
      weaponAttacks: this.weaponAttacks,
      permanentItemEffects: this.permanentItemEffects,
      dataSource: this.dataSource,
      resourceSpender: this.state,
      userId,
      characterId,
      dto,
    });
  }

  async rollDamage(
    userId: string,
    characterId: string,
    dto: RollDamageDto,
  ): Promise<CharacterRollResponseDto> {
    return executeRollDamage({
      access: this.access,
      sheet: this.sheet,
      domain: this.domain,
      weaponAttacks: this.weaponAttacks,
      permanentItemEffects: this.permanentItemEffects,
      dataSource: this.dataSource,
      resourceSpender: this.state,
      mechanicalCatalog: this.mechanicalCatalog,
      userId,
      characterId,
      dto,
    });
  }

  async rollSkill(
    userId: string,
    characterId: string,
    dto: RollSkillDto,
  ): Promise<CharacterRollResponseDto> {
    return executeRollSkill({
      access: this.access,
      sheet: this.sheet,
      domain: this.domain,
      dataSource: this.dataSource,
      resourceSpender: this.state,
      userId,
      characterId,
      dto,
    });
  }

  async rollSavingThrow(
    userId: string,
    characterId: string,
    dto: RollSavingThrowDto,
  ): Promise<CharacterRollResponseDto> {
    return executeRollSavingThrow({
      access: this.access,
      sheet: this.sheet,
      domain: this.domain,
      dataSource: this.dataSource,
      permanentItemEffects: this.permanentItemEffects,
      resourceSpender: this.state,
      userId,
      characterId,
      dto,
    });
  }

  async rollInitiative(
    userId: string,
    characterId: string,
    dto: RollInitiativeDto,
  ): Promise<CharacterRollResponseDto> {
    return executeRollInitiative({
      access: this.access,
      sheet: this.sheet,
      domain: this.domain,
      dataSource: this.dataSource,
      resourceSpender: this.state,
      userId,
      characterId,
      dto,
    });
  }
}
