import { ApiProperty } from '@nestjs/swagger';
import { IsInt, Max, Min } from 'class-validator';

export class AbilityScoresDto {
  @ApiProperty({ example: 15 })
  @IsInt()
  @Min(1)
  @Max(30)
  forca!: number;

  @ApiProperty({ example: 14 })
  @IsInt()
  @Min(1)
  @Max(30)
  destreza!: number;

  @ApiProperty({ example: 13 })
  @IsInt()
  @Min(1)
  @Max(30)
  constituicao!: number;

  @ApiProperty({ example: 10 })
  @IsInt()
  @Min(1)
  @Max(30)
  inteligencia!: number;

  @ApiProperty({ example: 12 })
  @IsInt()
  @Min(1)
  @Max(30)
  sabedoria!: number;

  @ApiProperty({ example: 8 })
  @IsInt()
  @Min(1)
  @Max(30)
  carisma!: number;
}
