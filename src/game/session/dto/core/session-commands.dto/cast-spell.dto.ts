import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsArray,
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

export class SpiritSelectionDto {
  @ApiProperty({ example: 'medio' })
  @IsString()
  variantKey!: string;

  @ApiProperty({ example: 2 })
  @IsInt()
  @Min(1)
  count!: number;
}

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

  @ApiPropertyOptional({
    example: 1,
    description:
      'Flex Caster Elevação: espaços extras do mesmo círculo (além do principal)',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  flexElevateExtraSlots?: number;

  @ApiPropertyOptional({
    example: true,
    description:
      'Flex Caster Redução: conjurar no círculo base e recuperar um espaço de 1º',
  })
  @IsOptional()
  @IsBoolean()
  flexReduce?: boolean;

  @ApiPropertyOptional({
    example: 'celestial',
    description:
      'Variante tipada para magias spirit_actor / Find Steed (obrigatório se a magia estiver em phb_spell_spirit)',
  })
  @IsOptional()
  @IsString()
  spiritVariantKey?: string;

  @ApiPropertyOptional({
    example: 2,
    description:
      'Quantidade da mesma variante (Animar Objetos). Ignorado se spiritSelections for enviado.',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  spiritCount?: number;

  @ApiPropertyOptional({
    type: [SpiritSelectionDto],
    description:
      'Seleções mistas por tamanho (Animar Objetos). Orçamento = mod. conjuração (1/2/3).',
  })
  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => SpiritSelectionDto)
  spiritSelections?: SpiritSelectionDto[];
}

export class CastSpellSpiritDto {
  @ApiProperty({ example: 'uuid-actor' })
  actorId!: string;

  @ApiProperty({ example: 'montaria-sobrenatural-celestial' })
  templateSlug!: string;

  @ApiProperty({ example: 'celestial' })
  variantKey!: string;

  @ApiProperty({ example: 'Celestial' })
  variantLabel!: string;

  @ApiProperty({ example: false })
  reused!: boolean;

  @ApiPropertyOptional({ example: 12 })
  armorClass!: number | null;

  @ApiPropertyOptional({ example: 25 })
  hitPointsMax!: number | null;
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

  @ApiPropertyOptional({
    type: CastSpellSpiritDto,
    description:
      'Primeiro actor spirit/montaria sincronizado após o cast (compat)',
  })
  spirit?: CastSpellSpiritDto | null;

  @ApiPropertyOptional({
    type: [CastSpellSpiritDto],
    description: 'Todos os actors spawnados (Animar Objetos multi-token)',
  })
  spirits?: CastSpellSpiritDto[] | null;

  @ApiProperty({ type: CharacterStateResponseDto })
  state!: CharacterStateResponseDto;
}
