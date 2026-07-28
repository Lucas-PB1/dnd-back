/**
 * Traduz mensagens de erro HTTP user-facing EN → PT-BR.
 * Mensagens já em português (acentos / frases conhecidas) passam intactas.
 */

const ERROR_LABEL_PT: Record<string, string> = {
  'Bad Request': 'Requisição inválida',
  Unauthorized: 'Não autorizado',
  Forbidden: 'Acesso negado',
  'Not Found': 'Não encontrado',
  Conflict: 'Conflito',
  'Unprocessable Entity': 'Entidade não processável',
  'Internal Server Error': 'Erro interno do servidor',
  'Validation Error': 'Erro de validação',
};

const EXACT_MESSAGE_PT: Record<string, string> = {
  'Internal server error': 'Erro interno do servidor',
  'Missing Bearer token': 'Token Bearer ausente',
  'Character hit points are not set': 'Pontos de vida do personagem não definidos',
  'Character is already at maximum level':
    'Personagem já está no nível máximo',
  'Encounter is closed': 'O encontro está encerrado',
  'Encounter is already closed': 'O encontro já está encerrado',
  'Cantrip choices must be different':
    'As escolhas de truque devem ser diferentes',
  'Duplicate language slugs are not allowed':
    'Idiomas duplicados não são permitidos',
};

const PATTERN_REPLACEMENTS: Array<{ pattern: RegExp; replace: string }> = [
  {
    pattern: /^Missing (.+)$/i,
    replace: 'Falta $1',
  },
  {
    pattern: /^Invalid (.+)$/i,
    replace: '$1 inválido(a)',
  },
  {
    pattern: /^(.+?) is not (a |an |on |in |the )?(.+)$/i,
    replace: '$1 não é $2$3',
  },
  {
    pattern: /^(.+?) requires (.+)$/i,
    replace: '$1 exige $2',
  },
  {
    pattern: /^(.+?) already (.+)$/i,
    replace: '$1 já $2',
  },
  {
    pattern: /^You are not (.+)$/i,
    replace: 'Você não é $1',
  },
  {
    pattern: /^Only (.+) can (.+)$/i,
    replace: 'Somente $1 pode $2',
  },
  {
    pattern: /^No active encounter in this campaign$/i,
    replace: 'Não há encontro ativo nesta campanha',
  },
  {
    pattern: /^Players may only roll for their own PCs$/i,
    replace: 'Jogadores só podem rolar iniciativa dos próprios personagens',
  },
];

function looksPortuguese(text: string): boolean {
  if (/[áàâãéêíóôõúçÁÀÂÃÉÊÍÓÔÕÚÇ]/.test(text)) return true;
  return /\b(não|para|com|sem|já|está|excede|capacidade|proficiência)\b/i.test(
    text,
  );
}

export function translateErrorLabel(error: string): string {
  return ERROR_LABEL_PT[error] ?? error;
}

const ENTITY_PT: Record<string, string> = {
  Character: 'Personagem',
  Class: 'Classe',
  Spell: 'Magia',
  Feat: 'Talento',
  Background: 'Antecedente',
  Species: 'Espécie',
  Encounter: 'Encontro',
  Campaign: 'Campanha',
  Skill: 'Perícia',
  Item: 'Item',
  Member: 'Membro',
  Combatant: 'Combatente',
};

function localizeEntity(name: string): string {
  const titled = name.charAt(0).toUpperCase() + name.slice(1).toLowerCase();
  return ENTITY_PT[name] ?? ENTITY_PT[titled] ?? name;
}

export function translateHttpMessage(message: string): string {
  const trimmed = message.trim();
  if (!trimmed) return trimmed;
  if (looksPortuguese(trimmed)) return trimmed;

  const exact = EXACT_MESSAGE_PT[trimmed];
  if (exact) return exact;

  const notFound = trimmed.match(/^(.+?) '([^']+)' not found$/i);
  if (notFound) {
    return `${localizeEntity(notFound[1])} '${notFound[2]}' não encontrado`;
  }

  const unknown = trimmed.match(/^Unknown (.+?) '([^']+)'$/i);
  if (unknown) {
    return `${localizeEntity(unknown[1])} '${unknown[2]}' desconhecido(a)`;
  }

  for (const { pattern, replace } of PATTERN_REPLACEMENTS) {
    if (pattern.test(trimmed)) {
      return trimmed.replace(pattern, replace);
    }
  }

  return trimmed;
}

export function translateHttpMessages(
  message: string | string[],
): string | string[] {
  if (Array.isArray(message)) {
    return message.map(translateHttpMessage);
  }
  return translateHttpMessage(message);
}
