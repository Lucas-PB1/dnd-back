import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  Min,
  ValidateIf,
} from 'class-validator';
import { ActorResponseDto } from '../../actor/dto/actor.dto';
import { VEHICLE_SHEET_ACTIONS } from '../domain/vehicle-sheet';
import { ActorStateResponseDto } from './actor-state.dto';

export class LinkCharacterVehicleDto {
  @ApiPropertyOptional({
    example: 'aeronave',
    description: 'Slug do item de transporte no inventário',
  })
  @IsOptional()
  @IsString()
  itemSlug?: string;

  @ApiPropertyOptional({
    example: 'aeronave',
    description: 'Slug do template de veículo (quando já conhecido)',
  })
  @IsOptional()
  @IsString()
  templateSlug?: string;
}

export class BoardCharacterVehicleDto {
  @ApiPropertyOptional({
    nullable: true,
    description: 'ID do game_actor; null/omitido para sair',
  })
  @ValidateIf((_, value) => value !== null && value !== undefined)
  @IsUUID()
  @IsOptional()
  actorId?: string | null;
}

export class CharacterVehicleLinkResponseDto extends ActorResponseDto {
  @ApiProperty({
    example: false,
    description: 'true se o actor já existia e foi reutilizado',
  })
  reused!: boolean;
}

export class CharacterVehicleBoardResponseDto {
  @ApiPropertyOptional({ nullable: true, example: null })
  boardedActorId!: string | null;
}

export class VehicleSheetActionDto {
  @ApiProperty({ enum: VEHICLE_SHEET_ACTIONS, example: 'set-metrics' })
  @IsIn([...VEHICLE_SHEET_ACTIONS])
  action!: (typeof VEHICLE_SHEET_ACTIONS)[number];

  @ApiPropertyOptional({
    nullable: true,
    description: 'Actor do veículo (obrigatório em board; senão usa o embarcado)',
  })
  @ValidateIf((_, value) => value !== null && value !== undefined)
  @IsUUID()
  @IsOptional()
  actorId?: string | null;

  @ApiPropertyOptional({ example: 4 })
  @IsOptional()
  @IsInt()
  @Min(0)
  crewCurrent?: number;

  @ApiPropertyOptional({ example: 2 })
  @IsOptional()
  @IsInt()
  @Min(0)
  passengerCurrent?: number;

  @ApiPropertyOptional({ example: 500 })
  @IsOptional()
  @IsInt()
  @Min(0)
  cargoCurrentLb?: number;
}

export class VehicleSheetActionResponseDto {
  @ApiPropertyOptional({ nullable: true })
  boardedActorId!: string | null;

  @ApiProperty({ example: 'Leme' })
  actionName!: string;

  @ApiProperty()
  note!: string;

  @ApiProperty()
  resourceSpent!: boolean;

  @ApiPropertyOptional({ type: () => ActorStateResponseDto })
  actorState?: ActorStateResponseDto;
}
