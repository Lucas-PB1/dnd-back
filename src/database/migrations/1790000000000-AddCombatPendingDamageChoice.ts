import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddCombatPendingDamageChoice1790000000000
  implements MigrationInterface
{
  name = 'AddCombatPendingDamageChoice1790000000000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      ALTER TABLE rpg.combat_session
        ADD COLUMN IF NOT EXISTS pending_damage_choice JSONB,
        ADD COLUMN IF NOT EXISTS savage_attacker_used BOOLEAN NOT NULL DEFAULT FALSE
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      ALTER TABLE rpg.combat_session
        DROP COLUMN IF EXISTS pending_damage_choice,
        DROP COLUMN IF EXISTS savage_attacker_used
    `);
  }
}
