import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbFeatGrantedSpell } from '../../entities/views/v-phb-feat-granted-spell.entity';
import { VPhbSpeciesGrantedSpell } from '../../entities/views/v-phb-species-granted-spell.entity';
import { VPhbSubclassPreparedSpell } from '../../entities/views/v-phb-subclass-prepared-spell.entity';
import { GrantedSpellCatalogService } from './infrastructure/granted-spell-catalog.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      VPhbSpeciesGrantedSpell,
      VPhbFeatGrantedSpell,
      VPhbSubclassPreparedSpell,
    ]),
  ],
  providers: [GrantedSpellCatalogService],
  exports: [GrantedSpellCatalogService],
})
export class SpellcastingModule {}
