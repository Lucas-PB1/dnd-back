/**
 * Seed remaining static PHB combat notes → phb_level_combat_note.
 * node scripts/gen-level-combat-notes-remaining.js
 */
const fs = require('fs');
const path = require('path');

function esc(s) {
  return String(s).replace(/'/g, "''");
}

const ROWS = [];
function S(slug, level, note, sort = 0) {
  ROWS.push({ kind: 'subclass', slug, level, note, sort });
}
function C(slug, level, note, sort = 0) {
  ROWS.push({ kind: 'class', slug, level, note, sort });
}

// —— Fighter ——
C('fighter', 2, 'Mente Tática: ao falhar em teste de atributo, gaste Recuperar Fôlego para +1d10 (uso devolvido se ainda falhar)');
C('fighter', 5, 'Ajuste Tático: ao usar Recuperar Fôlego, mova-se até metade do Deslocamento sem provocar AO');
C('fighter', 9, 'Mestre Tático: pode substituir a maestria da arma por Empurrar, Drenar ou Lentidão neste ataque');
C('fighter', 13, 'Ataques Estudados: se errar um ataque, vantagem no próximo ataque contra o mesmo alvo até o fim do próximo turno');
S('champion', 10, 'Combatente Heroico: no início do turno sem Inspiração Heroica, conceda-a a si');
S('champion', 18, 'Sobrevivente: Vantagem em salvaguardas contra morte; Regeneração Heroica se Sangrando');
S('eldritch-knight', 3, 'Cavaleiro Místico: conjuração de 1/3 (lista de Mago, INT)');
S('eldritch-knight', 7, 'Magia de Guerra: substitua 1 ataque por um truque (ação) na ação Atacar');
S('dungeoneer', 3, 'Chute na Porta: Vantagem nos ataques na primeira rodada de combate');
S('dungeoneer', 15, 'Evitar: em salvaguarda FOR/DES/CON por metade do dano, sucesso = 0 e falha = metade');

// —— Rogue ——
C('rogue', 2, 'Ação Ardilosa: Correr, Desengajar ou Esconder como Ação Bônus');
C('rogue', 3, 'Mira Firme: vantagem no próximo ataque, sem movimento no turno');
C('rogue', 5, 'Golpe Astuto: sacrifique dados de Ataque Furtivo para aplicar efeitos', 0);
C('rogue', 5, 'Esquiva Sobrenatural: use a Reação para reduzir pela metade o dano do ataque', 1);
C('rogue', 7, 'Evasão: sucesso em salvaguarda de Destreza causa 0 dano; falha causa metade', 0);
C('rogue', 7, 'Talento Confiável: resultados 9 ou menos viram 10 em testes com proficiência', 1);
C('rogue', 11, 'Golpe Astuto Aprimorado: aplique até dois efeitos, pagando ambos os custos');
C('rogue', 14, 'Golpes Sujos: Aturdir, Nocaute e Obscurecer disponíveis');
C('rogue', 15, 'Mente Escorregadia: proficiência em salvaguardas de Sabedoria e Carisma');
C('rogue', 18, 'Elusivo: ataques não têm Vantagem contra você enquanto não Incapacitado');
C('rogue', 20, 'Golpe de Sorte: transforme um Teste de D20 que falhou em 20');
S('soulknife', 3, 'Lâminas Psíquicas: 1d6 Psíquico; segunda lâmina 1d4 como Ação Bônus');
S('soulknife', 9, 'Lâminas da Alma: Golpes Teleguiados e Teleporte Psíquico');
S('soulknife', 13, 'Véu Psíquico: Invisível por até 1 hora');
S('soulknife', 17, 'Rasgar Mente: salvaguarda de Sabedoria ou Atordoado');
S('assassin', 3, 'Assassinar: Vantagem na Iniciativa e Golpe Surpreendente');
S('assassin', 9, 'Especialista em Infiltração: Mimetismo Magistral e Mira Móvel');
S('assassin', 13, 'Armas Venenosas: Envenenar causa 2d6 Venenoso adicional em falha');
S('assassin', 17, 'Golpe Mortal: salvaguarda de Constituição ou dobre o dano');
S('thief', 3, 'Ladrão: Mão Leve e Andarilho de Telhados');
S('thief', 9, 'Furtividade Suprema: Ataque Escondido custa 1 dado de Ataque Furtivo');
S('thief', 13, 'Usar Dispositivo Mágico: quatro sintonizações e uso de pergaminhos');
S('thief', 17, 'Reflexos de Ladrão: dois turnos na primeira rodada');
S('arcane-trickster', 3, 'Trapaceiro Arcano: conjuração de Mago (INT) e Mãos Mágicas Ligeiras');
S('arcane-trickster', 9, 'Emboscada Mágica: salvaguardas contra magia têm Desvantagem');
S('arcane-trickster', 13, 'Trapaceiro Versátil: Golpe Astuto também afeta alvo junto à Mão Mágica');
S('arcane-trickster', 17, 'Ladrão de Magias: negue e roube uma magia com sua Reação');
S('arachnoid-stalker', 3, 'Golpe Venenoso: Ataque Furtivo pode causar d8s de dano Venenoso', 0);
S('arachnoid-stalker', 3, 'Correia: teias para movimento, objetos, corda ou a magia Teia', 1);
S('arachnoid-stalker', 9, 'Rastejando na Parede: escalada em paredes e tetos com mãos livres');
S('arachnoid-stalker', 13, 'Sentido de Aranha: Esquiva Sobrenatural contra dano de salvaguarda');
S('arachnoid-stalker', 17, 'Veneno Paralítico: Paralisar custa 4 dados de Ataque Furtivo');

// —— Ranger ——
C('ranger', 1, 'Inimigo Favorito: Marca do Predador sempre preparada; usos gratuitos = PB (recuperam no Descanso Longo)');
C('ranger', 2, 'Explorador Hábil: Especialização em 1 perícia e 2 idiomas');
C('ranger', 5, 'Ataque Extra: dois ataques na ação Atacar');
C('ranger', 6, 'Errante: +3 m de Deslocamento (sem Armadura Pesada); Escalada e Natação iguais ao Deslocamento');
C('ranger', 9, 'Especialista: Especialização em mais 2 perícias');
C('ranger', 10, 'Incansável: ação Usar Magia concede 1d8 + SAB PV temporários (usos = mod. SAB); Descanso Curto reduz Exaustão em 1');
C('ranger', 13, 'Predador Implacável: dano não quebra Concentração da Marca do Predador');
C('ranger', 14, 'Véu da Natureza: Ação Bônus para Invisível até o fim do próximo turno (usos = mod. SAB)');
C('ranger', 17, 'Caçador Preciso: Vantagem nos ataques contra a criatura marcada');
C('ranger', 18, 'Sentidos Selvagens: Visão às Cegas 9 m');
C('ranger', 20, 'Matador de Inimigos Favoritos: dado da Marca do Predador vira d10');
S('beastborne', 3, 'Portador Bestial: garras (1d6 Cortante, DES/FOR), Escalada e Visão no Escuro +9 m.', 0);
S('beastborne', 3, 'Aspecto Bestial: na mesa, suba o nível (0–5) ao causar dano (Ação Bônus); zera se 1 min sem dano. Níveis: Carnificina +2, Velocidade +3 m, Frenesi de Sangue, Pele +2 CA, Retaliação.', 1);
S('beastborne', 7, 'Uivo Feral: na Iniciativa, role 1d4 e defina o Aspecto Bestial nesse valor.');
S('beastborne', 11, 'Fúria Sedenta: Marca do Predador na Ação Bônus que sobe o Aspecto; Carnificina +3.');
S('beastborne', 15, 'Resiliência Monstruosa: 1×/turno reduza dano em mod. CON + nível de Aspecto (mín. 0).');
S('hunter', 3, 'Presa do Caçador: Assassino de Colossos (+1d8 1×/turno vs alvo abaixo do máximo) ou Destruidor de Hordas (ataque extra a outro alvo a 1,5 m)', 0);
S('hunter', 3, 'Conhecimento do Caçador: enquanto marcado, saiba Imunidades/Resistências/Vulnerabilidades', 1);
S('hunter', 7, 'Táticas Defensivas: Defesa Contra Ataques Múltiplos ou Escapar de Hordas');
S('hunter', 11, 'Presa do Caçador Superior: ao causar dano da Marca, cause o mesmo em outra criatura a até 9 m');
S('hunter', 15, 'Defesa do Caçador Superior: Reação para Resistência ao dano recebido neste turno');
S('beast-master', 3, 'Companheiro Primal: Ação Bônus para comandar a fera; pode sacrificar um ataque para o Golpe da Fera');
S('beast-master', 7, 'Treinamento Excepcional: comande Ajudar/Correr/Desengajar/Esquivar; dano Energético opcional');
S('beast-master', 11, 'Fúria Bestial: Golpe da Fera duas vezes; a fera também causa o bônus da Marca do Predador');
S('beast-master', 15, 'Compartilhar Magias: magias em si também afetam a fera a até 9 m');
S('fey-wanderer', 3, 'Glamour Transcendental: +mod. SAB (mín. +1) em testes de Carisma');
S('fey-wanderer', 7, 'Detalhe Sedutor: Vantagem vs Amedrontado/Enfeitiçado; Reação para redirecionar o efeito');
S('fey-wanderer', 11, 'Reforços Feéricos: Convocar Feérico 1× sem espaço / longo (sem Concentração, 1 min)');
S('fey-wanderer', 15, 'Andarilho Nebuloso: Passo Nebuloso gratuito (usos = mod. SAB); pode levar um aliado');
S('gloom-stalker', 3, 'Visão Umbrosa: Visão no Escuro 18 m (ou +18 m); Invisível na Escuridão contra Visão no Escuro');
S('gloom-stalker', 7, 'Mente de Ferro: proficiência em salvaguarda de Sabedoria (ou INT/CAR se já tiver)');
S('gloom-stalker', 11, 'Torrente do Vigilante: Golpe Terrível 2d8 + ataque/Medo em Massa');
S('gloom-stalker', 15, 'Esquiva Sombria: Reação impõe Desvantagem e teleporte de 9 m');

// —— Warlock ——
C('warlock', 11, 'Arcanum Místico: conjura magias de 6º a 9º círculo sem gastar slots de pacto (1×/Descanso Longo cada).');
S('celestial', 6, 'Alma Radiante: Resistência a Radiante; 1×/turno +CAR no dano de Fogo ou Radiante de uma magia sua.');
S('celestial', 10, 'Resiliência Celestial: após Astúcia Mágica ou Descanso Curto/Longo, PV temp = nível + CAR (você e até 5 aliados a 9 m).');
S('celestial', 14, 'Vingança Calcinante: quando você ou aliado a 18 m for fazer salvaguarda contra morte (1×/DL).');
S('fiend', 3, 'Patrono Ínfero: Bênção do Tenebroso (PV temp = CAR + nível ao reduzir inimigo a 0 PV).');
S('fiend', 6, 'A Sorte do Próprio Tenebroso: +1d10 a um teste ou salvaguarda (usos = CAR).');
S('fiend', 10, 'Resistência Ínfera: após Descanso Curto ou Longo, escolha Resistência a um tipo de dano (exceto Energético).');
S('fiend', 14, 'Lançar no Inferno: ao acertar, envie o alvo aos Infernos (1×/DL; recarrega com Slot de Pacto).');
S('archfey', 6, 'Fuga em Névoa: Reação ao sofrer dano — conjure Passo Nebuloso; efeitos Desvanecedor e Terrível entram nas opções de Passos Feéricos.');
S('archfey', 10, 'Defesas Sedutoras: imune a Enfeitiçado; Reação após ser acertado — metade do dano + psíquico no atacante (1×/DL ou Slot de Pacto).');
S('archfey', 14, 'Magia Sedutora: após conjurar Encantamento ou Ilusão com ação e espaço, conjure Passo Nebuloso como parte da mesma ação sem gastar espaço.');
S('great-old-one', 3, 'Patrono Grande Antigo: Mente Desperta (telepatia BA a 9 m) e Magias Psíquicas (dano de Bruxo pode ser Psíquico; Encantamento/Ilusão sem V/S).');
S('great-old-one', 6, 'Combatente Clarividente: ao usar Mente Desperta, alvo salva Sabedoria; falha → desv. vs você / você vant. vs alvo (1× SR/LR ou Slot).');
S('great-old-one', 10, 'Danação Mística: sempre tem Danação preparada; alvo também tem Desvantagem nas salvaguardas do atributo escolhido.', 0);
S('great-old-one', 10, 'Escudo Mental: pensamentos ilegíveis; Resistência a Psíquico; quem causar Psíquico a você também sofre o dano.', 1);
S('great-old-one', 14, 'Criar Servo: Invocar Aberração sem Concentração (duração 1 min) + PV temp = nível; dano psíquico extra vs alvo da sua Danação.');

// —— Wizard ——
C('wizard', 1, 'Ritualista Arcano: conjure magias de ritual diretamente do seu Grimório sem precisar tê-las preparadas.');
C('wizard', 18, 'Dominância de Magias: escolha 1º e 2º círculo na aba Magias; conjure à vontade sem espaço.');
C('wizard', 20, 'Assinatura de Magia: 2 magias de 3º círculo preparadas sempre disponíveis; 1× por descanso longo conjure cada uma sem gastar slot.');
S('abjurer', 3, 'Abjurador: Proteção Arcana (barreira ao conjurar Abjuração 1º+; Ação Bônus gasta slot para recuperar 2× círculo).');
S('abjurer', 14, 'Resistência à Magia: vantagem em salvaguardas contra magias; Resistência a dano de magias.');
S('diviner', 6, 'Perito em Adivinhação: ao conjurar Adivinhação com espaço de 2º+, recupere um espaço de nível inferior.');
S('evoker', 3, 'Evocador: Truque Potente (em salvaguarda bem-sucedida contra seu truque de dano, o alvo ainda sofre metade).');
S('evoker', 6, 'Esculpir Magias: escolha aliados na área de Evocação; passam automaticamente e não sofrem dano.');
S('evoker', 10, 'Evocação Potencializada: ao rolar dano de Evocação conjurada com espaço, trate 1s no dado como 2s.');
S('illusionist', 3, 'Ilusionista: Ilusão Aprimorada (truques de Ilusão e Imagem Silenciosa como Ação Bônus, sem V, alcance dobrado).');
S('magic-missile-mage', 3, 'Mago dos Mísseis: +1–4 dardos nos nv. 3/6/10/14; penetram Escudo. Economia na aba Ações (gratuitos, Versáteis, Escudo, Giga).');
S('sangromancer', 3, 'Sangromante: Dados de Sangromancia (d12; máx. = 1 + nível de Mago). Gaste no lugar de Dados de Vida ao conjurar magias de Sangromancia. Recupera 1 no Descanso Curto, todos no Longo.', 0);
S('sangromancer', 3, 'Especialista em Sangromancia: magias de Sangromancia contam como de Mago; grimório ganha escolhas gratuitas na aba de opções de subclasse.', 1);
S('sangromancer', 10, 'Sangue por Sangue: 1×/turno, ao causar dano com magia de Mago, gaste DV ou Dado de Sangromancia para dano extra (Ferido: role 2×, use o maior).');
S('sangromancer', 14, 'Renovação Rubra: após Descanso Curto, recupere metade do nível em DV e Dados de Sangromancia (1× até o próximo Descanso Longo).');

// —— Cleric ——
C('cleric', 1, 'Ordem Divina: Protetor concede armas Marciais e Armadura Pesada; Taumaturgo concede um truque e +SAB (mín. +1) em Arcanismo/Religião');
C('cleric', 5, 'Fulminar Mortos-Vivos: mortos-vivos que falham contra Expulsar sofrem dados Radiantes iguais ao mod. SAB (mín. 1d8)');
C('cleric', 10, 'Intervenção Divina: conjure uma magia de Clérigo de até 5º círculo sem espaço ou componente Material (1×/Descanso Longo)');
C('cleric', 14, 'Golpes Abençoados Aprimorados: Conjuração Poderosa concede 2×SAB PV temporários ou Golpe Divino causa 2d8');
C('cleric', 20, 'Intervenção Divina Maior: pode escolher Desejo; nesse caso, recarga após 2d4 Descansos Longos');
S('life', 3, 'Domínio da Vida: Discípulo da Vida soma 2 + círculo à cura; Preservar a Vida distribui 5 × nível em PV até metade do máximo');
S('life', 6, 'Curandeiro Abençoado: ao curar outra criatura com espaço, recupere 2 + círculo em PV');
S('life', 17, 'Cura Suprema: dados de cura usam o valor máximo');
S('light', 3, 'Domínio da Luz: Brilho do Amanhecer causa 2d10 + nível Radiante; Labareda Protetora impõe Desvantagem como Reação');
S('light', 6, 'Labareda Protetora Aprimorada: recupera em Descanso Curto e concede 2d6 + SAB PV temporários');
S('light', 17, 'Coroa de Luz: aura de luz solar; inimigos têm Desvantagem nas salvaguardas contra dano Ígneo/Radiante');
S('trickery', 3, 'Domínio da Trapaça: Bênção do Trapaceiro dá Vantagem em Furtividade; Invocar Duplicidade cria a ilusão com Canalizar Divindade');
S('trickery', 6, 'Transposição do Trapaceiro: troque de lugar com a ilusão');
S('trickery', 17, 'Duplicidade Aprimorada: aliados também recebem a distração');
S('war', 3, 'Domínio da Guerra: Ataque Direcionado concede +10 após um erro; Sacerdote da Guerra faz ataque com Ação Bônus');
S('war', 6, 'Bênção do Deus da Guerra: Canalizar conjura Arma Espiritual ou Escudo da Fé sem espaço e sem Concentração');
S('war', 17, 'Avatar da Guerra: Resistência a dano Contundente, Cortante e Perfurante');
S('dragon-domain', 3, 'Domínio do Dragão: após Descanso Longo escolha Ácido/Frio/Fogo/Relâmpago/Veneno; troque Necrótico/Radiante de Clérigo por esse tipo e cause dano extra = nível (usos = mod. SAB).', 0);
S('dragon-domain', 3, 'Majestade Dracônica: Canalizar Divindade — Emanação 9 m Enfeitiçado ou Amedrontado (salvaguarda SAB).', 1);
S('dragon-domain', 6, 'Bênção da Serpe: Canalizar para Sopro do Dragão ou Proteção contra Energia em você sem Concentração.');
S('dragon-domain', 17, 'Aspecto Lendário: 3 ações lendárias/DL (Rasgar, Cauda, Asas) — Usar no painel/economia.');

// —— Bard ——
C('bard', 2, 'Pau para Toda Obra: adicione metade da PB (arredondada para baixo) em testes de habilidade sem proficiência.', 0);
C('bard', 2, 'Balada de Cura: criaturas que gastam Dados de Vida no Descanso Curto recuperam +1d6 PV extras.', 1);
C('bard', 5, 'Fonte de Inspiração: Inspiração de Bardo recarrega em Descanso Curto ou Longo.');
C('bard', 18, 'Inspiração Superior: ao rolar iniciativa sem usos de Inspiração de Bardo, recupere 1 uso.');
S('lore', 3, 'Colégio do Conhecimento: Palavras de Interrupção (Reação: gasta Inspiração para subtrair do ataque/teste/dano inimigo).');
S('lore', 6, 'Descobertas Mágicas: aprenda 2 magias adicionais de qualquer lista.');
S('lore', 14, 'Perícia Inigualável: após falhar teste/ataque, some o dado de Inspiração (só gasta se virar sucesso).');
S('glamour', 3, 'Colégio do Glamour: Manto de Inspiração (gasta Inspiração para PV temp. 2×dado e movimento por Reação).');
S('glamour', 6, 'Manto de Majestade: Comando sem espaço (1×/DL; restaurável com espaço 3+).');
S('glamour', 14, 'Majestade Inquebrável: presença 1 min — atacante falha salvo CAR ou o ataque falha.');
S('dance', 3, 'Colégio da Dança: Dança Virtuosa (Ataque Desarmado com DES + dado de Inspiração; Golpes Ágeis ao gastar Inspiração).');
S('dance', 6, 'Movimento Coordenado (iniciativa) e Movimento Inspirador (Reação a 1,5 m).');
S('dance', 14, 'Evasão Liderada: Evasão e compartilhe com aliado a 1,5 m.');
S('valor', 3, 'Colégio da Bravura: Inspiração em Combate (aliados usam Inspiração na CA ou no dano). Proficiência Marcial/Escudo.');
S('valor', 6, 'Ataque Extra (Bravura): pode substituir um ataque por um Truque.');
S('valor', 14, 'Magia de Batalha: após magia de ação, ataque com arma como Ação Bônus.');
S('college-of-masks', 3, 'Colégio das Máscaras: vista máscaras no painel; efeitos que gastam Inspiração têm Usar (Anjo/Diabo/Dragão/Gladiador/Bobão).', 0);
S('college-of-masks', 3, 'Artista Teatral: Kit de Disfarce; some o dado de Inspiração em Atuação sem gastar uso.', 1);
S('college-of-masks', 6, 'Habilidade de Virtuoso: 1×/turno Teste d20 com Carisma (usos = mod. CAR).');
S('college-of-masks', 14, 'Mestre de Muitas Faces: use duas máscaras ao mesmo tempo.');

// —— Druid ——
C('druid', 1, 'Ordem Primal: escolha entre Protetor (Armaduras Médias e Armas Marciais) ou Magista (+1 truque de Druida).');
C('druid', 5, 'Ressurgimento Selvagem: gaste 1 uso de Forma Selvagem para recuperar 1 Slot de 1º círculo (ou 1 slot de 1º círculo para recuperar 1 uso de Forma Selvagem).');
C('druid', 18, 'Besta Feiticeira: conjure magias na Forma Selvagem sem componentes V ou S.');
C('druid', 20, 'Arquidruida: recupere 1 uso de Forma Selvagem ao rolar Iniciativa se não houver usos restantes.');
S('moon', 6, 'Lua L6: ataques na forma podem ser Radiantes; +SAB em salvaguardas de Constituição.');
S('moon', 10, 'Passo Lunar: teleporte 9 m (usos = SAB); restaurar com espaço 2+.');
S('moon', 14, 'Forma Lunar: +2d10 radiante 1×/turno na forma; Passo Lunar pode levar um aliado.');
S('land', 6, 'Recuperação Natural: 1 magia do Círculo sem espaço (1×/DL); no Descanso Curto recupere slots (soma ≤ ⌈nível/2⌉, sem 6+).');
S('land', 10, 'Proteção Natural: imune a Envenenado; resistência conforme terreno escolhido.');
S('land', 14, 'Santuário Natural: gaste Forma Selvagem — cubo 4,5 m com cobertura parcial (mover com Ação Bônus).');
S('stars', 3, 'Mapa Estelar: Raio Guia gratuito (usos = SAB) + Orientação preparada.');
S('stars', 6, 'Presságio Cósmico: após DL, Reação ±1d6 em Teste de D20 (usos = SAB).');
S('stars', 10, 'Constelações Cintilantes: 2d8; Dragão voo 6 m; trocar constelação no início do turno.');
S('sea', 14, 'Manifestação Oceânica: gaste 2 usos de Forma Selvagem para a variante aprimorada (mesa).');
S('circle-of-the-city', 3, 'Círculo da Cidade: gaste Forma Selvagem para Fundir-se na Pedra, Passagem ou Moldar Rocha sem espaço; magias urbanas usam estética de cidade.');
S('circle-of-the-city', 6, 'Forma de Objeto: Forma Selvagem como Objeto Animado (até Grande; Enorme no nv. 10).');
S('circle-of-the-city', 10, 'Distorção de Muro: Reação cria painel de Muralha de Pedra (1×/LR ou espaço 3º+) — veja recurso.');
S('circle-of-the-city', 14, 'Colosso Urbano: na forma de objeto, CA 18, limiar de dano, Multiataque e atravessar criaturas.');

function emit(rows) {
  const lines = [
    '-- Notas PHB restantes (estáticas) — literais sem template dinâmico.',
    '',
  ];
  for (const r of rows) {
    if (r.kind === 'subclass') {
      lines.push(
        `INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)`,
      );
      lines.push(
        `SELECT 'subclass', NULL, s.id, ${r.level}, '${esc(r.note)}', ${r.sort}`,
      );
      lines.push(`FROM rpg.phb_subclass s WHERE s.slug = '${r.slug}'`);
      lines.push(`  AND NOT EXISTS (`);
      lines.push(`    SELECT 1 FROM rpg.phb_level_combat_note n`);
      lines.push(
        `    WHERE n.subclass_id = s.id AND n.unlock_level = ${r.level} AND n.note = '${esc(r.note)}'`,
      );
      lines.push(`  );`);
    } else {
      lines.push(
        `INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)`,
      );
      lines.push(
        `SELECT 'class', c.id, NULL, ${r.level}, '${esc(r.note)}', ${r.sort}`,
      );
      lines.push(`FROM rpg.phb_class c WHERE c.slug = '${r.slug}'`);
      lines.push(`  AND NOT EXISTS (`);
      lines.push(`    SELECT 1 FROM rpg.phb_level_combat_note n`);
      lines.push(
        `    WHERE n.class_id = c.id AND n.unlock_level = ${r.level} AND n.note = '${esc(r.note)}'`,
      );
      lines.push(`  );`);
    }
    lines.push('');
  }
  return lines.join('\n');
}

const out =
  'database/seeds/notes/phb/phb_level_combat_note.remaining-static.sql';
fs.mkdirSync(path.dirname(out), { recursive: true });
fs.writeFileSync(out, emit(ROWS));
console.log(ROWS.length, '→', out);
