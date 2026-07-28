import { Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { CharacterDomainService } from '../../sheet/domain/core/character-domain.service';
import { CharacterSheetRepository } from '../../sheet/infrastructure/character-sheet.repository';
import { ResolveEquippedWeaponAttacks } from '../../combat/application/resolve-equipped-weapon-attacks';
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

@Injectable()
export class CharacterRollsService {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly sheet: CharacterSheetRepository,
    private readonly domain: CharacterDomainService,
    private readonly weaponAttacks: ResolveEquippedWeaponAttacks,
    private readonly dataSource: DataSource,
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
      userId,
      characterId,
      dto,
    });
  }
}
