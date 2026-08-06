import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsArray,
  IsBoolean,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Max,
  Min,
  ValidateNested,
} from 'class-validator';

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
}

export class UseClassResourceDto {
  @ApiProperty({ example: 'rage' })
  @IsString()
  resourceSlug!: string;

  @ApiPropertyOptional({ example: 1, description: 'Usos a gastar (padrão 1)' })
  @IsOptional()
  @IsInt()
  @Min(1)
  amount?: number;
}

export class ResourceDieRollDto {
  @ApiProperty({ example: 'risk' })
  resourceSlug!: string;

  @ApiProperty({ example: 8 })
  faces!: number;

  @ApiProperty({ example: 5 })
  value!: number;

  @ApiProperty({ example: '1d8' })
  expression!: string;
}

export class UseClassResourceResponseDto {
  @ApiProperty({ type: CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiPropertyOptional({ type: ResourceDieRollDto })
  roll?: ResourceDieRollDto | null;
}

export class UseManeuverDto {
  @ApiProperty({ example: 'bite-the-bullet' })
  @IsString()
  maneuverSlug!: string;
}

export class UseManeuverResponseDto {
  @ApiProperty({ type: CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiProperty({ example: 'bite-the-bullet' })
  maneuverSlug!: string;

  @ApiProperty({ example: 'Morda a Bala' })
  maneuverName!: string;

  @ApiProperty({ example: 'temp_hp' })
  effectKind!: string;

  @ApiProperty({ type: ResourceDieRollDto })
  riskRoll!: ResourceDieRollDto;

  @ApiPropertyOptional({ example: 12 })
  tempHpGained?: number;

  @ApiPropertyOptional({ example: 7 })
  missDamage?: number;

  @ApiPropertyOptional({ example: 4 })
  acBonus?: number;

  @ApiPropertyOptional({ example: 3 })
  checkBonus?: number;

  @ApiProperty({ example: '+12 PV Temporários' })
  note!: string;
}

export class ToggleRageDto {
  @ApiPropertyOptional({
    example: true,
    description: 'true = entrar (gasta 1 Fúria); false = sair; omitido = alternar',
  })
  @IsOptional()
  @IsBoolean()
  active?: boolean;
}

export class ToggleRecklessDto {
  @ApiPropertyOptional({
    example: true,
    description: 'true = ativar; false = desativar; omitido = alternar',
  })
  @IsOptional()
  @IsBoolean()
  active?: boolean;
}

export class SecondWindResponseDto {
  @ApiProperty({ type: () => CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiProperty({ example: '1d10+5' })
  expression!: string;

  @ApiProperty({ example: 12 })
  healAmount!: number;

  @ApiProperty({ example: 8 })
  hitPointsCurrent!: number;

  @ApiPropertyOptional({
    example: 'Ajuste Tático: mova-se até metade do Deslocamento sem provocar AO',
  })
  note?: string;
}

export class TacticalMindDto {
  /** Opcional: se enviados check+CD, só gasta Fôlego se virar sucesso. */
  @ApiPropertyOptional({
    example: 14,
    description:
      'Total atual do teste (opcional). Sem check/CD, gasta 1 uso e só rola o +1d10.',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  checkTotal?: number;

  @ApiPropertyOptional({
    example: 15,
    description: 'CD do teste (opcional; exige checkTotal).',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  dc?: number;
}

export class TacticalMindResponseDto {
  @ApiProperty({ type: () => CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiProperty({ example: '1d10' })
  expression!: string;

  @ApiProperty({ example: 7 })
  roll!: number;

  @ApiPropertyOptional({
    example: 21,
    description: 'Total com bônus; só quando checkTotal foi informado',
  })
  newTotal?: number;

  @ApiPropertyOptional({
    example: true,
    description: 'Sucesso vs CD; só quando check+CD foram informados',
  })
  success?: boolean;

  @ApiProperty({ example: true })
  resourceSpent!: boolean;

  @ApiProperty({ example: 'Mente Tática: +7 (1d10). Some ao teste.' })
  note!: string;
}

export class ActionSurgeResponseDto {
  @ApiProperty({ type: () => CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiProperty({
    example: 'Surto de Ação: execute uma ação adicional (exceto Usar Magia)',
  })
  note!: string;
}

export class UseBattleMasterManeuverDto {
  @ApiProperty({ example: 'trip-attack' })
  @IsString()
  maneuverSlug!: string;

  @ApiPropertyOptional({
    example: false,
    description:
      'Implacável (nível 15+): usa 1d8 sem gastar Superioridade; controle de 1×/turno fica na mesa',
  })
  @IsOptional()
  @IsBoolean()
  useRelentless?: boolean;
}

export class TableActionResponseDto {
  @ApiProperty({ type: () => CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiProperty({ example: 'Ataque Derrubador' })
  actionName!: string;

  @ApiPropertyOptional({ example: '1d8' })
  expression?: string;

  @ApiPropertyOptional({ example: 6 })
  roll?: number;

  @ApiPropertyOptional({ example: 9 })
  total?: number;

  @ApiPropertyOptional({ example: 15 })
  saveDc?: number;

  @ApiProperty({ example: true })
  resourceSpent!: boolean;

  @ApiProperty({
    example:
      'Ataque Derrubador: Dado de Superioridade = 6. CD 15, quando aplicável.',
  })
  note!: string;
}

/** @deprecated Use TableActionResponseDto — alias de compatibilidade. */
export class FighterTableActionResponseDto extends TableActionResponseDto {}

export class UsePsiWarriorActionDto {
  @ApiProperty({
    enum: [
      'protective-field',
      'telekinetic-movement',
      'psychic-leap',
      'mental-guard',
      'energy-bulwark',
      'telekinetic-master',
    ],
    example: 'protective-field',
  })
  @IsIn([
    'protective-field',
    'telekinetic-movement',
    'psychic-leap',
    'mental-guard',
    'energy-bulwark',
    'telekinetic-master',
  ])
  actionSlug!:
    | 'protective-field'
    | 'telekinetic-movement'
    | 'psychic-leap'
    | 'mental-guard'
    | 'energy-bulwark'
    | 'telekinetic-master';

  @ApiPropertyOptional({
    example: false,
    description:
      'Gasta Energia Psiônica em vez do uso gratuito da característica',
  })
  @IsOptional()
  @IsBoolean()
  usePsiDie?: boolean;
}

export class UseDungeonPrecautionDto {
  @ApiProperty({ example: 'detectar-magia' })
  @IsString()
  spellSlug!: string;
}

export class UseRogueTableActionDto {
  @ApiProperty({
    enum: [
      'psychic-blade-main',
      'psychic-blade-bonus',
      'psi-bolstered-knack',
      'guided-strike',
      'psychic-whispers',
      'psychic-teleport',
      'psychic-veil',
      'rend-mind',
      'spell-thief',
      'arachnoid-web',
      'magic-device-charge',
    ],
  })
  @IsIn([
    'psychic-blade-main',
    'psychic-blade-bonus',
    'psi-bolstered-knack',
    'guided-strike',
    'psychic-whispers',
    'psychic-teleport',
    'psychic-veil',
    'rend-mind',
    'spell-thief',
    'arachnoid-web',
    'magic-device-charge',
  ])
  actionSlug!:
    | 'psychic-blade-main'
    | 'psychic-blade-bonus'
    | 'psi-bolstered-knack'
    | 'guided-strike'
    | 'psychic-whispers'
    | 'psychic-teleport'
    | 'psychic-veil'
    | 'rend-mind'
    | 'spell-thief'
    | 'arachnoid-web'
    | 'magic-device-charge';

  @ApiPropertyOptional({ description: 'Total atual do teste ou ataque' })
  @IsOptional()
  @IsInt()
  checkTotal?: number;

  @ApiPropertyOptional({ description: 'CD do teste ou CA do alvo' })
  @IsOptional()
  @IsInt()
  @Min(1)
  dc?: number;

  @ApiPropertyOptional({
    default: false,
    description: 'Gasta Dados de Energia Psiônica em vez do uso gratuito',
  })
  @IsOptional()
  @IsBoolean()
  usePsiDie?: boolean;
}

export class UseMonkTableActionDto {
  @ApiProperty({
    enum: [
      'flurry-of-blows',
      'patient-defense',
      'step-of-the-wind',
      'stunning-strike',
      'open-hand-technique',
      'elemental-blast',
      'hand-of-healing',
      'hand-of-harm',
      'shadow-step',
    ],
  })
  @IsIn([
    'flurry-of-blows',
    'patient-defense',
    'step-of-the-wind',
    'stunning-strike',
    'open-hand-technique',
    'elemental-blast',
    'hand-of-healing',
    'hand-of-harm',
    'shadow-step',
  ])
  actionSlug!:
    | 'flurry-of-blows'
    | 'patient-defense'
    | 'step-of-the-wind'
    | 'stunning-strike'
    | 'open-hand-technique'
    | 'elemental-blast'
    | 'hand-of-healing'
    | 'hand-of-harm'
    | 'shadow-step';
}

export class UsePaladinTableActionDto {
  @ApiProperty({
    enum: [
      'lay-on-hands',
      'cure-poison',
      'divine-sense',
      'abjure-enemies',
      'oath-channel',
    ],
  })
  @IsIn([
    'lay-on-hands',
    'cure-poison',
    'divine-sense',
    'abjure-enemies',
    'oath-channel',
  ])
  actionSlug!:
    | 'lay-on-hands'
    | 'cure-poison'
    | 'divine-sense'
    | 'abjure-enemies'
    | 'oath-channel';

  @ApiPropertyOptional({
    minimum: 1,
    description: 'Pontos de Mãos Consagradas a gastar (cura)',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  amount?: number;
}

export class UseRangerTableActionDto {
  @ApiProperty({
    enum: [
      'hunters-mark-free',
      'tireless',
      'natures-veil',
      'fey-reinforcements',
      'misty-wanderer',
      'primal-companion',
      'set-bestial-aspect',
      'feral-howl',
    ],
  })
  @IsIn([
    'hunters-mark-free',
    'tireless',
    'natures-veil',
    'fey-reinforcements',
    'misty-wanderer',
    'primal-companion',
    'set-bestial-aspect',
    'feral-howl',
  ])
  actionSlug!:
    | 'hunters-mark-free'
    | 'tireless'
    | 'natures-veil'
    | 'fey-reinforcements'
    | 'misty-wanderer'
    | 'primal-companion'
    | 'set-bestial-aspect'
    | 'feral-howl';

  @ApiPropertyOptional({
    minimum: 0,
    maximum: 5,
    description: 'Nível de Aspecto Bestial (set-bestial-aspect)',
  })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(5)
  level?: number;
}

const CLERIC_TABLE_ACTION_SLUGS = [
  'divine-spark-heal',
  'divine-spark-damage',
  'turn-undead',
  'divine-intervention',
  'preserve-life',
  'radiance-of-dawn',
  'warding-flare',
  'crown-of-light',
  'tricksters-blessing',
  'invoke-duplicity',
  'guided-strike',
  'war-priest',
  'war-gods-blessing',
] as const;

export class UseClericTableActionDto {
  @ApiProperty({ enum: CLERIC_TABLE_ACTION_SLUGS })
  @IsIn(CLERIC_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof CLERIC_TABLE_ACTION_SLUGS)[number];
}

const BARD_TABLE_ACTION_SLUGS = [
  'grant-inspiration',
  'cutting-words',
  'enthralling-performance',
  'agile-response',
  'unarmed-dance',
  'combat-inspiration',
  'superior-inspiration',
  'set-persona-masks',
] as const;

export class UseBardTableActionDto {
  @ApiProperty({ enum: BARD_TABLE_ACTION_SLUGS })
  @IsIn(BARD_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof BARD_TABLE_ACTION_SLUGS)[number];

  @ApiPropertyOptional({
    type: [String],
    description: 'Máscaras a vestir (set-persona-masks)',
    example: ['persona-mask-angel'],
  })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  masks?: string[];
}

const SORCERER_TABLE_ACTION_SLUGS = [
  'convert-slot-1-to-points',
  'convert-slot-2-to-points',
  'convert-slot-3-to-points',
  'convert-slot-4-to-points',
  'convert-slot-5-to-points',
  'convert-points-to-slot-1',
  'convert-points-to-slot-2',
  'convert-points-to-slot-3',
  'convert-points-to-slot-4',
  'convert-points-to-slot-5',
  'use-metamagic-1',
  'use-metamagic-2',
  'use-metamagic-3',
  'innate-sorcery',
  'sorcerous-restoration',
  'tides-of-chaos',
  'bastion-of-law',
] as const;

export class UseSorcererTableActionDto {
  @ApiProperty({ enum: SORCERER_TABLE_ACTION_SLUGS })
  @IsIn(SORCERER_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof SORCERER_TABLE_ACTION_SLUGS)[number];
}

const WARLOCK_TABLE_ACTION_SLUGS = [
  'magical-cunning',
  'healing-light',
  'dark-ones-own-luck',
  'fey-step-effect',
  'awakened-mind',
  'fiendish-resilience',
] as const;

export class UseWarlockTableActionDto {
  @ApiProperty({ enum: WARLOCK_TABLE_ACTION_SLUGS })
  @IsIn(WARLOCK_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof WARLOCK_TABLE_ACTION_SLUGS)[number];
}

const DRUID_TABLE_ACTION_SLUGS = [
  'wild-shape',
  'wild-resurgence-slot',
  'wild-resurgence-shape',
  'starry-form-archer',
  'starry-form-chalice',
  'starry-form-dragon',
  'wrath-of-the-sea',
  'moon-combat-wild-shape',
] as const;

export class UseDruidTableActionDto {
  @ApiProperty({ enum: DRUID_TABLE_ACTION_SLUGS })
  @IsIn(DRUID_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof DRUID_TABLE_ACTION_SLUGS)[number];
}

const WIZARD_TABLE_ACTION_SLUGS = [
  'arcane-recovery-1',
  'arcane-recovery-2',
  'arcane-recovery-3',
  'arcane-recovery-4',
  'arcane-recovery-5',
  'arcane-ward',
  'portent',
  'sculpt-spells',
  'improved-illusions',
  'spell-mastery',
] as const;

export class UseWizardTableActionDto {
  @ApiProperty({ enum: WIZARD_TABLE_ACTION_SLUGS })
  @IsIn(WIZARD_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof WIZARD_TABLE_ACTION_SLUGS)[number];
}

export class FirearmChamberDto {
  @ApiProperty({ example: 'revolver' })
  itemSlug!: string;

  @ApiProperty({ example: 4 })
  remaining!: number;

  @ApiProperty({ example: 6 })
  capacity!: number;
}

export class ReloadFirearmDto {
  @ApiProperty({ example: 'revolver' })
  @IsString()
  itemSlug!: string;
}

export class FireChamberDto {
  @ApiProperty({ example: 'revolver' })
  @IsString()
  itemSlug!: string;

  @ApiPropertyOptional({
    example: 1,
    description: 'Tiros a gastar (Automática = 2)',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  shots?: number;
}

export class PatchCharacterStateDto {
  @ApiPropertyOptional({ example: ['poisoned'] })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  conditions?: string[];

  @ApiPropertyOptional({ example: 5 })
  @IsOptional()
  @IsInt()
  @Min(0)
  tempHp?: number;

  @ApiPropertyOptional({ example: null, description: 'null para encerrar concentração' })
  @IsOptional()
  @IsString()
  concentratingOn?: string | null;

  @ApiPropertyOptional({ example: 2, description: 'Sucessos em death saves (0–3)' })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(3)
  deathSaveSuccesses?: number;

  @ApiPropertyOptional({ example: 1, description: 'Falhas em death saves (0–3)' })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(3)
  deathSaveFailures?: number;

  @ApiPropertyOptional({ example: true })
  @IsOptional()
  @IsBoolean()
  inspiration?: boolean;
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
}

export class CastSpellResponseDto {
  @ApiProperty({ example: 'alarme' })
  spellSlug!: string;

  @ApiPropertyOptional({ example: 1 })
  slotLevelUsed!: number | null;

  @ApiProperty({ type: CharacterStateResponseDto })
  state!: CharacterStateResponseDto;
}

export class RestDto {
  @ApiProperty({ enum: ['short', 'long'] })
  @IsIn(['short', 'long'])
  type!: 'short' | 'long';

  @ApiPropertyOptional({
    example: 1,
    description:
      'Dados de vida a gastar no descanso curto (ignorado no longo). Padrão 0.',
  })
  @IsOptional()
  @IsInt()
  @Min(0)
  hitDiceSpent?: number;
}

export class RestResponseDto {
  @ApiProperty({ enum: ['short', 'long'] })
  type!: 'short' | 'long';

  @ApiProperty({ type: CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiPropertyOptional({ example: 1 })
  hitDiceSpent?: number;

  @ApiPropertyOptional({ example: [7, 4], description: 'Faces brutas dos dados gastos' })
  hitDiceRolls?: number[];

  @ApiPropertyOptional({ example: 12 })
  hitPointsHealed?: number;
}
