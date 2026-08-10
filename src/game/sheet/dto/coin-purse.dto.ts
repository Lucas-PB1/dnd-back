import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsInt, IsOptional, Min, ValidateNested } from 'class-validator';

export class CoinPurseDto {
  @ApiProperty({ example: 0, description: 'PC — cobre' })
  copper!: number;

  @ApiProperty({ example: 0, description: 'PP — prata' })
  silver!: number;

  @ApiProperty({ example: 0, description: 'PE — electrum' })
  electrum!: number;

  @ApiProperty({ example: 0, description: 'PO — ouro' })
  gold!: number;

  @ApiProperty({ example: 0, description: 'PL — platina' })
  platinum!: number;
}

/** Campos opcionais para set parcial. */
export class CoinPursePartialDto {
  @ApiPropertyOptional({ example: 10 })
  @IsOptional()
  @IsInt()
  @Min(0)
  copper?: number;

  @ApiPropertyOptional({ example: 5 })
  @IsOptional()
  @IsInt()
  @Min(0)
  silver?: number;

  @ApiPropertyOptional({ example: 0 })
  @IsOptional()
  @IsInt()
  @Min(0)
  electrum?: number;

  @ApiPropertyOptional({ example: 50 })
  @IsOptional()
  @IsInt()
  @Min(0)
  gold?: number;

  @ApiPropertyOptional({ example: 1 })
  @IsOptional()
  @IsInt()
  @Min(0)
  platinum?: number;
}

export class PatchCharacterWealthDto {
  @ApiProperty({
    type: CoinPursePartialDto,
    description: 'Saldos absolutos (set) — campos omitidos permanecem',
  })
  @ValidateNested()
  @Type(() => CoinPursePartialDto)
  coins!: CoinPursePartialDto;
}
