---
description: Varredura de legado morto pasta a pasta no dnd-api
---

# Legado morto — playbook

Use quando o usuário pedir limpeza de código morto, pastas órfãs ou “investigar legado”.

## Pré-requisitos

- Ler `.cursor/rules/game-folder-conventions.mdc` e `docs/okf/module-map.md`
- Skills: `nestjs`, `domain-driven-design`, `dry`, `typescript`, `testing`

## Protocolo (uma pasta por vez)

1. Escolher pasta (começar por suspeitas: `src/game/companion/`, arquivos sem `*.module.ts`, barrels órfãos)
2. Listar exports públicos e **quem importa** (`rg` / Go to References)
3. Classificar cada arquivo:
   - **vivo** — importado por módulo Nest ou teste ativo
   - **só teste** — manter ou mover para `__fixtures__`
   - **morto** — zero imports de produção → candidatar remoção
   - **errado de lugar** — vivo mas fora da convenção → mover (não apagar)
4. Registrar achados em `docs/okf/log.md` (1 bloco por pasta)
5. Remover/mover só com teste (`tsc` + specs do escopo) verde
6. Não misturar com feature nova no mesmo PR

## Ordem sugerida

1. `src/game/companion/`
2. Pastas sem `*.module.ts` sob `src/game/`
3. `src/game/combat/domain/<classe>/` — duplicatas / generated morto
4. `src/entities/` sem ViewEntity/Entity referenciada
5. Docs/planos concluídos que deveriam ter sido apagados (`docs/README.md` política)

## Saída esperada

Tabela: `path | status | ação | evidência (importer ou “nenhum”)`.
