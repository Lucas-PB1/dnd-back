# LEG-3 — Entities + Catalog órfãos

**Status:** aberto · **Pai:** [`legado-cleanup-backlog.md`](legado-cleanup-backlog.md) · **Dep:** LEG-2 · **Tam:** M

## Skills / rules

`typeorm` · `nestjs` · `typescript` · `catalog-sql-first` · `testing` · `okf`  
`catalog-sql-first.mdc` · `nestjs-project.mdc`

## Escopo

- `src/entities/` sem Entity/ViewEntity registrada / importada
- Features Catalog com Query/DTO mortos
- Imports Game → `@catalog/.../domain` profundos → `game-port`

## DoD

- [ ] Zero entity órfã no módulo TypeORM
- [ ] Log OKF
- [ ] Apagar este `.md`
