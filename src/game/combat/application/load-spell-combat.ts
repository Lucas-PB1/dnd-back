import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSpellCombat } from '@entities/spell/phb-spell-combat.entity';
import type { SpellCombatRow } from '../domain/resolve-combat-spell';

@Injectable()
export class LoadSpellCombat {
  constructor(
    @InjectRepository(PhbSpellCombat)
    private readonly repo: Repository<PhbSpellCombat>,
  ) {}

  async bySlug(spellSlug: string): Promise<SpellCombatRow | null> {
    const row = await this.repo.findOne({ where: { spellSlug } });
    if (!row) return null;
    return {
      spellSlug: row.spellSlug,
      resolution: row.resolution,
      label: row.label,
      damageDie: row.damageDie,
      flatPerDie: row.flatPerDie,
      autoUnitBase: row.autoUnitBase,
      autoUnitPerSlotAboveBase: row.autoUnitPerSlotAboveBase,
      diceCountBase: row.diceCountBase,
      dicePerSlotAboveBase: row.dicePerSlotAboveBase,
      spellLevel: row.spellLevel,
      cantripScale: row.cantripScale,
      perDieAttack: row.perDieAttack,
      includeSpellcastingMod: row.includeSpellcastingMod,
      saveSuccessOutcome: row.saveSuccessOutcome,
      saveAbilitySlug: row.saveAbilitySlug,
      conditionSlug: row.conditionSlug,
      damageTypeSlug: row.damageTypeSlug,
    };
  }
}
