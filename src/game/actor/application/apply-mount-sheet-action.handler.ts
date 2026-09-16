import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { GameActor } from '../infrastructure/game-actor.entity';
import { GameActorState } from '../infrastructure/game-actor-state.entity';
import { ActorStateRepository } from '../infrastructure/actor-state.repository';
import { BoardCharacterVehicleHandler } from './character-vehicle.handlers';
import {
  applyHealToActorVitals,
  consumeLongRestUse,
  isCelestialSteedTemplate,
  isFeySteedTemplate,
  isFiendSteedTemplate,
  longRestUseRemaining,
} from '../domain/mount-sheet';
import {
  MountSheetActionDto,
  MountSheetActionResponseDto,
} from '../dto/character-mount.dto';

@Injectable()
export class ApplyMountSheetActionHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly characters: CharacterRepository,
    private readonly board: BoardCharacterVehicleHandler,
    private readonly actorState: ActorStateRepository,
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
    @InjectRepository(GameActorState)
    private readonly actorStates: Repository<GameActorState>,
    @InjectRepository(PlayerCharacterState)
    private readonly pcStates: Repository<PlayerCharacterState>,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: MountSheetActionDto,
  ): Promise<MountSheetActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );

    if (dto.action === 'board') {
      if (!dto.actorId) {
        throw new BadRequestException('Montar exige actorId');
      }
      const boarded = await this.board.execute(userId, characterId, {
        actorId: dto.actorId,
      });
      return {
        boardedActorId: boarded.boardedActorId,
        actionName: 'Montar',
        note: boarded.boardedActorId
          ? 'Embarcado na montaria.'
          : 'Desmontou.',
        resourceSpent: false,
      };
    }

    if (dto.action === 'dismount') {
      await this.board.execute(userId, characterId, { actorId: null });
      return {
        boardedActorId: null,
        actionName: 'Desmontar',
        note: 'Desmontou.',
        resourceSpent: false,
      };
    }

    const actor = await this.resolveMountActor(characterId, dto.actorId);
    const pcState = await this.pcStates.findOne({ where: { characterId } });
    const boardedActorId = pcState?.boardedActorId ?? null;

    if (dto.action === 'healing-touch') {
      return this.applyHealingTouch(character, actor, dto, boardedActorId);
    }
    if (dto.action === 'fey-step') {
      return this.applyOncePerRestDeclare({
        actor,
        boardedActorId,
        key: 'passo-feerico',
        requireBoarded: true,
        templateOk: isFeySteedTemplate(actor.templateSlug),
        actionName: 'Passo Feérico',
        note: 'Passo Feérico: a montaria se teleporta com o cavaleiro até 18 m (declare o espaço na mesa). Combate/posicionamento vs alvo fica fora.',
      });
    }
    return this.applyOncePerRestDeclare({
      actor,
      boardedActorId,
      key: 'derrubar-brilho',
      requireBoarded: false,
      templateOk: isFiendSteedTemplate(actor.templateSlug),
      actionName: 'Derrubar Brilho',
      note: 'Derrubar Brilho: salvaguarda de Sabedoria (CD da magia), 18 m. Falha: Amedrontado até o fim do seu próximo turno (declare no alvo). Combate fica fora.',
    });
  }

  private async resolveMountActor(
    characterId: string,
    actorId: string | null | undefined,
  ): Promise<GameActor> {
    const pcState = await this.pcStates.findOne({ where: { characterId } });
    const id = actorId ?? pcState?.boardedActorId ?? null;
    if (!id) {
      throw new BadRequestException(
        'Informe actorId ou embarque numa montaria antes',
      );
    }
    const actor = await this.actors.findOne({ where: { id } });
    if (!actor) {
      throw new NotFoundException(`Actor '${id}' not found`);
    }
    if (actor.parentCharacterId !== characterId) {
      throw new BadRequestException('Actor is not linked to this character');
    }
    if (actor.actorKind !== 'mount') {
      throw new BadRequestException('Only mount actors accept mount sheet actions');
    }
    return actor;
  }

  private async applyHealingTouch(
    character: Awaited<
      ReturnType<PlayerCharacterAccessService['findAccessibleOrFail']>
    >,
    actor: GameActor,
    dto: MountSheetActionDto,
    boardedActorId: string | null,
  ): Promise<MountSheetActionResponseDto> {
    if (!isCelestialSteedTemplate(actor.templateSlug)) {
      throw new BadRequestException(
        'Toque Curativo exige Montaria Sobrenatural celestial',
      );
    }
    const amount = dto.amount;
    if (amount == null || amount < 1) {
      throw new BadRequestException(
        'Toque Curativo exige amount (2d8 + círculo do slot, na mesa)',
      );
    }
    const state = await this.actorState.ensureState(actor.id);
    if (!longRestUseRemaining(state.innateSpellUses, 'toque-curativo')) {
      throw new BadRequestException('Toque Curativo já foi usado (1/Descanso Longo)');
    }
    state.innateSpellUses = consumeLongRestUse(
      state.innateSpellUses,
      'toque-curativo',
    );
    await this.actorStates.save(state);

    const target = dto.target === 'mount' ? 'mount' : 'rider';
    if (target === 'mount') {
      const next = applyHealToActorVitals({
        hitPointsCurrent: actor.hitPointsCurrent,
        hitPointsMax: actor.hitPointsMax,
        amount,
      });
      actor.hitPointsCurrent = next.hitPointsCurrent;
      await this.actors.save(actor);
      return {
        boardedActorId,
        actionName: 'Toque Curativo',
        note: `Toque Curativo: +${next.healed} PV na montaria.`,
        resourceSpent: true,
        healed: next.healed,
      };
    }

    const max = character.hitPointsMax;
    const current = character.hitPointsCurrent;
    if (max == null || current == null) {
      throw new BadRequestException('Personagem sem PV para receber Toque Curativo');
    }
    const after = Math.min(max, current + amount);
    const healed = after - current;
    character.hitPointsCurrent = after;
    await this.characters.save(character);
    return {
      boardedActorId,
      actionName: 'Toque Curativo',
      note: `Toque Curativo: +${healed} PV no cavaleiro.`,
      resourceSpent: true,
      healed,
    };
  }

  private async applyOncePerRestDeclare(input: {
    actor: GameActor;
    boardedActorId: string | null;
    key: string;
    requireBoarded: boolean;
    templateOk: boolean;
    actionName: string;
    note: string;
  }): Promise<MountSheetActionResponseDto> {
    if (!input.templateOk) {
      throw new BadRequestException(
        `${input.actionName} não está disponível nesta montaria`,
      );
    }
    if (input.requireBoarded && input.boardedActorId !== input.actor.id) {
      throw new BadRequestException(
        `${input.actionName} exige estar embarcado nesta montaria`,
      );
    }
    const state = await this.actorState.ensureState(input.actor.id);
    if (!longRestUseRemaining(state.innateSpellUses, input.key)) {
      throw new BadRequestException(
        `${input.actionName} já foi usado (1/Descanso Longo)`,
      );
    }
    state.innateSpellUses = consumeLongRestUse(state.innateSpellUses, input.key);
    await this.actorStates.save(state);
    return {
      boardedActorId: input.boardedActorId,
      actionName: input.actionName,
      note: input.note,
      resourceSpent: true,
    };
  }
}
