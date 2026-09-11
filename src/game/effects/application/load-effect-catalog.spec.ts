import { asDep } from '@common/testing/as-dep';
import { LoadEffectCatalog } from './load-effect-catalog';
import type { PhbEffect } from '@entities/effect/phb-effect.entity';
import type { Repository } from 'typeorm';
import type { PhbFeatRef } from '@entities/feat/phb-feat-ref.entity';
import type { PhbSpecies } from '@entities/species/phb-species.entity';
import type { PhbSpellRef } from '@entities/spell/phb-spell-ref.entity';
import type { PhbWeaponMastery } from '@entities/equipment/phb-weapon-mastery.entity';
import type { PhbSubclassRef } from '@entities/subclass-feature/phb-subclass-ref.entity';

describe('LoadEffectCatalog', () => {
  it('maps repository rows to catalog effects with owner slug', async () => {
    const row = {
      id: '1',
      kind: 'grant_spell',
      ownerKind: 'feat',
      ownerId: '99',
      trigger: 'on_build',
      unlockLevel: 1,
      sortOrder: 0,
      minTraitTakes: 1,
      actionSlug: null,
      resourceSlug: null,
      label: 'Truque 1',
      requiresOptionKey: null,
      requiresOptionValue: null,
      spell: {
        effectId: '1',
        spellId: '77',
        optionKey: 'cantrip1',
        spellLevel: 0,
      },
      castEconomy: {
        effectId: '1',
        economy: 'at_will',
        usesFormula: 'fixed',
        fixedUses: null,
      },
      numeric: null,
      note: null,
      resource: null,
      combatMod: null,
    } as PhbEffect;

    const qb = {
      leftJoinAndSelect: jest.fn().mockReturnThis(),
      orderBy: jest.fn().mockReturnThis(),
      addOrderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue([row]),
    };

    const effectsRepo = {
      createQueryBuilder: jest.fn().mockReturnValue(qb),
    };
    const featsRepo = {
      find: jest
        .fn()
        .mockResolvedValueOnce([{ id: '99', slug: 'magic-initiate' }])
        .mockResolvedValueOnce([{ id: '99', slug: 'magic-initiate' }]),
    };
    const speciesRepo = { find: jest.fn().mockResolvedValue([]) };
    const spellsRepo = {
      find: jest.fn().mockResolvedValue([{ id: '77', slug: 'luz' }]),
    };
    const masteryRepo = { find: jest.fn().mockResolvedValue([]) };
    const subclassRepo = { find: jest.fn().mockResolvedValue([]) };

    const loader = new LoadEffectCatalog(
      asDep<Repository<PhbEffect>>(effectsRepo),
      asDep<Repository<PhbFeatRef>>(featsRepo),
      asDep<Repository<PhbSpecies>>(speciesRepo),
      asDep<Repository<PhbSpellRef>>(spellsRepo),
      asDep<Repository<PhbWeaponMastery>>(masteryRepo),
      asDep<Repository<PhbSubclassRef>>(subclassRepo),
    );

    const catalog = await loader.load({
      ownerKind: 'feat',
      ownerSlugs: ['magic-initiate'],
    });

    expect(featsRepo.find).toHaveBeenCalled();
    expect(spellsRepo.find).toHaveBeenCalled();
    expect(catalog).toEqual([
      expect.objectContaining({
        id: '1',
        kind: 'grant_spell',
        ownerSlug: 'magic-initiate',
        spell: {
          spellId: '77',
          spellSlug: 'luz',
          optionKey: 'cantrip1',
          spellLevel: 0,
        },
        castEconomy: {
          economy: 'at_will',
          usesFormula: 'fixed',
          fixedUses: null,
        },
      }),
    ]);
  });

  it('returns empty when ownerSlugs use unsupported ownerKind', async () => {
    const effectsRepo = {
      createQueryBuilder: jest.fn(),
    };
    const loader = new LoadEffectCatalog(
      asDep<Repository<PhbEffect>>(effectsRepo),
      asDep<Repository<PhbFeatRef>>({ find: jest.fn() }),
      asDep<Repository<PhbSpecies>>({ find: jest.fn() }),
      asDep<Repository<PhbSpellRef>>({ find: jest.fn() }),
      asDep<Repository<PhbWeaponMastery>>({ find: jest.fn() }),
      asDep<Repository<PhbSubclassRef>>({ find: jest.fn() }),
    );

    const catalog = await loader.load({
      ownerKind: 'class',
      ownerSlugs: ['fighter'],
    });

    expect(catalog).toEqual([]);
    expect(effectsRepo.createQueryBuilder).not.toHaveBeenCalled();
  });
});
