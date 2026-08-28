import { Module, forwardRef } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogModule } from '@catalog/catalog.module';
import { CharacterInventoryModule } from '../inventory/character-inventory.module';
import { PhbCharacterLevel } from '@entities/phb-character-level.entity';
import { PhbSubclassRef } from '@entities/phb-subclass-ref.entity';
import { PhbOptionDef, PhbOptionValue } from '@entities/phb-option.entity';
import { VPhbSpeciesTraitChoices } from '@entities/views/v-phb-species-trait-choices.entity';
import { VSpellByClass } from '@entities/views/v-spell-by-class.entity';
import { VPhbSpell } from '@entities/views/v-phb-spell.entity';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { VPhbClassEquipment } from '@entities/views/v-phb-class-equipment.entity';
import { VPhbBackgroundEquipment } from '@entities/views/v-phb-background-equipment.entity';
import { VPhbBackgroundToolOption } from '@entities/views/v-phb-background-tool-option.entity';
import { PhbFeatRef } from '@entities/phb-feat-ref.entity';
import { PlayerCharacterItem } from '../inventory/infrastructure/player-character-item.entity';
import { GameSharedModule } from '../shared/game-shared.module';
import { CombatModule } from '../combat/combat.module';
import { SpellcastingModule } from '../spellcasting/spellcasting.module';
import { PlayerCharacterSkill } from './infrastructure/player-character-skill.entity';
import {
  PlayerCharacterEquipment,
  PlayerCharacterFeat,
  PlayerCharacterLanguage,
  PlayerCharacterOption,
  PlayerCharacterSpeciesChoice,
  PlayerCharacterSpell,
  PlayerCharacterThread,
  PlayerCharacterThreadMilestone,
} from './infrastructure/player-sheet.entities';
import { CharactersController } from './characters.controller';
import { CharacterThreadController } from './character-thread.controller';
import { CharacterSheetRepository } from './infrastructure/character-sheet.repository';
import { CharacterMapper } from './infrastructure/character.mapper';
import { CharacterDomainService } from './domain/core/character-domain.service';
import { CharacterSheetValidator } from './domain/validation/character-sheet.validator';
import { CharacterBackgroundValidator } from './domain/validation/background/character-background.validator';
import { CharacterEquipmentValidator } from './domain/validation/equipment/character-equipment.validator';
import { CharacterSpellsValidator } from './domain/validation/spells/character-spells.validator';
import { CharacterClassOptionsValidator } from './domain/validation/class-options/character-class-options.validator';
import { CharacterSpeciesChoicesValidator } from './domain/validation/class-options/character-species-choices.validator';
import { CharacterSubclassOptionsValidator } from './domain/validation/class-options/character-subclass-options.validator';
import { CharacterSubclassOptionValueValidator } from './domain/validation/class-options/character-subclass-option-value.validator';
import { CharacterClassExpertiseValidator } from './domain/validation/class-options/character-class-expertise.validator';
import { CharacterWeaponMasteryValidator } from './domain/validation/class-options/character-weapon-mastery.validator';
import { CharacterSpellMasteryValidator } from './domain/validation/class-options/character-spell-mastery.validator';
import { CharacterEldritchInvocationsValidator } from './domain/validation/class-options/character-eldritch-invocations.validator';
import { CharacterMetamagicValidator } from './domain/validation/class-options/character-metamagic.validator';
import { CharacterClassFeatureOptionsValidator } from './domain/validation/class-options/character-class-feature-options.validator';
import { CharacterClassExtraSkillValidator } from './domain/validation/class-options/character-class-extra-skill.validator';
import { CharacterMysticArcanumValidator } from './domain/validation/class-options/character-mystic-arcanum.validator';
import { CharacterSignatureSpellsValidator } from './domain/validation/class-options/character-signature-spells.validator';
import { CharacterFeatOptionValueValidator } from './domain/validation/feats/character-feat-option-value.validator';
import { CharacterFeatOptionsValidator } from './domain/validation/feats/character-feat-options.validator';
import { CharacterFeatsValidator } from './domain/validation/feats/character-feats.validator';
import { CharacterCreateRequirementsValidator } from './domain/validation/character-create-requirements.validator';
import { ListCharactersQuery } from './application/list-characters.query';
import { GetCharacterQuery } from './application/get-character.query';
import { CreateCharacterHandler } from './application/create-character.handler';
import { UpdateCharacterHandler } from './application/update-character.handler';
import { DeleteCharacterHandler } from './application/delete-character.handler';
import { PatchCharacterWealthHandler } from './application/patch-character-wealth.handler';
import { GetCharacterNotesQuery } from './application/get-character-notes.query';
import { UpdateCharacterNotesHandler } from './application/update-character-notes.handler';
import { CharacterSpellLookup } from './application/character-spell-lookup';
import { LoadCharacterThreadBundleQuery } from './application/load-character-thread-bundle.query';
import { CharacterThreadCommands } from './application/character-thread.commands';
import { CampaignModule } from '../campaign/campaign.module';
import { PhbCharacterThread } from '@entities/phb-character-thread.entity';
import { VPhbCharacterThreadBundle } from '@entities/views/v-phb-character-thread-bundle.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PlayerCharacterSkill,
      PlayerCharacterSpeciesChoice,
      PlayerCharacterOption,
      PlayerCharacterFeat,
      PlayerCharacterSpell,
      PlayerCharacterEquipment,
      PlayerCharacterLanguage,
      PlayerCharacterThread,
      PlayerCharacterThreadMilestone,
      PhbCharacterThread,
      VPhbCharacterThreadBundle,
      PhbCharacterLevel,
      VPhbSpeciesTraitChoices,
      VSpellByClass,
      VPhbSpell,
      VPhbSubclassPreparedSpell,
      PhbSubclassRef,
      PhbOptionValue,
      VPhbClassEquipment,
      VPhbBackgroundEquipment,
      VPhbBackgroundToolOption,
      PhbFeatRef,
      PhbOptionDef,
      PlayerCharacterItem,
    ]),
    GameSharedModule,
    CatalogModule,
    CharacterInventoryModule,
    forwardRef(() => CampaignModule),
    CombatModule,
    SpellcastingModule,
  ],
  controllers: [CharactersController, CharacterThreadController],
  providers: [
    CharacterDomainService,
    CharacterBackgroundValidator,
    CharacterEquipmentValidator,
    CharacterSpellsValidator,
    CharacterSpeciesChoicesValidator,
    CharacterSubclassOptionsValidator,
    CharacterSubclassOptionValueValidator,
    CharacterClassExpertiseValidator,
    CharacterWeaponMasteryValidator,
    CharacterSpellMasteryValidator,
    CharacterEldritchInvocationsValidator,
    CharacterMetamagicValidator,
    CharacterClassFeatureOptionsValidator,
    CharacterClassExtraSkillValidator,
    CharacterMysticArcanumValidator,
    CharacterSignatureSpellsValidator,
    CharacterClassOptionsValidator,
    CharacterFeatOptionValueValidator,
    CharacterFeatOptionsValidator,
    CharacterFeatsValidator,
    CharacterCreateRequirementsValidator,
    CharacterSheetValidator,
    CharacterSheetRepository,
    CharacterMapper,
    ListCharactersQuery,
    GetCharacterQuery,
    CreateCharacterHandler,
    UpdateCharacterHandler,
    DeleteCharacterHandler,
    PatchCharacterWealthHandler,
    GetCharacterNotesQuery,
    UpdateCharacterNotesHandler,
    CharacterSpellLookup,
    LoadCharacterThreadBundleQuery,
    CharacterThreadCommands,
  ],
  exports: [
    CharacterDomainService,
    UpdateCharacterHandler,
    CharacterSpellLookup,
    CharacterSheetRepository,
  ],
})
export class CharacterSheetModule {}
