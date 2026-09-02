/** Notas informativas de subclasse do Bárbaro (sem simular duração por turno). */

export function addBarbarianSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (level < 3 || !subclassSlug) return;

  if (subclassSlug === 'berserker') {
    notes.push(
      'Berserker: Frenesi — com Fúria + Imprudente, +Nd6 (N = bônus de Fúria) no 1º acerto FOR do turno.',
    );
    if (level >= 6) {
      notes.push(
        'Fúria Irracional: Imunidade a Amedrontado/Enfeitiçado enquanto enfurecido.',
      );
    }
    if (level >= 10) {
      notes.push(
        'Retaliação: Reação ao sofrer dano a 1,5 m — ataque corpo a corpo.',
      );
    }
    if (level >= 14) {
      notes.push(
        'Presença Intimidante: AB — CD FOR; Amedrontado 1 min (1×/DL; restaure gastando Fúria).',
      );
    }
  }

  if (subclassSlug === 'wild-heart') {
    notes.push(
      'Coração Selvagem: ao entrar em Fúria escolha Águia/Lobo/Urso. Águia tem Usar (AB: Correr+Desengajar).',
    );
    if (level >= 6) {
      notes.push(
        'Aspecto dos Selvagens: Coruja/Pantera/Salmão (escolha no DL — mesa).',
      );
    }
    if (level >= 14) {
      notes.push(
        'Poder dos Selvagens: ao entrar em Fúria escolha Carneiro/Falcão/Leão.',
      );
    }
  }

  if (subclassSlug === 'world-tree') {
    notes.push(
      'Árvore do Mundo: ao entrar em Fúria, PV temp. = nível; no início do turno (Fúria), aliado a 3 m pode ganhar Nd6 PV temp. (N = bônus de Fúria).',
    );
    if (level >= 6) {
      notes.push(
        'Ramos: Reação — teleporte inimigo a 9 m (salvaguarda FOR).',
      );
    }
    if (level >= 10) {
      notes.push(
        'Raízes Devastadoras: +3 m de alcance com armas Pesadas/Versáteis; no acerto pode Derrubar ou Empurrar além de outra maestria.',
      );
    }
    if (level >= 14) {
      notes.push(
        'Percorrer a Árvore: teleporte 18 m (AB); 1×/Fúria até 45 m + aliados.',
      );
    }
  }

  if (subclassSlug === 'zealot') {
    notes.push(
      'Fanático: Campeão dos Deuses (reserva d12); Fúria Divina (+1d6 + metade do nível no 1º acerto/turno).',
    );
    if (level >= 6) {
      notes.push(
        'Concentração Fanática: 1×/Fúria, rerrolar salvaguarda com +bônus de Fúria.',
      );
    }
    if (level >= 10) {
      notes.push(
        'Presença Zelosa: AB — Vantagem em ataque/salvaguarda a aliados até seu próximo turno (1×/DL).',
      );
    }
    if (level >= 14) {
      notes.push(
        'Fúria dos Deuses: forma divina 1 min ao entrar em Fúria (1×/DL).',
      );
    }
  }

  if (subclassSlug === 'path-of-the-muscle-wizard') {
    notes.push(
      'Mago Musculoso: “Truques” (Mãos Mágicas / Toque Chocante / Ataque Certeiro); “Magias” 1× cada / DL enquanto enfurecido; Reação pode entrar em Fúria sem gastar uso.',
    );
    if (level >= 10) {
      notes.push(
        'Resistência Mágica: Vantagem em salvaguardas vs magias enquanto enfurecido.',
      );
    }
    if (level >= 14) {
      notes.push(
        'Eu lancei o punho: 1×/Fúria — Ataque Desarmado com Vantagem, 6d6+FOR Contundente.',
      );
    }
  }
}
