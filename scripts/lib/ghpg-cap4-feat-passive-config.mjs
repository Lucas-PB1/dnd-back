/**
 * Lembretes passivos GH Cap. 4 (coluna Passivas).
 * Benefícios com economy em C075 ficam só na aba Ações.
 *
 * @type {Record<string, string[]>}
 */
export const GH_CAP4_FEAT_PASSIVE_NOTES = {
  'blood-hound': [
    'Sensor de Movimento: criatura P+ a 3 m → ciente da presença (se não Inconsciente).',
    'Sem Esconderijo: Vantagem em Percepção (som/olfato).',
  ],
  'convincing-inquisitor': [
    'Influenciar: sem Desvantagem em Hostis; Vantagem em Indiferentes.',
    'Influenciar: use qualquer mod. de atributo em Intimidação/Persuasão.',
    'Intuição ao Procurar mentiras → Vantagem em Iniciativa vs alvo (1 h).',
  ],
  deathbound: [
    'Com 2 falhas em Salvaguardas contra Morte: Vantagem até sair de 0 PV.',
    'DC: role DV duas vezes ao recuperar PV (usa o maior).',
  ],
  'fortuneofthe-thaumaturge': [
    'Fortuna do Desconhecido: ao usar Fortitude da Fortuna, máx./mín. no DV → recupera esse DV.',
  ],
  'free-sword-mercenarys-will': [
    'Resoluto: Vantagem em salvaguardas que aplicariam condição.',
  ],
  'insightful-collector': [
    'Achado Raro: começa com 1 item mágico Comum (combine com o Mestre).',
  ],
  'resolutionofthe-syndicate': [
    'Golpe Rápido: 1º turno após Iniciativa +1d4 dano (2d4 nv.9; 4d4 nv.16).',
    'Resiliente: +1 PV máx. por nível de personagem (aplicado no catálogo).',
  ],
  survivor: [
    'Resistente: metade da comida diária necessária.',
    'Intuitivo: Vantagem em Inteligência ao Estudar.',
    'Sacudir: DC −1 Exaustão; DL −2 Exaustão.',
  ],
  'triage-expert': [
    'Trato ao Paciente: ao curar ou usar Sangue e Osso, role dado extra e descarte o menor.',
  ],
  'blackpowder-pistol-expert': [
    'Olho de Águia: sem Desvantagem em alcance longo com pistola.',
    'Recarga Rápida: ignora propriedade Recarregar da pistola.',
  ],
  'expanded-grip': [
    'Empunhadura a Uma Mão: Versátil com uma mão usa dano entre parênteses.',
    'Agarre Zeloso: CD 15 FOR para manter agarre; Vantagem em salvaguardas para não soltar.',
  ],
  'hulking-figure': [
    'Brutal: 1×/turno +1d4 Contundente em Ataque Desarmado.',
    'Intimidante: soma mod. FOR em Intimidação/Atuação/Persuasão.',
    'Poderoso: conta como um tamanho maior (até Grande) para carga.',
  ],
  'iron-gut': [
    'Imune a Veneno: Vantagem vs Envenenado.',
    'Tudo Parece Delicioso: Vantagem em Sobrevivência para forragear.',
  ],
  'medicianofthe-morbus-doctore': [
    'Médico Habilidoso: Sangue e Osso permite até 3 Dados de Vida.',
    'Cirurgião de Campo: Sangue e Osso pode curar Ferida Grave ou encerrar condição (3 DV).',
  ],
  'nimble-physique': [
    'Esquivo: sem armadura/Escudo → Desviar como Ação Bônus.',
    'Escorregadio: Agarrado/Impedido — ataques sem Desvantagem; inimigos sem Vantagem.',
  ],
  'sangromantic-initiate': [
    'Magia de Sangue: 1 magia de Sangromancia preparada; 1×/DL sem espaço.',
    'Potência Sanguínea: pool de 2d12 no lugar de DV em magias de Sangromancia (recupera no DL).',
  ],
  'shadowsteel-adept': [
    'Conjurador de Maldições: maldições Shadowsteel sempre preparadas.',
    'Mordida de Shadowsteel: +1 ataque mágico e CD com foco.',
    'Arma de Shadowsteel: foco-arma +1 ataque e dano.',
  ],
  'shadowsteel-master': [
    'Harmonia Necrótica: alvo de magia sofre +1d4 Necrótico/nível de espaço.',
    'Arma Necrótica: foco-arma +2; 1×/turno +2d8 Necrótico no acerto.',
  ],
  'syndicate-spy': [
    'Chaveiro: prof. Ferramentas de Ladrão; fabrica chave em 10 min.',
    'Mestre do Disfarce: prof. Kit de Disfarce; aparência customizável (10 min).',
    'Mestre Calígrafo: prof. Kit de Falsificação; sem limite de 10 palavras.',
    'Passar Despercebido: Esconder-se Levemente Obscurecido; pode usar Carisma.',
  ],
  'thrown-weapon-master': [
    'Arremesso Múltiplo: após Atacar com Arremesso simples → 2 ataques extras (AB).',
    'Mãos Rápidas: AB para pegar/guardar armas Arremesso simples a 1,5 m.',
    'Retorno: arremesso simples proficiente ganha Retorno.',
  ],
  'witch-hunter': [
    'Mantenha Inimigos Perto: acerto corpo a corpo → −4,5 m Deslocamento do alvo.',
    'Resistir a Maldições: Vantagem vs maldições Shadowsteel e magias >10 min.',
  ],
  'advanced-weapon-proficiency': [
    'Proficiência com armas Avançadas e propriedades de maestria.',
    'Especial: pode ser talento Geral a partir do nível 8.',
  ],
  'close-combat-artillerist': [
    'Tiro em Corpo a Corpo: sem Desvantagem à distância a 1,5 m.',
    'Tiro à Queima-Roupa: acerto à distância a 1,5 m → +2 dano.',
  ],
  flurry: [
    'Golpe Rápido: com Vantagem no ataque, pode renunciar e atacar outro alvo a 1,5 m.',
  ],
  'mobile-combatant': [
    'Escorregadio: na ação Atacar +3 m Desloc.; Ataques de Oportunidade com Desvantagem contra você.',
  ],
  'prone-defense': [
    'Defensivo: Caído — sem Desvantagem nos ataques; inimigos sem Vantagem por Caído.',
    'Levantar Rápido: Caído → levantar com 1,5 m de deslocamento.',
  ],
  'boonofthe-archlich': [
    'Vaso de Vitalidade: no DL, Vaso da Alma recebe alma se vazio.',
  ],
  'boonofthe-ascended-vampire': [
    'Imune à Luz Solar.',
  ],
  'boonofthe-earthly-tether': [
    'Assombração Persistente: imune à Falha Realidade Desfiada.',
    'Crescimento Divergente: ganha 1 Dádiva Espectro elegível.',
  ],
  'boonofthe-elder-horror': [
    'Forma Estabilizante: rerrola ≤25 em Forma Instável (1×/DL).',
    'Crescimento Divergente: ganha 1 Dádiva Horror Aberrante elegível.',
  ],
  'boonofthe-elder-fey': [
    'Baluarte Fey: imune à Falha Constituição Enfraquecida.',
    'Crescimento Divergente: ganha 1 Dádiva Fey elegível.',
  ],
  'boonofthe-elder-fiend': [
    'Agente Livre: imune à Falha Puxão do Submundo.',
    'Crescimento Divergente: ganha 1 Dádiva Diabo elegível.',
  ],
  'boonofthe-elemental-temperance': [
    'Caos Controlado: imune à Falha Caos Primordial.',
  ],
  'boonofthe-high-seraph': [
    'Absolvição: imune à Falha Corrupção Serafim.',
    'Crescimento Divergente: ganha 1 Dádiva Serafim elegível.',
  ],
  'boonof-magic-resistance': [
    'Resistência Heroica: falha em salvaguarda → sucesso (1×/DC ou DL).',
  ],
  'boonof-perfect-flight': [
    'Voo 12 m (pairar).',
    'Queda Graciosa: queda >1,5 m desacelera a 18 m/rodada.',
  ],
  'boonof-shadowsteel-mastery': [
    'Estranhos Companheiros: imune à Falha Solitária.',
  ],
  'boonofthe-wilds': [
    'Predador Ápice: Forma Híbrida — 25 PV temp. ao entrar; +10 PV temp./turno se zerado; Vantagem sem PV temp.',
  ],
};

/**
 * Feats 100% ativos (C075) — não entram em GH_CAP4_FEAT_PASSIVE_NOTES.
 * Mecânica na aba Ações, não na coluna Passivas.
 */
export const GH_CAP4_ECONOMY_ONLY_FEATS = new Set([
  'lightning-caster', // Conjuração Dupla, Conjuração Rápida, Sobrecarga
  'dual-shot', // ataque extra no mesmo Ataque (arco/besta)
  'opportunist', // +2 ataque/dano em reações
]);
