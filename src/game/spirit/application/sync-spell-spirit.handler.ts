import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, In, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/game-port';
import { scaleSpiritCombatStats } from '@game/spirit/domain/scale-spirit-stats';
import {
  planSpiritSpawns,
  resolveSpiritSelections,
  type SpiritSelectionInput,
} from '@game/spirit/domain/spirit-spawn-plan';
import {
  loadSpellSpiritProfile,
  loadSpellSpiritVariants,
} from '@game/spirit/infrastructure/spell-spirit.queries';
import { loadScaleBySlot } from '@game/actor/infrastructure/creature-scale.queries';
import { ActorPersistenceService } from '@game/actor/infrastructure/actor-persistence.service';
import { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import { GameActorSpeed } from '@game/actor/infrastructure/game-actor-speed.entity';

export type SyncSpellSpiritActorResult = {
  actorId: string;
  templateSlug: string;
  variantKey: string;
  variantLabel: string;
  reused: boolean;
  armorClass: number | null;
  hitPointsMax: number | null;
};

/** Compat: campos do primeiro actor + lista completa. */
export type SyncSpellSpiritResult = SyncSpellSpiritActorResult & {
  actors: SyncSpellSpiritActorResult[];
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
   * Se está e falta variante, falha com BadRequest.
   */
  async execute(input: {
    ownerUserId: string;
    characterId: string;
    spellSlug: string;
    variantKey: string | undefined;
    spiritCount?: number;
    selections?: SpiritSelectionInput[];
    slotLevel: number;
    /** Orçamento (Animar Objetos). */
    castingAbilityMod?: number | null;
    /** Ex.: 0.5 para Criaturas Espectrais. */
    hpMultiplier?: number;
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

    const selections = resolveSpiritSelections({
      variantKey: input.variantKey,
      spiritCount: input.spiritCount,
      selections: input.selections,
    });
    const planned = planSpiritSpawns({
      spellSlug: input.spellSlug,
      selections,
      variants,
      castingAbilityMod: input.castingAbilityMod,
    });

    const templateSlugs = variants.map((v) => v.templateSlug);
    const existing = await this.actors.find({
      where: {
        parentCharacterId: input.characterId,
        templateSlug: In(templateSlugs),
      },
    });
    if (existing.length > 0) {
      await this.actors.remove(existing);
    }

    const hpMultiplier =
      input.hpMultiplier != null && Number.isFinite(input.hpMultiplier)
        ? Math.max(0, input.hpMultiplier)
        : 1;

    const results: SyncSpellSpiritActorResult[] = [];
    for (const spawn of planned) {
      await this.catalogLookup.findCreatureTemplateOrFail(spawn.templateSlug);
      const scale = await loadScaleBySlot(this.dataSource, spawn.templateSlug);
      if (!scale) {
        throw new BadRequestException(
          `Template '${spawn.templateSlug}' sem phb_creature_scale_by_slot`,
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
      const hitPointsMax =
        scaled.hitPointsMax != null
          ? Math.max(1, Math.floor(scaled.hitPointsMax * hpMultiplier))
          : null;
      const armorClass = scaled.armorClass;

      for (let i = 0; i < spawn.count; i += 1) {
        const actorId = await this.persistence.spawnFromTemplate({
          templateSlug: spawn.templateSlug,
          ownerUserId: input.ownerUserId,
          actorKind: profile.actorKind,
          parentCharacterId: input.characterId,
        });
        const actor = await this.actors.findOneOrFail({ where: { id: actorId } });
        await this.applyScaledStats(actor, { hitPointsMax, armorClass }, true);
        await this.applyFlyGate(
          actorId,
          profile.flySpeedMinSlot,
          input.slotLevel,
        );
        results.push({
          actorId,
          templateSlug: spawn.templateSlug,
          variantKey: spawn.variantKey,
          variantLabel: spawn.label,
          reused: false,
          armorClass,
          hitPointsMax,
        });
      }
    }

    const first = results[0];
    if (!first) {
      throw new BadRequestException(
        `Falha ao sincronizar espírito de '${input.spellSlug}'`,
      );
    }
    return { ...first, actors: results };
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
