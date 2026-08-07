import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { weaponPropsOf } from '../../../catalog/equipment/weapon-props';
import { PhbWeapon } from '../../../entities/phb-weapon.entity';
import { VPhbArmor } from '../../../entities/views/v-phb-armor.entity';
import { ResolveEquipmentCompliance } from '../../combat/application/resolve-equipment-compliance';
import { PlayerCharacterFeat } from '../../sheet/infrastructure/player-sheet.entities';
import { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import { assertCanEquipItem } from '../domain/assert-can-equip-item';

/** Carrega contexto da ficha/catálogo e aplica o gate de equip. */
@Injectable()
export class AssertCanEquipItemService {
  constructor(
    private readonly equipmentCompliance: ResolveEquipmentCompliance,
    @InjectRepository(VPhbArmor)
    private readonly armorCatalog: Repository<VPhbArmor>,
    @InjectRepository(PhbWeapon)
    private readonly weapons: Repository<PhbWeapon>,
    @InjectRepository(PlayerCharacterFeat)
    private readonly feats: Repository<PlayerCharacterFeat>,
    private readonly dataSource: DataSource,
  ) {}

  async assert(character: PlayerCharacter, itemSlug: string): Promise<void> {
    const featRows = await this.feats.find({
      where: { characterId: character.id },
    });
    const featSlugs = featRows.map((row) => row.featSlug);

    const armor = await this.armorCatalog.findOne({ where: { itemSlug } });
    if (armor) {
      const armorTrainingSlugs =
        await this.equipmentCompliance.loadArmorTrainingSlugs(
          character.classSlug,
        );
      assertCanEquipItem({
        kind: 'armor',
        piece: {
          itemSlug: armor.itemSlug,
          itemName: armor.itemName,
          categorySlug: armor.categorySlug,
          strengthReq: armor.strengthReq,
          stealthDisadvantage: armor.stealthDisadvantage,
        },
        armorTrainingSlugs,
        featSlugs,
        strengthScore: character.abilityScores.forca,
      });
      return;
    }

    const weapon = await this.weapons.findOne({
      where: { item: { slug: itemSlug } },
      relations: ['item'],
    });
    if (!weapon) return;

    const weaponProficiencySlugs = await this.loadWeaponProficiencySlugs(
      character.classSlug,
    );
    const props = weaponPropsOf(weapon);
    assertCanEquipItem({
      kind: 'weapon',
      piece: {
        itemSlug: weapon.item.slug,
        itemName: weapon.item.name,
        category: weapon.category,
        damage: weapon.damage,
        damageType: weapon.damageType,
        versatileDamage: props.versatileDamage ?? null,
        propertySlugs: props.propertyIds ?? [],
        equipmentSlot: 'main_hand',
      },
      weaponProficiencySlugs,
      featSlugs,
      itemName: weapon.item.name,
    });
  }

  private async loadWeaponProficiencySlugs(
    classSlug: string,
  ): Promise<string[]> {
    const rows = await this.dataSource.query<{ slug: string }[]>(
      `SELECT cwp.proficiency_slug AS slug
       FROM rpg.phb_class c
       JOIN rpg.phb_class_weapon_proficiency cwp ON cwp.class_id = c.id
       WHERE c.slug = $1
       ORDER BY cwp.proficiency_slug`,
      [classSlug],
    );
    return rows.map((row) => row.slug);
  }
}
