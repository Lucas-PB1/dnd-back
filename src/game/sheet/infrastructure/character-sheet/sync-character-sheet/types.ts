import { Repository } from 'typeorm';
import { PlayerCharacterSkill } from '../../player-character-skill.entity';
import {
  PlayerCharacterEquipment,
  PlayerCharacterFeat,
  PlayerCharacterLanguage,
  PlayerCharacterOption,
  PlayerCharacterSpeciesChoice,
  PlayerCharacterSpell,
} from '../../player-sheet.entities';

export type CharacterSheetSyncDeps = {
  skills: Repository<PlayerCharacterSkill>;
  speciesChoices: Repository<PlayerCharacterSpeciesChoice>;
  options: Repository<PlayerCharacterOption>;
  feats: Repository<PlayerCharacterFeat>;
  spells: Repository<PlayerCharacterSpell>;
  equipment: Repository<PlayerCharacterEquipment>;
  languages: Repository<PlayerCharacterLanguage>;
  dataSource: import('typeorm').DataSource;
};
