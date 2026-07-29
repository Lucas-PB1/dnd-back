import type { CharacterDomainService } from '../../../sheet/domain/core/character-domain.service';
import type { CharacterSheetRepository } from '../../../sheet/infrastructure/character-sheet.repository';
import type { ResolveEquippedWeaponAttacks } from '../../../combat/application/resolve-equipped-weapon-attacks';
import type { PlayerCharacterAccessService } from '../../../shared/player-character-access.service';
import {
  rollD20Check,
  type AdvantageMode,
} from '../../domain/dice';
import type { CharacterRollResponseDto, RollAttackDto } from '../../dto/character-roll.dto';
import type { ResolveActivePermanentItemEffects } from '../../../inventory/application/resolve-active-permanent-item-effects';
import {
  findEquippedWeaponAttack,
  loadAccessibleCharacter,
} from './roll-weapon-context';

export async function executeRollAttack(input: {
  access: PlayerCharacterAccessService;
  sheet: CharacterSheetRepository;
  domain: CharacterDomainService;
  weaponAttacks: ResolveEquippedWeaponAttacks;
  permanentItemEffects: ResolveActivePermanentItemEffects;
  userId: string;
  characterId: string;
  dto: RollAttackDto;
}): Promise<CharacterRollResponseDto> {
  const character = await loadAccessibleCharacter(
    input.access,
    input.userId,
    input.characterId,
  );
  const attack = await findEquippedWeaponAttack(
    {
      sheet: input.sheet,
      domain: input.domain,
      weaponAttacks: input.weaponAttacks,
      permanentItemEffects: input.permanentItemEffects,
    },
    character,
    input.dto.itemSlug,
    input.dto.mode,
  );
  let mode: AdvantageMode = input.dto.advantage ?? 'normal';
  if (attack.attackDisadvantage && mode === 'normal') {
    mode = 'disadvantage';
  }
  const result = rollD20Check(attack.attackBonus, mode);
  return {
    kind: 'attack',
    label: `Ataque — ${attack.itemName} (${input.dto.mode === 'ranged' ? 'à distância' : 'corpo a corpo'})`,
    expression: result.expression,
    total: result.total,
    modifier: result.modifier,
    mode: result.mode,
    rolls: result.d20.rolls,
    kept: result.d20.kept,
  };
}
