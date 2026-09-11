import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { PhbEffect } from '@entities/effect/phb-effect.entity';
import { PhbFeatRef } from '@entities/feat/phb-feat-ref.entity';
import { PhbSpellRef } from '@entities/spell/phb-spell-ref.entity';
import { PhbSpecies } from '@entities/species/phb-species.entity';
import { PhbWeaponMastery } from '@entities/equipment/phb-weapon-mastery.entity';
import { PhbSubclassRef } from '@entities/subclass-feature/phb-subclass-ref.entity';
import type { CatalogEffect, EffectOwnerKind } from '../domain/catalog-effect';
import { mapPhbEffectToCatalog } from '../infrastructure/map-phb-effect';

export type LoadEffectsFilter = {
  ownerKind?: EffectOwnerKind;
  ownerIds?: string[];
  ownerSlugs?: string[];
  triggers?: CatalogEffect['trigger'][];
  kinds?: CatalogEffect['kind'][];
  actionSlug?: string;
  resourceSlug?: string;
};

@Injectable()
export class LoadEffectCatalog {
  constructor(
    @InjectRepository(PhbEffect)
    private readonly effects: Repository<PhbEffect>,
    @InjectRepository(PhbFeatRef)
    private readonly feats: Repository<PhbFeatRef>,
    @InjectRepository(PhbSpecies)
    private readonly species: Repository<PhbSpecies>,
    @InjectRepository(PhbSpellRef)
    private readonly spells: Repository<PhbSpellRef>,
    @InjectRepository(PhbWeaponMastery)
    private readonly weaponMasteries: Repository<PhbWeaponMastery>,
    @InjectRepository(PhbSubclassRef)
    private readonly subclasses: Repository<PhbSubclassRef>,
  ) {}

  async load(filter: LoadEffectsFilter = {}): Promise<CatalogEffect[]> {
    const ownerIds = await this.resolveOwnerIds(filter);
    if (ownerIds !== undefined && ownerIds.length === 0) return [];

    const qb = this.effects
      .createQueryBuilder('e')
      .leftJoinAndSelect('e.spell', 'spell')
      .leftJoinAndSelect('e.castEconomy', 'castEconomy')
      .leftJoinAndSelect('e.numeric', 'numeric')
      .leftJoinAndSelect('e.note', 'note')
      .leftJoinAndSelect('e.resource', 'resource')
      .leftJoinAndSelect('e.combatMod', 'combatMod')
      .leftJoinAndSelect('e.proficiency', 'proficiency')
      .leftJoinAndSelect('e.purchaseDiscount', 'purchaseDiscount')
      .leftJoinAndSelect('e.damageDie', 'damageDie')
      .leftJoinAndSelect('e.weapon', 'weapon')
      .leftJoinAndSelect('e.feat', 'feat')
      .leftJoinAndSelect('e.saveAdvantage', 'saveAdvantage')
      .leftJoinAndSelect('e.sense', 'sense')
      .leftJoinAndSelect('e.damageType', 'damageType')
      .leftJoinAndSelect('e.language', 'language')
      .leftJoinAndSelect('e.checkAdvantage', 'checkAdvantage')
      .leftJoinAndSelect('e.reach', 'reach')
      .leftJoinAndSelect('e.restQuirk', 'restQuirk')
      .leftJoinAndSelect('e.environmentalImmunity', 'environmentalImmunity')
      .leftJoinAndSelect('e.condition', 'condition')
      .leftJoinAndSelect('e.save', 'save')
      .leftJoinAndSelect('e.forcedMovement', 'forcedMovement')
      .leftJoinAndSelect('e.dice', 'dice')
      .leftJoinAndSelect('e.combatFlag', 'combatFlag')
      .leftJoinAndSelect('e.companion', 'companion')
      .orderBy('e.sort_order', 'ASC')
      .addOrderBy('e.id', 'ASC');

    if (filter.ownerKind) {
      qb.andWhere('e.owner_kind = :ownerKind', {
        ownerKind: filter.ownerKind,
      });
    }
    if (ownerIds !== undefined) {
      qb.andWhere('e.owner_id IN (:...ownerIds)', { ownerIds });
    }
    if (filter.triggers?.length) {
      qb.andWhere('e.trigger IN (:...triggers)', {
        triggers: filter.triggers,
      });
    }
    if (filter.kinds?.length) {
      qb.andWhere('e.kind IN (:...kinds)', { kinds: filter.kinds });
    }
    if (filter.actionSlug) {
      qb.andWhere('e.action_slug = :actionSlug', {
        actionSlug: filter.actionSlug,
      });
    }
    if (filter.resourceSlug) {
      qb.andWhere('e.resource_slug = :resourceSlug', {
        resourceSlug: filter.resourceSlug,
      });
    }

    const rows = await qb.getMany();
    await this.attachSpellSlugs(rows);
    const slugByOwner = await this.loadOwnerSlugs(rows);
    return rows.map((row) =>
      mapPhbEffectToCatalog(
        row,
        slugByOwner.get(`${row.ownerKind}:${row.ownerId}`) ?? null,
      ),
    );
  }

