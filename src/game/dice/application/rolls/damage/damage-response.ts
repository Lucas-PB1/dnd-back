import type { CharacterRollResponseDto } from '../../../dto/character-roll.dto';
import type { RollDamageDto } from '../../../dto/character-roll.dto';
import type { DamageAccumulator } from './damage-accumulator';
import type { DamageWeaponAttack } from './damage-roll-context';

export function buildDamageRollResponse(input: {
  attack: DamageWeaponAttack;
  dto: RollDamageDto;
  acc: DamageAccumulator;
  modifier: number;
  critical: boolean;
  kept?: number[];
}): CharacterRollResponseDto {
  const { attack, dto, acc } = input;
  const labelExtras = [
    dto.critical ? ' (crítico)' : '',
    attack.greatWeaponFighting ? ' (GWF)' : '',
    attack.overkillExtraDice ? ' (Exagero)' : '',
    dto.headShot ? ' (Tiro na cabeça)' : '',
    dto.brutalStrike ? ' (Golpe Brutal)' : '',
    dto.divineFury ? ' (Fúria Divina)' : '',
    dto.psiStrike ? ' (Golpe Psiônico)' : '',
    dto.monsterSlayer ? ' (Matar Monstro)' : '',
    dto.sneakAttack ? ' (Ataque Furtivo)' : '',
    dto.divineSmite ? ' (Destruição Divina)' : '',
    dto.huntersMark ? ' (Marca do Predador)' : '',
    dto.colossusSlayer ? ' (Assassino de Colossos)' : '',
    dto.dreadfulStrikes ? ' (Golpes Terríveis)' : '',
    dto.dreadAmbusher ? ' (Golpe Terrível)' : '',
  ].join('');

  return {
    kind: 'damage',
    label: `Dano — ${attack.itemName}${labelExtras}`,
    expression: acc.expression,
    total: acc.total,
    modifier: input.modifier,
    critical: input.critical,
    rolls: acc.rolls,
    kept: input.kept,
    note: acc.notes.length > 0 ? acc.notes.join(' · ') : undefined,
  };
}
