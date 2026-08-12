import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbOptionDef } from '@entities/phb-option.entity';
import { PhbSubclassRef } from '@entities/phb-subclass-ref.entity';
import { SubclassOptionDto } from '@game/sheet/dto/character-sheet.dto';
import {
  LORE_MAGICAL_DISCOVERY_KEYS,
  collectSubclassOptionGrantedSpellSlugs,
} from '@game/sheet/domain/validation/class-options/subclass-option-effects';

@Injectable()
export class ResolveSubclassOptionGrantedSpells {
  constructor(
    @InjectRepository(PhbSubclassRef)
    private readonly subclassRefRepo: Repository<PhbSubclassRef>,
    @InjectRepository(PhbOptionDef)
    private readonly optionDefRepo: Repository<PhbOptionDef>,
  ) {}

  async resolveExtraGrantedSlugs(
    subclassSlug: string | null | undefined,
    level: number,
    subclassOptions: SubclassOptionDto[] | undefined,
  ): Promise<Set<string>> {
    if (!subclassSlug || !subclassOptions?.length) return new Set();

    const subclass = await this.subclassRefRepo.findOne({
      where: { slug: subclassSlug },
    });
    if (!subclass) return new Set();

    const defs = await this.optionDefRepo.find({
      where: { scope: 'subclass', ownerId: subclass.id },
    });
    const unlockByKey = new Map(
      defs
        .filter((def) => LORE_MAGICAL_DISCOVERY_KEYS.has(def.optionKey))
        .map((def) => [def.optionKey, def.unlockLevel ?? 6]),
    );

    return collectSubclassOptionGrantedSpellSlugs(
      level,
      subclassOptions,
      unlockByKey,
    );
  }
}
