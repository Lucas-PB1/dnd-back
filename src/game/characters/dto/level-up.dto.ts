import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsOptional, ValidateNested } from 'class-validator';
import { CharacterSheetInputDto } from './character-sheet.dto';

/** Escolhas opcionais ao subir de nível (mesmos campos parciais da ficha). */
export class LevelUpDto extends CharacterSheetInputDto {
  @ApiPropertyOptional({ example: 'champion' })
  @IsOptional()
  subclassSlug?: string;
}

export class LevelUpSpellOptionDto {
  @ApiProperty({ example: 'fire-bolt' })
  spellSlug!: string;

  @ApiProperty({ example: 'Raio de Fogo' })
  spellName!: string;

  @ApiProperty({ example: 0 })
  spellLevel!: number;
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
}
