/**
 * Gera seeds R001–R007 (Griffon's Saddlebag Book One Part II) + migrations V065/V066.
 * Uso: node scripts/generate-gsb-part-ii-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const outDir = path.join(apiRoot, 'database/seeds/griffons-saddlebag');
const migTypes = path.join(apiRoot, 'database/migrations/010_types');
const migViews = path.join(apiRoot, 'database/migrations/060_views');

const CITATION = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options';
const EDITION = 'griffons-saddlebag-book-one-2024-en';

const SUBCLASSES = [
  {
    slug: 'path-of-the-glacier',
    classSlug: 'barbarian',
    name: 'Caminho da Glaciar',
    tagline: 'Domine inimigos com a força de uma nevasca e armadura de gelo',
    summary:
      'Nascidos na gélida e imponente Everglaciar, bárbaros do Caminho da Glaciar aprenderam a abrigar a quietude, a paciência e a determinação implacável da paisagem gelada — e sua destruição.',
    description:
      'Nascidos na gélida e imponente Everglaciar, bárbaros do Caminho da Glaciar aprenderam a abrigar a quietude, a paciência e a determinação implacável da paisagem gelada — e sua destruição. Esses guerreiros transformam o corpo em bunkers móveis poderosos, tão difíceis de derrubar quanto de escapar.\n\nQuem segue este caminho costuma ser caçador treinado que aprecia a perseguição paciente. Prosperam no perigo que impõem às presas em fuga e se orgulham da abordagem lenta e constante.',
  },
  {
    slug: 'college-of-choreography',
    classSlug: 'bard',
    name: 'Colégio da Coreografia',
    tagline: 'Inspire aliados e confunda inimigos com movimento ágil',
    summary:
      'Bardos do Colégio da Coreografia contam histórias e performam sem som, usando movimento feérico e mágico para inspirar e confundir.',
    description:
      'Bardos do Colégio da Coreografia contam histórias e performam sem som, escolhendo mover-se com graça feérica e magia para evitar danos e inspirar outros. Essas danças vêm da Festerwood, cujos esporos radiantes e luz geravam performances miraculosas e perigos mortais. Estão do taverna local aos palcos mais altos, comovendo multidões ou incitando rebelião. Em cada passo, inspiram coragem, movimento e participação.',
  },
  {
    slug: 'astral-domain',
    classSlug: 'cleric',
    name: 'Domínio Astral',
    tagline: 'Controle o fluxo do espaço e da magia planar',
    summary:
      'Deuses do Plano Astral estão perdidos no tempo e no espaço tanto quanto o reino que governam. Clérigos deste domínio veem o vazio como algo e conduzem outros ao destino final de todas as coisas.',
    description:
      'Deuses do Plano Astral estão perdidos no tempo e no espaço tanto quanto o reino que governam. O Plano Astral preenche as lacunas entre os planos e equilibra o multiverso. Praticantes deste domínio veem a ausência de tudo como algo e consideram o Astral o destino final de todas as coisas. Seguem o caminho até lá e ajudam outros nessa jornada de entropia. Clérigos do Domínio Astral são caóticos por natureza, mas costumam destruir o mal onde o encontram.',
  },
  {
    slug: 'the-unbroken-circle',
    classSlug: 'druid',
    name: 'Círculo Inquebrável',
    tagline: 'Use a força da natureza para potencializar sua maestria marcial',
    summary:
      'Ordem de druidas que abandonou ensinamentos pacientes para tomar armas em defesa da natureza, formando milícias contra ameaças ao sagrado.',
    description:
      'O Círculo Inquebrável é uma ordem de druidas que abandonou os ensinamentos pacientes dos antecessores para tomar armas em defesa da natureza. Formam milícias e canalizam a fúria da natureza para expulsar o mal que ameaça terras sagradas.\n\nHá caos natural nesses druidas, mas corpo e impulsos são domados por treino e disciplina. Originários da implacável Festerwood, seus ensinamentos são tão rigorosos quanto a floresta.',
  },
  {
    slug: 'couatl-herald',
    classSlug: 'fighter',
    name: 'Arauto Couatl',
    tagline: 'Mostre misericórdia e apoie aliados como paragono de civismo',
    summary:
      'Guerreiros marciais que neutralizavam ameaças sem recorrer sempre à força letal — símbolos de paz na outrora grande cidade de Hearth.',
    description:
      'Os Arautos Couatl eram guerreiros marciais cujo intento era neutralizar ameaças sem sempre recorrer à força letal. Eram símbolos amados de paz na outrora grande cidade de Hearth, cuja destruição se perdeu quase por completo na história. Você pode vir de uma linhagem oculta que escapou do colapso, ou ter encontrado diários antigos de um instrutor da cidade. Um verdadeiro Arauto Couatl defende todas as vidas, independentemente das transgressões.',
  },
  {
    slug: 'warrior-of-the-celestial',
    classSlug: 'monk',
    name: 'Guerreiro Celestial',
    tagline: 'Responda com divindade, apoie aliados e fulmine inimigos',
    summary:
      'Monjes pacíficos e protetores que meditam para canalizar energia celestial em defesa dos seus.',
    description:
      'Monjes Guerreiros Celestiais são pacificadores e protetores de seu povo escolhido. Meditam para compreender um ser divino e canalizar energias celestiais. São pensativos, pacientes e compreensivos, mas oferecem pouca misericórdia quando intenções más ficam claras.\n\nA tradição surgiu na perdida cidade de Hearth como tributo aos couatl guardiões. Embora rara, pequenos mosteiros protegidos podem ainda existir após a destruição da cidade.',
  },
  {
    slug: 'oath-of-the-hearth',
    classSlug: 'paladin',
    name: 'Juramento da Lareira',
    tagline: 'Proteja amigos com calor e incinere quem os ameaçar',
    summary:
      'Juramento originado na cidade de Hearth, jurando proteger a metrópole tropical sob guardiões celestiais.',
    description:
      'O Juramento da Lareira vem da cidade homônima, cujo declínio trágico se perdeu ao longo de séculos. Paladinos juraram proteger aquela cidade ensolarada em nome de guardiões celestiais — e cumpriram o juramento até o fim. Você pode jurá-lo por laço de sangue ou por histórias e encontros com seres celestiais relacionados. Vestem armaduras com símbolos de comunidade, fogo e sol.\n\nEsses paladinos compartilham os seguintes preceitos.',
  },
  {
    slug: 'winter-trapper',
    classSlug: 'ranger',
    name: 'Caçador Invernal',
    tagline: 'Use armadilhas geladas para imobilizar presas',
    summary:
      'Mestres do controle originários da Everglaciar, experts em manter presas e adversários à distância.',
    description:
      'Caçadores Invernais dominam controle e mantêm adversários e presas indefesos e à distância. Originários da Everglaciar, são caçadores treinados que permanecem de pé quando outros cairiam, usando magia e acrobacia para proteger a si e aos aliados.',
  },
  {
    slug: 'runetagger',
    classSlug: 'rogue',
    name: 'Runetaggeiro',
    tagline: 'Use runas poderosas para enfraquecer inimigos e escapar',
    summary:
      'Rebeldes, artistas e espiões que marcam alvos com runas mágicas difíceis de rastrear.',
    description:
      'Runetaggeiros concentram esforços em aperfeiçoar a arte de marcas especiais para reivindicar e debilitar alvos. Líderes rebeldes, artistas, espiões e membros do submundo político podem pertencer a este arquétipo. Tática de subterfúgio da Festerwood; difíceis de prender. As marcas mágicas viram cartão de visita — e a fama cresce com os feitos.',
  },
  {
    slug: 'frost-sorcery',
    classSlug: 'sorcerer',
    name: 'Feitiçaria Glacial',
    tagline: 'Invoque tempestades e gelo escorregadio para controlar o campo',
    summary:
      'Magia nascida do Everheart, núcleo da Everglaciar — você é encarnação do frio.',
    description:
      'Sua magia vem de fragmentos do Everheart, força por trás da Everglaciar. Pode ser herança de ancestrais que protegeram o núcleo mágico, ou encontro acidental com o gelo encantado. Seja qual for a fonte, você é criatura de frio encarnado.',
  },
  {
    slug: 'astral-griffon-patron',
    classSlug: 'warlock',
    name: 'Patrono Grifo Astral',
    tagline: 'Controle seu próprio espaço extradimensional',
    summary:
      'Pacto com Criir, semideus grifo do Plano Astral que coleciona tesouros mundanos e mágicos pelo multiverso.',
    description:
      'Você firmou pacto com Criir, semideus grifo do Plano Astral cujo controle sobre espaço, criação e dimensões de bolso se estende pelo multiverso. Busca expandir coleção eclética de tesouros — valiosos ou não para lojas comuns, mas especiais para o Grifo Astral. A ligação pode levar longe em busca de artefatos ou a uma taverna por um medalhão manchado. Os objetivos raramente são claramente bons ou maus.',
  },
  {
    slug: 'materializer',
    classSlug: 'wizard',
    name: 'Materializador',
    tagline: 'Crie e destrua matéria como mestre artesão e arcanista',
    summary:
      'Magos que focam a força que mantém tudo unido, tecendo matéria do nada.',
    description:
      'Alguns magos abandonam escolas arcanas e focam a força que une tudo. Tecem e recriam matéria para arte e utilidade, valorizando ofícios de artesãos como magia por si. Materializadores veem beleza no potencial da matéria bruta — em bibliotecas antigas ou no centro de uma forja movimentada. Muitos cuidam das bolsas de componentes e se identificam com bardos e artesãos.',
  },
];

const FEATURES = {
  'path-of-the-glacier': [
    [3, 'Permafrost', `Sua pele fica gelada ao toque, manifestando o poço frio e paciente dentro de você.

Carne Gelada. Sem armadura, você recebe +1 na CA.

Extensão de Fúria. Quando sua Fúria terminaria e você não estiver Inconsciente, pode estendê-la (sem ação). Usos = mod. Constituição (mín. 1); recupera todos no Descanso Longo.

Resistência. Você tem Resistência a dano Gélido.`],
    [3, 'Geladura', `Enquanto a Fúria estiver ativa, uma vez por turno você pode liberar frio implacável ao acertar com ataque baseado em Força. O alvo sofre 1d6 de dano Gélido extra (2d6 no nível 9 de Bárbaro; 3d6 no 16).

Quando uma criatura sofre dano Gélido assim, a Velocidade dela cai 3 m até o início do seu próximo turno.`],
    [6, 'Fortaleza Gelada', `Ao entrar em Fúria sem armadura, sua pele ganha camada protetora de gelo: PV temporários = 1d12 + mod. Constituição.

Como Ação Bônus nos turnos seguintes enquanto a Fúria durar, pode gastar um Dado de Vida para ganhar esses PV temporários de novo.`],
    [10, 'Sono Profundo', `Pode entrar em hibernação profunda num Descanso Longo. Fica gelado ao toque e parece morto a inspeção e magias que determinem seu estado. Ruído não o acorda.

Desperta após 6 horas, ao sofrer dano ou quando alguém usa ação para esbofeteá-lo. Se completar 6 horas contínuas, recebe benefícios de Descanso Longo e um pool especial de Dados de Vida ( = mod. Constituição, mín. 1) de Bárbaro até o próximo Descanso Longo.`],
    [14, 'Pisoteio Avalanche', `Como ação Mágica, pode pisotear o chão e enviar tremor. Cada criatura escolhida numa Emanação de 4,5 m centrada em você faz salvaguarda de Destreza (CD 8 + mod. Força + PB). Em falha: dano Contundente = 3d6 + mod. Força e condição Caído.`],
  ],
  'college-of-choreography': [
    [3, 'Movimento Rápido', `Sua Velocidade aumenta 3 m. Aumenta mais 1,5 m no nível 6 de Bardo (total +4,5 m) e no 14 (+6 m).`],
    [3, 'Dança Inspiradora', `Como Ação Bônus, gaste uma Inspiração de Bardo para dançar e reanimar criatura à vista. Role o dado de Inspiração; ela ganha PV temporários = resultado + mod. Carisma (mín. 2). Ao ganhar PV temporários assim, pode usar Reação para se mover até a Velocidade sem provocar Ataques de Oportunidade ou fazer a ação Esquivar.`],
    [6, 'Movimento Encantador', `Movimentos tão graciosos que inimigos frios sentem remorso por interromper sua dança. Quando uma criatura acerta você com Ataque de Oportunidade ou ataque enquanto você se beneficia de Esquivar, sofre dano Psíquico = mod. Carisma + metade do nível de Bardo (arred. p/ baixo).

Você sempre tem Enfeitiçar Pessoa preparada e pode conjurá-la sem componente Verbal. Com este recurso, conjura sem gastar espaço como magia de 3º círculo; alvos não têm Vantagem na salvaguarda por combate. 1× / Descanso Longo.`],
    [14, 'Dança Infinita', `Quando uma criatura ganharia PV temporários de Dança Inspiradora, pode usar Reação para fazer um ataque com arma ou Ataque Desarmado.

Além disso, pode Esquivar como Ação Bônus; sempre que usar Ação Bônus para gastar dado de Inspiração, pode Esquivar como parte dessa Ação Bônus.`],
  ],
  'astral-domain': [
    [3, 'Magias do Domínio Astral', `Sua conexão divina garante magias sempre preparadas conforme a tabela do Domínio Astral (níveis de Clérigo 3, 5, 7 e 9).`],
    [3, 'Criar Vazio', `Como Ação Bônus, gaste Canalizar Divindade para abrir rasgo planar em ponto à vista a até 18 m, criando vácuo numa Esfera de 4,5 m de raio. Cada criatura na área faz salvaguarda de Destreza. Em falha: dano de Força = 1d8 + nível de Clérigo e é puxada até 4,5 m em direção ao ponto. Em sucesso: metade do dano. O rasgo some em seguida.`],
    [3, 'Alcance Planar', `Pode criar e alcançar breves buracos na realidade. Ao conjurar magia de alcance Toque, pode torná-la alcance 9 m. Usos = mod. Sabedoria (mín. 1) / Descanso Longo.`],
    [6, 'Troca Espacial', `Sempre tem Passo Nebuloso preparado. Pode conjurá-lo gastando Canalizar Divindade em vez de espaço. Ao conjurar assim, pode escolher espaço a até 9 m ocupado por criatura voluntária e trocar de lugar; falha se não houver espaço para ambos.`],
    [17, 'Troca Suprema', `Troca Espacial melhora:

• Sempre que conjurar Passo Nebuloso, pode trocar com criatura voluntária, mesmo usando espaço.

• Ao conjurar Passo Nebuloso com Canalizar Divindade, pode escolher criatura involuntária a até 9 m; ela faz salvaguarda de Carisma contra sua CD de magia ou a troca falha e o uso de Canalizar Divindade é perdido.

• Ao trocar de lugar com sucesso via Canalizar Divindade, pode conjurar magia de círculo 0–5 de alcance Toque como parte da mesma Ação Bônus, mirando a criatura com quem trocou.`],
  ],
  'the-unbroken-circle': [
    [3, 'Bordão Místico Aprimorado', `Ao conjurar Bordão Místico, pode imbuir qualquer arma corpo a corpo que segure; pode manter o dado de dano normal em vez de d8. Pode usar qualquer arma com proficiência como foco de conjuração.`],
    [3, 'Magias do Círculo Inquebrável', `Magias sempre preparadas conforme tabela (níveis de Druida 3, 5, 7 e 9).`],
    [3, 'Recuperação Selvagem', `Como Ação Bônus, gaste uma Forma Selvagem para recuperar PV = 2d6 + nível de Druida (+1d6 no nível 10; +2d6 no 14).`],
    [6, 'Maestria do Bordão', `Com arma sob efeito de Bordão Místico, pode atacar duas vezes com ela ao usar a ação Atacar. +1 em ataques e dano com essa arma (+2 no nível 10; +3 no 14). Se a arma já tiver bônus, escolha qual usar.`],
    [10, 'Druida de Guerra', `Ao usar a ação Atacar, pode substituir um ataque por conjuração de um truque de Druida com tempo de conjuração de ação.`],
    [14, 'Armadura da Natureza', `Sempre sob efeito de Pele-Casca.

No início de cada turno, ganha PV temporários = metade do nível de Druida (arred. p/ baixo). Ao assumir Forma Selvagem, ganha PV temporários = nível de Druida + metade do nível (arred. p/ baixo).`],
  ],
  'couatl-herald': [
    [3, 'Agente de Misericórdia', `Reservatório de magia positiva representado por Dados de Misericórdia (veja tabela por nível de Guerreiro). Recupera todos no Descanso Curto ou Longo.

Presença Benevolente. Em testes de Intuição ou Carisma (Atuação/Persuasão), pode gastar Dados de Misericórdia e somá-los.

Golpe Implacável. Uma vez por turno ao acertar com arma ou Ataque Desarmado, gaste um dado para dano Radiante extra = valor do dado.

Proteção Pacífica. Como Ação Bônus, gaste um dado: PV temporários = dado + mod. Carisma (mín. 1).`],
    [3, 'Um do Povo', `Proficiência em Intuição e Persuasão. Ao reduzir criatura a 0 PV com ataque corpo a corpo ou à distância, pode nocauteá-la (1 PV, Inconsciente, inicia Descanso Curto) até recuperar PV ou alguém prestar primeiros socorros (Medicina CD 10).`],
    [7, 'Portador de Paz', `Dano com arma ou Ataque Desarmado pode ser Radiante ou tipo normal.

Sempre tem Acalmar Emoções e Santuário preparadas (Carisma, sem componentes Somático/Material). Cada uma 1× sem espaço / Descanso Curto ou Longo.`],
    [10, 'Mente Calma', `Ao persuadir criatura a desescalar violência, recupera um Dado de Misericórdia (um por criatura afetada). Imunidade a Enfeitiçado e Amedrontado.`],
    [15, 'Paragono', `Como Ação Bônus, ordene criatura à vista a até 9 m e gaste um Dado de Misericórdia. Se ouvir você: PV temporários = dado + mod. Carisma (mín. 1) e Reação para mover metade da Velocidade sem provocar oportunidade e atacar. Dano nocauteante em vez de matar.`],
    [18, 'Executor Heráldico', `Pode usar Golpe Implacável uma vez por turno sem gastar dado; se o fizer, pode usar de novo no turno gastando dado normalmente.

Ao nocautear em vez de matar, o alvo permanece Inconsciente por 8 h ou até você/aliado sacudi-lo, mesmo se recuperar PV ou receber primeiros socorros.`],
  ],
  'warrior-of-the-celestial': [
    [3, 'Conexão Celestial', `Telepatia com qualquer criatura à vista a até 9 m. Não precisa compartilhar idioma, mas ela deve entender ao menos um. Não concede resposta telepática.`],
    [3, 'Golpe de Busca da Alma', `Ao tocar ou acertar com Ataque Desarmado, gaste 1 Ponto de Foco (sem ação) para sondar a alma até o fim do seu próximo turno (ou 1 min fora de combate): emoções e desejo mais óbvio; à critério do Mestre, PV ou fragmento de história. Vantagem no próximo ataque e em Intuição contra o alvo.

Ao acertar com ataque de Rajada de Golpes, pode usar sem gastar Ponto de Foco.`],
    [6, 'Foco Estabilizador', `Como ação Mágica, toque criatura Ferida e gaste 1+ Pontos de Foco: cada ponto restaura 5 PV (máx. metade do máximo de PV). Pode gastar 2 pontos para conjurar Aprimorar Atributo, Restauração Menor ou Proteção Contra o Bem e o Mal sem espaço ou material (Sabedoria).`],
    [11, 'Emissário Celestial', `Sempre tem Sonho e Vidência preparadas (Sabedoria). 1× cada sem espaço/material / Descanso Longo. Sonho: só você pode ser mensageiro.

Em acerto com Vantagem, dano Radiante extra = um dado de Artes Marciais. Usos = mod. Sabedoria (mín. 1) / Descanso Longo.`],
    [17, 'Celestial Ascendente', `Energia entrelaçada com magia celestial ofensiva e curativa.

Foco Estabilizador Aprimorado. Pode usar como Ação Bônus; alvo Ferido a até 9 m em vez de toque.

Voo Limitado. Deslocamento de Voo = Velocidade; cai se terminar o turno no ar sem suporte.

Golpe da Alma. Ataques Desarmados causam +1d4 Radiante.`],
  ],
  'oath-of-the-hearth': [
    [3, 'Magias do Juramento da Lareira', `Magias sempre preparadas conforme tabela (níveis de Paladino 3, 5, 9, 13 e 17).`],
    [3, 'Arma Flamejante', `Na ação Atacar, gaste Canalizar Divindade para incendiar uma arma corpo a corpo: por 10 min ou até usar de novo, dano Ígneo extra = mod. Carisma (mín. 1) por acerto; pode escolher tipo normal ou Ígneo. Emite Luz Plena num raio de 6 m e Meia-luz por mais 6 m.`],
    [7, 'Aura de Calor', `Você e aliados na Aura de Proteção têm Resistência a dano Gélido e Ígneo.`],
    [15, 'Proteção Isolante', `Ao conjurar magia de Paladino de círculo 1+ com espaço ou sem espaço via recurso de Paladino, você e aliados na Aura de Proteção ganham PV temporários = círculo da magia + mod. Carisma (mín. 2).`],
    [20, 'Espírito Flamejante', `Como Ação Bônus, por 10 min (ou até encerrar): 1× / Descanso Longo (ou restaurar gastando espaço de 5º círculo).

Luz Ígnea. Luz Plena preenche a Aura de Proteção e Meia-luz por mais 9 m.

Passos Ligeiros. Velocidade +3 m; pode atravessar e terminar em espaço ocupado sem Caído.

Chama Vingativa. No fim de cada turno, criaturas escolhidas numa Emanação de 3 m sofrem dano Ígneo = 2× mod. Carisma (mín. 2).`],
  ],
  'winter-trapper': [
    [3, 'Fixar', `Uma vez por turno ao acertar, dano extra = 1d6 do tipo do ataque e Velocidade do alvo cai 3 m até o início do seu próximo turno. No nível 11: 1d8 e alvo não pode fazer Ataques de Oportunidade.`],
    [3, 'Magia do Caçador Invernal', `Magias sempre preparadas conforme tabela (níveis de Patrulheiro 3, 5, 9, 13 e 17).`],
    [7, 'Predador Ártico', `Presa Indefesa. Sem Desvantagem por Caído em alvos Caídos a mais de 1,5 m.

Caminhante do Gelo. Terreno difícil de gelo/neve não custa movimento extra; Vantagem em Furtividade em gelo/neve.

Pé Firme. Não pode estar Caído salvo se também Incapacitado.`],
    [11, 'Armadilha Mágica', `Como Ação Bônus, cria armadilha imperceptível no chão. Primeira criatura Grande ou menor (exceto você/designados) que entrar no espaço no próximo minuto: salvaguarda de Destreza vs. CD de magia. Falha: 2d8 Perfurante e Velocidade 0 até fim do seu próximo turno. Metade do dano em sucesso. Usos = mod. Sabedoria (mín. 1) / Descanso Longo.`],
    [15, 'Defesas Tropeçadas', `Quando criatura a até 1,5 m erra ataque contra você, Reação para desequilibrá-la: Grande ou menor fica Caída; senão Velocidade reduzida pela metade até fim do turno (salvo Imunidade a Caído). Depois, ataque ou move metade da Velocidade sem provocar oportunidade dela.`],
  ],
  'runetagger': [
    [3, 'Impressionista', `Perícia em Suprimentos de Calígrafo e Pintor; nunca fica sem pincéis. Como ação Mágica, cria suprimentos numa mão livre e tinta ou tinta de qualquer cor. Objetos somem se saírem de você ou se recriar.

Ao terminar marca com tinta, pode imbuir efeito de Mensagem: marca brilha (Meia-luz 1,5 m); quem tocar ouve a mensagem telepática e a marca perde o efeito.`],
    [3, 'Runas', `4 Pontos de Runa; recupera no Descanso Curto ou Longo. Ao acertar corpo a corpo, gaste 1 ponto para marcar criatura por até 1 min (some se apagada com ação).

Cryos: alvo não pode fazer Reações até início do seu próximo turno.

Hexxus: Reação quando alvo passa em teste/ataque a até 18 m: −1d6 no resultado.

Locus: próximo ataque contra o alvo tem Vantagem; se acertar, +1d6 Ácido.`],
    [9, 'Artista da Fuga', `Vantagem em testes/salvaguardas para evitar ou encerrar Agarrado/Restringido. Pode escapar como Ação Bônus se normalmente exigiria ação.

A até 1,5 m de superfície sólida, Ação Bônus + 1 Ponto de Runa: Invisível por 10 min (termina ao atacar, causar dano, conjurar ou sair do espaço).`],
    [13, 'Engenhoso', `Na Iniciativa, recupera Pontos de Runa até ter 2 se tiver menos. Ao usar Ataque Furtivo com efeito de Golpe Astuto, pode gastar Pontos de Runa para reduzir dados de dano trocados por efeito (1 ponto = −1 dado).`],
    [17, 'Tinta de Chumbo', `Contra alvo marcado ou ao marcar com runa no ataque, não precisa de Vantagem nem aliado a 1,5 m para Ataque Furtivo (salvo se tiver Desvantagem). Ataque Furtivo +2d6.`],
  ],
  'frost-sorcery': [
    [3, 'Criar Gelo', `Tocando superfície sólida, Ação Bônus: gelo em até cinco quadrados de 1,5 m contíguos a partir do ponto tocado. Terreno difícil até fim do seu próximo turno. Gaste Pontos de Feitiçaria para +5 quadrados contíguos por ponto.`],
    [3, 'Magias Glaciais', `Magias sempre preparadas conforme tabela (níveis de Feiticeiro 3, 5, 7 e 9).`],
    [3, 'Corpo Congelado', `Pele com brilho cristalino. PV máximo +3 (+1 por nível de Feiticeiro). Terreno difícil de gelo/neve não custa extra; em gelo, 1 m de movimento por cada 2 m.`],
    [6, 'Coração Gelado', `Criomancia. Ao causar dano Gélido com magia em criatura Grande ou menor, gaste Pontos de Feitiçaria: −4,5 m de Velocidade por ponto até fim do turno dela; se Velocidade 0, +2d6 Gélido.

Congelar Água. Criar Gelo também funciona em água (5 m de profundidade, Cubo de 1,5 m).

Resistência a dano Gélido.`],
    [14, 'Congelamento Súbito', `Movimento no gelo não provoca oportunidade. Reação quando criatura a 1,5 m acerta você: dano Gélido = mod. Carisma + metade do nível de Feiticeiro; pode usar Criar Gelo como parte da Reação.`],
    [18, 'Alma Congelada', `Imunidade a dano Gélido; Resistência a Ígneo. Sempre tem Muralha de Gelo preparada, sem componente material; 1× sem espaço / Descanso Longo (painéis planos não precisam ser contíguos).`],
  ],
  'astral-griffon-patron': [
    [3, 'Magias do Grifo Astral', `Magias sempre preparadas conforme tabela (níveis de Bruxo 3, 5, 7 e 9).`],
    [3, 'Míssil Astral', `Conjura Mísseis Mágicos sem espaço usos = mod. Carisma (mín. 1) / Descanso Longo. Dardos podem mirar alvo invisível; se fora de alcance, voam erraticamente e somem por rasgo planar.`],
    [3, 'Acuidade Extradimensional', `Bolso dimensional permanente: até 22 kg de material inanimado, volume máx. ~28 L, acessível pelas mãos. Colocar Bolsa de Holding, Haversack ou Buraco Portable destrói o item e espalha conteúdos no Astral; bolso inacessível por 7 dias.

Sente espaços extradimensionais (exceto o seu) a até 18 m (não revela quantidade/local).`],
    [6, 'Escape Planar', `Reação ao sofrer dano: metade do dano, desaparece em semiplano inofensivo sobreposto ao plano atual. Percebe o plano de origem e move-se normalmente, imperceptível lá. Permanece até fim do seu próximo turno ou retorno voluntário. 1× / Descanso Curto ou Longo.`],
    [10, 'Maestria Extradimensional', `Clareza Astral. Ação Mágica: por 10 min, Vantagem em Percepção visual e Visão Verdadeira 9 m. Usos = mod. Carisma (mín. 1) / Descanso Longo.

Espião Mágico. A 3 m de item com espaço extradimensional, sente conteúdo.

Resistência a dano de Força.`],
    [14, 'Bolseiro', `Bolso dimensional: até 113 kg, ~280 L. Ação Mágica: envia objeto à vista a até 9 m (não vestido) ao bolso; se não couber, falha. Se carregado por criatura, salvaguarda de Sabedoria vs. CD de magia. Objeto retorna no fim do seu próximo turno se não recuperado. 1× em objeto carregado / Descanso Curto ou Longo.`],
  ],
  'materializer': [
    [3, 'Artesão Arcano', `Truque Bônus. Conhece Reparar; se já conhece, aprende outro truque de Mago (não conta no limite).

Perito em Criação. Proficiência em três Ferramentas de Artesão; troca uma por outra ao fim de cada Descanso Longo.

Ofício Arcano. Ao craftar com ferramenta proficiente, subtrai mod. Inteligência (mín. 1) das horas diárias (mín. 2 h/dia).`],
    [3, 'Criação Menor', `Ao conjurar magia de círculo 1+, cria Cubo de material inanimado até 1,5 m de lado a até 9 m (18 m no nível 10). Peso ≈ 5× comprimento do lado em kg; suporta 10× peso. Máximo de Cubos = nível de Mago. Dispersa com Ação Bônus ou após 1 h/dano. CA = 10 + mod. Int; 1 PV; Imunidade a Força.

Detonação. Ao dispersar, pode detonar: salvaguarda de Destreza vs. CD de magia em raio de 3 m, dano Força = 1d6 + metade do nível de Mago. Usos de detonação = mod. Int (mín. 1) / Descanso Longo; restaura com espaço de círculo 1+.`],
    [6, 'Aprimoramento Material', `Ação Mágica: toque arma, armadura ou objeto. Até fim do próximo Descanso Curto/Longo, torna mágico com até 2 benefícios entre: +1 ataque/dano em arma (+2 no 10; +3 no 14); +1 CA em armadura (+2/+3); armadura sem Desvantagem em Furtividade; luz 6 m/6 m; peso reduzido pela metade; cores/texturas; objeto arremessado volta à mão.

2 usos por benefício; recupera no Descanso Curto/Longo. Mesmo benefício não repete até recuperar usos.`],
    [10, 'Desmaterializar', `Magias causam dano dobrado a objetos e estruturas; construtos sofrem +1d8 Força.`],
    [14, 'Rematerializar', `Reação ao ver objeto ou estrutura Grande ou menor não mágico destruído a até 18 m: destroços somem. Até 8 h depois, ação Mágica recria intacto a até 18 m. Se no ar, cai; criatura abaixo: salvaguarda de Destreza vs. CD de magia, dano Contundente por queda (P/M/G: 1d6/2d6/3d6). 1× / Descanso Longo.`],
  ],
};

const PREPARED = {
  'astral-domain': {
    3: ['embacar', 'raio-guia', 'invisibilidade', 'passos-largos', 'fagulha-estelar'],
    5: ['piscar', 'lentidao'],
    7: ['banimento', 'porta-dimensional'],
    9: ['circulo-de-teleporte', 'muralha-de-energia'],
  },
  'the-unbroken-circle': {
    3: ['golpe-constritor', 'bordao-mistico', 'destruicao-radiante', 'golpe-certeiro'],
    5: ['celeridade'],
    7: ['escudo-ardente'],
    9: ['coluna-de-chamas'],
  },
  'oath-of-the-hearth': {
    3: ['maos-flamejantes', 'convocar-familiar'],
    5: ['auxilio', 'chama-continua'],
    9: ['sinal-de-esperanca', 'luz-do-dia'],
    13: ['escudo-ardente', 'guardioes-espirituais'],
    17: ['coluna-de-chamas', 'ligacao-telepatica-de-rary'],
  },
  'winter-trapper': {
    3: ['faca-de-gelo'],
    5: ['reflexos'],
    9: ['nevasca'],
    13: ['terreno-alucinatorio'],
    17: ['paralisar-monstro'],
  },
  'frost-sorcery': {
    3: ['cegueira-surdez', 'faca-de-gelo', 'passo-nebuloso', 'sono'],
    5: ['nevasca', 'lentidao'],
    7: ['escudo-ardente', 'tempestade-glacial'],
    9: ['cone-de-frio', 'invocar-elemental'],
  },
  'astral-griffon-patron': {
    3: ['identificar', 'localizar-objeto', 'misseis-magicos', 'corda-extradimensional'],
    5: ['piscar', 'clarividencia'],
    7: ['santuario-particular-de-mordenkainen', 'arca-secreta-de-leomund'],
    9: ['lendas-e-historias', 'criar-passagem'],
  },
};

function sqlStr(s) {
  return s.replace(/'/g, "''");
}

function writeFile(rel, content) {
  const p = path.join(apiRoot, rel);
  fs.mkdirSync(path.dirname(p), { recursive: true });
  fs.writeFileSync(p, content, 'utf8');
  console.log('wrote', rel);
}

// R001
writeFile(
  'database/seeds/griffons-saddlebag/R001_phb_edition_citation.sql',
  `-- Edição The Griffon's Saddlebag: Book One (Part II) + citação

INSERT INTO rpg.phb_edition (slug, label, book, language, extracted_at, notes)
VALUES (
  '${EDITION}',
  'Griffon''s Saddlebag Book One 2024',
  'The Griffon''s Saddlebag: Book One',
  'pt',
  NOW(),
  'Griffon''s Saddlebag Book One — Part II: Character Options; textos traduzidos para PT-BR (regras 2024)'
)
ON CONFLICT (slug) DO UPDATE SET
  label = EXCLUDED.label,
  book = EXCLUDED.book,
  language = EXCLUDED.language,
  notes = EXCLUDED.notes,
  extracted_at = EXCLUDED.extracted_at;

INSERT INTO rpg.phb_source_citation (
  slug, edition_id, chapter, chapter_title, extracted_at
)
VALUES (
  '${CITATION}',
  (SELECT id FROM rpg.phb_edition WHERE slug = '${EDITION}'),
  2,
  'The Griffon''s Saddlebag: Book One — Parte II: Opções de Personagem',
  NOW()
)
ON CONFLICT (slug) DO UPDATE SET
  edition_id = EXCLUDED.edition_id,
  chapter = EXCLUDED.chapter,
  chapter_title = EXCLUDED.chapter_title,
  extracted_at = EXCLUDED.extracted_at;
`,
);

// R002
let r002 = `-- Seed Griffon's Saddlebag Book One — subclasses (Part II)\n\n`;
for (const sc of SUBCLASSES) {
  r002 += `INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  '${sc.slug}',
  (SELECT id FROM rpg.phb_class WHERE slug = '${sc.classSlug}'),
  '${sqlStr(sc.name)}',
  '${sqlStr(sc.tagline)}',
  '${sqlStr(sc.summary)}',
  '${sqlStr(sc.description)}',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = '${CITATION}')
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

`;
}
writeFile('database/seeds/griffons-saddlebag/R002_phb_subclass.sql', r002);

// R003
let r003 = `-- Seed Griffon's Saddlebag Book One — subclass features (Part II)\n-- 63 features; fonte: docs/source/extracts/griffons-saddlebag/book-one-part-ii.json\n\n`;
let featureCount = 0;
for (const [slug, feats] of Object.entries(FEATURES)) {
  for (const [level, name, desc] of feats) {
    featureCount++;
    r003 += `INSERT INTO rpg.phb_subclass_feature (
  subclass_id, level, name, description
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = '${slug}'),
  ${level},
  '${sqlStr(name)}',
  '${sqlStr(desc)}'
)
ON CONFLICT (subclass_id, level, name) DO UPDATE SET
  description = EXCLUDED.description;

`;
  }
}
writeFile('database/seeds/griffons-saddlebag/R003_phb_subclass_feature.sql', r003);
console.log('features:', featureCount);

// R004
let r004 = `-- Prepared spells — Griffon's Saddlebag Part II (domínios, juramentos, círculos, patronos)\n\n`;
for (const [slug, levels] of Object.entries(PREPARED)) {
  r004 += `-- ${slug}\n`;
  for (const [lvl, spells] of Object.entries(levels)) {
    r004 += `INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, ${lvl}, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = '${slug}' AND sp.slug IN (
  ${spells.map((x) => `'${x}'`).join(', ')}
)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;

`;
  }
}
writeFile('database/seeds/griffons-saddlebag/R004_phb_subclass_prepared_spell.sql', r004);

// R005 species
writeFile(
  'database/seeds/griffons-saddlebag/R005_phb_species.sql',
  `-- Espécie Feathren — Griffon's Saddlebag Book One Part II

INSERT INTO rpg.phb_species (
  slug, name, creature_type, size, speed, description, source_meta
)
VALUES (
  'feathren',
  'Feathren',
  'Humanoide',
  'Médio (cerca de 1,50–1,80 m)',
  '9 metros',
  'Feathren são algo novo feito de algo antigo — um passo além da herança grifo, celebrando individualidade entre vaias do povo comum. Nascidos originalmente no Plano Astral, onde tudo pode se perder, ser encontrado e refeito, agora caminham o Plano Material em busca de ideias, materiais e direção. Curiosos, muitos viram aventureiros e artesãos.

Herança Variada. Feathren unem aspectos marcantes de criaturas díspares: pernas felinas, tórax, braços e cabeça aviários. Poucos se parecem; plumagem, pelagem e porte variam (águia/leão, coruja/tigre, etc.). Adoram joias e enfeites — anéis em garras, orelhas emplumadas e cauda. Muitos não resistem a arrumar penas e adornos ao ver o reflexo.

Confiantes e Curiosos. Dotados de confiança compartilhada, passam a vida aprendendo ofícios novos, preferindo resolver enigmas sozinhos. Encontram camaradagem entre pares de paixões comuns e gostam de trocar histórias sobre interesses.',
  '{"editionSlug":"${EDITION}","book":"The Griffon''s Saddlebag: Book One","language":"pt","citationSlug":"${CITATION}","source":"griffons-saddlebag"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  creature_type = EXCLUDED.creature_type,
  size = EXCLUDED.size,
  speed = EXCLUDED.speed,
  description = EXCLUDED.description,
  source_meta = EXCLUDED.source_meta;
`,
);

// R006 traits
writeFile(
  'database/seeds/griffons-saddlebag/R006_phb_species_trait.sql',
  `-- Traços Feathren — Griffon's Saddlebag Part II

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    'Visão no Escuro',
    'Você tem Visão no Escuro com alcance de 18 metros.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    'Ancestria Feathren',
    $t$Escolha uma opção Aviária e uma Felina nas tabelas de Ancestria Feathren.

Você conhece o truque da opção aviária e a magia Identificar. No 3º nível de personagem, aprende a magia da opção felina. No 5º, aprende Aprimorar Atributo. Sempre tem essas magias preparadas; cada uma 1× sem espaço ou componente material / Descanso Longo (também pode usar espaços).

Inteligência, Sabedoria ou Carisma é seu atributo de conjuração para essas magias (escolha ao definir as ancestrias).$t$,
    'feathren_avian_ancestry'::rpg.species_choice_kind
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    'Ancestria Felina',
    'Escolha uma linhagem felina na tabela de Ancestria Feathren (par de escolhas com a opção aviária).',
    'feathren_feline_ancestry'::rpg.species_choice_kind
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    'Atributo de Conjuração Feathren',
    'Escolha Inteligência, Sabedoria ou Carisma como atributo de conjuração das magias concedidas pela Ancestria Feathren.',
    'feathren_casting_ability'::rpg.species_choice_kind
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    'Fala Fraterna',
    'Comunica ideias simples a aves e felinos Grandes ou menores, incluindo grifos. Eles entendem suas palavras, mas você não os entende automaticamente. Vantagem em Sabedoria (Lidar com Animais) e testes de Carisma para influenciá-los.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    'Criador Natural',
    'Imbuído com essência criativa do grifo astral: proficiência em duas Ferramentas de Artesão à escolha; aprende nova ferramenta em metade do tempo normal.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    'Garras',
    'Ataques Desarmados com garras causam 1d6 Perfurante em vez de Contundente.',
    NULL
  )
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
`,
);

// R007 options + spell grants
writeFile(
  'database/seeds/griffons-saddlebag/R007_phb_species_option.sql',
  `-- Opções Feathren — ancestria aviária/felina + magias concedidas

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, value_type)
VALUES
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenAvianAncestryId', 'catalog'::rpg.option_value_type),
  ('species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenFelineAncestryId', 'catalog'::rpg.option_value_type)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

-- Ancestria aviária (truque)
INSERT INTO rpg.phb_option_value (
  scope, owner_id, option_key, value_id, label, sort_order,
  level1_benefit, spell_level1_id, edition_slug
)
VALUES
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenAvianAncestryId', 'jay-owl-raven', 'Gaio, Coruja ou Corvo', 1,
  'Truque: Taumaturgia.',
  (SELECT id FROM rpg.phb_spell WHERE slug = 'taumaturgia'),
  '${EDITION}'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenAvianAncestryId', 'eagle-falcon-hawk', 'Águia, Falcão ou Gavião', 2,
  'Truque: Mensagem.',
  (SELECT id FROM rpg.phb_spell WHERE slug = 'mensagem'),
  '${EDITION}'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenAvianAncestryId', 'cardinal-mockingbird-parrot', 'Cardeal, Sabiá ou Papagaio', 3,
  'Truque: Prestidigitação Arcana.',
  (SELECT id FROM rpg.phb_spell WHERE slug = 'prestidigitacao-arcana'),
  '${EDITION}'
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order,
  level1_benefit = EXCLUDED.level1_benefit,
  spell_level1_id = EXCLUDED.spell_level1_id,
  edition_slug = EXCLUDED.edition_slug;

-- Ancestria felina (magia desbloqueada no 3º nível de personagem)
INSERT INTO rpg.phb_option_value (
  scope, owner_id, option_key, value_id, label, sort_order,
  level1_benefit, spell_level3_id, edition_slug
)
VALUES
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenFelineAncestryId', 'lion-panther-saber', 'Leão, Pantera ou Tigre-dentes-de-sabre', 1,
  'Magia (3º nível de personagem): Detectar o Bem e o Mal.',
  (SELECT id FROM rpg.phb_spell WHERE slug = 'detectar-o-bem-e-o-mal'),
  '${EDITION}'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenFelineAncestryId', 'cheetah-serval-tiger', 'Guepardo, Serval ou Tigre', 2,
  'Magia (3º nível de personagem): Detectar Veneno e Doença.',
  (SELECT id FROM rpg.phb_spell WHERE slug = 'detectar-veneno-e-doenca'),
  '${EDITION}'
),
(
  'species'::rpg.option_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'), 'feathrenFelineAncestryId', 'jaguar-lynx-snow-leopard', 'Onça, Lince ou Leopardo-das-neves', 3,
  'Magia (3º nível de personagem): Detectar Magia.',
  (SELECT id FROM rpg.phb_spell WHERE slug = 'detectar-magia'),
  '${EDITION}'
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order,
  level1_benefit = EXCLUDED.level1_benefit,
  spell_level3_id = EXCLUDED.spell_level3_id,
  edition_slug = EXCLUDED.edition_slug;

-- Magias fixas da ancestria (Identificar L1, Aprimorar Atributo L5)
INSERT INTO rpg.phb_spell_grant (origin_type, origin_id, spell_id, unlock_level)
VALUES
  (
    'species'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'identificar'),
    1
  ),
  (
    'species'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'aprimorar-atributo'),
    5
  )
ON CONFLICT (origin_type, origin_id, spell_id, unlock_level) DO NOTHING;
`,
);

// Migration enum
writeFile(
  'database/migrations/010_types/013_species_choice_kind_feathren.sql',
  `-- Feathren — ancestria aviária/felina e atributo de conjuração

ALTER TYPE rpg.species_choice_kind ADD VALUE IF NOT EXISTS 'feathren_avian_ancestry';
ALTER TYPE rpg.species_choice_kind ADD VALUE IF NOT EXISTS 'feathren_feline_ancestry';
ALTER TYPE rpg.species_choice_kind ADD VALUE IF NOT EXISTS 'feathren_casting_ability';
`,
);

// V065 - extend trait choices (copy tail unions from V064)
const v064 = fs.readFileSync(path.join(migViews, 'V064_v_phb_species_trait_choices_dwarf_culture.sql'), 'utf8');
const feathrenUnions = `
UNION ALL
-- Feathren ancestria aviária (option_key = 'feathrenAvianAncestryId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'feathrenAvianAncestryId'
  AND t.choice_kind = 'feathren_avian_ancestry'::rpg.species_choice_kind
UNION ALL
-- Feathren ancestria felina (option_key = 'feathrenFelineAncestryId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  s3.slug,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'feathrenFelineAncestryId'
  AND t.choice_kind = 'feathren_feline_ancestry'::rpg.species_choice_kind
LEFT JOIN rpg.phb_spell s3 ON s3.id = ov.spell_level3_id
UNION ALL
`;

const castingPatch = `    'mandrake_casting_ability'::rpg.species_choice_kind,
    'feathren_casting_ability'::rpg.species_choice_kind
  )`;

let v065 = v064.replace(
  "    'mandrake_casting_ability'::rpg.species_choice_kind\n  )",
  castingPatch,
);

// insert feathren unions before dwarf culture block
v065 = v065.replace(
  'UNION ALL\n-- Variante cultural anã',
  `${feathrenUnions}UNION ALL\n-- Variante cultural anã`,
);

v065 = v065.replace(
  'V064_v_phb_species_trait_choices_dwarf_culture.sql',
  'V065_v_phb_species_trait_choices_feathren.sql',
);
v065 = v065.replace(
  '-- Inclui dwarf_culture em v_phb_species_trait_choices (base = V058).',
  '-- Inclui feathren_avian/feline/casting em v_phb_species_trait_choices (base = V064).',
);

writeFile('database/migrations/060_views/V065_v_phb_species_trait_choices_feathren.sql', v065);

// V066 granted spells for feathren
writeFile(
  'database/migrations/060_views/V066_v_phb_species_granted_spell_feathren.sql',
  `-- Magias concedidas por ancestria Feathren + Identificar / Aprimorar Atributo

CREATE OR REPLACE VIEW rpg.v_phb_species_granted_spell AS
SELECT * FROM (
  SELECT
    sp.slug AS species_slug,
    NULL::rpg.species_choice_kind AS choice_kind,
    NULL::text AS choice_slug,
    1 AS unlock_level,
    s.slug AS spell_slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_spell s ON s.id = t.spell_id
  WHERE t.spell_id IS NOT NULL

  UNION ALL

  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'lineageId'
    AND t.choice_kind = 'elf_lineage'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level1_id
  WHERE ov.spell_level1_id IS NOT NULL
  UNION ALL
  SELECT sp.slug, t.choice_kind, ov.value_id, 3, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'lineageId'
    AND t.choice_kind = 'elf_lineage'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level3_id
  WHERE ov.spell_level3_id IS NOT NULL
  UNION ALL
  SELECT sp.slug, t.choice_kind, ov.value_id, 5, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'lineageId'
    AND t.choice_kind = 'elf_lineage'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level5_id
  WHERE ov.spell_level5_id IS NOT NULL

  UNION ALL

  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'infernalLegacyId'
    AND t.choice_kind = 'infernal_legacy'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level1_id
  WHERE ov.spell_level1_id IS NOT NULL
  UNION ALL
  SELECT sp.slug, t.choice_kind, ov.value_id, 3, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'infernalLegacyId'
    AND t.choice_kind = 'infernal_legacy'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level3_id
  WHERE ov.spell_level3_id IS NOT NULL
  UNION ALL
  SELECT sp.slug, t.choice_kind, ov.value_id, 5, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'infernalLegacyId'
    AND t.choice_kind = 'infernal_legacy'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level5_id
  WHERE ov.spell_level5_id IS NOT NULL

  UNION ALL

  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'gnomeLineageId'
    AND t.choice_kind = 'gnome_lineage'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_1_id
  WHERE ov.spell_1_id IS NOT NULL
  UNION ALL
  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'gnomeLineageId'
    AND t.choice_kind = 'gnome_lineage'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_2_id
  WHERE ov.spell_2_id IS NOT NULL

  UNION ALL

  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'giantkinAncestryId'
    AND t.choice_kind = 'giantkin_ancestry'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level1_id
  WHERE ov.spell_level1_id IS NOT NULL

  UNION ALL

  -- Feathren aviária L1 (truque)
  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'feathrenAvianAncestryId'
    AND t.choice_kind = 'feathren_avian_ancestry'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level1_id
  WHERE ov.spell_level1_id IS NOT NULL
  UNION ALL
  -- Feathren felina L3
  SELECT sp.slug, t.choice_kind, ov.value_id, 3, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'feathrenFelineAncestryId'
    AND t.choice_kind = 'feathren_feline_ancestry'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level3_id
  WHERE ov.spell_level3_id IS NOT NULL

  UNION ALL

  SELECT sp.slug, NULL::rpg.species_choice_kind, NULL::text, g.unlock_level, s.slug
  FROM rpg.phb_spell_grant g
  JOIN rpg.phb_species sp ON sp.id = g.origin_id
  JOIN rpg.phb_spell s ON s.id = g.spell_id
  WHERE g.origin_type = 'species'::rpg.spell_grant_origin
) AS granted;
`,
);

console.log('Done. Output:', outDir);
