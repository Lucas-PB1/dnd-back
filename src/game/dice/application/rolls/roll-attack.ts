import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { ResolveEquippedWeaponAttacks } from '@game/combat/application/resolve-equipped-weapon-attacks';
import type { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { rollD20Check } from '@game/dice/domain/dice';
import type {
  CharacterRollResponseDto,
  RollAttackDto,
} from '@game/dice/dto/character-roll.dto';
import type { ResolveActivePermanentItemEffects } from '@game/inventory/application/effects/resolve-active-permanent-item-effects';
import type { CharacterResourceSpender } from '@game/session/domain/character-resource-spender';
import {
  coverAcBonus,
  effectiveCoverForAttack,
  isCoverBlockingAttack,
} from '@game/dice/domain/attack-cover';
import { hasPreciseHunter, isRangerClass } from '@game/combat/domain/ranger';
import {
  findEquippedWeaponAttack,
  loadAccessibleCharacter,
} from './roll-weapon-context';
import { buildAttackAdvantageContributions } from './build-attack-advantage-contributions';
import { applyStrokeOfLuckIfRequested } from './stroke-of-luck';
import { applyCursemarkedBracketIfTriggered } from './apply-cursemarked-bracket';

function coverNote(level: ReturnType<typeof effectiveCoverForAttack>): string | null {
  if (level === 'half') return 'Cobertura parcial: +2 CA do alvo';
  if (level === 'three_quarters') return 'Cobertura ¾: +5 CA do alvo';
  return null;
}

export async function executeRollAttack(input: {
  access: PlayerCharacterAccessService;
  sheet: CharacterSheetRepository;
  domain: CharacterDomainService;
  weaponAttacks: ResolveEquippedWeaponAttacks;
  permanentItemEffects: ResolveActivePermanentItemEffects;
  dataSource: DataSource;
  resourceSpender: CharacterResourceSpender;
  userId: string;
  characterId: string;
  dto: RollAttackDto;
}): Promise<CharacterRollResponseDto> {
  const character = await loadAccessibleCharacter(
    input.access,
    input.userId,
    input.characterId,
  );
  const { attack, combatFlags, featSlugs } = await findEquippedWeaponAttack(
    {
      sheet: input.sheet,
      domain: input.domain,
      weaponAttacks: input.weaponAttacks,
      permanentItemEffects: input.permanentItemEffects,
      dataSource: input.dataSource,
    },
    character,
    input.dto.itemSlug,
    input.dto.mode,
  );

  if (input.dto.steadyAim) {
    if (character.classSlug !== 'rogue' || character.level < 3) {
      throw new BadRequestException('Steady Aim requires Rogue level 3');
    }
  }
  if (input.dto.assassinate) {
    if (character.subclassSlug !== 'assassin' || character.level < 3) {
      throw new BadRequestException('Assassinate requires Assassin level 3');
    }
  }
  if (input.dto.preciseHunter) {
    if (
      !isRangerClass(character.classSlug) ||
      !hasPreciseHunter(character.level)
    ) {
      throw new BadRequestException('Precise Hunter requires Ranger level 17');
    }
  }

  const effectiveCover = effectiveCoverForAttack({
    cover: input.dto.targetCover ?? 'none',
    featSlugs,
  });
  if (isCoverBlockingAttack(effectiveCover)) {
    throw new BadRequestException(
      'Cobertura total: alvo inacessível para este ataque',
    );
  }
  const targetAcBonus = coverAcBonus(effectiveCover);

  const { mode, notes } = buildAttackAdvantageContributions({
    dto: input.dto,
    classSlug: character.classSlug,
    subclassSlug: character.subclassSlug,
    level: character.level,
    attackDisadvantage: attack.attackDisadvantage,
    masteryActive: attack.masteryActive,
    masterySlug: attack.masterySlug,
    abilitySlug: attack.abilitySlug,
    combatFlags,
    featSlugs,
  });

  const coverLabel = coverNote(effectiveCover);
  if (coverLabel) notes.unshift(coverLabel);

  let result = rollD20Check(attack.attackBonus, mode);
  result = await applyStrokeOfLuckIfRequested({
    requested: input.dto.strokeOfLuck,
    spender: input.resourceSpender,
    character,
    result,
    notes,
  });
  const kept = result.d20.kept[0] ?? 0;
  const critical = kept >= (attack.critThreshold ?? 20);
  if (critical && character.classSlug === 'gunslinger' && character.level >= 5) {
    notes.push(
      'Tiro intestinal: Velocidade pela metade e Desvantagem nos ataques (1 min; criatura Grande ou menor)',
    );
  }
  await applyCursemarkedBracketIfTriggered({
    dataSource: input.dataSource,
    character,
    resourceSpender: input.resourceSpender,
    kind: 'attack',
    kept,
    notes,
  });

  const response: CharacterRollResponseDto = {
    kind: 'attack',
    label: `Ataque — ${attack.itemName} (${input.dto.mode === 'ranged' ? 'à distância' : 'corpo a corpo'})${critical ? ' (crítico)' : ''}`,
    expression: result.expression,
    total: result.total,
    modifier: result.modifier,
    mode: result.mode,
    critical,
    rolls: result.d20.rolls,
    kept: result.d20.kept,
    note: notes.length > 0 ? notes.join(' · ') : undefined,
  };

  if (targetAcBonus > 0) {
    response.targetAcBonus = targetAcBonus;
  }
  if (input.dto.targetAc != null) {
    const effectiveTargetAc = input.dto.targetAc + targetAcBonus;
    response.effectiveTargetAc = effectiveTargetAc;
    response.hit = result.total >= effectiveTargetAc;
  }

  return response;
}
