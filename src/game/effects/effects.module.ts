import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbEffect } from '@entities/phb-effect.entity';
import { PhbEffectCastEconomy } from '@entities/phb-effect-cast-economy.entity';
import { PhbEffectCheckAdvantage } from '@entities/phb-effect-check-advantage.entity';
import { PhbEffectCombatMod } from '@entities/phb-effect-combat-mod.entity';
import { PhbEffectDamageDie } from '@entities/phb-effect-damage-die.entity';
import { PhbEffectDamageType } from '@entities/phb-effect-damage-type.entity';
import { PhbEffectEnvironmentalImmunity } from '@entities/phb-effect-environmental-immunity.entity';
import { PhbEffectCondition } from '@entities/phb-effect-condition.entity';
import { PhbEffectSave } from '@entities/phb-effect-save.entity';
import { PhbEffectForcedMovement } from '@entities/phb-effect-forced-movement.entity';
import { PhbEffectDice } from '@entities/phb-effect-dice.entity';
import { PhbEffectFeat } from '@entities/phb-effect-feat.entity';
import { PhbSubclassRef } from '@entities/phb-subclass-ref.entity';
import { PhbEffectLanguage } from '@entities/phb-effect-language.entity';
import { PhbEffectNote } from '@entities/phb-effect-note.entity';
import { PhbEffectNumeric } from '@entities/phb-effect-numeric.entity';
import { PhbEffectProficiency } from '@entities/phb-effect-proficiency.entity';
import { PhbEffectPurchaseDiscount } from '@entities/phb-effect-purchase-discount.entity';
import { PhbEffectReach } from '@entities/phb-effect-reach.entity';
import { PhbEffectResource } from '@entities/phb-effect-resource.entity';
import { PhbEffectRestQuirk } from '@entities/phb-effect-rest-quirk.entity';
import { PhbEffectSaveAdvantage } from '@entities/phb-effect-save-advantage.entity';
import { PhbEffectSense } from '@entities/phb-effect-sense.entity';
import { PhbEffectSpell } from '@entities/phb-effect-spell.entity';
import { PhbEffectWeapon } from '@entities/phb-effect-weapon.entity';
import { PhbFeatRef } from '@entities/phb-feat-ref.entity';
import { PhbSpecies } from '@entities/phb-species.entity';
import { PhbSpellRef } from '@entities/phb-spell-ref.entity';
import { PhbWeaponMastery } from '@entities/phb-weapon-mastery.entity';
import { LoadEffectCatalog } from './application/load-effect-catalog';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PhbEffect,
      PhbEffectSpell,
      PhbEffectCastEconomy,
      PhbEffectNumeric,
      PhbEffectNote,
      PhbEffectResource,
      PhbEffectCombatMod,
      PhbEffectProficiency,
      PhbEffectPurchaseDiscount,
      PhbEffectDamageDie,
      PhbEffectWeapon,
      PhbEffectFeat,
      PhbEffectSaveAdvantage,
      PhbEffectSense,
      PhbEffectDamageType,
      PhbEffectLanguage,
      PhbEffectCheckAdvantage,
      PhbEffectReach,
      PhbEffectRestQuirk,
      PhbEffectEnvironmentalImmunity,
      PhbEffectCondition,
      PhbEffectSave,
      PhbEffectForcedMovement,
      PhbEffectDice,
      PhbFeatRef,
      PhbSpecies,
      PhbSpellRef,
      PhbWeaponMastery,
      PhbSubclassRef,
    ]),
  ],
  providers: [LoadEffectCatalog],
  exports: [LoadEffectCatalog],
})
export class EffectsModule {}
