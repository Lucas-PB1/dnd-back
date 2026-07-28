---
name: split-large-module
description: >-
  Divide arquivos TypeScript grandes do dnd-api em módulos com uma
  responsabilidade (SRP). Use when splitting files over 150–200 lines, god
  validators/handlers/repositories, or extracting domain from Nest/TypeORM.
---

# Split large module

## Meta

Arquivo tocado deve sair **≤ 200 linhas** (ideal ≤ 150), sem mudar comportamento.

## Workflow

1. **Ler** o arquivo e listar concerns (validação X, cálculo Y, I/O Z).
2. **Escolher** um concern coeso para extrair (o mais fácil de isolar).
3. **Criar** arquivo irmão no mesmo layer / pasta de concern:
   - Game domain: `game/<sub>/domain/<nome>.ts` (cálculos)
   - Validators da ficha: `game/sheet/domain/validation/<concern>/`
     (`feats/`, `class-options/`, `background/`, `equipment/`, `spells/`)
   - Application: `.../application/<nome>.handler.ts` ou helper
   - Infra: `.../infrastructure/<nome>.repository.ts` / mapper
4. **Mover** funções/tipos; manter exports públicos estáveis (reexport temporário OK).
5. **Ajustar** imports; rodar spec do módulo (`*.application.spec.ts` / `*.queries.spec.ts`).
6. **Não** misturar rename cosmético com split.
7. **Não** despejar dezenas de validators na raiz de `domain/` — use subpasta do concern.

## Regras de layer

| De | Pode importar |
|----|----------------|
| `domain/` | só domain / tipos puros |
| `application/` | domain + ports |
| `infrastructure/` | TypeORM + domain types |
| `catalog/` | sem `game/` |

## Exemplo (validator gordo)

```
character-sheet.validator.ts  (1434 linhas)
→ validation/feats/...
→ validation/class-options/...
→ validation/equipment/...
→ validation/character-sheet.validator.ts  (orquestra só)
```

## Checklist

- [ ] Cada arquivo novo tem um motivo para mudar
- [ ] Specs verdes no módulo
- [ ] Sem lógica D&D duplicada (DRY)
- [ ] Se ainda > 200 → outro PR/split

## Ver também

- Skill shared-ai: `clean-code`, `solid`, `dry`
- [`code-standards.md`](../../../docs/architecture/code-standards.md)
