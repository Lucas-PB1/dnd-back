import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class SpellSlotsMapDto {
  @ApiPropertyOptional({ example: 2, description: 'Slots de 1º círculo disponíveis no total' })
  '1'?: number;

  @ApiPropertyOptional({ example: 0 })
  '2'?: number;

  @ApiPropertyOptional({ example: 0 })
  '3'?: number;

  @ApiPropertyOptional({ example: 0 })
  '4'?: number;

  @ApiPropertyOptional({ example: 0 })
  '5'?: number;

  @ApiPropertyOptional({ example: 0 })
  '6'?: number;

  @ApiPropertyOptional({ example: 0 })
  '7'?: number;

  @ApiPropertyOptional({ example: 0 })
  '8'?: number;

  @ApiPropertyOptional({ example: 0 })
  '9'?: number;
}

export class ClassResourceStateDto {
  @ApiProperty({ example: 'rage' })
  slug!: string;

  @ApiProperty({ example: 'Fúria' })
  name!: string;

  @ApiProperty({ example: 3 })
  max!: number;

  @ApiProperty({ example: 1 })
  used!: number;

  @ApiProperty({ example: 2 })
  remaining!: number;

  @ApiPropertyOptional({
    example: 8,
    description: 'Faces do dado associado (ex. Risk d8/d10/d12); omitido se N/A',
  })
  dieFaces?: number | null;

  @ApiPropertyOptional({
    example: 'd8',
    description: 'Rótulo do dado (ex. d8); omitido se N/A',
  })
  dieLabel?: string | null;
}

export class CharacterStateResponseDto {
  @ApiProperty({ example: { '1': 2 } })
  spellSlotsMax!: Record<string, number>;

  @ApiProperty({ example: { '1': 1 } })
  spellSlotsUsed!: Record<string, number>;

  @ApiProperty({ example: { '1': 1 } })
  spellSlotsRemaining!: Record<string, number>;

  @ApiProperty({ type: [ClassResourceStateDto] })
  classResources!: ClassResourceStateDto[];

  @ApiPropertyOptional({ example: 'alarme' })
  concentratingOn!: string | null;

  @ApiProperty({ example: ['poisoned'] })
  conditions!: string[];

  @ApiProperty({ example: 0 })
  tempHp!: number;

  @ApiPropertyOptional({ example: 8 })
  hitPointsCurrent!: number | null;

  @ApiPropertyOptional({ example: 10 })
  hitPointsMax!: number | null;

  @ApiProperty({
    example: 3,
    description: 'Dados de vida restantes (máximo = nível do personagem)',
  })
  hitDiceCurrent!: number;

  @ApiProperty({
    example: 5,
    description: 'Máximo de dados de vida (= nível)',
  })
  hitDiceMax!: number;

  @ApiPropertyOptional({
    example: 'D10',
    description: 'Dado de vida da classe (catálogo)',
  })
  hitDie!: string | null;

  @ApiProperty({
    example: 0,
    description: 'Sucessos em salvaguardas contra a morte (0–3)',
  })
  deathSaveSuccesses!: number;

  @ApiProperty({
    example: 0,
    description: 'Falhas em salvaguardas contra a morte (0–3)',
  })
  deathSaveFailures!: number;

  @ApiProperty({
    example: false,
    description: 'Inspiração (mantida no descanso longo)',
  })
  inspiration!: boolean;

  @ApiProperty({
    example: { 'repreensao-diabolica': 1 },
    description: 'Usos free já gastos de magias concedidas (1×/LD)',
  })
  grantedSpellUses!: Record<string, number>;

  @ApiProperty({
    example: false,
    description: 'Alto Elfo pode trocar o truque L1 após descanso longo',
  })
  highElfCantripSwapAvailable!: boolean;

  @ApiProperty({
    type: 'array',
    description: 'Economia e usos restantes de magias concedidas com free cast',
  })
  grantedSpellCastOptions!: Array<{
    spellSlug: string;
    castEconomy: 'at_will' | 'once_per_long_rest' | 'slot_only';
    freeCastsRemaining: number | null;
  }>;

  @ApiProperty({
    example: { revolver: 4 },
    description: 'Tiros restantes na câmara por arma com Recarga',
  })
  firearmChambers!: Record<string, number>;

  @ApiProperty({ example: false, description: 'Fúria do Bárbaro ativa' })
  rageActive!: boolean;

  @ApiProperty({
    example: false,
    description: 'Ataque Imprudente ativo',
  })
  recklessActive!: boolean;

  @ApiProperty({
    example: ['persona-mask-angel'],
    description: 'Máscaras de Persona equipadas (Colégio das Máscaras)',
  })
  personaMasks!: string[];

  @ApiProperty({
    example: 0,
    description: 'Nível de Aspecto Bestial (Beastborne), 0–5',
  })
  bestialAspectLevel!: number;

  @ApiProperty({
    example: false,
    description: 'Escudo de Mísseis armado (próximo cast de Mísseis Mágicos)',
  })
  missileShieldArmed!: boolean;

  @ApiProperty({
    example: false,
    description: 'Giga-Míssil armado (próximo cast de Mísseis Mágicos)',
  })
  gigaMissileArmed!: boolean;

  @ApiProperty({
    example: false,
    description: 'Forma Estrelada ativa (Círculo das Estrelas)',
  })
  starryFormActive!: boolean;

  @ApiPropertyOptional({
    example: 'archer',
    description: 'Constelação ativa na Forma Estrelada',
  })
  stellarConstellation!: string | null;
}
