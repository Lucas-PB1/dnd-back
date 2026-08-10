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

export function druidCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isDruidClass(input.classSlug)) return [];

  const level = input.level ?? 1;
  const uses = wildShapeMaxUses(level);

  const notes = [
    'Ordem Primal: escolha entre Protetor (Armaduras Médias e Armas Marciais) ou Magista (+1 truque de Druida).',
  ];

  addBaseDruidNotes(notes, level, uses);
  addDruidSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBaseDruidNotes(notes: string[], level: number, uses: number): void {
  if (level >= 2) {
    notes.push(
      `Forma Selvagem (${uses} usos): pool na Economia (±). Assumir ficha de besta = polish futuro; Ação Bônus também ativa Companheiro Selvagem (mesa).`,
    );
  }
  if (level >= 5) {
    notes.push(
      'Ressurgimento Selvagem: gaste 1 uso de Forma Selvagem para recuperar 1 Slot de 1º círculo (ou 1 slot de 1º círculo para recuperar 1 uso de Forma Selvagem).',
    );
  }
  if (level >= 18) {
    notes.push(
      'Besta Feiticeira: conjure magias na Forma Selvagem sem componentes V ou S.',
    );
  }
  if (level >= 20) {
    notes.push(
      'Arquidruida: recupere 1 uso de Forma Selvagem ao rolar Iniciativa se não houver usos restantes.',
    );
  }
}

function addDruidSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (level < 3) return;

  if (subclassSlug === 'moon') {
    notes.push(
      `Círculo da Lua: Forma Selvagem de Combate (ND máx. ⌊nível/3⌋, CA 13+SAB, ${moonWildShapeTempHp(level)} PV temp.).`,
    );
    if (level >= 6) {
      notes.push(
        'Lua L6: ataques na forma podem ser Radiantes; +SAB em salvaguardas de Constituição.',
      );
    }
    if (level >= 10) {
      notes.push(
        'Passo Lunar: teleporte 9 m (usos = SAB); restaurar com espaço 2+.',
      );
    }
    if (level >= 14) {
      notes.push(
        'Forma Lunar: +2d10 radiante 1×/turno na forma; Passo Lunar pode levar um aliado.',
      );
    }
  }

  if (subclassSlug === 'land') {
    notes.push(
      `Círculo da Terra: Auxílio da Terra (${landAidDice(level)}d6 dano necrótico + cura à escolha, gasta Forma Selvagem).`,
    );
    if (level >= 6) {
      notes.push(
        'Recuperação Natural: 1 magia do Círculo sem espaço (1×/DL); no Descanso Curto recupere slots (soma ≤ ⌈nível/2⌉, sem 6+).',
      );
    }
    if (level >= 10) {
      notes.push(
        'Proteção Natural: imune a Envenenado; resistência conforme terreno escolhido.',
      );
    }
    if (level >= 14) {
      notes.push(
        'Santuário Natural: gaste Forma Selvagem — cubo 4,5 m com cobertura parcial (mover com Ação Bônus).',
      );
    }
  }

  if (subclassSlug === 'stars') {
    const dice = starryFormDice(level);
    notes.push(
      `Círculo das Estrelas: Forma Estelar (Arquiro: ${dice}+SAB radiante; Cálice: +${dice}+SAB cura; Dragão: mínimo 10).`,
    );
    notes.push(
      'Mapa Estelar: Raio Guia gratuito (usos = SAB) + Orientação preparada.',
    );
    if (level >= 6) {
      notes.push(
        'Presságio Cósmico: após DL, Reação ±1d6 em Teste de D20 (usos = SAB).',
      );
    }
    if (level >= 10) {
      notes.push(
        'Constelações Cintilantes: 2d8; Dragão voo 6 m; trocar constelação no início do turno.',
      );
    }
  }

  if (subclassSlug === 'sea') {
    const radius = wrathOfTheSeaRadiusMeters(level);
    notes.push(
      `Círculo do Mar: Ira do Mar (Emanação ${radius} m, d6s = SAB de dano Gélido + empurrão 4,5 m; gasta Forma Selvagem).`,
    );
    if (level >= 14) {
      notes.push(
        'Manifestação Oceânica: gaste 2 usos de Forma Selvagem para a variante aprimorada (mesa).',
      );
    }
  }

  if (subclassSlug === 'circle-of-the-city') {
    notes.push(
      'Círculo da Cidade: gaste Forma Selvagem para Fundir-se na Pedra, Passagem ou Moldar Rocha sem espaço; magias urbanas usam estética de cidade.',
    );
    if (level >= 6) {
      notes.push(
        'Forma de Objeto: Forma Selvagem como Objeto Animado (até Grande; Enorme no nv. 10).',
      );
    }
    if (level >= 10) {
      notes.push(
        'Distorção de Muro: Reação cria painel de Muralha de Pedra (1×/LR ou espaço 3º+) — veja recurso.',
      );
    }
    if (level >= 14) {
      notes.push(
        'Colosso Urbano: na forma de objeto, CA 18, limiar de dano, Multiataque e atravessar criaturas.',
      );
    }
  }
}
