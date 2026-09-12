import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, In, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/game-port';
import { scaleSpiritCombatStats } from '@game/spirit/domain/scale-spirit-stats';
import {
  loadSpellSpiritProfile,
  loadSpellSpiritVariants,
} from '@game/spirit/infrastructure/spell-spirit.queries';
import { loadScaleBySlot } from '@game/actor/infrastructure/creature-scale.queries';
import { ActorPersistenceService } from '@game/actor/infrastructure/actor-persistence.service';
import { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import { GameActorSpeed } from '@game/actor/infrastructure/game-actor-speed.entity';

export type SyncSpellSpiritResult = {
  actorId: string;
  templateSlug: string;
  variantKey: string;
  variantLabel: string;
  reused: boolean;
  armorClass: number | null;
  hitPointsMax: number | null;
};

@Injectable()
export class SyncSpellSpiritHandler {
  constructor(
    private readonly dataSource: DataSource,
    private readonly catalogLookup: CatalogLookupService,
    private readonly persistence: ActorPersistenceService,
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
    @InjectRepository(GameActorSpeed)
    private readonly speeds: Repository<GameActorSpeed>,
  ) {}

  /**
   * Se a magia não está em phb_spell_spirit, retorna null.
   * Se está e falta spiritVariantKey, falha com BadRequest.
   */
  async execute(input: {
    ownerUserId: string;
    characterId: string;
    spellSlug: string;
    variantKey: string | undefined;
    slotLevel: number;
  }): Promise<SyncSpellSpiritResult | null> {
    const profile = await loadSpellSpiritProfile(
      this.dataSource,
      input.spellSlug,
    );
    if (!profile) return null;

    const variants = await loadSpellSpiritVariants(
      this.dataSource,
      input.spellSlug,
    );
    if (variants.length === 0) {
      throw new BadRequestException(
        `Magia '${input.spellSlug}' está mapeada como spirit sem variantes`,
      );
    }

    if (!input.variantKey) {
      const keys = variants.map((v) => v.variantKey).join(', ');
      throw new BadRequestException(
        `spiritVariantKey é obrigatório para '${input.spellSlug}' (opções: ${keys})`,
      );
    }

    const chosen = variants.find((v) => v.variantKey === input.variantKey);
    if (!chosen) {
      const keys = variants.map((v) => v.variantKey).join(', ');
      throw new BadRequestException(
        `Variante '${input.variantKey}' inválida para '${input.spellSlug}' (opções: ${keys})`,
      );
    }

    await this.catalogLookup.findCreatureTemplateOrFail(chosen.templateSlug);
    const scale = await loadScaleBySlot(this.dataSource, chosen.templateSlug);
    if (!scale) {
      throw new BadRequestException(
        `Template '${chosen.templateSlug}' sem phb_creature_scale_by_slot`,
      );
    }
    const scaled = scaleSpiritCombatStats(
      {
        scaleMinSlot: scale.scaleMinSlot,
        acBase: scale.acBase,
        acPerSlot: scale.acPerSlot,
        hpBase: scale.hpBase,
        hpPerSlot: scale.hpPerSlot,
        hpMode: scale.hpMode,
      },
      input.slotLevel,
    );
    const templateSlugs = variants.map((v) => v.templateSlug);

    const existing = await this.actors.find({
      where: {
        parentCharacterId: input.characterId,
        templateSlug: In(templateSlugs),
      },
      order: { createdAt: 'ASC' },
    });

    const sameTemplate = existing.find(
      (actor) => actor.templateSlug === chosen.templateSlug,
    );
    if (sameTemplate) {
      await this.applyScaledStats(sameTemplate, scaled, true);
      await this.applyFlyGate(
        sameTemplate.id,
        profile.flySpeedMinSlot,
        input.slotLevel,
      );
      for (const other of existing) {
        if (other.id !== sameTemplate.id) {
          await this.actors.remove(other);
        }
      }
      return {
        actorId: sameTemplate.id,
        templateSlug: chosen.templateSlug,
        variantKey: chosen.variantKey,
        variantLabel: chosen.label,
        reused: true,
        armorClass: scaled.armorClass,
        hitPointsMax: scaled.hitPointsMax,
      };
    }

    for (const actor of existing) {
      await this.actors.remove(actor);
    }

    const actorId = await this.persistence.spawnFromTemplate({
      templateSlug: chosen.templateSlug,
      ownerUserId: input.ownerUserId,
      actorKind: profile.actorKind,
      parentCharacterId: input.characterId,
    });
    const actor = await this.actors.findOneOrFail({ where: { id: actorId } });
    await this.applyScaledStats(actor, scaled, true);
    await this.applyFlyGate(actorId, profile.flySpeedMinSlot, input.slotLevel);

    return {
      actorId,
      templateSlug: chosen.templateSlug,
      variantKey: chosen.variantKey,
      variantLabel: chosen.label,
      reused: false,
      armorClass: scaled.armorClass,
      hitPointsMax: scaled.hitPointsMax,
    };
  }

  private async applyScaledStats(
    actor: GameActor,
    scaled: { hitPointsMax: number | null; armorClass: number | null },
    restoreHp: boolean,
  ): Promise<void> {
    let dirty = false;
    if (scaled.hitPointsMax != null) {
      actor.hitPointsMax = scaled.hitPointsMax;
      if (restoreHp || actor.hitPointsCurrent == null) {
        actor.hitPointsCurrent = scaled.hitPointsMax;
      } else if (actor.hitPointsCurrent > scaled.hitPointsMax) {
        actor.hitPointsCurrent = scaled.hitPointsMax;
      }
      dirty = true;
    }
    if (scaled.armorClass != null) {
      actor.armorClass = scaled.armorClass;
      dirty = true;
    }
    if (dirty) {
      await this.actors.save(actor);
    }
  }

  private async applyFlyGate(
    actorId: string,
    flySpeedMinSlot: number | null,
    slotLevel: number,
  ): Promise<void> {
    if (flySpeedMinSlot == null) return;
    if (slotLevel >= flySpeedMinSlot) return;
    await this.speeds.delete({ actorId, movementKind: 'fly' });
  }
}
