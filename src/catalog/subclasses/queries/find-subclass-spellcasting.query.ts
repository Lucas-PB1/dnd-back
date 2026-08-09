import { Injectable, NotFoundException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { SubclassSpellcastingResponseDto } from '../dto/subclass-spellcasting-response.dto';

type SpellcastingRow = {
  subclass_slug: string;
  casting_type: string;
  ability_slug: string | null;
  focus_label: string | null;
  spell_list_class_slug: string;
  spell_slot_pattern_slug: string;
  ritual: boolean;
};

@Injectable()
export class FindSubclassSpellcastingQuery {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly dataSource: DataSource,
  ) {}

  async execute(subclassSlug: string): Promise<SubclassSpellcastingResponseDto> {
    await this.catalogLookup.findSubclassOrFail(subclassSlug);
    const rows = await this.dataSource.query<SpellcastingRow[]>(
      `SELECT
         sc.slug AS subclass_slug,
         ssc.casting_type::text AS casting_type,
         a.slug AS ability_slug,
         ssc.focus_label,
         list_c.slug AS spell_list_class_slug,
         p.slug AS spell_slot_pattern_slug,
         ssc.ritual
       FROM rpg.phb_subclass_spellcasting ssc
       JOIN rpg.phb_subclass sc ON sc.id = ssc.subclass_id
       JOIN rpg.phb_class list_c ON list_c.id = ssc.spell_list_class_id
       JOIN rpg.phb_spell_slot_pattern p ON p.id = ssc.spell_slot_pattern_id
       LEFT JOIN rpg.phb_ability a ON a.id = ssc.ability_id
       WHERE sc.slug = $1
       LIMIT 1`,
      [subclassSlug],
    );
    const row = rows[0];
    if (!row) {
      throw new NotFoundException(
        `Subclass '${subclassSlug}' has no spellcasting`,
      );
    }
    return {
      subclassSlug: row.subclass_slug,
      castingType: row.casting_type,
      abilitySlug: row.ability_slug,
      focusLabel: row.focus_label,
      spellListClassSlug: row.spell_list_class_slug,
      spellSlotPatternSlug: row.spell_slot_pattern_slug,
      ritual: row.ritual,
      spellcastingMode: 'prepared',
    };
  }
}
