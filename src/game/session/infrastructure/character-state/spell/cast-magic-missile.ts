import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import {
  GIGA_MISSILE_RESOURCE,
  MAGIC_MISSILE_FREE_RESOURCE,
  MAGIC_MISSILE_SPELL_SLUG,
  MISSILE_SHIELD_RESOURCE,
  buildMagicMissileCastNote,
  isMagicMissileMage,
} from '@game/combat/domain/wizard';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { applyResourceSpend } from '@game/session/domain/class-resources';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { resolveClassResources } from '../resources/class-resources';

export async function spendFreeCastResource(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  dataSource: DataSource;
  resourceSlug: string;
  spellSlug: string;
}): Promise<void> {
  const { character, state, dataSource, resourceSlug, spellSlug } = input;

  if (
    resourceSlug !== MAGIC_MISSILE_FREE_RESOURCE ||
    spellSlug !== MAGIC_MISSILE_SPELL_SLUG ||
    !isMagicMissileMage(character.subclassSlug)
  ) {
    throw new BadRequestException(
      `Resource free cast '${resourceSlug}' is not valid for '${spellSlug}'`,
    );
  }

  const resources = await resolveClassResources(dataSource, character);
  const resource = resources.find((item) => item.slug === resourceSlug);
  if (!resource) {
    throw new BadRequestException(
      `Resource '${resourceSlug}' is not available for this character`,
    );
  }
  try {
    state.resourcesUsed = applyResourceSpend(
      state.resourcesUsed ?? {},
      resourceSlug,
      resource.max,
      1,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot spend free cast resource',
    );
  }
}

export async function applyMagicMissileMageOnCast(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  dataSource: DataSource;
  spellSlug: string;
  slotLevelUsed: number | null;
  usedFreeResource: boolean;
  applyMissileShield?: boolean;
  applyGigaMissile?: boolean;
}): Promise<string | null> {
  const {
    character,
    state,
    dataSource,
    spellSlug,
    slotLevelUsed,
    usedFreeResource,
    applyMissileShield = false,
    applyGigaMissile = false,
  } = input;

  const isMissileCast =
    spellSlug === MAGIC_MISSILE_SPELL_SLUG &&
    isMagicMissileMage(character.subclassSlug);

  if ((applyMissileShield || applyGigaMissile) && !isMissileCast) {
    throw new BadRequestException(
      'Missile boosts only apply when a Magic Missile Mage casts Mísseis Mágicos',
    );
  }

  if (!isMissileCast) {
    return null;
  }

  const resources = await resolveClassResources(dataSource, character);
  let missileShield = false;
  let gigaMissile = false;
  const wantShield = applyMissileShield || state.missileShieldArmed;
  const wantGiga = applyGigaMissile || state.gigaMissileArmed;

  if (wantShield) {
    spendArmedResource({
      state,
      resources,
      resourceSlug: MISSILE_SHIELD_RESOURCE,
      label: 'Escudo de Mísseis',
    });
    missileShield = true;
    state.missileShieldArmed = false;
  }

  if (wantGiga) {
    spendArmedResource({
      state,
      resources,
      resourceSlug: GIGA_MISSILE_RESOURCE,
      label: 'Giga-Míssil',
    });
    gigaMissile = true;
    state.gigaMissileArmed = false;
  }

  const intModifier = abilityModifier(character.abilityScores.inteligencia);
  return buildMagicMissileCastNote({
    level: character.level,
    slotLevelUsed,
    usedFreeResource,
    missileShield,
    gigaMissile,
    intModifier,
  });
}

function spendArmedResource(input: {
  state: PlayerCharacterState;
  resources: { slug: string; max: number }[];
  resourceSlug: string;
  label: string;
}): void {
  const resource = input.resources.find(
    (item) => item.slug === input.resourceSlug,
  );
  if (!resource) {
    throw new BadRequestException(
      `${input.label} is not available for this character`,
    );
  }
  try {
    input.state.resourcesUsed = applyResourceSpend(
      input.state.resourcesUsed ?? {},
      input.resourceSlug,
      resource.max,
      1,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error
        ? `${input.label}: ${error.message}`
        : `Cannot spend ${input.label}`,
    );
  }
}
