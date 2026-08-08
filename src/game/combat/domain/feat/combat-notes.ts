/** Lembretes passivos de talento para Passivas (não entram na Economia). */

const FEAT_PASSIVE_NOTES: Record<string, string[]> = {
  alert: [
    'Proficiência em Iniciativa (+PB).',
    'Após Iniciativa: pode trocar com aliado voluntário.',
  ],
  'savage-attacker': [
    '1×/turno: role dados de dano da arma duas vezes e use qualquer resultado.',
  ],
  'tavern-brawler': [
    'Ataque Desarmado: 1d4 + FOR; rerole 1s; armas improvisadas; 1×/turno empurrar 1,5 m.',
  ],
  'great-weapon-master': [
    'Arma Pesada na ação Atacar: +PB de dano ao acertar.',
  ],
  sharpshooter: [
    'Ataques à distância ignoram Cobertura Parcial/¾; sem Desvantagem a 1,5 m nem no alcance longo.',
  ],
  'crossbow-expert': [
    'Ignora Recarga em bestas; sem Desvantagem a 1,5 m; Leve em besta Leve soma mod. no ataque extra.',
  ],
  mobile: [
    '+3 m Deslocamento; Correr ignora Terreno Difícil no turno; Desvantagem em Ataques de Oportunidade contra você.',
  ],
  crusher: [
    '1×/turno (Contundente): mover alvo 1,5 m; crítico Contundente → Vantagem nos ataques contra o alvo até seu próximo turno.',
  ],
  piercer: [
    '1×/turno (Perfurante): rerole 1 dado de dano; crítico Perfurante → +1 dado de dano.',
  ],
  slasher: [
    '1×/turno (Cortante): −3 m Deslocamento do alvo; crítico Cortante → Desvantagem nos ataques dele até seu próximo turno.',
  ],
  archery: ['+2 nas jogadas de ataque com armas à Distância.'],
  defense: ['+1 CA enquanto usar armadura Leve, Média ou Pesada.'],
  dueling: [
    '+2 no dano com arma Corpo a Corpo em uma mão (sem outra arma).',
  ],
  'great-weapon-fighting': [
    'Dano corpo a corpo Duas Mãos/Versátil: trate 1 ou 2 como 3.',
  ],
  'two-weapon-fighting': [
    'Ataque da propriedade Leve: some o modificador de atributo ao dano.',
  ],
  'thrown-weapon-fighting': [
    '+2 no dano com arma Arremesso em ataque à distância.',
  ],
  'unarmed-fighting': [
    'Desarmado: 1d6 (ou 1d8 sem arma/Escudo) + FOR; 1d4 no início do turno a Imobilizado.',
  ],
  'blind-fighting': ['Visão às Cegas 3 m.'],
  'heavy-armor-master': [
    'Com armadura Pesada: reduza Contundente/Cortante/Perfurante de ataques em PB.',
  ],
  'medium-armor-master': [
    'Armadura Média: some até +3 de DES à CA (se DES ≥ 16).',
  ],
  'mounted-combatant': [
    'Montado: Vantagem vs desmontados menores; redirecionar ataque à montaria; montaria Evasão parcial.',
  ],
  grappler: [
    'Desarmado: Dano+Imobilizar 1×/turno; Vantagem vs Imobilizado por você; sem custo extra de movimento.',
  ],
  stealthy: [
    'Visão às Cegas 3 m; Vantagem em Furtividade ao Esconder em combate; erro de ataque oculto não revela você.',
  ],
  durable: ['Vantagem em Salvaguardas Contra Morte.'],
  athlete: [
    'Deslocamento de Escalada; levantar com 1,5 m; saltar após 1,5 m de corrida.',
  ],
  charger: ['Correr: +3 m de Deslocamento nesta ação.'],
  'elemental-adept': [
    'Magias do tipo escolhido ignoram Resistência; 1s nos dados de dano viram 2.',
  ],
  'spell-sniper': [
    'Ataques de magia ignoram Cobertura Parcial/¾; sem Desvantagem a 1,5 m; +18 m de alcance em magias de ataque (≥ 3 m).',
  ],
  poisoner: ['Dano Venenoso ignora Resistência a Veneno.'],
  'mage-slayer': [
    'Dano a concentrador: Desvantagem na salvaguarda de Concentração.',
  ],
  sentinel: [
    'Ao acertar Ataque de Oportunidade: Deslocamento do alvo = 0 no turno.',
  ],
  'boon-of-fortitude': [
    '+40 PV máximos; +mod CON ao recuperar PV (1× até o início do próximo turno).',
  ],
  'boon-of-energy-resistance': [
    'Resistência a 2 tipos de energia (trocáveis no LR).',
  ],
  'boon-of-speed': ['+9 m Deslocamento.'],
  'boon-of-truesight': ['Visão Verdadeira 18 m.'],
  'boon-of-irresistible-offense': [
    'Contundente/Cortante/Perfurante ignora Resistência; crítico 20: +valor do atributo aumentado.',
  ],
  'boon-of-the-night-spirit': [
    'Em Meia-luz/Escuridão: Resistência a todos os danos exceto Psíquico e Radiante.',
  ],
  'boon-of-spell-recall': [
    'Ao conjurar com espaço 1º–4º: 1d4; se igual ao círculo, o espaço não é gasto.',
  ],
  'brutal-grip': [
    'Empunhar Duas Mãos em uma mão; Versátil em uma mão conta como Leve.',
  ],
  'focused-critical': [
    'Crítico com armas/Desarmado em 19–20.',
  ],
  'iron-hero': [
    '+2 CA vs atacante de ND > seu nível; Vantagem vs quem zerou aliado desde seu último turno.',
  ],
  'field-commander': [
    'A ≤ 1,5 m de ≥ 2 aliados: inimigos sem Vantagem contra você.',
  ],
  'marksman-s-luck': [
    '1×/turno: virar um dado de dano à distância (não d4); crítico à distância → Deslocamento 0.',
  ],
  'flex-caster': [
    'Elevação: gastar espaços extras para subir círculo; Redução: conjurar no base e recuperar espaço de 1º.',
  ],
  'shock-trooper': [
    '1ª rodada de combate: Deslocamento dobrado.',
  ],
  spellblade: [
    'Na ação Atacar: pode substituir um ataque por truque de lâmina conhecido.',
  ],
  magitechnician: [
    'CD de item mágico: máx(CD do item, 8 + mod do atributo + PB).',
  ],
  pyromaniac: [
    'Dano Ígneo: rerole e some dados no máximo (até PB dados extras).',
  ],
};

export function featCombatNotes(input: {
  featSlugs: readonly string[];
}): string[] {
  const notes: string[] = [];
  const seen = new Set<string>();

  for (const slug of input.featSlugs) {
    if (seen.has(slug)) continue;
    seen.add(slug);
    const lines = FEAT_PASSIVE_NOTES[slug];
    if (!lines) continue;
    for (const line of lines) notes.push(line);
  }

  return notes;
}
