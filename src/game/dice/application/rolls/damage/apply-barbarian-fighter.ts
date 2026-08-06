import {
  divineFuryExtraDice,
  hasDivineFury,
} from '../../../../combat/domain/barbarian-rage';
import {
  DUNGEONEER_SLAYER_TYPES,
  psiEnergyDieFaces,
} from '../../../../combat/domain/fighter-features';
import { abilityModifier } from '../../../../sheet/domain/stats/ability-modifier';
import { addDamagePart } from './damage-accumulator';
import type { DamageEffect } from './damage-roll-context';

/** Golpe Brutal, Fúria Divina, Golpe Psiônico e Matar Monstro. */
export const applyBarbarianFighterExtras: DamageEffect = async (ctx, acc) => {
  const { attack, combatFlags, dto, character, domain, resourceSpender } = ctx;

  if (
    dto.brutalStrike &&
    attack.brutalStrikeDice &&
    dto.mode === 'melee' &&
    attack.abilitySlug === 'forca'
  ) {
    addDamagePart(acc, attack.brutalStrikeDice, { critical: dto.critical });
    acc.notes.push(
      'Golpe Brutal: efeito à escolha (empurrão/lentidão — narrativo); sem vantagem do Imprudente neste ataque',
    );
  }

  if (
    dto.divineFury &&
    combatFlags.rageActive &&
    hasDivineFury({
      subclassSlug: character.subclassSlug,
      level: character.level,
    })
  ) {
    addDamagePart(acc, divineFuryExtraDice(character.level), {
      critical: false,
    });
    acc.notes.push('Fúria Divina (Necrótico ou Radiante, à escolha)');
  }

  if (
    dto.psiStrike &&
    character.subclassSlug === 'psi-warrior' &&
    character.level >= 3
  ) {
    const faces = psiEnergyDieFaces(character.level);
    if (faces != null) {
      await resourceSpender.spendClassResource(
        character,
        'psi-energy-dice',
        1,
      );
      const intMod = abilityModifier(character.abilityScores.inteligencia);
      addDamagePart(acc, `1d${faces}+${intMod}`, { critical: false });
      const telekineticThrust =
        character.level >= 7
          ? `; Estocada Telecinética CD ${8 + (await domain.getProficiencyBonus(character.level)) + intMod}: Caído ou mova 3 m`
          : '';
      acc.notes.push(
        `Golpe Psiônico: +1d${faces}+INT Energético (1 Dado de Energia Psiônica)${telekineticThrust}`,
      );
    }
  }

  if (
    dto.monsterSlayer &&
    character.subclassSlug === 'dungeoneer' &&
    character.level >= 10
  ) {
    addDamagePart(acc, '1d10', { critical: dto.critical });
    acc.notes.push(
      `Matar Monstro: +1d10 vs ${DUNGEONEER_SLAYER_TYPES.join(', ')} (1×/turno)`,
    );
  }
};
