import { Repository } from 'typeorm';
import { PlayerCharacterSkill } from '../../player-character-skill.entity';
import {
  PlayerCharacterChoice,
  PlayerCharacterEquipment,
  PlayerCharacterFeat,
  PlayerCharacterLanguage,
  PlayerCharacterOption,
  PlayerCharacterSpell,
} from '../../player-sheet.entities';

export type CharacterSheetSyncDeps = {
  skills: Repository<PlayerCharacterSkill>;
  characterChoices: Repository<PlayerCharacterChoice>;
  options: Repository<PlayerCharacterOption>;
  feats: Repository<PlayerCharacterFeat>;
  spells: Repository<PlayerCharacterSpell>;
  equipment: Repository<PlayerCharacterEquipment>;
  languages: Repository<PlayerCharacterLanguage>;
  dataSource: import('typeorm').DataSource;
};
