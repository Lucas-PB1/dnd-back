import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  UseGuards,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiNoContentResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { SupabaseAuthGuard } from '@identity/guards/supabase-auth.guard';
import { CurrentUser } from '@identity/decorators/current-user.decorator';
import { AuthUser } from '@identity/auth-user';
import { ListActorsQuery } from '../application/list-actors.query';
import { GetActorQuery } from '../application/get-actor.query';
import { CreateActorHandler } from '../application/create-actor.handler';
import { UpdateActorHandler } from '../application/update-actor.handler';
import { DeleteActorHandler } from '../application/delete-actor.handler';
import { SpawnActorFromTemplateHandler } from '../application/spawn-actor-from-template.handler';
import { RollActorAttackHandler } from '../application/roll-actor-attack.handler';
import {
  ActorResponseDto,
  ActorSummaryResponseDto,
  CreateActorDto,
  RollActorAttackDto,
  RollActorAttackResponseDto,
  SpawnActorFromTemplateDto,
  UpdateActorDto,
} from '../dto/actor.dto';

@ApiTags('game-actors')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('actors')
export class ActorsController {
  constructor(
    private readonly listActors: ListActorsQuery,
    private readonly getActor: GetActorQuery,
    private readonly createActor: CreateActorHandler,
    private readonly updateActor: UpdateActorHandler,
    private readonly deleteActor: DeleteActorHandler,
    private readonly spawnFromTemplate: SpawnActorFromTemplateHandler,
    private readonly rollAttack: RollActorAttackHandler,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List actors owned by the authenticated user' })
  @ApiOkResponse({ type: [ActorSummaryResponseDto] })
  findAll(@CurrentUser() user: AuthUser): Promise<ActorSummaryResponseDto[]> {
    return this.listActors.execute(user.id);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get actor sheet bundle' })
  @ApiOkResponse({ type: ActorResponseDto })
  @ApiNotFoundResponse()
  findOne(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<ActorResponseDto> {
    return this.getActor.execute(user.id, id);
  }

  @Post()
  @ApiOperation({ summary: 'Create a new actor sheet' })
  @ApiCreatedResponse({ type: ActorResponseDto })
  create(
    @CurrentUser() user: AuthUser,
    @Body() dto: CreateActorDto,
  ): Promise<ActorResponseDto> {
    return this.createActor.execute(user.id, dto);
  }

  @Post('spawn-from-template')
  @ApiOperation({ summary: 'Spawn actor from catalog template' })
  @ApiCreatedResponse({ type: ActorResponseDto })
  spawn(
    @CurrentUser() user: AuthUser,
    @Body() dto: SpawnActorFromTemplateDto,
  ): Promise<ActorResponseDto> {
    return this.spawnFromTemplate.execute(user.id, dto);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update actor core stats' })
  @ApiOkResponse({ type: ActorResponseDto })
  @ApiNotFoundResponse()
  update(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateActorDto,
  ): Promise<ActorResponseDto> {
    return this.updateActor.execute(user.id, id, dto);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({ summary: 'Delete an actor' })
  @ApiNoContentResponse()
  @ApiNotFoundResponse()
  remove(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<void> {
    return this.deleteActor.execute(user.id, id);
  }

  @Post(':id/rolls/attack')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Roll attack for an actor action' })
  @ApiOkResponse({ type: RollActorAttackResponseDto })
  attackRoll(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: RollActorAttackDto,
  ): Promise<RollActorAttackResponseDto> {
    return this.rollAttack.execute(user.id, id, dto);
  }
}
