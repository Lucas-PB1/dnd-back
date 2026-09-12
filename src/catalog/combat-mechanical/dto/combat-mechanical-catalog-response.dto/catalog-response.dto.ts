import { ApiProperty } from '@nestjs/swagger';
import {
  BattleMasterManeuverDto,
  BeastborneAspectBenefitDto,
  CunningStrikeEffectDto,
  GunslingerManeuverDto,
  PersonaMaskDto,
  PrecautionSpellDto,
  StrikeOptionDto,
  SubclassTableActionDto,
} from './maneuvers-effects.dto';
import { ClassEconomyActionDto, ClassPanelActionDto } from './economy-panel.dto';


export class CombatMechanicalCatalogResponseDto {
  @ApiProperty({ type: [GunslingerManeuverDto] })
  gunslingerManeuvers!: GunslingerManeuverDto[];

  @ApiProperty({ type: [BattleMasterManeuverDto] })
  battleMasterManeuvers!: BattleMasterManeuverDto[];

  @ApiProperty({ type: [CunningStrikeEffectDto] })
  cunningStrikeEffects!: CunningStrikeEffectDto[];

  @ApiProperty({ type: [StrikeOptionDto] })
  strikeOptions!: StrikeOptionDto[];

  @ApiProperty({ type: [SubclassTableActionDto] })
  tableActions!: SubclassTableActionDto[];

  @ApiProperty({ type: [PersonaMaskDto] })
  personaMasks!: PersonaMaskDto[];

  @ApiProperty({ type: [BeastborneAspectBenefitDto] })
  beastborneAspectBenefits!: BeastborneAspectBenefitDto[];

  @ApiProperty({ type: [String], example: ['Aberração', 'Besta'] })
  dungeoneerSlayerLabels!: string[];

  @ApiProperty({ type: [PrecautionSpellDto] })
  precautionSpells!: PrecautionSpellDto[];

  @ApiProperty({ type: [ClassEconomyActionDto] })
  economyActions!: ClassEconomyActionDto[];

  @ApiProperty({ type: [ClassPanelActionDto] })
  panelActions!: ClassPanelActionDto[];
}
