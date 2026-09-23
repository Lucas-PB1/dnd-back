import { MigrationInterface, QueryRunner } from 'typeorm';
import {
  applySchemaSqlFiles,
  assertSchemaEmptyForBaseline,
} from '../apply-schema-sql';

export class BaselineSchema1727000000000 implements MigrationInterface {
  name = 'BaselineSchema1727000000000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await assertSchemaEmptyForBaseline(queryRunner);
    const count = await applySchemaSqlFiles((sql) => queryRunner.query(sql));
    console.log(`  baseline schema: ${count} file(s)`);
  }

  public async down(): Promise<void> {
    throw new Error(
      'BaselineSchema is irreversible; use npm run db:reset (dev wipe)',
    );
  }
}
