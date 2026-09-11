import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  CharacterResponseDto,
  CharacterSummaryResponseDto,
} from '../../dto/character-response.dto';
import { CharacterDomainService } from '../../domain/core/character-domain.service';
import { CharacterSheetRepository } from '../character-sheet.repository';
import { CharacterSheetData } from '../../domain/character-sheet.types';
import { ResolveEquippedArmorClass } from '@game/combat/application/resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from '@game/combat/application/resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from '@game/combat/application/resolve-equipment-compliance';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { ResolveActivePermanentItemEffects } from '@game/inventory/application/effects/resolve-active-permanent-item-effects';
import { LoadCharacterThreadBundleQuery } from '../../application/load-character-thread-bundle.query';
import { PhbHeritageTrait } from '@entities/heritage/phb-heritage-trait.entity';
import { mapCharacterToDto } from './map-character-to-dto';
import { LoadEffectCatalog } from '@game/effects';

@Injectable()
export class CharacterMapper {
  constructor(
    private readonly dataSource: DataSource,
    private readonly domain: CharacterDomainService,
    private readonly sheet: CharacterSheetRepository,
    private readonly equippedArmorClass: ResolveEquippedArmorClass,
    private readonly equippedWeaponAttacks: ResolveEquippedWeaponAttacks,
    private readonly equipmentCompliance: ResolveEquipmentCompliance,
    private readonly permanentItemEffects: ResolveActivePermanentItemEffects,
    @InjectRepository(VPhbSubclassPreparedSpell)
    private readonly subclassSpellsRepo: Repository<VPhbSubclassPreparedSpell>,
    @InjectRepository(PhbHeritageTrait)
    private readonly heritageTraitRepo: Repository<PhbHeritageTrait>,
    private readonly grantedSpellCatalog: LoadGrantedSpellCatalog,
    private readonly loadCharacterThread: LoadCharacterThreadBundleQuery,
    private readonly effectCatalog: LoadEffectCatalog,
  ) {}

  async toDto(
    row: PlayerCharacter,
    sheetData?: CharacterSheetData,
  ): Promise<CharacterResponseDto> {
    return mapCharacterToDto(
      {
        dataSource: this.dataSource,
        domain: this.domain,
        sheet: this.sheet,
        equippedArmorClass: this.equippedArmorClass,
        equippedWeaponAttacks: this.equippedWeaponAttacks,
        equipmentCompliance: this.equipmentCompliance,
        permanentItemEffects: this.permanentItemEffects,
        subclassSpellsRepo: this.subclassSpellsRepo,
        heritageTraitRepo: this.heritageTraitRepo,
        grantedSpellCatalog: this.grantedSpellCatalog,
        loadCharacterThread: this.loadCharacterThread,
        effectCatalog: this.effectCatalog,
      },
      row,
      sheetData,
    );
  }

  toSummaryDto(row: PlayerCharacter): CharacterSummaryResponseDto {
    return {
      id: row.id,
      name: row.name,
      level: row.level,
      classSlug: row.classSlug,
      className: row.classSlug,
      speciesSlug: row.speciesSlug || null,
      heritageSlug: row.heritageSlug,
      speciesName: row.heritageSlug ?? row.speciesSlug ?? '',
      backgroundSlug: row.backgroundSlug,
      subclassSlug: row.subclassSlug,
      subclassName: row.subclassSlug,
      portraitUrl: row.portraitUrl ?? null,
      createdAt: row.createdAt.toISOString(),
      updatedAt: row.updatedAt.toISOString(),
      campaigns: [],
    };
  }

  toSummaryList(rows: PlayerCharacter[]): CharacterSummaryResponseDto[] {
    return rows.map((row) => this.toSummaryDto(row));
  }
}
