/** Passivas Northlands — subclasses de conjurador / círculo. */

export function skaldSubclassNotes(level: number): string[] {
  if (level < 3) return [];
  const notes = [
    'Provocação Poética: Zombaria Perversa sempre preparada; falha na salv. — Desvantagem na próxima salv. de SAB/INT/CAR.',
    'Treino Marcial: armas Marciais, armadura Média e Escudos; arma como Foco; 1 maestria de arma (troca no DL).',
  ];
  if (level >= 6) {
    notes.push(
      'Runa de Bragi: use a Economia (Escárnio / Eloquência / Vitalidade).',
    );
  }
  if (level >= 14) {
    notes.push(
      'Sagas de Batalha: use a Economia (1 min de recitação; benefícios 1 h).',
    );
  }
  return notes;
}

export function nornboundSubclassNotes(level: number): string[] {
  if (level < 3) return [];
  const notes = [
    'Fios da Teia: role 2d6 no DL (dado sobe L7/11/15). Reação: some/subtraia 1 Fio a ataque/dano/salv./teste a 18 m.',
    'Puxar os Fios: use a Economia (Canalizar — Vantagem a aliados).',
  ];
  if (level >= 6) {
    notes.push(
      'Destino Entrelaçado: use a Economia (espaço → dano Força + cura/PV temp.).',
    );
  }
  if (level >= 17) {
    notes.push(
      'Tecelão da Teia: ao Puxar os Fios, inimigos a 9 m — salv. CAR ou Desvantagem 1 min.',
    );
  }
  return notes;
}

export function fenrisSubclassNotes(level: number): string[] {
  if (level < 3) return [];
  const notes = [
    'Manto do Lobo: use a Economia (Forma Selvagem). Com Manto: bônus FOR (Atletismo/salv.) = mod. SAB; mordida espectral.',
  ];
  if (level >= 6) {
    notes.push(
      'Manto Aprimorado: mordidas ×2 vs objetos; Visão no Escuro 18 m (ou +9 m); Velocidade +3 m.',
    );
  }
  if (level >= 10) {
    notes.push(
      'Defender a Alcateia: use a Economia (Reação — lobo fantasma 4d8 Força + Caído; L14: 6d8).',
    );
  }
  if (level >= 14) {
    notes.push(
      'Filhos do Grande Lobo: use a Economia (1×/dia ao assumir Manto — fenrikyn).',
    );
  }
  return notes;
}

export function spiritCallerSubclassNotes(level: number): string[] {
  if (level < 3) return [];
  const notes = [
    'Expertise Oculta: Arcanismo e Religião; pode usar CAR nesses testes se maior que INT.',
    'Orientação Espiritual: use a Economia (AB — Vantagem em perícia).',
  ];
  if (level >= 6) {
    notes.push(
      'Aura Espiritual: use a Economia (2×/DL ou 3 Pontos de Feitiçaria).',
    );
  }
  if (level >= 14) {
    notes.push(
      'Segredos Espirituais: use a Economia (rerrolar falha; ou 3 PF).',
    );
  }
  if (level >= 18) {
    notes.push(
      'Tempestade Espiritual: Aura 4,5 m; inimigo que entra/inicia — 2d8 Psíquico (1×/turno).',
    );
  }
  return notes;
}

export function tricksterSubclassNotes(level: number): string[] {
  if (level < 3) return [];
  const notes = [
    'Troca de Contexto: use a Economia (Reação — troca de lugar).',
    'Trapaça Ágil: prof. Prestidigitação; Vantagem ao trocar itens semelhantes.',
  ];
  if (level >= 6) {
    notes.push(
      'Troca Distante: alcance 9 m na Troca; ou Desvantagem na salv. + Invisível se falhar.',
    );
  }
  if (level >= 10) {
    notes.push(
      'Irrealidade Dolorosa: sucesso auto ao Analisar ilusões; falha ao discernir — salv. SAB, 4d10 Psíquico + Atordoado.',
    );
  }
  if (level >= 14) {
    notes.push('Arauto do Caos: use a Economia (1×/DC).');
  }
  return notes;
}
