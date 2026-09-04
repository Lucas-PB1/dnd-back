import { BadRequestException } from '@nestjs/common';
import type { Repository } from 'typeorm';
import type { ActorPersistenceService } from '@game/actor/infrastructure/actor-persistence.service';
import type { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import { PhbCreatureTemplate } from '@entities/phb-creature-template.entity';
import { DEFAULT_ABILITY_SCORES } from '@game/shared/domain/ability-scores';
import { resolveEncounterCreatureName } from '../../domain/resolve-encounter-creature-name';
import type { AddEncounterCreatureDto } from '../../dto/encounter.dto';

export function assertAddEncounterCreatureDto(dto: AddEncounterCreatureDto): void {
  if (dto.templateSlug?.trim()) return;
  if (!dto.name?.trim()) {
    throw new BadRequestException(
      'name, hpMax and armorClass are required without templateSlug',
    );
  }
  if (dto.hpMax == null || dto.armorClass == null) {
    throw new BadRequestException(
      'name, hpMax and armorClass are required without templateSlug',
    );
  }
}

async function applyCreatureOverrides(
  actor: GameActor,
  dto: AddEncounterCreatureDto,
  actors: Repository<GameActor>,
): Promise<GameActor> {
  if (dto.hpMax != null) {
    actor.hitPointsMax = dto.hpMax;
    actor.hitPointsCurrent = dto.hpCurrent ?? dto.hpMax;
  } else if (dto.hpCurrent != null) {
    actor.hitPointsCurrent = dto.hpCurrent;
  }
  if (dto.armorClass != null) actor.armorClass = dto.armorClass;
  if (dto.initiativeModifier != null) {
    actor.initiativeModifier = dto.initiativeModifier;
  }
  return actors.save(actor);
}

async function spawnManualCreature(
  deps: {
    actorPersistence: ActorPersistenceService;
    actors: Repository<GameActor>;
  },
  input: {
    userId: string;
    campaignId: string;
    dto: AddEncounterCreatureDto;
  },
): Promise<GameActor> {
  const dto = input.dto;
  return deps.actorPersistence.createWithChildren(
    deps.actors.create({
      ownerUserId: input.userId,
      campaignId: input.campaignId,
      actorKind: 'creature',
      name: dto.name!.trim(),
      hitPointsMax: dto.hpMax!,
      hitPointsCurrent: dto.hpCurrent ?? dto.hpMax!,
      armorClass: dto.armorClass!,
      initiativeModifier: dto.initiativeModifier ?? null,
      abilityScores: DEFAULT_ABILITY_SCORES,
    }),
    { actorKind: 'creature', name: dto.name! },
  );
}

export async function spawnEncounterCreatures(input: {
  actorPersistence: ActorPersistenceService;
  actors: Repository<GameActor>;
  templates: Repository<PhbCreatureTemplate>;
  userId: string;
  campaignId: string;
  dto: AddEncounterCreatureDto;
}): Promise<GameActor[]> {
  assertAddEncounterCreatureDto(input.dto);
  const templateSlug = input.dto.templateSlug?.trim();

  if (!templateSlug) {
    return [await spawnManualCreature(input, input)];
  }

  const template = await input.templates.findOne({ where: { slug: templateSlug } });
  if (!template) {
    throw new BadRequestException(`Creature template '${templateSlug}' not found`);
  }

  const count = input.dto.count ?? 1;
  const spawned: GameActor[] = [];
  for (let index = 1; index <= count; index += 1) {
    const name = resolveEncounterCreatureName({
      templateName: template.name,
      index,
      count,
      nameOverride: input.dto.name,
    });
    const actorId = await input.actorPersistence.spawnFromTemplate({
      templateSlug,
      ownerUserId: input.userId,
      actorKind: 'creature',
      campaignId: input.campaignId,
      nameOverride: name,
    });
    const actor = await input.actors.findOne({ where: { id: actorId } });
    if (!actor) {
      throw new BadRequestException(`Failed to spawn creature from '${templateSlug}'`);
    }
    spawned.push(await applyCreatureOverrides(actor, input.dto, input.actors));
  }
  return spawned;
}
