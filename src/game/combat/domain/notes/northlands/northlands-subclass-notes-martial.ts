/** Passivas Northlands — subclasses marciais / juramento. */

export function titanSubclassNotes(level: number): string[] {
  if (level < 3) return [];
  const notes = [
    'Fúria dos Gigantes: ao ativar Fúria, pode tornar-se Grande (equipamento cresce). Em Grande: carga ×2; Vantagem em FOR; +1 dado de dano em armas/Desarmado.',
  ];
  if (level >= 6) {
    notes.push(
      'Passos Esmagadores: atravessar espaço de criatura menor; inimigo — salv. FOR ou Caído e sem Reações.',
    );
  }
  if (level >= 10) {
    notes.push(
      'Golpes Titânicos: Golpe Forçoso empurra o dobro; Golpe no Tendão — Velocidade 0 até o próximo turno do alvo.',
    );
  }
  if (level >= 14) {
    notes.push(
      'Fúria dos Titãs: ao ativar Fúria, pode tornar-se Enorme (carga ×3; alcance +1,5 m; +2 dados de dano).',
    );
  }
  return notes;
}

export function vikingSubclassNotes(level: number): string[] {
  if (level < 3) return [];
  const notes = [
    'Nascido no Mar: Vantagem vs empurrão/Caído/movimento forçado; Vantagem ao pilotar veículo aquático.',
    'Maestria Viking: 1×/turno +PB no dano com Machado de Batalha, Espada Longa ou Lança (se tiver maestria).',
  ];
  if (level >= 7) {
    notes.push(
      'Investida Selvagem: ação Atacar — mover + ataque CA; no acerto, AB Disparar pelo espaço do alvo.',
    );
  }
  if (level >= 10) {
    notes.push(
      'Chamado das Terras Nórdicas: no DL escolha Matador de Dragões / Nadador / Frio / Matador de Trolls.',
    );
  }
  if (level >= 15) {
    notes.push(
      'Represália do Saqueador: use a Economia (Reação; crítico + PV temp.).',
    );
  }
  if (level >= 18) {
    notes.push('Assalto Imparável: use a Economia (1×/DL).');
  }
  return notes;
}

export function valhallaSubclassNotes(level: number): string[] {
  if (level < 3) return [];
  const notes = [
    'Destruição Encorajadora / Guardião dos Mortos: use a Economia (Canalizar).',
  ];
  if (level >= 7) {
    notes.push(
      'Aura Trovejante: você e aliados — Imunidade a Trovão na Aura de Proteção; montaria pode causar Trovão.',
    );
  }
  if (level >= 15) {
    notes.push(
      'Alma Valorosa: ao reduzir inimigo a 0 PV (CA), aliados a 18 m — Vantagem 1 min; morte com Repouso Tranquilo.',
    );
  }
  if (level >= 20) {
    notes.push('Espírito da Valquíria: use a Economia (forma 10 min).');
  }
  return notes;
}
