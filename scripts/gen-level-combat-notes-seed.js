/**
 * Gera seeds phb_level_combat_note (Northlands + packs PHB estáticos).
 * Rode: node scripts/gen-level-combat-notes-seed.js
 */
const fs = require('fs');
const path = require('path');

function esc(s) {
  return s.replace(/'/g, "''");
}

/** @type {{kind:'class'|'subclass', slug:string, level:number, note:string, sort?:number}[]} */
const ROWS = [];

function addSubclass(slug, level, note, sort = 0) {
  ROWS.push({ kind: 'subclass', slug, level, note, sort });
}
function addClass(slug, level, note, sort = 0) {
  ROWS.push({ kind: 'class', slug, level, note, sort });
}

// —— Northlands ——
addSubclass('path-of-the-titan', 3, 'Fúria dos Gigantes: ao ativar Fúria, pode tornar-se Grande (equipamento cresce). Em Grande: carga ×2; Vantagem em FOR; +1 dado de dano em armas/Desarmado.');
addSubclass('path-of-the-titan', 6, 'Passos Esmagadores: atravessar espaço de criatura menor; inimigo — salv. FOR ou Caído e sem Reações.');
addSubclass('path-of-the-titan', 10, 'Golpes Titânicos: Golpe Forçoso empurra o dobro; Golpe no Tendão — Velocidade 0 até o próximo turno do alvo.');
addSubclass('path-of-the-titan', 14, 'Fúria dos Titãs: ao ativar Fúria, pode tornar-se Enorme (carga ×3; alcance +1,5 m; +2 dados de dano).');

addSubclass('viking', 3, 'Nascido no Mar: Vantagem vs empurrão/Caído/movimento forçado; Vantagem ao pilotar veículo aquático.', 0);
addSubclass('viking', 3, 'Maestria Viking: 1×/turno +PB no dano com Machado de Batalha, Espada Longa ou Lança (se tiver maestria).', 1);
addSubclass('viking', 7, 'Investida Selvagem: ação Atacar — mover + ataque CA; no acerto, AB Disparar pelo espaço do alvo.');
addSubclass('viking', 10, 'Chamado das Terras Nórdicas: no DL escolha Matador de Dragões / Nadador / Frio / Matador de Trolls.');
addSubclass('viking', 15, 'Represália do Saqueador: use a Economia (Reação; crítico + PV temp.).');
addSubclass('viking', 18, 'Assalto Imparável: use a Economia (1×/DL).');

addSubclass('oath-of-valhalla', 3, 'Destruição Encorajadora / Guardião dos Mortos: use a Economia (Canalizar).');
addSubclass('oath-of-valhalla', 7, 'Aura Trovejante: você e aliados — Imunidade a Trovão na Aura de Proteção; montaria pode causar Trovão.');
addSubclass('oath-of-valhalla', 15, 'Alma Valorosa: ao reduzir inimigo a 0 PV (CA), aliados a 18 m — Vantagem 1 min; morte com Repouso Tranquilo.');
addSubclass('oath-of-valhalla', 20, 'Espírito da Valquíria: use a Economia (forma 10 min).');

addSubclass('skald', 3, 'Provocação Poética: Zombaria Perversa sempre preparada; falha na salv. — Desvantagem na próxima salv. de SAB/INT/CAR.', 0);
addSubclass('skald', 3, 'Treino Marcial: armas Marciais, armadura Média e Escudos; arma como Foco; 1 maestria de arma (troca no DL).', 1);
addSubclass('skald', 6, 'Runa de Bragi: use a Economia (Escárnio / Eloquência / Vitalidade).');
addSubclass('skald', 14, 'Sagas de Batalha: use a Economia (1 min de recitação; benefícios 1 h).');

addSubclass('nornbound', 3, 'Fios da Teia: role 2d6 no DL (dado sobe L7/11/15). Reação: some/subtraia 1 Fio a ataque/dano/salv./teste a 18 m.', 0);
addSubclass('nornbound', 3, 'Puxar os Fios: use a Economia (Canalizar — Vantagem a aliados).', 1);
addSubclass('nornbound', 6, 'Destino Entrelaçado: use a Economia (espaço → dano Força + cura/PV temp.).');
addSubclass('nornbound', 17, 'Tecelão da Teia: ao Puxar os Fios, inimigos a 9 m — salv. CAR ou Desvantagem 1 min.');

addSubclass('circle-of-fenris', 3, 'Manto do Lobo: use a Economia (Forma Selvagem). Com Manto: bônus FOR (Atletismo/salv.) = mod. SAB; mordida espectral.');
addSubclass('circle-of-fenris', 6, 'Manto Aprimorado: mordidas ×2 vs objetos; Visão no Escuro 18 m (ou +9 m); Velocidade +3 m.');
addSubclass('circle-of-fenris', 10, 'Defender a Alcateia: use a Economia (Reação — lobo fantasma 4d8 Força + Caído; L14: 6d8).');
addSubclass('circle-of-fenris', 14, 'Filhos do Grande Lobo: use a Economia (1×/dia ao assumir Manto — fenrikyn).');

addSubclass('spirit-caller', 3, 'Expertise Oculta: Arcanismo e Religião; pode usar CAR nesses testes se maior que INT.', 0);
addSubclass('spirit-caller', 3, 'Orientação Espiritual: use a Economia (AB — Vantagem em perícia).', 1);
addSubclass('spirit-caller', 6, 'Aura Espiritual: use a Economia (2×/DL ou 3 Pontos de Feitiçaria).');
addSubclass('spirit-caller', 14, 'Segredos Espirituais: use a Economia (rerrolar falha; ou 3 PF).');
addSubclass('spirit-caller', 18, 'Tempestade Espiritual: Aura 4,5 m; inimigo que entra/inicia — 2d8 Psíquico (1×/turno).');

addSubclass('trickster', 3, 'Troca de Contexto: use a Economia (Reação — troca de lugar).', 0);
addSubclass('trickster', 3, 'Trapaça Ágil: prof. Prestidigitação; Vantagem ao trocar itens semelhantes.', 1);
addSubclass('trickster', 6, 'Troca Distante: alcance 9 m na Troca; ou Desvantagem na salv. + Invisível se falhar.');
addSubclass('trickster', 10, 'Irrealidade Dolorosa: sucesso auto ao Analisar ilusões; falha ao discernir — salv. SAB, 4d10 Psíquico + Atordoado.');
addSubclass('trickster', 14, 'Arauto do Caos: use a Economia (1×/DC).');

// —— Gunslinger ——
addClass('gunslinger', 2, 'Dado de Risco: gaste em manobras (painel). Recarrega no Descanso Curto/Longo.');

const gun = [
  ['pistolero', 3, 'Pistolero — Tiro a Queima-Roupa: sem Desvantagem em ataques à distância a 1,5 m de inimigo.', 0],
  ['pistolero', 3, 'Abrir o Leque e Confronto: manobras no painel (gastam Dado de Risco).', 1],
  ['pistolero', 6, 'Desarmar: em crítico com Tiro no Estômago, solte um objeto a até 4,5 m (mesa).'],
  ['pistolero', 14, 'Tempo Bala: 1×/turno, Vantagem em um ataque à distância com arma.'],
  ['deadeye', 3, 'Olho Morto — Olho de Águia: manobra no painel (erra → +risk no ataque).', 0],
  ['deadeye', 3, 'Postura do atirador: sem Desvantagem à distância por Caído; levantar com 1,5 m.', 1],
  ['deadeye', 6, 'Posição oculta: Esconder Caído sem cobertura total; falha no ataque não revela se escondido.'],
  ['deadeye', 10, 'Reposicionar (Reação): ao ser errado, encerre Caído e mova até metade da Velocidade.'],
  ['deadeye', 14, 'Tiro Focado: Atacar com 1 ataque à distância (Vantagem = crítico) — Economia.'],
  ['high-roller', 3, 'Grande Apostador — Dados do Mentiroso: manobra no painel (blefe de dano).'],
  ['high-roller', 6, 'Negócio Arriscado: 1×/turno Desvantagem no ataque → recupera 1 risk (± Economia).'],
  ['high-roller', 10, 'Assumidor de risco: Espírito Independente / Por um Triz podem usar d6 sem gastar risk (mesa).'],
  ['high-roller', 14, 'Duplo ou Nada: no crítico, aposte d20 (10+ = ×4 dano; 9− = acerto normal) — Economia.'],
  ['secret-agent', 3, 'Agente Secreto — Tiro de despedida: manobra no painel (Correr/Desengajar/Esquivar → BA ataque).'],
  ['secret-agent', 6, 'Artesanato de campo: fantasia com Kit de Disfarce (BA); Enganação/Persuasão mínimo 10 no d20.'],
  ['secret-agent', 10, 'Estratégia de Saída: Reação Invisível + 3 m (1×/descanso; restaure com 1 risk) — Economia.'],
  ['secret-agent', 14, 'Licença para Matar: 1–2 risk no dano (explode no máximo; teto = PB) — Economia.'],
  ['spellslinger', 3, 'Pistoleiro Arcano — Tiro Arcano: BA +1 risk no dano de Pistolas de Dedo — Economia.'],
  ['spellslinger', 14, 'Bala Mágica: manobra no painel (substitui ataque mágico por arma + risk).'],
  ['trick-shot', 3, 'Tiro de Trucagem — Ricochete: manobra no painel (erra → rerrole + risk).', 0],
  ['trick-shot', 3, 'Trajetória Criativa: ataques à distância ignoram Meia Cobertura e Cobertura ¾.', 1],
  ['trick-shot', 6, 'Tiroteio extravagante: +risk grátis em Desempenho/Prestidigitação com arma; reload free no turno.'],
  ['trick-shot', 10, 'Deflexão Hábil: manobra no painel (Reação — Por um Triz em aliado).'],
  ['trick-shot', 14, 'Tiro de Pinball: ricochetes (1×/descanso; restaure com 2 risk) — Economia.'],
  ['white-hat', 3, 'Chapéu Branco — Estabeleça a Lei: manobra no painel (PV Temp. + Reação de tiro).', 0],
  ['white-hat', 3, 'Aura de Olhos de Aço (3 m): você e aliados com Vantagem vs Amedrontado.', 1],
  ['white-hat', 6, 'Alcance os céus: no crítico, peça rendição (SAB vs CD de Manobra) — mesa.'],
  ['white-hat', 10, 'Longo braço da lei: 1×/turno, acerto em Grande ou menor → mancar (precisa Desengajar para se mover).'],
  ['white-hat', 14, 'Herói Estrela Dourada: aura 9 m; Estabeleça a Lei dá Resistência física; rendição Atordoado.'],
];
for (const [slug, level, note, sort] of gun) addSubclass(slug, level, note, sort ?? 0);

// —— Sorcerer ——
addClass('sorcerer', 1, 'Feitiçaria Inata (2×/DL): Ação Bônus libera a magia por 1 minuto (+1 na CD das suas magias de Feiticeiro e Vantagem nas jogadas de ataque das magias de Feiticeiro).');
addClass('sorcerer', 2, 'Fonte de Magia: converta Slots de Magia em Pontos de Feitiçaria (1:1) ou Pontos de Feitiçaria em Slots de 1º a 5º círculo.', 0);
addClass('sorcerer', 2, 'Metamagia: aplique opções conhecidas gastando Pontos de Feitiçaria.', 1);
addClass('sorcerer', 5, 'Restauração Feiticeira (1×/DL): no Descanso Curto, recupere Pontos de Feitiçaria até metade do nível do Feiticeiro.');
addClass('sorcerer', 7, 'Feitiçaria Encarnada: sem usos de Feitiçaria Inata, gaste 2 Pontos de Feitiçaria ao ativá-la; com Inata ativa, até 2 Metamagias por magia.');
addClass('sorcerer', 20, 'Apoteose Arcana: enquanto a Feitiçaria Inata estiver ativa, você pode usar uma opção de Metamagia por turno sem gastar Pontos de Feitiçaria.');

addSubclass('draconic', 3, 'Linhagem Dracônica: Resiliência Dracônica (CA sem armadura = 10 + DES + CAR; +1 PV por nível) e Afinidade Elemental (+CAR no dano de magias do elemento ancestral).');
addSubclass('draconic', 14, 'Asas de Dragão (L14): Ação Bônus — voo 18 m por 1 h (1×/DL ou 3 Pontos de Feitiçaria para restaurar o uso).');
addSubclass('aberrant', 3, 'Feitiçaria Aberrante: Mente Psiónica (telepatia a 9 m) e Feitiçaria Psiónica (gaste Pontos de Feitiçaria em vez de slots para magias aberrantes sem componentes V, S ou M).');
addSubclass('aberrant', 18, 'Implosão de Distorção (L18): ação Usar Magia — teleporte e dano espacial (1×/DL); gaste na economia/painel.');
addSubclass('clockwork', 3, 'Feitiçaria Mecânica: Restaurar Equilíbrio (Reação; usos = CAR) e Bastião da Lei (1–5 Pontos → N d8 de proteção).');
addSubclass('wild-magic', 3, 'Feitiçaria Selvagem: Marés do Caos (Vantagem em 1 Teste de D20; 1 uso).');
addSubclass('wild-magic', 6, 'Distorcer a Sorte (L6): Reação — 1 Ponto de Feitiçaria → ±1d4 no d20 de outra criatura.');
addSubclass('heroic-sorcery', 3, 'Feitiçaria Heróica: Alma Heróica (1 Ponto de Feitiçaria no início do turno → PV temp. 1d6 + nível); treino marcial e Lâmina Inata (CAR no ataque com Feitiçaria Inata).');
addSubclass('heroic-sorcery', 6, 'Ataque Extra: dois ataques; pode trocar um por um Truque de Feiticeiro.');
addSubclass('heroic-sorcery', 14, 'Manobras Místicas (2 SP): Cegar, Ruinoso (−3 CA) ou Ferimento (sangramento) +2d8 no dano — gaste na economia.');
addSubclass('heroic-sorcery', 18, 'Aceleração Heróica: Acelerar em você sem Concentração (sem letargia ao terminar).');

// —— Barbarian subclasses ——
const barb = [
  ['berserker', 3, 'Berserker: Frenesi — com Fúria + Imprudente, +Nd6 (N = bônus de Fúria) no 1º acerto FOR do turno.'],
  ['berserker', 6, 'Fúria Irracional: Imunidade a Amedrontado/Enfeitiçado enquanto enfurecido.'],
  ['berserker', 10, 'Retaliação: Reação ao sofrer dano a 1,5 m — ataque corpo a corpo.'],
  ['berserker', 14, 'Presença Intimidante: AB — CD FOR; Amedrontado 1 min (1×/DL; restaure gastando Fúria).'],
  ['wild-heart', 3, 'Coração Selvagem: ao entrar em Fúria escolha Águia/Lobo/Urso. Águia tem Usar (AB: Correr+Desengajar).'],
  ['wild-heart', 6, 'Aspecto dos Selvagens: Coruja/Pantera/Salmão (escolha no DL — mesa).'],
  ['wild-heart', 14, 'Poder dos Selvagens: ao entrar em Fúria escolha Carneiro/Falcão/Leão.'],
  ['world-tree', 3, 'Árvore do Mundo: ao entrar em Fúria, PV temp. = nível; no início do turno (Fúria), aliado a 3 m pode ganhar Nd6 PV temp. (N = bônus de Fúria).'],
  ['world-tree', 6, 'Ramos: Reação — teleporte inimigo a 9 m (salvaguarda FOR).'],
  ['world-tree', 10, 'Raízes Devastadoras: +3 m de alcance com armas Pesadas/Versáteis; no acerto pode Derrubar ou Empurrar além de outra maestria.'],
  ['world-tree', 14, 'Percorrer a Árvore: teleporte 18 m (AB); 1×/Fúria até 45 m + aliados.'],
  ['zealot', 3, 'Fanático: Campeão dos Deuses (reserva d12); Fúria Divina (+1d6 + metade do nível no 1º acerto/turno).'],
  ['zealot', 6, 'Concentração Fanática: 1×/Fúria, rerrolar salvaguarda com +bônus de Fúria.'],
  ['zealot', 10, 'Presença Zelosa: AB — Vantagem em ataque/salvaguarda a aliados até seu próximo turno (1×/DL).'],
  ['zealot', 14, 'Fúria dos Deuses: forma divina 1 min ao entrar em Fúria (1×/DL).'],
  ['path-of-the-muscle-wizard', 3, 'Mago Musculoso: “Truques” (Mãos Mágicas / Toque Chocante / Ataque Certeiro); “Magias” 1× cada / DL enquanto enfurecido; Reação pode entrar em Fúria sem gastar uso.'],
  ['path-of-the-muscle-wizard', 10, 'Resistência Mágica: Vantagem em salvaguardas vs magias enquanto enfurecido.'],
  ['path-of-the-muscle-wizard', 14, 'Eu lancei o punho: 1×/Fúria — Ataque Desarmado com Vantagem, 6d6+FOR Contundente.'],
];
for (const [slug, level, note] of barb) addSubclass(slug, level, note);

// —— Monk subclasses ——
const monk = [
  ['open-hand', 3, 'Técnica da Mão Espalmada: na Torrente, cada acerto impõe Caído, empurrão ou sem Reação'],
  ['open-hand', 6, 'Integridade Corporal: Ação Bônus — cura MA + Sabedoria (usos = Sabedoria/DL)'],
  ['open-hand', 11, 'Passo Veloz: após Ação Bônus que não seja Passos do Vento, use Passos do Vento de imediato'],
  ['open-hand', 17, 'Palma Vibrante: 4 Foco no acerto desarmado → vibrações; encerrar força CON vs 10d12 Energético'],
  ['elements', 3, 'Sintonia Elemental: 1 Foco no início do turno (10 min) — tipo elemental, +3 m de alcance', 0],
  ['elements', 3, 'Manipular Elementos: conhece Elementalismo (SAB)', 1],
  ['elements', 6, 'Explosão Elemental: 2 Foco, esfera 6 m / 36 m, 3× MA (Destreza)'],
  ['elements', 11, 'Passo dos Elementos: com Sintonia ativa — natação e voo = Deslocamento'],
  ['elements', 17, 'Ápice Elemental: com Sintonia — dano extra MA 1×/turno; Passos do Vento aprimorados'],
  ['mercy', 3, 'Mão de Cura: 1 Foco para curar SAB + dado de Artes Marciais', 0],
  ['mercy', 3, 'Mão de Dolo: 1 Foco para dano Necrótico extra (1×/turno)', 1],
  ['mercy', 6, 'Toque de Médico: cura remove condição; dolo pode impor Envenenado'],
  ['mercy', 11, 'Torrente de Cura e Dolo: na Torrente, cura/dolo sem Foco extra (usos = Sabedoria/DL)'],
  ['mercy', 17, 'Mão da Misericórdia Final: 5 Foco + 1 uso/DL para reviver (4d10 + SAB)'],
  ['shadow', 3, 'Artes das Sombras: Visão no Escuro; 1 Foco → Escuridão (vê na área); Ilusão Menor'],
  ['shadow', 6, 'Passo da Sombra: teleporte 18 m entre Meia-luz/Escuridão + Vantagem'],
  ['shadow', 11, 'Passo Aprimorado: 1 Foco no Passo — sem requisito de sombra + Ataque Desarmado'],
  ['shadow', 17, 'Manto da Sombra: 3 Foco — Invisível 1 min; Torrente sem Foco'],
  ['warrior-of-the-street', 3, 'Combinação: 1 Foco no acerto → +2 a +6 nos ataques desarmados no turno', 0],
  ['warrior-of-the-street', 3, 'Punho de Ferro: acerto desarmado em objeto = crítico', 1],
  ['warrior-of-the-street', 6, 'Movimentos: Explosão de Energia, Quebrador de Guarda, Corte Superior (1 Foco cada)'],
  ['warrior-of-the-street', 11, 'Traço Aéreo: 1 Foco — voo até o fim do próximo turno'],
  ['warrior-of-the-street', 17, 'K.O.: +3× MA; ≤100 PV → Inconsciente (1×/descanso ou 5 Foco para recuperar)'],
];
for (const [slug, level, note, sort] of monk) addSubclass(slug, level, note, sort ?? 0);

// —— Paladin subclasses ——
const pal = [
  ['devotion', 3, 'Arma Sagrada: na ação Atacar, Canalizar — +Carisma no ataque e luz por 10 min'],
  ['devotion', 7, 'Aura de Devoção: imunidade a Enfeitiçado na aura'],
  ['devotion', 15, 'Destruição Protetora: ao usar Destruição Divina, Cobertura Parcial na aura até seu próximo turno'],
  ['devotion', 20, 'Resplendor Sagrado: aura de dano Radiante por 10 minutos'],
  ['glory', 3, 'Destruição Inspiradora: após Destruição Divina, Canalizar para distribuir PV temp. (2d8 + nível)', 0],
  ['glory', 3, 'Atleta Inigualável: Canalizar — Vantagem em Atletismo/Acrobacia e saltos +3 m por 1 h', 1],
  ['glory', 7, 'Aura de Vivacidade: +3 m de deslocamento (você e aliados na aura)'],
  ['glory', 15, 'Defesa Gloriosa: Reação — +CA (Carisma) contra um ataque; se errar, possível contra-ataque'],
  ['glory', 20, 'Lenda Viva: Vantagem em Carisma, golpe infalível e rerrolar salvaguarda'],
  ['ancients', 3, 'A Ira da Natureza: Canalizar — Contém criaturas a 4,5 m (salvaguarda de Força)'],
  ['ancients', 7, 'Aura de Resistência: Resistência a Necrótico, Psíquico e Radiante na aura'],
  ['ancients', 15, 'Sentinela Imortal: a 0 PV, fica com 1 + cura 3× nível (1×/DL)'],
  ['ancients', 20, 'Campeão Ancestral: transformação por 1 minuto'],
  ['vengeance', 3, 'Voto de Inimizade: na ação Atacar, Canalizar — Vantagem vs um alvo por 1 min'],
  ['vengeance', 7, 'Vingador Implacável: ao acertar AO, Desloc. 0 no alvo e metade do seu movimento'],
  ['vengeance', 15, 'Alma Vingativa: Reação para atacar o alvo do Voto após ele atacar'],
  ['vengeance', 20, 'Anjo Vingador: voo e aura Amedrontar por 10 minutos'],
  ['oath-of-revelry', 3, 'Conjurar Bebida: Canalizar Divindade para efeitos de bebida em área'],
  ['oath-of-revelry', 7, 'Aura de Fraternidade: +1d4 dano corpo a corpo na aura'],
  ['oath-of-revelry', 15, 'Folião: usos = mod. de Carisma por descanso longo'],
  ['oath-of-revelry', 20, 'Animal de Festa: transformação festiva (1×/longo ou espaço de 5º)'],
];
for (const [slug, level, note, sort] of pal) addSubclass(slug, level, note, sort ?? 0);

function emitSql(rows, header) {
  const lines = [header, ''];
  for (const r of rows) {
    if (r.kind === 'subclass') {
      lines.push(
        `INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)`,
      );
      lines.push(
        `SELECT 'subclass', NULL, s.id, ${r.level}, '${esc(r.note)}', ${r.sort ?? 0}`,
      );
      lines.push(`FROM rpg.phb_subclass s WHERE s.slug = '${r.slug}'`);
      lines.push(`  AND NOT EXISTS (`);
      lines.push(`    SELECT 1 FROM rpg.phb_level_combat_note n`);
      lines.push(
        `    WHERE n.subclass_id = s.id AND n.unlock_level = ${r.level} AND n.note = '${esc(r.note)}'`,
      );
      lines.push(`  );`);
      lines.push('');
    } else {
      lines.push(
        `INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)`,
      );
      lines.push(
        `SELECT 'class', c.id, NULL, ${r.level}, '${esc(r.note)}', ${r.sort ?? 0}`,
      );
      lines.push(`FROM rpg.phb_class c WHERE c.slug = '${r.slug}'`);
      lines.push(`  AND NOT EXISTS (`);
      lines.push(`    SELECT 1 FROM rpg.phb_level_combat_note n`);
      lines.push(
        `    WHERE n.class_id = c.id AND n.unlock_level = ${r.level} AND n.note = '${esc(r.note)}'`,
      );
      lines.push(`  );`);
      lines.push('');
    }
  }
  return lines.join('\n');
}

const northlands = ROWS.filter((r) =>
  [
    'path-of-the-titan',
    'viking',
    'oath-of-valhalla',
    'skald',
    'nornbound',
    'circle-of-fenris',
    'spirit-caller',
    'trickster',
  ].includes(r.slug),
);
const phb = ROWS.filter((r) => !northlands.includes(r));

const outN =
  'database/seeds/notes/northlands/phb_level_combat_note.northlands.sql';
const outP = 'database/seeds/notes/phb/phb_level_combat_note.static-packs.sql';
fs.mkdirSync(path.dirname(outN), { recursive: true });
fs.mkdirSync(path.dirname(outP), { recursive: true });
fs.writeFileSync(
  outN,
  emitSql(northlands, '-- Notas Northlands → phb_level_combat_note'),
);
fs.writeFileSync(
  outP,
  emitSql(
    phb,
    '-- Notas estáticas PHB/Valdas (gunslinger, sorcerer, barb/monk/paladin subclasses)',
  ),
);
console.log('northlands', northlands.length, '→', outN);
console.log('phb packs', phb.length, '→', outP);
