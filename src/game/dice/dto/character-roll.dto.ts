import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsArray,
  IsBoolean,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Max,
  Min,
} from 'class-validator';
import type { AdvantageMode } from '../domain/dice';

export class RollAttackDto {
  @ApiProperty({ example: 'longsword' })
  @IsString()
  itemSlug!: string;

  @ApiProperty({ enum: ['melee', 'ranged'], example: 'melee' })
  @IsIn(['melee', 'ranged'])
  mode!: 'melee' | 'ranged';

  @ApiPropertyOptional({
    enum: ['normal', 'advantage', 'disadvantage'],
    default: 'normal',
  })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: AdvantageMode;

  @ApiPropertyOptional({
    default: false,
    description: 'Maestria Automática: forçar desvantagem (2 ataques / 2× munição)',
  })
  @IsOptional()
  @IsBoolean()
  automatic?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Ataques Estudados (Guerreiro nv.13+): vantagem após errar o mesmo alvo',
  })
  @IsOptional()
  @IsBoolean()
  studiedAttack?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Chute na Porta (Explorador de Masmorras): vantagem na 1ª rodada',
  })
  @IsOptional()
  @IsBoolean()
  doorKick?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Mira Firme (Ladino nv.3+): vantagem; deslocamento 0 neste turno',
  })
  @IsOptional()
  @IsBoolean()
  steadyAim?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Golpe de Sorte (Ladino nv.20): transforma o d20 em 20 e gasta o uso',
  })
  @IsOptional()
  @IsBoolean()
  strokeOfLuck?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Assassinar: vantagem contra criatura que ainda não agiu na primeira rodada',
  })
  @IsOptional()
  @IsBoolean()
  assassinate?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Caçador Preciso (Guardião nv.17): vantagem contra a criatura marcada',
  })
  @IsOptional()
  @IsBoolean()
  preciseHunter?: boolean;
}

export class RollDamageDto {
  @ApiProperty({ example: 'longsword' })
  @IsString()
  itemSlug!: string;

  @ApiProperty({ enum: ['melee', 'ranged'], example: 'melee' })
  @IsIn(['melee', 'ranged'])
  mode!: 'melee' | 'ranged';

  @ApiPropertyOptional({ default: false })
  @IsOptional()
  @IsBoolean()
  critical?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Dano de Garantido (Graze) no erro — só modificador de atributo',
  })
  @IsOptional()
  @IsBoolean()
  grazeMiss?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Tiro na cabeça (Pistoleiro nv.20, no crítico): +10d10 ou morte se <100 PV',
  })
  @IsOptional()
  @IsBoolean()
  headShot?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Maestria Mira: rerrolar um dado de dano',
  })
  @IsOptional()
  @IsBoolean()
  sightedReroll?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Golpe Brutal (Bárbaro nv.9+): dados extras; abre mão da vantagem do Imprudente',
  })
  @IsOptional()
  @IsBoolean()
  brutalStrike?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Fúria Divina (Fanático): 1d6 + metade do nível enquanto enfurecido',
  })
  @IsOptional()
  @IsBoolean()
  divineFury?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Golpe Psiônico (Combatente Psíquico): gasta 1 Dado de Energia + INT',
  })
  @IsOptional()
  @IsBoolean()
  psiStrike?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Matar Monstro (Explorador de Masmorras): +1d10 vs tipos elegíveis',
  })
  @IsOptional()
  @IsBoolean()
  monsterSlayer?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Ataque Furtivo (Ladino): adiciona os dados permitidos pelo nível',
  })
  @IsOptional()
  @IsBoolean()
  sneakAttack?: boolean;

  @ApiPropertyOptional({
    type: [String],
    enum: [
      'poison',
      'withdraw',
      'trip',
      'hidden-attack',
      'daze',
      'knock-out',
      'obscure',
      'paralyze',
    ],
    description: 'Efeitos de Golpe Astuto; o custo é removido dos dados de Ataque Furtivo',
  })
  @IsOptional()
  @IsArray()
  @IsIn(
    [
      'poison',
      'withdraw',
      'trip',
      'hidden-attack',
      'daze',
      'knock-out',
      'obscure',
      'paralyze',
    ],
    { each: true },
  )
  cunningStrikeEffects?: string[];

  @ApiPropertyOptional({
    default: false,
    description: 'Golpe Venenoso (Perseguidor Aracnídeo): Ataque Furtivo usa d8 Venenoso',
  })
  @IsOptional()
  @IsBoolean()
  poisonousSneak?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Golpe Surpreendente (Assassino): soma o nível de Ladino na primeira rodada',
  })
  @IsOptional()
  @IsBoolean()
  assassinSurprise?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Golpe Mortal (Assassino nv.17): dobra o dano quando o alvo falha na salvaguarda',
  })
  @IsOptional()
  @IsBoolean()
  assassinDeathStrike?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Armas Venenosas (Assassino nv.13): +2d6 quando Envenenar falha',
  })
  @IsOptional()
  @IsBoolean()
  assassinPoisonFailedSave?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Destruição Divina (Paladino): gasta um espaço de magia e adiciona dano Radiante',
  })
  @IsOptional()
  @IsBoolean()
  divineSmite?: boolean;

  @ApiPropertyOptional({
    minimum: 1,
    maximum: 5,
    description: 'Círculo do espaço de magia gasto na Destruição Divina',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(5)
  smiteSlotLevel?: number;

  @ApiPropertyOptional({
    default: false,
    description: 'Destruição Divina contra Corruptor ou Morto-vivo: +1d8',
  })
  @IsOptional()
  @IsBoolean()
  smiteVsUndeadOrFiend?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Marca do Predador (Guardião): adiciona o dado da marca (1d6 ou 1d10 no nv.20)',
  })
  @IsOptional()
  @IsBoolean()
  huntersMark?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Assassino de Colossos (Caçador): +1d8 1×/turno contra alvo abaixo do máximo de PV',
  })
  @IsOptional()
  @IsBoolean()
  colossusSlayer?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Golpes Terríveis (Andarilho Feérico): +1d4/+1d6 Psíquico 1×/turno',
  })
  @IsOptional()
  @IsBoolean()
  dreadfulStrikes?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Golpe Terrível (Vigilante das Sombras): +2d6/+2d8 Psíquico; gasta 1 uso',
  })
  @IsOptional()
  @IsBoolean()
  dreadAmbusher?: boolean;
}

