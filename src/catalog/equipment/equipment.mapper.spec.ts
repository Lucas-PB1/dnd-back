import { EquipmentMapper } from './equipment.mapper';
import type { PhbWeapon } from '../../entities/phb-weapon.entity';
import type { VPhbArmor } from '../../entities/views/v-phb-armor.entity';

describe('EquipmentMapper', () => {
  const mapper = new EquipmentMapper();

  describe('toWeaponDto', () => {
    const weapon = {
      category: 'martial',
      damage: '1d8',
      damageType: 'slashing',
      item: {
        slug: 'longsword',
        name: 'Espada Longa',
        cost: 15,
        weight: 3,
        properties: {
          propertyIds: ['versatile', 'missing'],
          versatileDamage: '1d10',
        },
      },
    } as unknown as PhbWeapon;

    it('maps properties, skips unknown slugs, null mastery/range', () => {
      const dto = mapper.toWeaponDto(
        weapon,
        [
          {
            slug: 'versatile',
            name: 'Versátil',
            description: '1d10',
          } as never,
        ],
        null,
      );
      expect(dto).toMatchObject({
        slug: 'longsword',
        versatileDamage: '1d10',
        range: null,
        mastery: null,
        propertyDetails: [{ slug: 'versatile', name: 'Versátil' }],
      });
    });

    it('maps range and mastery when present', () => {
      const ranged = {
        ...weapon,
        item: {
          ...weapon.item,
          properties: {
            propertyIds: [],
            range: { normal: 80, max: 320 },
          },
        },
      } as unknown as PhbWeapon;
      const dto = mapper.toWeaponDto(ranged, [], {
        slug: 'vex',
        name: 'Vex',
        description: 'd',
      } as never);
      expect(dto.range).toEqual({ normal: 80, max: 320 });
      expect(dto.mastery).toEqual({ slug: 'vex', name: 'Vex', description: 'd' });
    });

    it('keeps partial range with null sides', () => {
      const ranged = {
        ...weapon,
        item: {
          ...weapon.item,
          properties: { propertyIds: [], range: { normal: 30 } },
        },
      } as unknown as PhbWeapon;
      expect(mapper.toWeaponDto(ranged).range).toEqual({ normal: 30, max: null });
    });
  });

  describe('toArmorDto', () => {
    it('maps armor view row', () => {
      const dto = mapper.toArmorDto({
        itemSlug: 'leather-armor',
        itemName: 'Couro',
        categorySlug: 'light',
        categoryName: 'Leve',
        donDoff: '1 min',
        acBase: 11,
        acFormula: 'dex',
        strengthReq: null,
        stealthDisadvantage: false,
        costText: '10 PO',
        weight: '10 lb',
      } as unknown as VPhbArmor);
      expect(dto.slug).toBe('leather-armor');
      expect(dto.acBase).toBe(11);
    });
  });
});
