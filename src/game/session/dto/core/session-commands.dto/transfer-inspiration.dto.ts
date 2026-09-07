import { ApiProperty } from '@nestjs/swagger';
import { IsUUID } from 'class-validator';

export class TransferInspirationDto {
  @ApiProperty({
    format: 'uuid',
    description: 'Aliado que recebe a Inspiração Heroica',
  })
  @IsUUID()
  targetCharacterId!: string;
}
