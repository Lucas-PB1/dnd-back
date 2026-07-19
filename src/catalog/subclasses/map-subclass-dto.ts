import { VPhbSubclass } from '../../entities/views/v-phb-subclass.entity';
import { SubclassResponseDto } from './dto/subclass-response.dto';

export function mapSubclassDto(row: VPhbSubclass): SubclassResponseDto {
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
