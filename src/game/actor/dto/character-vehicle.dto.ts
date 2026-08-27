import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString, IsUUID, ValidateIf } from 'class-validator';
import { ActorResponseDto } from '../../actor/dto/actor.dto';

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
