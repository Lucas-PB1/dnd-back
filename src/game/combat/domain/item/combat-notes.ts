/** Lembretes passivos de item mágico para Passivas (não entram na Economia). */

const ITEM_PASSIVE_NOTES: Record<string, string[]> = {
  'memento-mori': [
    'Após ler: Vantagem em Salvaguardas contra a Morte; morre só com 5 falhas (exceto morte descrita na carta).',
  ],
  'leaden-manacles': [
    'Em conjurador preso: teste CD 20 no atributo de conjuração ou magia/Ação Mágica falha e 4d6 Ígneo.',
  ],
  'reaper-s-ammunition': [
    'Criatura que sofre dano desta munição morre; a munição se torna não mágica.',
  ],
  'weapon-charm-blade-1': ['Encanto Lâmina: +1 nas jogadas de ataque e dano.'],
  'weapon-charm-blade-2': ['Encanto Lâmina: +2 nas jogadas de ataque e dano.'],
  'weapon-charm-blade-3': ['Encanto Lâmina: +3 nas jogadas de ataque e dano.'],
  'weapon-charm-lightning': [
    'Encanto Relâmpago: +1d6 de dano Elétrico nos ataques da arma.',
  ],
  'weapon-charm-flame': [
    'Encanto Chama: ataques da arma podem causar dano Ígneo (ver descrição).',
  ],
  'weapon-charm-quiver': [
    'Encanto Aljava: a arma ignora a propriedade Recarga; munição teleporta-se quando necessário.',
  ],
  'weapon-charm-spear': [
    'Encanto Lança: benefícios de carga/alcance conforme a descrição do encanto.',
  ],
  'weapon-charm-die': [
    'Encanto Dado: efeito de rolagem especial nos ataques (ver descrição).',
  ],
  'weapon-charm-arrowhead': [
    'Encanto Ponta de Flecha: benefícios de munição/alcance conforme a descrição.',
  ],
};

export function itemCombatNotes(input: {
  itemSlugs: readonly string[];
}): string[] {
  const notes: string[] = [];
  const seen = new Set<string>();

  for (const slug of input.itemSlugs) {
    if (seen.has(slug)) continue;
    seen.add(slug);
    const lines = ITEM_PASSIVE_NOTES[slug];
    if (!lines) continue;
    for (const line of lines) notes.push(line);
  }

  return notes;
}
