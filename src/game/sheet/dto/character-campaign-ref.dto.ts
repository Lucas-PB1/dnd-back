import { ApiProperty } from '@nestjs/swagger';

export class CharacterCampaignRefDto {
  @ApiProperty({ format: 'uuid' })
  id!: string;

  @ApiProperty({ example: 'Ruínas de Shadowdale' })
  name!: string;

  @ApiProperty({
    example: false,
    description:
      'Players podem adicionar item sem debitar moedas (checkbox “Não pagar”)',
  })
  allowPlayerSkipPayment!: boolean;

  @ApiProperty({
    enum: ['dm', 'player', 'assistant'],
    nullable: true,
    description: 'Papel do viewer nesta campanha (null se não for membro)',
  })
  myRole!: 'dm' | 'player' | 'assistant' | null;
}
