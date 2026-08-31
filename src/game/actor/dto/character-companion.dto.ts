import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsBoolean, IsOptional } from 'class-validator';
import { ActorResponseDto } from './actor.dto';

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
