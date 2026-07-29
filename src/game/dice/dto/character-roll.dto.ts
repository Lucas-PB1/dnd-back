import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsBoolean, IsIn, IsOptional, IsString } from 'class-validator';
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
    description:
      'Ataque Preciso (Mestre da Batalha): adiciona Dado de Superioridade (já gasto na sessão)',
  })
  @IsOptional()
  @IsBoolean()
  precisionAttack?: boolean;
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
}

export class RollInitiativeDto {
  @ApiPropertyOptional({
    enum: ['normal', 'advantage', 'disadvantage'],
    default: 'normal',
  })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: AdvantageMode;
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