  private async attachSpellSlugs(rows: PhbEffect[]): Promise<void> {
    const spellIds = [
      ...new Set(
        rows
          .map((row) => row.spell?.spellId)
          .filter((id): id is string => Boolean(id)),
      ),
    ];
    if (spellIds.length === 0) return;
    const spells = await this.spells.find({ where: { id: In(spellIds) } });
    const byId = new Map(spells.map((spell) => [spell.id, spell.slug]));
    for (const row of rows) {
      if (row.spell?.spellId) {
        row.spell.spellSlug = byId.get(row.spell.spellId) ?? null;
      }
    }
  }

  private async resolveOwnerIds(
    filter: LoadEffectsFilter,
  ): Promise<string[] | undefined> {
    if (filter.ownerIds?.length) return filter.ownerIds;
    if (!filter.ownerSlugs?.length || !filter.ownerKind) return undefined;

    if (filter.ownerKind === 'feat') {
      const feats = await this.feats.find({
        where: { slug: In(filter.ownerSlugs) },
      });
      return feats.map((feat) => feat.id);
    }
    if (filter.ownerKind === 'species') {
      const species = await this.species.find({
        where: { slug: In(filter.ownerSlugs) },
      });
      return species.map((row) => row.id);
    }
    if (filter.ownerKind === 'weapon_mastery') {
      const rows = await this.weaponMasteries.find({
        where: { slug: In(filter.ownerSlugs) },
      });
      return rows.map((row) => row.id);
    }
    if (filter.ownerKind === 'subclass') {
      const rows = await this.subclasses.find({
        where: { slug: In(filter.ownerSlugs) },
      });
      return rows.map((row) => row.id);
    }

    return [];
  }

  private async loadOwnerSlugs(
    rows: PhbEffect[],
  ): Promise<Map<string, string>> {
    const map = new Map<string, string>();
    const featIds = [
      ...new Set(
        rows.filter((r) => r.ownerKind === 'feat').map((r) => r.ownerId),
      ),
    ];
    const speciesIds = [
      ...new Set(
        rows.filter((r) => r.ownerKind === 'species').map((r) => r.ownerId),
      ),
    ];
    const masteryIds = [
      ...new Set(
        rows
          .filter((r) => r.ownerKind === 'weapon_mastery')
          .map((r) => r.ownerId),
      ),
    ];
    const subclassIds = [
      ...new Set(
        rows.filter((r) => r.ownerKind === 'subclass').map((r) => r.ownerId),
      ),
    ];
    if (featIds.length) {
      const feats = await this.feats.find({ where: { id: In(featIds) } });
      for (const feat of feats) {
        map.set(`feat:${feat.id}`, feat.slug);
      }
    }
    if (speciesIds.length) {
      const species = await this.species.find({
        where: { id: In(speciesIds) },
      });
      for (const row of species) {
        map.set(`species:${row.id}`, row.slug);
      }
    }
    if (masteryIds.length) {
      const masteries = await this.weaponMasteries.find({
        where: { id: In(masteryIds) },
      });
      for (const row of masteries) {
        map.set(`weapon_mastery:${row.id}`, row.slug);
      }
    }
    if (subclassIds.length) {
      const subclasses = await this.subclasses.find({
        where: { id: In(subclassIds) },
      });
      for (const row of subclasses) {
        map.set(`subclass:${row.id}`, row.slug);
      }
    }
    return map;
  }
}
