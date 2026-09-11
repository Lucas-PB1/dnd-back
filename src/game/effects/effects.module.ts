import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbEffect } from '@entities/effect/phb-effect.entity';
import { PhbEffectCastEconomy } from '@entities/effect/phb-effect-cast-economy.entity';
import { PhbEffectCheckAdvantage } from '@entities/effect/phb-effect-check-advantage.entity';
import { PhbEffectCombatFlag } from '@entities/effect/phb-effect-combat-flag.entity';
import { PhbEffectCombatMod } from '@entities/effect/phb-effect-combat-mod.entity';
import { PhbEffectCompanion } from '@entities/effect/phb-effect-companion.entity';
import { PhbEffectDamageDie } from '@entities/effect/phb-effect-damage-die.entity';
import { PhbEffectDamageType } from '@entities/effect/phb-effect-damage-type.entity';
import { PhbEffectEnvironmentalImmunity } from '@entities/effect/phb-effect-environmental-immunity.entity';
import { PhbEffectCondition } from '@entities/effect/phb-effect-condition.entity';
import { PhbEffectSave } from '@entities/effect/phb-effect-save.entity';
import { PhbEffectForcedMovement } from '@entities/effect/phb-effect-forced-movement.entity';
import { PhbEffectDice } from '@entities/effect/phb-effect-dice.entity';
import { PhbEffectFeat } from '@entities/effect/phb-effect-feat.entity';
import { PhbSubclassRef } from '@entities/subclass-feature/phb-subclass-ref.entity';
import { PhbEffectLanguage } from '@entities/effect/phb-effect-language.entity';
import { PhbEffectNote } from '@entities/effect/phb-effect-note.entity';
import { PhbEffectNumeric } from '@entities/effect/phb-effect-numeric.entity';
import { PhbEffectProficiency } from '@entities/effect/phb-effect-proficiency.entity';
import { PhbEffectPurchaseDiscount } from '@entities/effect/phb-effect-purchase-discount.entity';
import { PhbEffectReach } from '@entities/effect/phb-effect-reach.entity';
import { PhbEffectResource } from '@entities/effect/phb-effect-resource.entity';
import { PhbEffectRestQuirk } from '@entities/effect/phb-effect-rest-quirk.entity';
import { PhbEffectSaveAdvantage } from '@entities/effect/phb-effect-save-advantage.entity';
import { PhbEffectSense } from '@entities/effect/phb-effect-sense.entity';
import { PhbEffectSpell } from '@entities/effect/phb-effect-spell.entity';
import { PhbEffectWeapon } from '@entities/effect/phb-effect-weapon.entity';
import { PhbFeatRef } from '@entities/feat/phb-feat-ref.entity';
import { PhbSpecies } from '@entities/species/phb-species.entity';
import { PhbSpellRef } from '@entities/spell/phb-spell-ref.entity';
import { PhbWeaponMastery } from '@entities/equipment/phb-weapon-mastery.entity';
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
      PhbEffectCombatFlag,
      PhbEffectCompanion,
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
