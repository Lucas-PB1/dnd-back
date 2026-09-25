import { Entity, PrimaryColumn, TableInheritance } from 'typeorm';

/** Kind-specific columns live on the child entities (PhbEffectSpell, PhbEffectFeat, …). */
@Entity({ schema: 'rpg', name: 'phb_effect_grant_ref' })
@TableInheritance({ column: { type: 'text', name: 'grant_kind' } })
export class PhbEffectGrantRef {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;
}

/** Kind-specific columns live on the child entities (PhbEffectNumeric, PhbEffectReach, …). */
@Entity({ schema: 'rpg', name: 'phb_effect_scalar' })
@TableInheritance({ column: { type: 'text', name: 'scalar_kind' } })
export class PhbEffectScalar {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;
}

/** Kind-specific columns live on PhbEffectCheckAdvantage / PhbEffectSaveAdvantage. */
@Entity({ schema: 'rpg', name: 'phb_effect_advantage' })
@TableInheritance({ column: { type: 'text', name: 'advantage_kind' } })
export class PhbEffectAdvantage {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;
}

/** Kind-specific columns live on PhbEffectSense / PhbEffectEnvironmentalImmunity. */
@Entity({ schema: 'rpg', name: 'phb_effect_sense_env' })
@TableInheritance({ column: { type: 'text', name: 'sense_env_kind' } })
export class PhbEffectSenseEnv {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;
}

/** Kind-specific columns live on PhbEffectDamageDie / PhbEffectDice. */
@Entity({ schema: 'rpg', name: 'phb_effect_dice' })
@TableInheritance({ column: { type: 'text', name: 'dice_kind' } })
export class PhbEffectDicePayload {
  @PrimaryColumn({ type: 'bigint', name: 'effect_id' })
  effectId!: string;
}
