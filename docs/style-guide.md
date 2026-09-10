# Guia de estilo da documentação

Base: [Google developer documentation style guide](https://developers.google.com/style/highlights).  
Idioma do projeto: **português**. Adapte as regras do Google; não copie inglês literal.

Este guia vale para `dnd-api/docs/`. O inventário de tecnologias do monorepo fica em `docs/` na raiz do workspace.

## Objetivos

1. Ajudar alguém a **fazer uma tarefa** ou a **entender uma decisão**.
2. Ser escaneável em 30 segundos (título → tabelas → links).
3. Permanecer **verdadeiro** em relação ao código e ao schema.

Se um parágrafo não serve a um desses três, corte.

## Tom e voz

| Fazer | Evitar |
|-------|--------|
| Tom direto, como um colega experiente | Marketing, “enciclopédia”, emojis decorativos |
| Segunda pessoa: **você** | “nós vamos”, “vamos começar nossa jornada” |
| Voz ativa: “O serviço carrega o efeito” | “O efeito é carregado pelo serviço” |
| Presente | Futuro de anúncio (“em breve”, “vamos migrar…”) |

Não diga que algo é “simples”, “fácil” ou “óbvio”.

## Estrutura de página

1. **Um H1** = título da página (sentence case: só a primeira palavra e nomes próprios em maiúscula).
2. Nas primeiras 2–3 linhas: o que é o doc e para quem.
3. Links para SSOT relacionados (não repita a mesma política em três arquivos).
4. Corpo em seções com H2/H3 descritivos (“Como aplicar o schema”, não “Overview”).
5. Listas numeradas = sequência; bullets = itens sem ordem.

## Formatação

- **UI** em negrito; código, paths, slugs e `kind` em `fonte monoespaçada`.
- Texto de link descritivo: “veja o [dicionário de efeitos](architecture/effect-dictionary.md)”, não “clique aqui”.
- Datas no formato `AAAA-MM-DD`.
- Tabelas para pares campo→uso, status, ou inventários.
- Sem dual imperial/métrico na prosa de produto (só SI na UI; colunas `*_ft`/`*_lb` no banco podem permanecer).

## Tipos de documento

| Tipo | Pasta | Critério de qualidade |
|------|-------|------------------------|
| Índice | `docs/README.md` | Só mapa; sem regra de negócio longa |
| Arquitetura / inventário | `architecture/` | Estado **atual** do sistema |
| ADR | `architecture/adr-*.md` | Contexto → decisão → consequências; status claro |
| Plano / backlog | `plans/` | Só o que ainda está aberto; concluído **sai** |
| Ops / how-to | `deploy/`, READMEs de `database/` | Passos reproduzíveis |
| Fonte regenerável | `source/` | Não é doc de produto; pode ser bruto |

## O que não documentar aqui

- Tutorial longo de framework genérico (React/Nest) — não vive neste hub; mantenha só inventário de stack em `docs/` na raiz do workspace.
- Histórico de “Fase 0…N” depois de fechado — mova o essencial para ADR/inventário e apague o resto.
- Referências a rules/skills Cursor que **não existem mais** no repo.

## Checklist antes de mergear um `.md`

- [ ] Título e H2 em sentence case
- [ ] Abertura diz o propósito em ≤3 linhas
- [ ] Links quebrados / paths `.cursor` inexistentes removidos
- [ ] Sem anunciar trabalho futuro como se já existisse
- [ ] Termos iguais aos do código (`phb_effect`, `owner_kind`, …)
- [ ] Se for plano concluído: **apagar** o arquivo e tirar do índice
