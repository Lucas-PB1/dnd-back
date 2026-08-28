import { ApiProperty } from '@nestjs/swagger';
import { IsString, MaxLength } from 'class-validator';

export class CharacterNotesResponseDto {
  @ApiProperty({ format: 'uuid' })
  characterId!: string;

  @ApiProperty({ example: 'Pista: a chave está no porão.' })
  notes!: string;

  @ApiProperty({ type: String, format: 'date-time' })
  createdAt!: string;

  @ApiProperty({ type: String, format: 'date-time' })
  updatedAt!: string;
}

export class UpdateCharacterNotesDto {
  @ApiProperty({ maxLength: 8000 })
  @IsString()
  @MaxLength(8000)
  notes!: string;
}
