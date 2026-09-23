import { MigrationInterface, QueryRunner } from 'typeorm';

export class CreateSeedMigrationLedger1727000002000
  implements MigrationInterface
{
  name = 'CreateSeedMigrationLedger1727000002000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS rpg.seed_migration (
        version TEXT PRIMARY KEY,
        checksum TEXT NOT NULL,
        applied_at TIMESTAMPTZ NOT NULL DEFAULT now()
      )
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`DROP TABLE IF EXISTS rpg.seed_migration`);
  }
}
