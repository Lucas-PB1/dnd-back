import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { assertUnique } from '@common/assert';
import {
  CharacterSheetContext,
  CharacterSheetInput,
} from '@game/sheet/domain/character-sheet.types';
import {
  classOptionValueExists,
  loadClassOptionDefs,
} from '@game/sheet/infrastructure/queries/class-option.queries';

@Injectable()
export class CharacterClassFeatureOptionsValidator {
  constructor(private readonly dataSource: DataSource) {}

  async loadOptionKeysAtLevel(classSlug: string, level: number): Promise<string[]> {
    const defs = await loadClassOptionDefs(this.dataSource, classSlug);
    return defs
      .filter((def) => def.unlockLevel <= level)
      .map((def) => def.optionKey);
  }

  async validate(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
  ): Promise<void> {
    const defs = await loadClassOptionDefs(this.dataSource, ctx.classSlug);
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
      const valid = await classOptionValueExists(
        this.dataSource,
        ctx.classSlug,
        option.optionKey,
        option.valueId,
      );
      if (!valid) {
        throw new BadRequestException(
          `Opção de classe '${option.optionKey}/${option.valueId}' é inválida para '${ctx.classSlug}'.`,
        );
      }
    }
  }
}