export class RollSkillDto {
  @ApiProperty({ example: 'athletics' })
  @IsString()
  skillSlug!: string;

  @ApiPropertyOptional({
    enum: ['normal', 'advantage', 'disadvantage'],
    default: 'normal',
  })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: AdvantageMode;

  @ApiPropertyOptional({
    default: false,
    description: 'Golpe de Sorte (Ladino nv.20): transforma o d20 em 20 e gasta o uso',
  })
  @IsOptional()
  @IsBoolean()
  strokeOfLuck?: boolean;
}

export class RollSavingThrowDto {
  @ApiProperty({
    example: 'destreza',
    enum: ['forca', 'destreza', 'constituicao', 'inteligencia', 'sabedoria', 'carisma'],
  })
  @IsIn(['forca', 'destreza', 'constituicao', 'inteligencia', 'sabedoria', 'carisma'])
  abilitySlug!: string;

  @ApiPropertyOptional({
    enum: ['normal', 'advantage', 'disadvantage'],
    default: 'normal',
  })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: AdvantageMode;

  @ApiPropertyOptional({
    default: false,
    description:
      'Indomável (Guerreiro nv.9+): rerrola salvaguarda com +nível (gasta uso)',
  })
  @IsOptional()
  @IsBoolean()
  indomitable?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Golpe de Sorte (Ladino nv.20): transforma o d20 em 20 e gasta o uso',
  })
  @IsOptional()
  @IsBoolean()
  strokeOfLuck?: boolean;
}

export class RollInitiativeDto {
  @ApiPropertyOptional({
    enum: ['normal', 'advantage', 'disadvantage'],
    default: 'normal',
  })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: AdvantageMode;

  @ApiPropertyOptional({
    default: false,
    description: 'Golpe de Sorte (Ladino nv.20): transforma o d20 em 20 e gasta o uso',
  })
  @IsOptional()
  @IsBoolean()
  strokeOfLuck?: boolean;
}

export class CharacterRollResponseDto {
  @ApiProperty({ example: 'attack' })
  kind!: 'attack' | 'damage' | 'skill' | 'saving_throw' | 'initiative';

  @ApiProperty({ example: 'Ataque — Espada Longa (corpo a corpo)' })
  label!: string;

  @ApiProperty({ example: '1d20+5' })
  expression!: string;

  @ApiProperty({ example: 17 })
  total!: number;

  @ApiProperty({ example: 5 })
  modifier!: number;

  @ApiPropertyOptional({ enum: ['normal', 'advantage', 'disadvantage'] })
  mode?: AdvantageMode;

  @ApiPropertyOptional()
  critical?: boolean;

  @ApiPropertyOptional({
    description: 'Faces do d20 (checks) ou dados de dano',
  })
  rolls!: number[];

  @ApiPropertyOptional({ description: 'Faces mantidas (vantagem/desvantagem)' })
  kept?: number[];

  @ApiPropertyOptional({
    description: 'Nota situacional (Tiro intestinal, Tiro na cabeça, etc.)',
  })
  note?: string;
}
