import type { DataSource } from 'typeorm';
import { PhbCompanionCommand } from '@entities/companion/phb-companion-command.entity';

export type CompanionCommandRow = {
  slug: string;
  labelPt: string;
  noteKind: 'strike' | 'bonus_action';
};

export async function loadCompanionCommands(
  dataSource: DataSource,
): Promise<ReadonlyMap<string, CompanionCommandRow>> {
  const rows = await dataSource.getRepository(PhbCompanionCommand).find({
    order: { sortOrder: 'ASC' },
  });
  return new Map(
    rows.map((row) => [
      row.slug,
      {
        slug: row.slug,
        labelPt: row.labelPt,
        noteKind: row.noteKind,
      },
    ]),
  );
}
