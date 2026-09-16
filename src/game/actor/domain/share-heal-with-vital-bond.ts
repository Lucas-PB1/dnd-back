import type { GameActor } from '../infrastructure/game-actor.entity';
import { applyHealToActorVitals, isVitalBondMountTemplate } from './mount-sheet';

export type VitalBondActorStore = {
  findOne(input: { where: { id: string } }): Promise<GameActor | null>;
  save(actor: GameActor): Promise<unknown>;
};

/** Vínculo Vital: cura da ficha do cavaleiro também cura a montaria sobrenatural embarcada. */
export async function shareHealWithVitalBondMount(
  actors: VitalBondActorStore,
  boardedActorId: string | null | undefined,
  amount: number,
): Promise<number> {
  if (!boardedActorId || amount <= 0) return 0;
  const actor = await actors.findOne({ where: { id: boardedActorId } });
  if (!actor || actor.actorKind !== 'mount') return 0;
  if (!isVitalBondMountTemplate(actor.templateSlug)) return 0;
  const next = applyHealToActorVitals({
    hitPointsCurrent: actor.hitPointsCurrent,
    hitPointsMax: actor.hitPointsMax,
    amount,
  });
  if (next.healed <= 0) return 0;
  actor.hitPointsCurrent = next.hitPointsCurrent;
  await actors.save(actor);
  return next.healed;
}
