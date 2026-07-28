import { ApiProperty } from '@nestjs/swagger';

export class CharacterCampaignRefDto {
  @ApiProperty({ format: 'uuid' })
  id!: string;

  @ApiProperty({ example: 'Ruínas de Shadowdale' })
  name!: string;
}
