import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  UseGuards,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { SupabaseAuthGuard } from '../../identity/guards/supabase-auth.guard';
import { CurrentUser } from '../../identity/decorators/current-user.decorator';
import { AuthUser } from '../../identity/auth-user';
import { CampaignEncounterService } from './application/campaign-encounter.service';
import { CampaignEncounterInitiativeService } from './application/campaign-encounter-initiative.service';
import {
  AddEncounterCreatureDto,
  CampaignEncounterDto,
  CreateCampaignEncounterDto,
  PatchCampaignEncounterDto,
  PatchEncounterCombatantDto,
  RollEncounterInitiativeDto,
} from './dto/encounter.dto';

@ApiTags('game-campaign-encounters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('campaigns/:campaignId/encounters')
export class CampaignEncountersController {
  constructor(
    private readonly encounters: CampaignEncounterService,
    private readonly initiative: CampaignEncounterInitiativeService,
  ) {}

  @Post()
  @ApiOperation({ summary: 'Start active encounter with linked PCs (dm)' })
  @ApiCreatedResponse({ type: CampaignEncounterDto })
  create(
    @CurrentUser() user: AuthUser,
    @Param('campaignId', ParseUUIDPipe) campaignId: string,
    @Body() dto: CreateCampaignEncounterDto,
  ): Promise<CampaignEncounterDto> {
    return this.encounters.create(user.id, campaignId, dto);
  }

  @Get('active')
  @ApiOperation({ summary: 'Active encounter (players if playersCanView)' })
  @ApiOkResponse({ type: CampaignEncounterDto })
  getActive(
    @CurrentUser() user: AuthUser,
    @Param('campaignId', ParseUUIDPipe) campaignId: string,
  ): Promise<CampaignEncounterDto> {
    return this.encounters.getActive(user.id, campaignId);
  }

  @Get(':encounterId')
  @ApiOperation({ summary: 'Get encounter by id' })
  @ApiOkResponse({ type: CampaignEncounterDto })
  getOne(
    @CurrentUser() user: AuthUser,
    @Param('campaignId', ParseUUIDPipe) campaignId: string,
    @Param('encounterId', ParseUUIDPipe) encounterId: string,
  ): Promise<CampaignEncounterDto> {
    return this.encounters.getOne(user.id, campaignId, encounterId);
  }

  @Patch(':encounterId')
  @ApiOperation({ summary: 'Update visibility/name (dm)' })
  @ApiOkResponse({ type: CampaignEncounterDto })
  patchEncounter(
    @CurrentUser() user: AuthUser,
    @Param('campaignId', ParseUUIDPipe) campaignId: string,
    @Param('encounterId', ParseUUIDPipe) encounterId: string,
    @Body() dto: PatchCampaignEncounterDto,
  ): Promise<CampaignEncounterDto> {
    return this.encounters.patchEncounter(
      user.id,
      campaignId,
      encounterId,
      dto,
    );
  }

  @Post(':encounterId/creatures')
  @ApiOperation({ summary: 'Add manual creature (dm)' })
  @ApiCreatedResponse({ type: CampaignEncounterDto })
  addCreature(
    @CurrentUser() user: AuthUser,
    @Param('campaignId', ParseUUIDPipe) campaignId: string,
    @Param('encounterId', ParseUUIDPipe) encounterId: string,
    @Body() dto: AddEncounterCreatureDto,
  ): Promise<CampaignEncounterDto> {
    return this.encounters.addCreature(user.id, campaignId, encounterId, dto);
  }

  @Post(':encounterId/roll-all-initiative')
  @ApiOperation({ summary: 'Roll all missing initiatives (dm)' })
  @ApiOkResponse({ type: CampaignEncounterDto })
  rollAll(
    @CurrentUser() user: AuthUser,
    @Param('campaignId', ParseUUIDPipe) campaignId: string,
    @Param('encounterId', ParseUUIDPipe) encounterId: string,
    @Body() dto: RollEncounterInitiativeDto,
  ): Promise<CampaignEncounterDto> {
    return this.initiative.rollAll(user.id, campaignId, encounterId, dto);
  }

  @Post(':encounterId/combatants/:combatantId/roll-initiative')
  @ApiOperation({ summary: 'Roll one combatant initiative' })
  @ApiOkResponse({ type: CampaignEncounterDto })
  rollOne(
    @CurrentUser() user: AuthUser,
    @Param('campaignId', ParseUUIDPipe) campaignId: string,
    @Param('encounterId', ParseUUIDPipe) encounterId: string,
    @Param('combatantId', ParseUUIDPipe) combatantId: string,
    @Body() dto: RollEncounterInitiativeDto,
  ): Promise<CampaignEncounterDto> {
    return this.initiative.rollOne(
      user.id,
      campaignId,
      encounterId,
      combatantId,
      dto,
    );
  }

  @Patch(':encounterId/combatants/:combatantId')
  @ApiOperation({ summary: 'Patch combatant (HP/CA creatures) (dm)' })
  @ApiOkResponse({ type: CampaignEncounterDto })
  patchCombatant(
    @CurrentUser() user: AuthUser,
    @Param('campaignId', ParseUUIDPipe) campaignId: string,
    @Param('encounterId', ParseUUIDPipe) encounterId: string,
    @Param('combatantId', ParseUUIDPipe) combatantId: string,
    @Body() dto: PatchEncounterCombatantDto,
  ): Promise<CampaignEncounterDto> {
    return this.encounters.patchCombatant(
      user.id,
      campaignId,
      encounterId,
      combatantId,
      dto,
    );
  }

  @Delete(':encounterId/combatants/:combatantId')
  @ApiOperation({ summary: 'Remove combatant (dm)' })
  @ApiOkResponse({ type: CampaignEncounterDto })
  removeCombatant(
    @CurrentUser() user: AuthUser,
    @Param('campaignId', ParseUUIDPipe) campaignId: string,
    @Param('encounterId', ParseUUIDPipe) encounterId: string,
    @Param('combatantId', ParseUUIDPipe) combatantId: string,
  ): Promise<CampaignEncounterDto> {
    return this.encounters.removeCombatant(
      user.id,
      campaignId,
      encounterId,
      combatantId,
    );
  }

  @Post(':encounterId/next-turn')
  @ApiOperation({ summary: 'Next turn (dm)' })
  @ApiOkResponse({ type: CampaignEncounterDto })
  nextTurn(
    @CurrentUser() user: AuthUser,
    @Param('campaignId', ParseUUIDPipe) campaignId: string,
    @Param('encounterId', ParseUUIDPipe) encounterId: string,
  ): Promise<CampaignEncounterDto> {
    return this.encounters.nextTurn(user.id, campaignId, encounterId);
  }

  @Post(':encounterId/close')
  @ApiOperation({ summary: 'Close encounter (dm)' })
  @ApiOkResponse({ type: CampaignEncounterDto })
  close(
    @CurrentUser() user: AuthUser,
    @Param('campaignId', ParseUUIDPipe) campaignId: string,
    @Param('encounterId', ParseUUIDPipe) encounterId: string,
  ): Promise<CampaignEncounterDto> {
    return this.encounters.close(user.id, campaignId, encounterId);
  }
}
