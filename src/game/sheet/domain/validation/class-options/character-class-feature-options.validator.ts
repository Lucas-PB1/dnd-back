import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { assertUnique } from '@common/assert';
import {
  CharacterSheetContext,
  CharacterSheetInput,
} from '@game/sheet/domain/character-sheet.types';

type ClassFeatureDefRow = { optionKey: string; unlockLevel: number };

@Injectable()
export class CharacterClassFeatureOptionsValidator {
  constructor(private readonly dataSource: DataSource) {}

  async loadOptionKeysAtLevel(classSlug: string, level: number): Promise<string[]> {
    const defs = await this.loadDefs(classSlug);
    return defs
      .filter((def) => def.unlockLevel <= level)
      .map((def) => def.optionKey);
  }

  async validate(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
  ): Promise<void> {
    const defs = await this.loadDefs(ctx.classSlug);
    if (defs.length === 0) return;

    const defByKey = new Map(defs.map((def) => [def.optionKey, def]));
    const featureOptions = options.filter((option) => defByKey.has(option.optionKey));

    assertUnique(
      featureOptions.map((option) => option.optionKey),
      'Opções de classe duplicadas não são permitidas.',
    );

    for (const option of featureOptions) {
      const def = defByKey.get(option.optionKey);
      if (!def) continue;
      if (def.unlockLevel > ctx.level) {
        throw new BadRequestException(
          `Opção de classe '${option.optionKey}' desbloqueia no nível ${def.unlockLevel}.`,
        );
      }
      const valid = await this.dataSource.query<{ ok: number }[]>(
        `SELECT 1 AS ok
         FROM rpg.phb_option_value val
         JOIN rpg.phb_class c ON c.id = val.owner_id
         WHERE val.scope = 'class'::rpg.option_scope
           AND c.slug = $1
           AND val.option_key = $2
           AND val.value_id = $3
         LIMIT 1`,
        [ctx.classSlug, option.optionKey, option.valueId],
      );
      if (valid.length === 0) {
        throw new BadRequestException(
          `Opção de classe '${option.optionKey}/${option.valueId}' é inválida para '${ctx.classSlug}'.`,
        );
      }
    }
  }

  private async loadDefs(classSlug: string): Promise<ClassFeatureDefRow[]> {
    return this.dataSource.query<ClassFeatureDefRow[]>(
      `SELECT def.option_key AS "optionKey",
              COALESCE(def.unlock_level, 1) AS "unlockLevel"
       FROM rpg.phb_option_def def
       JOIN rpg.phb_class c ON c.id = def.owner_id
       WHERE def.scope = 'class'::rpg.option_scope
         AND c.slug = $1
       ORDER BY def.unlock_level ASC NULLS FIRST, def.option_key ASC`,
      [classSlug],
    );
  }
}
