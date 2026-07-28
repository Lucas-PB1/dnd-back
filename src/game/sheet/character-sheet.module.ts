import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogModule } from '../../catalog/catalog.module';
import { CharacterInventoryModule } from '../inventory/character-inventory.module';
import { PhbCharacterLevel } from '../../entities/phb-character-level.entity';
import { PhbSubclassOptionValue, PhbSubclassRef } from '../../entities/phb-subclass-option-value.entity';
import { VPhbSpeciesTraitChoices } from '../../entities/views/v-phb-species-trait-choices.entity';
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
  PlayerCharacterClassOption,
} from './infrastructure/player-sheet.entities';
import { CharactersController } from './characters.controller';
import { CharacterSheetRepository } from './infrastructure/character-sheet.repository';
import { CharacterMapper } from './infrastructure/character.mapper';
import { EquippedArmorClassService } from './infrastructure/equipped-armor-class.service';
import { EquippedWeaponAttacksService } from './infrastructure/equipped-weapon-attacks.service';
import { CharacterDomainService } from './domain/core/character-domain.service';
import { CharacterSheetValidator } from './domain/validation/character-sheet.validator';
import { CharacterBackgroundValidator } from './domain/validation/background/character-background.validator';
import { CharacterEquipmentValidator } from './domain/validation/equipment/character-equipment.validator';
import { CharacterSpellsValidator } from './domain/validation/spells/character-spells.validator';
import { CharacterClassOptionsValidator } from './domain/validation/class-options/character-class-options.validator';
import { CharacterSpeciesChoicesValidator } from './domain/validation/class-options/character-species-choices.validator';
import { CharacterSubclassOptionsValidator } from './domain/validation/class-options/character-subclass-options.validator';
import { CharacterClassExpertiseValidator } from './domain/validation/class-options/character-class-expertise.validator';
import { CharacterWeaponMasteryValidator } from './domain/validation/class-options/character-weapon-mastery.validator';
import { CharacterFeatOptionValueValidator } from './domain/validation/feats/character-feat-option-value.validator';
import { CharacterFeatOptionsValidator } from './domain/validation/feats/character-feat-options.validator';
import { CharacterFeatsValidator } from './domain/validation/feats/character-feats.validator';
import { CharacterCreateRequirementsValidator } from './domain/validation/character-create-requirements.validator';
import { ListCharactersQuery } from './application/list-characters.query';
import { GetCharacterQuery } from './application/get-character.query';
import { CreateCharacterHandler } from './application/create-character.handler';
import { UpdateCharacterHandler } from './application/update-character.handler';
import { DeleteCharacterHandler } from './application/delete-character.handler';
import { CharacterSpellLookup } from './application/character-spell-lookup';
import { PhbWeapon } from '../../entities/phb-weapon.entity';
import { PhbWeaponMastery } from '../../entities/phb-weapon-mastery.entity';
import { PhbSpecies } from '../../entities/phb-species.entity';
import { VPhbSpeciesGrantedSpell } from '../../entities/views/v-phb-species-granted-spell.entity';
import { VPhbFeatGrantedSpell } from '../../entities/views/v-phb-feat-granted-spell.entity';
import { VPhbHpBonusSource } from '../../entities/views/v-phb-hp-bonus-source.entity';
import { VPhbUnarmoredDefense } from '../../entities/views/v-phb-unarmored-defense.entity';
import { GrantedSpellCatalogService } from './infrastructure/granted-spell-catalog.service';
import { CombatCatalogService } from './infrastructure/combat-catalog.service';
import { CampaignModule } from '../campaign/campaign.module';
import { EquippedEquipmentComplianceService } from './infrastructure/equipped-equipment-compliance.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PlayerCharacterSkill,
      PlayerCharacterSpeciesChoice,
      PlayerCharacterSubclassOption,
      PlayerCharacterClassOption,
      PlayerCharacterFeat,
      PlayerCharacterFeatOption,
      PlayerCharacterSpell,
      PlayerCharacterEquipment,
      PlayerCharacterLanguage,
      PhbCharacterLevel,
      VPhbSpeciesTraitChoices,
      VSpellByClass,
      VPhbSubclassPreparedSpell,
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
      PhbWeapon,
      PhbWeaponMastery,
      PhbSpecies,
      VPhbSpeciesGrantedSpell,
      VPhbFeatGrantedSpell,
      VPhbHpBonusSource,
      VPhbUnarmoredDefense,
    ]),
    GameSharedModule,
    CatalogModule,
    CharacterInventoryModule,
    CampaignModule,
  ],
  controllers: [CharactersController],
  providers: [
    CharacterDomainService,
    CharacterBackgroundValidator,
    CharacterEquipmentValidator,
    CharacterSpellsValidator,
    CharacterSpeciesChoicesValidator,
    CharacterSubclassOptionsValidator,
    CharacterClassExpertiseValidator,
    CharacterWeaponMasteryValidator,
    CharacterClassOptionsValidator,
    CharacterFeatOptionValueValidator,
    CharacterFeatOptionsValidator,
    CharacterFeatsValidator,
    CharacterCreateRequirementsValidator,
    CharacterSheetValidator,
    CharacterSheetRepository,
    CharacterMapper,
    EquippedArmorClassService,
    EquippedWeaponAttacksService,
    EquippedEquipmentComplianceService,
    GrantedSpellCatalogService,
    CombatCatalogService,
    ListCharactersQuery,
    GetCharacterQuery,
    CreateCharacterHandler,
    UpdateCharacterHandler,
    DeleteCharacterHandler,
    CharacterSpellLookup,
  ],
  exports: [
    CharacterDomainService,
    UpdateCharacterHandler,
    CharacterSpellLookup,
    CharacterSheetRepository,
    EquippedWeaponAttacksService,
  ],
})
export class CharacterSheetModule {}
