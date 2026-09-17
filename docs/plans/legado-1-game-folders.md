# LEG-1 — Pastas Game suspeitas

**Status:** aberto · **Pai:** [`legado-cleanup-backlog.md`](legado-cleanup-backlog.md) · **Tam:** M

## Skills / rules

`nestjs` · `typescript` · `domain-driven-design` · `dry` · `testing` · `okf`  
`/legado` · `game-folder-conventions.mdc`

## Escopo

1. `src/game/companion/` — revalidar imports; órfãos → remover ou documentar como domain library
2. Qualquer pasta sob `src/game/` sem `*.module.ts` (exceto shared domain-only documentado)
3. Arquivos sem importer de produção

## DoD

- [ ] Tabela `path | status | ação | evidência` no `docs/okf/log.md`
- [ ] Mortos removidos; errados de lugar movidos
- [ ] `tsc` + specs do escopo verdes
- [ ] Apagar este `.md` do backlog pai
