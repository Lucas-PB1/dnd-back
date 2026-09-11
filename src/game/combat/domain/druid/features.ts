export function isDruidClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'druid';
}

export function wildShapeMaxUses(level: number): number {
  if (level < 2) return 0;
  if (level >= 17) return 4;
  if (level >= 6) return 3;
  return 2;
}

export function moonWildShapeTempHp(level: number): number {
  return 3 * level;
}

/** Auxílio da Terra: 2d6 → 3d6@10 → 4d6@14. */
export function landAidDice(level: number): number {
  if (level >= 14) return 4;
  if (level >= 10) return 3;
  return 2;
}

/** Forma Estelar Arquiro/Cálice: 1d8 → 2d8@10. */
export function starryFormDice(level: number): string {
  return level >= 10 ? '2d8' : '1d8';
}

/** Ira do Mar: 1,5 m → 3 m@6. */
export function wrathOfTheSeaRadiusMeters(level: number): number {
  return level >= 6 ? 3 : 1.5;
}

/** Notas dinâmicas. Estáticas → `phb_level_combat_note`. */
export function druidCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isDruidClass(input.classSlug)) return [];

  const level = input.level ?? 1;
  const uses = wildShapeMaxUses(level);
  const notes: string[] = [];

  if (level >= 2) {
    notes.push(
      `Forma Selvagem (${uses} usos): pool na Economia (±). Assumir ficha de besta = polish futuro; Ação Bônus também ativa Companheiro Selvagem (mesa).`,
    );
  }

  if (level < 3) return notes;
  const subclassSlug = input.subclassSlug;

  if (subclassSlug === 'moon') {
    notes.push(
      `Círculo da Lua: Forma Selvagem de Combate (ND máx. ⌊nível/3⌋, CA 13+SAB, ${moonWildShapeTempHp(level)} PV temp.).`,
    );
  }
  if (subclassSlug === 'land') {
    notes.push(
      `Círculo da Terra: Auxílio da Terra (${landAidDice(level)}d6 dano necrótico + cura à escolha, gasta Forma Selvagem).`,
    );
  }
  if (subclassSlug === 'stars') {
    const dice = starryFormDice(level);
    notes.push(
      `Círculo das Estrelas: Forma Estelar (Arquiro: ${dice}+SAB radiante; Cálice: +${dice}+SAB cura; Dragão: mínimo 10).`,
    );
  }
  if (subclassSlug === 'sea') {
    const radius = wrathOfTheSeaRadiusMeters(level);
    notes.push(
      `Círculo do Mar: Ira do Mar (Emanação ${radius} m, d6s = SAB de dano Gélido + empurrão 4,5 m; gasta Forma Selvagem).`,
    );
  }
  return notes;
}
