import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsIn, IsOptional, IsString } from 'class-validator';
import { CharacterSheetInputDto } from '../../sheet/dto/character-sheet.dto';

/** Escolhas opcionais ao subir de nível (mesmos campos parciais da ficha). */
export class LevelUpDto extends CharacterSheetInputDto {
  @ApiPropertyOptional({ example: 'champion' })
  @IsOptional()
  subclassSlug?: string;

  @ApiPropertyOptional({
    enum: ['plus2', 'plus1plus1'],
    description:
      'ASI no level-up: +2 em um atributo ou +1 em dois distintos. Só válido em níveis ASI/talento.',
  })
  @IsOptional()
  @IsIn(['plus2', 'plus1plus1'])
  asiDistributionMode?: 'plus2' | 'plus1plus1';

  @ApiPropertyOptional({
    example: 'forca',
    description: 'Atributo principal do ASI (+2 ou primeiro +1)',
  })
  @IsOptional()
  @IsString()
  asiPrimaryAbilitySlug?: string;

  @ApiPropertyOptional({
    example: 'destreza',
    description: 'Segundo atributo (+1); obrigatório quando asiDistributionMode = plus1plus1',
  })
  @IsOptional()
  @IsString()
  asiSecondaryAbilitySlug?: string;
}

export class LevelUpSpellOptionDto {
  @ApiProperty({ example: 'fire-bolt' })
  spellSlug!: string;

  @ApiProperty({ example: 'Raio de Fogo' })
  spellName!: string;

  @ApiProperty({ example: 0 })
  spellLevel!: number;
}

export class LevelUpClassExpertiseSlotDto {
  @ApiProperty({ example: 'expertiseSkill3' })
  optionKey!: string;

  @ApiProperty({ example: 6 })
  unlockLevel!: number;
}

export class LevelUpWeaponMasterySlotDto {
  @ApiProperty({ example: 'masteryWeapon4' })
  optionKey!: string;

  @ApiProperty({ example: 4 })
  unlockLevel!: number;
}

export class LevelUpPreviewDto {
  @ApiProperty({ example: 1 })
  currentLevel!: number;

  @ApiProperty({ example: 2 })
  nextLevel!: number;

  @ApiProperty({ example: 2 })
  currentProficiencyBonus!: number;

  @ApiProperty({ example: 2 })
  nextProficiencyBonus!: number;

  @ApiProperty({ example: 6, description: 'Ganho médio de HP no próximo nível (classe + CON)' })
  estimatedHpGain!: number;

  @ApiProperty({ example: 12 })
  estimatedHitPointsMax!: number;

  @ApiProperty({ example: false })
  subclassRequired!: boolean;

  @ApiPropertyOptional({ example: 3 })
  subclassUnlockLevel?: number;

  @ApiProperty({ example: false })
  isAsiOrFeatLevel!: boolean;

  @ApiProperty({ type: [LevelUpSpellOptionDto] })
  newSpellOptions!: LevelUpSpellOptionDto[];

  @ApiProperty({
    type: [LevelUpClassExpertiseSlotDto],
    description: 'Novos slots de Especialização desbloqueados no próximo nível',
  })
  newClassExpertiseSlots!: LevelUpClassExpertiseSlotDto[];

  @ApiProperty({
    type: [LevelUpWeaponMasterySlotDto],
    description: 'Novos slots de Maestria em Arma desbloqueados no próximo nível',
  })
  newWeaponMasterySlots!: LevelUpWeaponMasterySlotDto[];
}
