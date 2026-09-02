import { ApiProperty, ApiPropertyOptional, PartialType, PickType } from '@nestjs/swagger';
import {
  IsArray,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  MaxLength,
  Min,
  MinLength,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';
import type { ActorKind } from '../../infrastructure/game-actor.entity';
import {
  ACTOR_KINDS,
  ActorActionInputDto,
  ActorSpeedInputDto,
  ActorSpellInputDto,
} from './input.dto';

export class CreateActorDto {
  @ApiProperty({ enum: ACTOR_KINDS })
  @IsIn(ACTOR_KINDS)
  actorKind!: ActorKind;

  @ApiProperty({ example: 'Goblin #1' })
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  name!: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsUUID()
  campaignId?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsUUID()
  parentCharacterId?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  templateSlug?: string;

  @ApiPropertyOptional({ example: 7 })
  @IsOptional()
  @IsInt()
  @Min(0)
  hitPointsMax?: number;

  @ApiPropertyOptional({ example: 7 })
  @IsOptional()
  @IsInt()
  @Min(0)
  hitPointsCurrent?: number;

  @ApiPropertyOptional({ example: 15 })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(40)
  armorClass?: number;

  @ApiPropertyOptional({ example: 2 })
  @IsOptional()
  @IsInt()
  initiativeModifier?: number;

  @ApiPropertyOptional({ example: 2 })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(9)
  proficiencyBonus?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  sizeSlug?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  notes?: string;

  @ApiPropertyOptional({ type: [ActorSpeedInputDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ActorSpeedInputDto)
  speeds?: ActorSpeedInputDto[];

  @ApiPropertyOptional({ type: [ActorActionInputDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ActorActionInputDto)
  actions?: ActorActionInputDto[];

  @ApiPropertyOptional({ type: [ActorSpellInputDto] })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => ActorSpellInputDto)
  spells?: ActorSpellInputDto[];
}

export class UpdateActorDto extends PartialType(
  PickType(CreateActorDto, [
    'name',
    'hitPointsMax',
    'hitPointsCurrent',
    'armorClass',
    'initiativeModifier',
    'notes',
  ] as const),
) {}

export class SpawnActorFromTemplateDto {
  @ApiProperty({ example: 'primal-companion-earth' })
  @IsString()
  templateSlug!: string;

  @ApiProperty({ enum: ACTOR_KINDS })
  @IsIn(ACTOR_KINDS)
  actorKind!: ActorKind;

  @ApiPropertyOptional()
  @IsOptional()
  @IsUUID()
  campaignId?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsUUID()
  parentCharacterId?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  @MaxLength(120)
  nameOverride?: string;
}
