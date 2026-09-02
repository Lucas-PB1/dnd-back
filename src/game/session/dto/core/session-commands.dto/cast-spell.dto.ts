import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsBoolean,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Min,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';
import { CharacterStateResponseDto } from '../character-state-response.dto';

export class ArtifactRandomCastDto {
  @ApiProperty({ example: 'varinha-de-orcus' })
  @IsString()
  itemSlug!: string;

  @ApiProperty({
    enum: [
      'minorBeneficial',
      'majorBeneficial',
      'minorDetrimental',
      'majorDetrimental',
    ],
  })
  @IsIn([
    'minorBeneficial',
    'majorBeneficial',
    'minorDetrimental',
    'majorDetrimental',
  ])
  bucket!:
    | 'minorBeneficial'
    | 'majorBeneficial'
    | 'minorDetrimental'
    | 'majorDetrimental';

  @ApiProperty({ example: 0 })
  @IsInt()
  @Min(0)
  index!: number;
}

export class CastSpellDto {
  @ApiProperty({ example: 'alarme' })
  @IsString()
  spellSlug!: string;

  @ApiPropertyOptional({
    example: 1,
    description: 'Círculo do slot a gastar (padrão = nível da magia; truques não gastam slot)',
  })
  @IsOptional()
  @IsInt()
  @Min(0)
  slotLevel?: number;

  @ApiPropertyOptional({
    example: true,
    description:
      'Usar conjuração free de magia concedida (1×/LD) em vez de slot de classe',
  })
  @IsOptional()
  @IsBoolean()
  useFreeCast?: boolean;

  @ApiPropertyOptional({
    example: 'magic-missile-free',
    description:
      'Gasta este recurso de classe em vez de slot (ex.: Mísseis Mágicos gratuitos)',
  })
  @IsOptional()
  @IsString()
  freeCastResourceSlug?: string;

  @ApiPropertyOptional({
    example: 'varinhaMisseisCharges',
    description:
      'Cast via carga de item (fase 6): resource do item ativo + bypass da lista',
  })
  @IsOptional()
  @IsString()
  itemCastResourceSlug?: string;

  @ApiPropertyOptional({
    example: 2,
    description: 'Cargas gastas no cast de item (padrão 1)',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  itemCastSpendAmount?: number;

  @ApiPropertyOptional({
    example: 'cajado-dos-magi',
    description:
      'Cast gratuito de item (sem carga): item ativo + economy com spell_slug e sem resource',
  })
  @IsOptional()
  @IsString()
  itemCastItemSlug?: string;

  @ApiPropertyOptional({
    type: ArtifactRandomCastDto,
    description:
      'Cast de magia rolada em prop de artefato (instance_properties; 1× até DL)',
  })
  @IsOptional()
  @ValidateNested()
  @Type(() => ArtifactRandomCastDto)
  artifactRandomCast?: ArtifactRandomCastDto;
}

export class CastSpellResponseDto {
  @ApiProperty({ example: 'alarme' })
  spellSlug!: string;

  @ApiPropertyOptional({ example: 1 })
  slotLevelUsed!: number | null;

  @ApiPropertyOptional({
    example: 'Mísseis Mágicos: 7 dardo(s) · penetram Escudo',
  })
  note?: string | null;

  @ApiPropertyOptional({
    example: 18,
    description: 'CD fixa do item (Treasure); null = usar CD do personagem',
  })
  spellSaveDcOverride?: number | null;

  @ApiPropertyOptional({
    example: 10,
    description: 'Bônus de ataque mágico do item, se houver',
  })
  spellAttackBonusOverride?: number | null;

  @ApiProperty({ type: CharacterStateResponseDto })
  state!: CharacterStateResponseDto;
}
