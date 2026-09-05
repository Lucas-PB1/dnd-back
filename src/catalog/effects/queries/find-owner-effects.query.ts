import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbEffect } from '@entities/phb-effect.entity';
import { PhbFeatRef } from '@entities/phb-feat-ref.entity';
import { PhbSpecies } from '@entities/phb-species.entity';
import { EffectSummaryResponseDto } from '../dto/effect-summary-response.dto';

export type CatalogEffectOwnerKind = 'feat' | 'species';

@Injectable()
export class FindOwnerEffectsQuery {
  constructor(
    @InjectRepository(PhbEffect)
    private readonly effects: Repository<PhbEffect>,
    @InjectRepository(PhbFeatRef)
    private readonly feats: Repository<PhbFeatRef>,
    @InjectRepository(PhbSpecies)
    private readonly species: Repository<PhbSpecies>,
  ) {}

  async execute(
    ownerKind: CatalogEffectOwnerKind,
    slug: string,
  ): Promise<EffectSummaryResponseDto[]> {
    const ownerId = await this.resolveOwnerId(ownerKind, slug);
    if (!ownerId) {
      throw new NotFoundException(
        ownerKind === 'feat'
          ? `Feat '${slug}' not found`
          : `Species '${slug}' not found`,
      );
    }

    const rows = await this.effects.find({
      where: { ownerKind, ownerId },
      relations: { note: true },
      order: { sortOrder: 'ASC', id: 'ASC' },
    });

    return rows.map((row) => ({
      id: row.id,
      kind: row.kind,
      trigger: row.trigger,
      label: row.label,
      note: row.note?.note ?? null,
      unlockLevel: row.unlockLevel,
      sortOrder: row.sortOrder,
    }));
  }

  private async resolveOwnerId(
    ownerKind: CatalogEffectOwnerKind,
    slug: string,
  ): Promise<string | null> {
    if (ownerKind === 'feat') {
      const feat = await this.feats.findOne({ where: { slug } });
      return feat?.id ?? null;
    }
    const species = await this.species.findOne({ where: { slug } });
    return species?.id ?? null;
  }
}
