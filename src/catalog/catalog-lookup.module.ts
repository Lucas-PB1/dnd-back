import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbClass } from '../entities/views/v-phb-class.entity';
import { PhbSpecies } from '../entities/phb-species.entity';
import { VPhbBackground } from '../entities/views/v-phb-background.entity';
import { VPhbSubclass } from '../entities/views/v-phb-subclass.entity';
import { PhbAlignment } from '../entities/phb-alignment.entity';
import { CatalogLookupService } from './catalog-lookup.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      VPhbClass,
      PhbSpecies,
      VPhbBackground,
      VPhbSubclass,
      PhbAlignment,
    ]),
  ],
  providers: [CatalogLookupService],
  exports: [CatalogLookupService],
})
export class CatalogLookupModule {}
