import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsBoolean, IsOptional, IsUUID } from 'class-validator';
import { ActorResponseDto } from './actor.dto';

export class CompanionTrackerDto {
  @ApiProperty()
  actorId!: string;

  @ApiProperty()
  name!: string;

  @ApiPropertyOptional({ nullable: true })
  templateSlug!: string | null;

  @ApiPropertyOptional({ nullable: true })
  hitPointsCurrent!: number | null;

  @ApiPropertyOptional({ nullable: true })
  hitPointsMax!: number | null;

  @ApiPropertyOptional({ nullable: true })
  armorClass!: number | null;

  @ApiProperty({ description: 'true se PV atuais ≤ 0' })
  defeated!: boolean;

  @ApiProperty({ type: [String] })
  conditions!: string[];
}

export class SyncCharacterCompanionDto {
  @ApiPropertyOptional({
    default: false,
    description: 'Restaura PV atuais ao máximo após sincronizar',
  })
  @IsOptional()
  @IsBoolean()
  restoreHp?: boolean;
}

export class CharacterCompanionSyncResponseDto extends ActorResponseDto {
  @ApiProperty({
    example: false,
    description: 'true se o actor já existia com o mesmo template',
  })
  reused!: boolean;

  @ApiProperty({
    example: 'primal-companion-guardian-land',
    description: 'Slug do template resolvido a partir da ficha',
  })
  templateSlug!: string;

  @ApiProperty({
    example: 'Guardião Primal · Terra',
    description: 'Rótulo da variante escolhida na ficha',
  })
  variantLabel!: string;

  @ApiProperty({
    example: 'beast-master-primal',
    description: 'ID do perfil de companheiro',
  })
  profileId!: string;
}

export class DismissCharacterCompanionDto {
  @ApiPropertyOptional({
    description: 'Actor a dispensar; omite para o único companheiro vinculado',
  })
  @IsOptional()
  @IsUUID()
  actorId?: string;
}
