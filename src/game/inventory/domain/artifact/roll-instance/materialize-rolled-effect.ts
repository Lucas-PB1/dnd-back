import type {
  ArtifactRandomTableRow,
  RolledArtifactProperty,
} from '../artifact-instance.types';
import { ARTIFACT_RANDOM_SPELL_SAVE_DC } from '../artifact-instance.types';
import type { Rng } from './artifact-roll-rng';
import { pickOne } from './artifact-roll-rng';

export type PickSpellByLevel = (level: number, rng: Rng) => string | null;

const ABILITIES = [
  'forca',
  'destreza',
  'constituicao',
  'inteligencia',
  'sabedoria',
  'carisma',
] as const;

const DAMAGE_TYPES_PT = [
  'Ácido',
  'Frio',
  'Fogo',
  'Energético',
  'Elétrico',
  'Necrótico',
  'Perfurante',
  'Veneno',
  'Psíquico',
  'Radiante',
  'Cortante',
  'Trovejante',
] as const;

const SKILLS_PT = [
  'Acrobacia',
  'Arcanismo',
  'Atletismo',
  'Enganação',
  'Furtividade',
  'História',
  'Intimidação',
  'Intuição',
  'Investigação',
  'Lidar com Animais',
  'Medicina',
  'Natureza',
  'Percepção',
  'Persuasão',
  'Prestidigitação',
  'Religião',
  'Sobrevivência',
] as const;


export function materializeRolledEffect(
  row: ArtifactRandomTableRow,
  rng: Rng,
  pickSpellByLevel?: PickSpellByLevel,
): RolledArtifactProperty {
  const baseEffect = row.effect ?? { type: 'reminder', text: row.summaryPt };
  let summaryPt = row.summaryPt;
  let effect: RolledArtifactProperty['effect'] = { ...baseEffect };

  if (
    typeof baseEffect === 'object' &&
    baseEffect !== null &&
    'type' in baseEffect
  ) {
    if (baseEffect.type === 'permanentEffects') {
      const pe = {
        ...(baseEffect.permanentEffects as Record<string, unknown>),
      };
      if (pe.abilityBonusChoice === true) {
        const ability = pickOne(ABILITIES, rng);
        delete pe.abilityBonusChoice;
        pe.abilityBonuses = { [ability]: 2 };
        pe.abilityScoreMax = 24;
        summaryPt = `${summaryPt} (${ability} +2, máx. 24)`;
      }
      effect = { type: 'permanentEffects', permanentEffects: pe };
    } else if (baseEffect.type === 'artifactSpell') {
      const spellLevel = Number(
        (baseEffect as { spellLevel?: number }).spellLevel ?? 0,
      );
      const spellSlug = pickSpellByLevel?.(spellLevel, rng) ?? null;
      const levelLabel =
        spellLevel === 0 ? 'truque' : `${spellLevel}º círculo`;
      summaryPt = spellSlug
        ? `Conjura ${spellSlug} (${levelLabel}) · CD ${ARTIFACT_RANDOM_SPELL_SAVE_DC} · 1×/DL`
        : `Conjura magia de ${levelLabel} (nenhuma no catálogo)`;
      effect = {
        type: 'artifactSpell',
        spellLevel,
        spellSlug: spellSlug ?? undefined,
        spentUntilLongRest: false,
        spellSaveDc: ARTIFACT_RANDOM_SPELL_SAVE_DC,
      };
    } else if (baseEffect.type === 'artifactRegen') {
      const dice =
        typeof (baseEffect as { dice?: string }).dice === 'string'
          ? (baseEffect as { dice: string }).dice
          : '1d6';
      summaryPt = `Regeneração ${dice} PV no início do turno (botão na ficha)`;
      effect = { type: 'artifactRegen', dice };
    } else if (baseEffect.type === 'abilityPenalty') {
      const amount = Math.abs(
        Number((baseEffect as { amount?: number }).amount ?? 2) || 2,
      );
      const ability = pickOne(ABILITIES, rng);
      summaryPt = `${ability} −${amount} (até Restauração Maior)`;
      effect = { type: 'abilityPenalty', amount, ability };
    } else if (baseEffect.type === 'reminder') {
      let text =
        typeof baseEffect.text === 'string' ? baseEffect.text : row.summaryPt;
      if (row.slug === 'skill-proficiency') {
        const skill = pickOne(SKILLS_PT, rng);
        text = `Proficiência em ${skill} (escolha do Mestre materializada no roll).`;
        summaryPt = `Proficiência em ${skill}`;
      } else if (row.slug === 'damage-resistance') {
        const damageType = pickOne(DAMAGE_TYPES_PT, rng);
        text = `Resistência a dano ${damageType} (escolha do Mestre materializada no roll).`;
        summaryPt = `Resistência a ${damageType}`;
      }
      effect = { type: 'reminder', text };
    }
  }

  return {
    slug: row.slug,
    summaryPt,
    roll: 0,
    effect,
  };
}
