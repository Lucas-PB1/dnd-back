import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import {
  baseWildShapeTempHp,
  moonWildShapeArmorClassFloor,
  moonWildShapeTempHp,
} from '@game/combat/domain/druid';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { assertWildShapeTemplateEligible } from '@game/session/infrastructure/wild-shape/wild-shape.queries';
import type { SyncWildShapeActorHandler } from '@game/actor/application/sync-wild-shape-actor.handler';

export async function applyWildShapeTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  dataSource: DataSource;
  templateSlug: string | undefined;
  moon: boolean;
  actionName: string;
  ownerUserId?: string;
  syncWildShapeActor?: SyncWildShapeActorHandler;
}): Promise<TableActionResponseDto> {
  const slug = input.templateSlug?.trim();
  if (!slug) {
    throw new BadRequestException(
      `${input.actionName} exige templateSlug da besta`,
    );
  }

  const before = await input.state.buildResponse(input.character);
  const known = before.wildShapeKnownSlugs ?? [];
  if (known.length === 0) {
    throw new BadRequestException(
      'Defina formas conhecidas (set-wild-shape-known-forms) antes de assumir Forma Selvagem',
    );
  }
  if (!known.includes(slug)) {
    throw new BadRequestException(
      `Besta '${slug}' não está nas formas conhecidas`,
    );
  }

  const template = await assertWildShapeTemplateEligible(input.dataSource, {
    templateSlug: slug,
    level: input.character.level,
    moon: input.moon,
  });

  await input.state.useClassResource(input.character, 'wildShape', 1);

  const tempHp = input.moon
    ? moonWildShapeTempHp(input.character.level)
    : baseWildShapeTempHp(input.character.level);

  await input.state.patch(input.character, { tempHp });

  const wisMod = abilityModifier(
    input.character.abilityScores?.sabedoria ?? 10,
  );
  const moonAcFloor = input.moon
    ? moonWildShapeArmorClassFloor(wisMod)
    : null;
  const effectiveAc =
    moonAcFloor != null
      ? Math.max(template.armorClass ?? 0, moonAcFloor)
      : template.armorClass;

  let actorId: string | null = null;
  if (input.syncWildShapeActor && input.ownerUserId) {
    const spawned = await input.syncWildShapeActor.enter({
      character: input.character,
      ownerUserId: input.ownerUserId,
      templateSlug: template.slug,
      templateName: template.name,
      armorClass: effectiveAc,
      previousActorId: before.wildShapeActorId,
    });
    actorId = spawned.actorId;
  }

  const state = await input.state.setWildShape(input.character, {
    active: true,
    templateSlug: template.slug,
    actorId,
  });

  const parts = [
    `${input.actionName}: ${template.name} (${template.slug})`,
    `${tempHp} PV temp.`,
  ];
  if (effectiveAc != null) {
    parts.push(
      input.moon
        ? `CA efetiva ${effectiveAc} (máx besta/${moonAcFloor})`
        : `CA ${effectiveAc}`,
    );
  }
  if (actorId) parts.push(`actor ${actorId}`);

  return {
    state,
    actionName: input.actionName,
    resourceSpent: true,
    total: tempHp,
    note: parts.join(' · '),
  };
}

export async function applyWildShapeEndTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  syncWildShapeActor?: SyncWildShapeActorHandler;
}): Promise<TableActionResponseDto> {
  const before = await input.state.buildResponse(input.character);
  if (input.syncWildShapeActor) {
    await input.syncWildShapeActor.leave(before.wildShapeActorId);
  }
  const state = await input.state.setWildShape(input.character, {
    active: false,
    templateSlug: null,
    actorId: null,
  });
  return {
    state,
    actionName: 'Encerrar Forma Selvagem',
    resourceSpent: false,
    note: 'Forma Selvagem encerrada na ficha.',
  };
}
