import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { CharacterBackgroundValidator } from '../background/character-background.validator';
import { CharacterEquipmentValidator } from '../equipment/character-equipment.validator';
import { CharacterSpellsValidator } from '../spells/character-spells.validator';
import { CharacterClassOptionsValidator } from '../class-options/character-class-options.validator';
import { CharacterFeatsValidator } from '../feats/character-feats.validator';
import { CharacterClassExtraSkillValidator } from '../class-options/character-class-extra-skill.validator';
import { CharacterMysticArcanumValidator } from '../class-options/character-mystic-arcanum.validator';
import { CharacterSignatureSpellsValidator } from '../class-options/character-signature-spells.validator';
import { CharacterTransformationValidator } from '../../transformation/character-transformation.validator';

export type ValidateSheetInputDeps = {
  catalogLookup: Pick<CatalogLookupService, 'validateClassSkillChoices'>;
  backgroundValidator: Pick<
    CharacterBackgroundValidator,
    'assertClassSkillsDoNotOverlapBackground' | 'validateBackgroundLanguages'
  >;
  equipmentValidator: Pick<
    CharacterEquipmentValidator,
    'validateEquipment' | 'validateLanguageSlugs' | 'validateAbilityGenerationMethod'
  >;
  spellsValidator: Pick<CharacterSpellsValidator, 'validateCharacterSpells'>;
  classOptionsValidator: Pick<
    CharacterClassOptionsValidator,
    | 'validateOriginChoices'
    | 'validateSubclassOptions'
    | 'validateFightingStyleSelections'
    | 'validateClassExpertiseOptions'
    | 'validateClassWeaponMasteryOptions'
    | 'validateSpellMasteryOptions'
    | 'validateEldritchInvocationOptions'
    | 'validateMetamagicOptions'
    | 'validateClassFeatureOptions'
  >;
  featsValidator: Pick<
    CharacterFeatsValidator,
    'validateCharacterFeats' | 'validateFeatOptions'
  >;
  extraSkillValidator: Pick<
    CharacterClassExtraSkillValidator,
    'validateClassExtraSkillOptions'
  >;
  mysticArcanumValidator: Pick<
    CharacterMysticArcanumValidator,
    'validateMysticArcanumOptions'
  >;
  signatureSpellsValidator: Pick<
    CharacterSignatureSpellsValidator,
    'validateSignatureSpellOptions'
  >;
  transformationValidator: Pick<CharacterTransformationValidator, 'validate'>;
};
