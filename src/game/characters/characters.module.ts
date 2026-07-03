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
import { PlayerCharacter } from './infrastructure/player-character.entity';
import { PlayerCharacterSkill } from './infrastructure/player-character-skill.entity';
import {
  PlayerCharacterEquipment,
  PlayerCharacterFeat,
  PlayerCharacterLanguage,
  PlayerCharacterSpeciesChoice,
  PlayerCharacterSpell,
  PlayerCharacterSubclassOption,
} from './infrastructure/player-sheet.entities';
import { CharactersController } from './characters.controller';
import { CharacterRepository } from './infrastructure/character.repository';
import { CharacterSheetRepository } from './infrastructure/character-sheet.repository';
import { CharacterMapper } from './infrastructure/character.mapper';
import { CharacterDomainService } from './domain/character-domain.service';
import { CharacterSheetValidator } from './domain/character-sheet.validator';
import { LevelUpService } from './domain/level-up.service';
import { ListCharactersQuery } from './application/list-characters.query';
import { GetCharacterQuery } from './application/get-character.query';
import { CreateCharacterHandler } from './application/create-character.handler';
import { UpdateCharacterHandler } from './application/update-character.handler';
import { DeleteCharacterHandler } from './application/delete-character.handler';
import { LevelUpHandler } from './application/level-up.handler';
import { LevelUpPreviewQuery } from './application/level-up-preview.query';
import { RollAbilitiesHandler } from './application/roll-abilities.handler';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PlayerCharacter,
      PlayerCharacterSkill,
      PlayerCharacterSpeciesChoice,
      PlayerCharacterSubclassOption,
      PlayerCharacterFeat,
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
    ]),
    CatalogModule,
  ],
  controllers: [CharactersController],
  providers: [
    CharacterDomainService,
    CharacterSheetValidator,
    LevelUpService,
    CharacterRepository,
    CharacterSheetRepository,
    CharacterMapper,
    ListCharactersQuery,
    GetCharacterQuery,
    CreateCharacterHandler,
    UpdateCharacterHandler,
    DeleteCharacterHandler,
    RollAbilitiesHandler,
    LevelUpPreviewQuery,
    LevelUpHandler,
  ],
})
export class CharactersModule {}
