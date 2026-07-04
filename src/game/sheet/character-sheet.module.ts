import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogModule } from '../../catalog/catalog.module';
import { PhbCharacterLevel } from '../../entities/phb-character-level.entity';
import { PhbLanguage } from '../../entities/phb-language.entity';
import { PhbAbilityGenerationMethod } from '../../entities/phb-ability-generation-method.entity';
import { PhbSubclassOptionValue, PhbSubclassRef } from '../../entities/phb-subclass-option-value.entity';
import { VPhbSpeciesTraitChoices } from '../../entities/views/v-phb-species-trait-choices.entity';
import { VPhbFeat } from '../../entities/views/v-phb-feat.entity';
import { VSpellByClass } from '../../entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '../../entities/views/v-phb-subclass-prepared-spell.entity';
import { VPhbClassEquipment } from '../../entities/views/v-phb-class-equipment.entity';
import { VPhbBackgroundEquipment } from '../../entities/views/v-phb-background-equipment.entity';
import { VPhbBackgroundToolOption } from '../../entities/views/v-phb-background-tool-option.entity';
import {
  PhbFeatOptionDef,
  PhbFeatOptionValue,
  PhbFeatRef,
} from '../../entities/phb-feat-option.entity';
import { VPhbArmor } from '../../entities/views/v-phb-armor.entity';
import { PlayerCharacterItem } from '../inventory/infrastructure/player-character-item.entity';
import { GameSharedModule } from '../shared/game-shared.module';
import { PlayerCharacterSkill } from './infrastructure/player-character-skill.entity';
import {
  PlayerCharacterEquipment,
  PlayerCharacterFeat,
  PlayerCharacterFeatOption,
  PlayerCharacterLanguage,
  PlayerCharacterSpeciesChoice,
  PlayerCharacterSpell,
  PlayerCharacterSubclassOption,
} from './infrastructure/player-sheet.entities';
import { CharactersController } from './characters.controller';
import { CharacterSheetRepository } from './infrastructure/character-sheet.repository';
import { CharacterMapper } from './infrastructure/character.mapper';
import { EquippedArmorClassService } from './infrastructure/equipped-armor-class.service';
import { CharacterDomainService } from './domain/character-domain.service';
import { CharacterSheetValidator } from './domain/character-sheet.validator';
import { ListCharactersQuery } from './application/list-characters.query';
import { GetCharacterQuery } from './application/get-character.query';
import { CreateCharacterHandler } from './application/create-character.handler';
import { UpdateCharacterHandler } from './application/update-character.handler';
import { DeleteCharacterHandler } from './application/delete-character.handler';
import { CharacterSpellLookup } from './application/character-spell-lookup';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PlayerCharacterSkill,
      PlayerCharacterSpeciesChoice,
      PlayerCharacterSubclassOption,
      PlayerCharacterFeat,
      PlayerCharacterFeatOption,
      PlayerCharacterSpell,
      PlayerCharacterEquipment,
      PlayerCharacterLanguage,
      PhbCharacterLevel,
      VPhbSpeciesTraitChoices,
      VPhbFeat,
      VSpellByClass,
      VPhbSubclassPreparedSpell,
      PhbLanguage,
      PhbAbilityGenerationMethod,
      PhbSubclassRef,
      PhbSubclassOptionValue,
      VPhbClassEquipment,
      VPhbBackgroundEquipment,
      VPhbBackgroundToolOption,
      PhbFeatRef,
      PhbFeatOptionDef,
      PhbFeatOptionValue,
      VPhbArmor,
      PlayerCharacterItem,
    ]),
    GameSharedModule,
    CatalogModule,
  ],
  controllers: [CharactersController],
  providers: [
    CharacterDomainService,
    CharacterSheetValidator,
    CharacterSheetRepository,
    CharacterMapper,
    EquippedArmorClassService,
    ListCharactersQuery,
    GetCharacterQuery,
    CreateCharacterHandler,
    UpdateCharacterHandler,
    DeleteCharacterHandler,
    CharacterSpellLookup,
  ],
  exports: [CharacterDomainService, UpdateCharacterHandler, CharacterSpellLookup],
})
export class CharacterSheetModule {}

/** @deprecated Use CharacterSheetModule */
export { CharacterSheetModule as CharactersModule };
