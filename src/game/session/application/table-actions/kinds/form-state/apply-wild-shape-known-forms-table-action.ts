import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import { maxWildShapeKnownForms } from '@game/combat/domain/druid';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { assertWildShapeTemplateEligible } from '@game/session/infrastructure/wild-shape/wild-shape.queries';

export async function applySetWildShapeKnownFormsTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  dataSource: DataSource;
  templateSlugs: string[] | undefined;
  moon?: boolean;
}): Promise<TableActionResponseDto> {
  const max = maxWildShapeKnownForms(input.character.level);
  if (max <= 0) {
    throw new BadRequestException('Forma Selvagem exige nível 2+');
  }
  const slugs = [
    ...new Set(
      (input.templateSlugs ?? []).map((s) => s.trim()).filter(Boolean),
    ),
  ];
  if (slugs.length === 0 || slugs.length > max) {
    throw new BadRequestException(
      `Informe de 1 a ${max} templateSlugs de bestas elegíveis`,
    );
  }

  const before = await input.state.buildResponse(input.character);
  const current = before.wildShapeKnownSlugs ?? [];
  if (current.length > 0 && slugs.length < current.length) {
    throw new BadRequestException(
      'Para reduzir/trocar formas use replace-wild-shape-known-form',
    );
  }
  if (current.length > 0) {
    const missing = current.filter((s) => !slugs.includes(s));
    if (missing.length > 0) {
      throw new BadRequestException(
        'Ao preencher slots, mantenha as formas já conhecidas e só adicione novas',
      );
    }
  }

  for (const slug of slugs) {
    await assertWildShapeTemplateEligible(input.dataSource, {
      templateSlug: slug,
      level: input.character.level,
      moon: input.moon,
    });
  }

  const state = await input.state.setWildShapeKnownForms(input.character, {
    knownSlugs: slugs,
  });
  return {
    state,
    actionName: 'Definir Formas Conhecidas',
    resourceSpent: false,
    note: `Formas conhecidas: ${slugs.join(', ')} (${slugs.length}/${max}).`,
  };
}

export async function applyReplaceWildShapeKnownFormTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  dataSource: DataSource;
  replaceSlug: string | undefined;
  templateSlug: string | undefined;
  moon?: boolean;
}): Promise<TableActionResponseDto> {
  const oldSlug = input.replaceSlug?.trim();
  const newSlug = input.templateSlug?.trim();
  if (!oldSlug || !newSlug) {
    throw new BadRequestException(
      'Troca exige replaceSlug (atual) e templateSlug (nova)',
    );
  }
  if (oldSlug === newSlug) {
    throw new BadRequestException('A nova forma deve ser diferente da atual');
  }

  const before = await input.state.buildResponse(input.character);
  if (!before.wildShapeFormSwapAvailable) {
    throw new BadRequestException(
      'Troca de forma conhecida disponível após Descanso Longo',
    );
  }
  const known = [...(before.wildShapeKnownSlugs ?? [])];
  const idx = known.indexOf(oldSlug);
  if (idx < 0) {
    throw new BadRequestException(
      `Forma '${oldSlug}' não está nas conhecidas`,
    );
  }
  if (known.includes(newSlug)) {
    throw new BadRequestException(`Forma '${newSlug}' já é conhecida`);
  }

  await assertWildShapeTemplateEligible(input.dataSource, {
    templateSlug: newSlug,
    level: input.character.level,
    moon: input.moon,
  });

  known[idx] = newSlug;
  const state = await input.state.setWildShapeKnownForms(input.character, {
    knownSlugs: known,
    formSwapAvailable: false,
  });
  return {
    state,
    actionName: 'Trocar Forma Conhecida',
    resourceSpent: false,
    note: `Trocou ${oldSlug} → ${newSlug}.`,
  };
}
