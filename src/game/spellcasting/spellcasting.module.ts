import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbOptionDef } from '@entities/phb-option.entity';
import { PhbSubclassRef } from '@entities/phb-subclass-ref.entity';
import { VPhbFeatGrantedSpell } from '@entities/views/v-phb-feat-granted-spell.entity';
import { VPhbSpeciesGrantedSpell } from '@entities/views/v-phb-species-granted-spell.entity';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { VPhbClassGrantedSpell } from '@entities/views/v-phb-class-granted-spell.entity';
import { LoadGrantedSpellCatalog } from './application/load-granted-spell-catalog';
import { ResolveSubclassOptionGrantedSpells } from './application/resolve-subclass-option-granted-spells';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      VPhbSpeciesGrantedSpell,
      VPhbFeatGrantedSpell,
      VPhbSubclassPreparedSpell,
      VPhbClassGrantedSpell,
      PhbSubclassRef,
      PhbOptionDef,
    ]),
  ],
  providers: [LoadGrantedSpellCatalog, ResolveSubclassOptionGrantedSpells],
  exports: [LoadGrantedSpellCatalog, ResolveSubclassOptionGrantedSpells],
})
export class SpellcastingModule {}
