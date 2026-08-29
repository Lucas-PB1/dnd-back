import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  CreatureTemplateActionDto,
  CreatureTemplateSpeedDto,
  CreatureTemplateTraitDto,
} from '../../creature-templates/dto/creature-template-response.dto';

export class VehicleTemplateSummaryResponseDto {
  @ApiProperty()
  slug!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty()
  editionSlug!: string;

  @ApiPropertyOptional({ nullable: true })
  armorClass!: number | null;

  @ApiPropertyOptional({ nullable: true })
  hitPoints!: number | null;

  @ApiPropertyOptional({ nullable: true })
  crewCapacity!: number | null;

  @ApiPropertyOptional({
    example: '/catalog/ships/aeronave.png',
    nullable: true,
  })
  imageUrl!: string | null;
}

export class VehicleTemplateResponseDto extends VehicleTemplateSummaryResponseDto {
  @ApiPropertyOptional({ nullable: true })
  subtitle!: string | null;

  @ApiPropertyOptional({ nullable: true })
  damageThreshold!: number | null;

  @ApiPropertyOptional({ nullable: true })
  passengerCapacity!: number | null;

  @ApiPropertyOptional({ nullable: true })
  cargoCapacityLb!: number | null;

  @ApiPropertyOptional({ nullable: true })
  cargoCapacityLabel!: string | null;

  @ApiPropertyOptional({ nullable: true })
  initiativeModifier!: number | null;

  @ApiPropertyOptional({ nullable: true })
  abilityScores!: Record<string, number> | null;

  @ApiProperty({ type: [CreatureTemplateSpeedDto] })
  speeds!: CreatureTemplateSpeedDto[];

  @ApiProperty({ type: [CreatureTemplateActionDto] })
  actions!: CreatureTemplateActionDto[];

  @ApiProperty({ type: [CreatureTemplateTraitDto] })
  traits!: CreatureTemplateTraitDto[];
}
