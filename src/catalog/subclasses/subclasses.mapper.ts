import { Injectable } from '@nestjs/common';
import { VPhbSubclass } from '../../entities/views/v-phb-subclass.entity';
import { VPhbSubclassMechanics } from '../../entities/views/v-phb-subclass-mechanics.entity';
import { VPhbSubclassPreparedSpell } from '../../entities/views/v-phb-subclass-prepared-spell.entity';
import { SubclassResponseDto } from './dto/subclass-response.dto';
import { SubclassMechanicResponseDto } from './dto/subclass-mechanic-response.dto';
import { SubclassSpellResponseDto } from './dto/subclass-spell-response.dto';

@Injectable()
export class SubclassesMapper {
  toSubclassDto(row: VPhbSubclass): SubclassResponseDto {
    return {
      slug: row.subclassSlug,
      name: row.subclassName,
      classSlug: row.classSlug,
      className: row.className,
      tagline: row.tagline,
      summary: row.summary,
      sourceChapter: row.sourceChapter,
      editionSlug: row.editionSlug,
      spellSourceSlug: row.spellSourceSlug,
      spellSourceLabel: row.spellSourceLabel,
    };
  }

  toMechanicDto(row: VPhbSubclassMechanics): SubclassMechanicResponseDto {
    return {
      classSlug: row.classSlug,
      featureLevel: row.featureLevel,
      featureName: row.featureName,
      featureDescription: row.featureDescription,
      featureKind: row.featureKind,
      optionKey: row.optionKey,
      resourceSlug: row.resourceSlug,
      resourceName: row.resourceName,
      resourceUnlockLevel: row.resourceUnlockLevel,
      maxFormula: row.maxFormula,
      fixedMax: row.fixedMax,
    };
  }

  toSpellDto(row: VPhbSubclassPreparedSpell): SubclassSpellResponseDto {
    return {
      unlockLevel: row.unlockLevel,
      slug: row.spellSlug,
      name: row.spellName,
      terrainSlug: row.terrainSlug,
      terrainLabel: row.terrainLabel,
    };
  }
}
