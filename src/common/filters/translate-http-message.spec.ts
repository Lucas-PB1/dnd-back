import {
  translateErrorLabel,
  translateHttpMessage,
  translateHttpMessages,
} from './translate-http-message';

describe('translateHttpMessage', () => {
  it('keeps Portuguese messages', () => {
    expect(
      translateHttpMessage('Carga excedida ao adicionar item'),
    ).toBe('Carga excedida ao adicionar item');
    expect(translateHttpMessage('Sem proficiência com espada')).toBe(
      'Sem proficiência com espada',
    );
  });

  it('translates exact known messages', () => {
    expect(translateHttpMessage('Internal server error')).toBe(
      'Erro interno do servidor',
    );
    expect(translateHttpMessage('Missing Bearer token')).toBe(
      'Token Bearer ausente',
    );
  });

  it('translates common patterns', () => {
    expect(translateHttpMessage("Class 'fighter' not found")).toBe(
      "Classe 'fighter' não encontrado",
    );
    expect(translateHttpMessage("Unknown skill 'arcana'")).toBe(
      "Perícia 'arcana' desconhecido(a)",
    );
    expect(translateHttpMessage('Invalid slug')).toBe('slug inválido(a)');
  });

  it('translates arrays and error labels', () => {
    expect(translateHttpMessages(['Invalid slug', 'Missing Bearer token'])).toEqual([
      'slug inválido(a)',
      'Token Bearer ausente',
    ]);
    expect(translateErrorLabel('Bad Request')).toBe('Requisição inválida');
    expect(translateErrorLabel('Not Found')).toBe('Não encontrado');
  });
});
