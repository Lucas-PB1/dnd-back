/**
 * Texto editorial PT para heranças GH Cap. 1 (prosa, tamanho, deslocamento).
 * Sobrescreve o glossário automático onde a prosa extraída permanece em inglês.
 */
export const HERITAGE_CATEGORY_LABEL_PT = {
  common: 'Variante comum',
  rare: 'Variante rara',
  eldritch: 'Variante eldritch',
};

/** @type {Record<string, { description?: string; size?: string; speed?: string }>} */
export const HERITAGE_FIELDS_PT = {
  'gh-dragonborn': {
    description:
      'Draconatos caminham com orgulho por um mundo que os recebe com medo e admiração. Escamas espessas, garras afiadas e presas lembram dragões — embora sem asas nem tamanho lendário. Muitos migraram de Castinella e reconstruíram Ember Cairn, tornando-se fervorosos do Dogma Eterno.',
    size:
      'Draconatos são tipicamente altos e robustos; a maioria passa de 1,8 m e pesa cerca de 125 kg em média. Seu tamanho é Médio.',
    speed: '9 m.',
  },
  'gh-dwarf': {
    description:
      'Anões forjaram reinos nas montanhas Rock-Teeth e Grey Spine muito antes da história registrada. Guerras da Era da Expansão dizimaram Grabenstein; Stehlenwald sobreviveu com adamantina e isolamento. Hoje, muitos vivem no Império Bürach — orgulhosos, resilientes e mestres artesãos das profundezas.',
    size:
      'Anões medem entre 1,2 m e 1,5 m e pesam cerca de 75 kg em média. Seu tamanho é Médio.',
    speed:
      '9 m. Seu deslocamento não é reduzido por usar armadura pesada. Você pode reduzir seu deslocamento em 1,5 m para ganhar um traço tradicional extra.',
  },
  'gh-elf': {
    description:
      'Elfos habitam Etharis desde eras imemoriais, ligados a florestas antigas e à magia feérica. Divididos em linhagens distintas, preservam tradições longínquas enquanto navegam um mundo dominado por impérios humanos e conflitos sem fim.',
    size:
      'Elfos variam de menos de 1,5 m a mais de 1,8 m de altura, com porte frequentemente esguio. Seu tamanho é Médio.',
    speed: '9 m.',
  },
  'gh-gnome': {
    description:
      'Gnomos são inventores, ilusionistas e curiosos incansáveis. Pequenos em estatura, grandes em engenho — prosperam em comunidades onde engenhosidade e humor desarmam perigos maiores que eles.',
    size:
      'Gnomos medem entre 0,9 m e 1,2 m e pesam cerca de 20 kg em média. Seu tamanho é Pequeno.',
    speed: '9 m.',
  },
  'gh-halfling': {
    description:
      'Halflings valorizam conforto, comunidade e sorte discreta. Ágeis e discretos, encontram caminho entre impérios e guerras, muitas vezes prosperando onde povos maiores falham.',
    size:
      'Halflings têm cerca de 0,9 m de altura e pesam cerca de 20 kg. Seu tamanho é Pequeno.',
    speed: '9 m.',
  },
  'gh-human': {
    description:
      'Humanos dominam Etharis na era atual — adaptáveis, expansionistas e encontrados do norte gelado ao sul escaldante. Surgiram nas florestas temperadas do que hoje é o Império Bürach e espalharam-se em ondas de colonização que moldaram o continente.',
    size:
      'Humanos variam muito em altura e porte, de pouco mais de 1,5 m a bem acima de 1,8 m. Seu tamanho é Médio.',
    speed: '9 m.',
  },
  'gh-dreamer': {
    description:
      'Sonhadores são descendentes de um império perdido, preservados em estase oneírica por milênios. Ao despertar, misturam memória e sonho; adaptam-se rápido ao mundo moderno, mas ainda encontram conforto no sono profundo.',
    size:
      'Sonhadores medem tipicamente entre 1,5 m e 1,8 m e têm porte sólido. Seu tamanho é Médio.',
    speed: '9 m.',
  },
  'gh-grudgel': {
    description:
      'Rancorosos descendem dos antigos orcs do norte, embora sua cultura tenha mudado muito desde as lendas de conquista. Imponentes e trabalhadores, são artesãos, viajantes e guardiões do segredo do stryllum — vidro solidificado de luz estelar.',
    size:
      'Rancorosos são mais altos e robustos que muitos humanoides, tipicamente entre 1,8 m e 2,1 m, pesando 100 kg ou mais. Seu tamanho é Médio.',
    speed: '9 m.',
  },
  'gh-laneshi': {
    description:
      'Laneshi habitam o império submarino Llana’Shi, guiados por dualidade rígida e laços entre vida e morte. Guerreiros e místicos — estes últimos ligados a um guia espiritual — observam o mundo de superfície com motivos ainda incertos.',
    size:
      'Laneshi medem tipicamente entre 1,5 m e 1,8 m e têm porte esguio. Seu tamanho é Médio.',
    speed: '9 m. Você tem deslocamento de natação de 9 m.',
  },
  'gh-ogresh': {
    description:
      'Ogrês são gigantes gentis e raros, sábios em histórias populares. Jovens viajam até encontrar território para assentar-se; adultos tornam-se sedentários e vorazes, desenvolvendo talento incomum para ler e influenciar outros.',
    size:
      'Ogrês jovens medem entre 1,8 m e 2,1 m, com corpo largo e pesado — entre 90 kg e 135 kg; exemplares mais velhos podem ultrapassar 350 kg. Seu tamanho é Médio.',
    speed: '9 m.',
  },
  'gh-accursed': {
    description:
      'Amaldiçoados são personagens únicos — cada um quase uma herança por si. Não representam um povo homogêneo; servem de “catch-all” criativo para conceitos que não cabem nas demais variantes de Grim Hollow.',
    size:
      'Amaldiçoados podem medir de menos de 0,9 m a 1,8 m ou mais, com tipos corporais variados. Seu tamanho é Pequeno ou Médio, conforme você definir.',
    speed:
      '9 m. Se você for Pequeno, pode reduzir seu deslocamento em 1,5 m para ganhar um traço extra.',
  },
  'gh-arisen': {
    description:
      'Reerguidos são construtos orgânicos animados por magia ou ciência arcana — não mortos-vivos, mas pessoas com personalidade própria. Cada um carrega memórias fragmentadas da criação e questiona alma, mortalidade e lugar no mundo.',
    size:
      'Reerguidos podem ser compactos (cerca de 0,6 m) ou imponentes (acima de 2,1 m). Seu tamanho é Pequeno ou Médio, conforme você definir.',
    speed:
      '9 m. Se você for Pequeno, pode reduzir seu deslocamento em 1,5 m para ganhar um traço tradicional extra.',
  },
  'gh-dhampir': {
    description:
      'Dhampirs nascem da linhagem vampírica, equilibrando sede e humanidade. Muitos vivem à margem de sociedades que temem sua natureza, desenvolvendo instinto aguçado e resistência incomum.',
    size:
      'Um dhampir tem o mesmo tamanho do humanoide do qual surgiu. Você é Pequeno ou Médio, conforme você definir.',
    speed: '9 m.',
  },
  'gh-disembodied': {
    description:
      'Desencarnados são ecos translúcidos de quem já viveram — quase insubstanciais, com peso reduzido a um quarto do original. Persistem entre planos, ligados a memórias, magia ou promessas inacabadas.',
    size:
      'Desencarnados aparecem como versões translúcidas de si mesmos; sua natureza quase insubstancial reduz o peso a um quarto do original. Seu tamanho é Pequeno ou Médio, conforme você definir.',
    speed: '9 m.',
  },
  'gh-downcast': {
    description:
      'Relegados carregam marcas de queda social, maldição ou exílio — visíveis ou sutis. Resilientes, reinventam-se em margens de impérios onde poucos esperam sobreviver.',
    size:
      'Relegados medem geralmente entre 1,5 m e 1,8 m, com tipos corporais variados. Seu tamanho é Médio.',
    speed: '9 m.',
  },
  'gh-wechselkind': {
    description:
      'Wechselkind foram construídos para lembrar crianças — autômatos ou feitos de matéria orgânica animada. Movem-se entre inocência aparente e purpose sombrio, desconfiados por quem conhece a lenda.',
    size:
      'Wechselkind medem entre 0,6 m e 0,9 m e pesam entre 12,5 kg e 17,5 kg. Seu tamanho é Pequeno.',
    speed: '9 m.',
  },
  'gh-wulven': {
    description:
      'Wulven são humanoides tocados por maldição licantrópica incompleta — nem homem nem lobo, mas algo entre. Mantêm forma humanoide, porém com instintos e corpo alterados pela ferida da maldição.',
    size:
      'Wulven têm altura semelhante à herança original, porém costumam ser mais robustos, musculosos ou ágeis conforme a natureza da maldição. Seu tamanho é Pequeno ou Médio, conforme você definir.',
    speed: '9 m.',
  },
};
