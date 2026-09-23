import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddWeaponSecondaryMastery1727000001000
  implements MigrationInterface
{
  name = 'AddWeaponSecondaryMastery1727000001000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      ALTER TABLE rpg.phb_weapon
        ADD COLUMN IF NOT EXISTS secondary_mastery_id BIGINT
          REFERENCES rpg.phb_weapon_mastery(id)
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      ALTER TABLE rpg.phb_weapon
        DROP COLUMN IF EXISTS secondary_mastery_id
    `);
  }
}
