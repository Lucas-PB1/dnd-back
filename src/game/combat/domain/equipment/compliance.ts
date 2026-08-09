import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';

export type EquippedArmorCompliancePiece = {
  itemSlug: string;
  itemName: string;
  /** light | medium | heavy | shield */
  categorySlug: string;
  strengthReq: number | null;
  stealthDisadvantage: boolean;
};

export type EquipmentWarning = {
  code:
    | 'lacks_armor_training'
    | 'strength_requirement'
    | 'stealth_disadvantage'
    | 'dual_wield_needs_feat'
    | 'dual_wield_two_handed_off_hand'
    | 'heavy_weapon_small_size';
  message: string;
  itemSlug?: string;
};

export type EquipmentComplianceInput = {
  strengthScore: number;
  /** Categorias de treino da classe: light, medium, heavy, shield */
  armorTrainingSlugs: readonly string[];
  featSlugs?: readonly string[];
  /** Escudo ou arma two-handed na off_hand sem dual válido */
  dualWieldNeedsFeat?: boolean;
  dualWieldTwoHandedOffHand?: boolean;
  heavyWeaponSlugsForSmall?: readonly string[];
};

export type EquipmentComplianceResult = {
  lacksArmorTraining: boolean;
  strengthPenalty: { required: number; actual: number; itemSlug: string } | null;
  stealthDisadvantage: boolean;
  cannotCastSpells: boolean;
  strDexTestDisadvantage: boolean;
  speedPenaltyMeters: 0 | 3;
  warnings: EquipmentWarning[];
};

const BODY_ARMOR = new Set(['light', 'medium', 'heavy']);

function needsTraining(categorySlug: string): boolean {
  return BODY_ARMOR.has(categorySlug) || categorySlug === 'shield';
}

function hasArmorTraining(
  categorySlug: string,
  trainingSlugs: readonly string[],
  featSlugs: readonly string[],
): boolean {
  if (trainingSlugs.includes(categorySlug)) return true;
  // Feats de treino no PHB 2024 usam estes slugs quando presentes no catálogo.
  const featMap: Record<string, string[]> = {
    light: ['light-armor-training'],
    medium: ['medium-armor-training'],
    heavy: ['heavy-armor-training'],
    shield: ['shield-training', 'light-armor-training', 'medium-armor-training', 'heavy-armor-training'],
  };
  return (featMap[categorySlug] ?? []).some((slug) => featSlugs.includes(slug));
}

/**
 * Avalia conformidade de armadura/equipamento equipado (PHB 2024).
 * Não bloqueia equip — só flags e avisos.
 */
export function computeEquipmentCompliance(
  pieces: readonly EquippedArmorCompliancePiece[],
  input: EquipmentComplianceInput,
): EquipmentComplianceResult {
  const featSlugs = input.featSlugs ?? [];
  const warnings: EquipmentWarning[] = [];
  let lacksArmorTraining = false;
  let stealthDisadvantage = false;
  let strengthPenalty: EquipmentComplianceResult['strengthPenalty'] = null;

  for (const piece of pieces) {
    if (needsTraining(piece.categorySlug)) {
      const trained = hasArmorTraining(
        piece.categorySlug,
        input.armorTrainingSlugs,
        featSlugs,
      );
      if (!trained) {
        lacksArmorTraining = true;
        warnings.push({
          code: 'lacks_armor_training',
          itemSlug: piece.itemSlug,
          message: `Sem treino com ${piece.itemName}: desvantagem em testes de FOR/DES e não pode conjurar.`,
        });
      }
    }

    if (
      piece.strengthReq != null &&
      input.strengthScore < piece.strengthReq &&
      BODY_ARMOR.has(piece.categorySlug)
    ) {
      if (
        !strengthPenalty ||
        piece.strengthReq > strengthPenalty.required
      ) {
        strengthPenalty = {
          required: piece.strengthReq,
          actual: input.strengthScore,
          itemSlug: piece.itemSlug,
        };
      }
      warnings.push({
        code: 'strength_requirement',
        itemSlug: piece.itemSlug,
        message: `${piece.itemName} exige Força ${piece.strengthReq} (atual ${input.strengthScore}): deslocamento −3 m.`,
      });
    }

    if (piece.stealthDisadvantage && BODY_ARMOR.has(piece.categorySlug)) {
      stealthDisadvantage = true;
      warnings.push({
        code: 'stealth_disadvantage',
        itemSlug: piece.itemSlug,
        message: `${piece.itemName}: desvantagem em Furtividade.`,
      });
    }
  }

  if (input.dualWieldTwoHandedOffHand) {
    warnings.push({
      code: 'dual_wield_two_handed_off_hand',
      message:
        'Arma de duas mãos na mão secundária não serve para combate com duas armas.',
    });
  } else if (input.dualWieldNeedsFeat) {
    warnings.push({
      code: 'dual_wield_needs_feat',
      message:
        'Mão secundária sem propriedade Leve: ataque adicional exige o talento Especialista Ambidestro.',
    });
  }

  for (const slug of input.heavyWeaponSlugsForSmall ?? []) {
    warnings.push({
      code: 'heavy_weapon_small_size',
      itemSlug: slug,
      message: 'Arma Pesada com tamanho Pequeno: desvantagem nas jogadas de ataque.',
    });
  }

  return {
    lacksArmorTraining,
    strengthPenalty,
    stealthDisadvantage,
    cannotCastSpells: lacksArmorTraining,
    strDexTestDisadvantage: lacksArmorTraining,
    speedPenaltyMeters: strengthPenalty ? 3 : 0,
    warnings,
  };
}

/** Usado só para tipar AbilityScores em callers sem import circular. */
export type { AbilityScores };
