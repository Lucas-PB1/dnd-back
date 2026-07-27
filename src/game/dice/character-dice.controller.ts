import {
  Body,
  Controller,
  HttpCode,
  HttpStatus,
  Param,
  ParseUUIDPipe,
  Post,
  UseGuards,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { SupabaseAuthGuard } from '../../identity/guards/supabase-auth.guard';
import { CurrentUser } from '../../identity/decorators/current-user.decorator';
import { AuthUser } from '../../identity/auth-user';
import { CharacterRollsService } from './application/character-rolls.service';
import {
  CharacterRollResponseDto,
  RollAttackDto,
  RollDamageDto,
  RollInitiativeDto,
  RollSavingThrowDto,
  RollSkillDto,
} from './dto/character-roll.dto';

@ApiTags('game-characters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters')
export class CharacterDiceController {
  constructor(private readonly rolls: CharacterRollsService) {}

  @Post(':id/rolls/attack')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Roll a weapon attack (d20 + attack bonus)' })
  @ApiOkResponse({ type: CharacterRollResponseDto })
  @ApiNotFoundResponse()
  rollAttack(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: RollAttackDto,
  ): Promise<CharacterRollResponseDto> {
    return this.rolls.rollAttack(user.id, id, dto);
  }

  @Post(':id/rolls/damage')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Roll weapon damage dice' })
  @ApiOkResponse({ type: CharacterRollResponseDto })
  @ApiNotFoundResponse()
  rollDamage(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: RollDamageDto,
  ): Promise<CharacterRollResponseDto> {
    return this.rolls.rollDamage(user.id, id, dto);
  }

  @Post(':id/rolls/skill')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Roll a skill check' })
  @ApiOkResponse({ type: CharacterRollResponseDto })
  @ApiNotFoundResponse()
  rollSkill(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: RollSkillDto,
  ): Promise<CharacterRollResponseDto> {
    return this.rolls.rollSkill(user.id, id, dto);
  }

  @Post(':id/rolls/saving-throw')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Roll a saving throw' })
  @ApiOkResponse({ type: CharacterRollResponseDto })
  @ApiNotFoundResponse()
  rollSavingThrow(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: RollSavingThrowDto,
  ): Promise<CharacterRollResponseDto> {
    return this.rolls.rollSavingThrow(user.id, id, dto);
  }

  @Post(':id/rolls/initiative')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Roll initiative (d20 + DEX)' })
  @ApiOkResponse({ type: CharacterRollResponseDto })
  @ApiNotFoundResponse()
  rollInitiative(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: RollInitiativeDto,
  ): Promise<CharacterRollResponseDto> {
    return this.rolls.rollInitiative(user.id, id, dto);
  }
}
