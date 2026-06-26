# Objetivo: fichas de personagem

Este repositório extrai o **Livro do Jogador 2024 (PT-BR)** para JSON estruturado. O foco é montar o **mínimo de dados** para montar e validar uma **ficha de personagem do jogador** — não o livro inteiro, não regras de Mestre, não monstros.

As fichas em `data/characters/` são **casos de teste de integração**: provam que espécie + antecedente + classe + magia + equipamento referenciam o acervo corretamente. **Não** é objetivo gerar UI, exportar PDF ou implementar motor de jogo.

---

## Release atual — escopo ficha do jogador

Snapshot do que consideramos **in scope** para a ficha (atualizado conforme extraímos).

### ✅ Criação nível 1 — dados prontos

| Área | Dados | Onde |
|------|--------|------|
| Origem | Espécie, antecedente | `species/`, `backgrounds/` |
| **Alinhamento** | 9 combinações + eixos | `creation/alignments.json` |
| **Atributos** | Conjunto padrão, rolagem, ponto buy, tabela por classe, bônus do antecedente | `creation/ability-generation.json` |
| **Idiomas** | Comum + 2, tabelas Comuns (1d12) e Raros | `creation/languages.json` |
| Classe | 12 classes, 48 subclasses, features, equipamento inicial | `classes/`, `subclasses/` |
| PV / nível | Dado de vida, PV fixo por nível, XP, proficiência | `hitPoints`, `rules/hp.json`, `rules/character-advancement.json` |
| Modificadores | Tabela valor → modificador | `rules/ability-modifiers.json` |
| Perícias | 18 perícias + regras de uso | `skills/` |
| Testes de D20 | Teste de atributo, salvaguarda, ataque | `rules/` |
| Magia | 391 magias, listas por classe, progressão | `spells/`, `spells/by-class/` |
| Talentos | 75 talentos | `feats/` |
| Equipamento | Armas, armaduras, itens, moedas | `weapons/`, `armor/`, `equipment/` |
| Ficha de teste | Schema + validador + Aelindra nível 3 | `character.schema.json`, `validate:character` |

### 🔲 Próximo na ficha (não bloqueia nível 1)

| Item | Nota |
|------|------|
| Ficha de teste **nível 1** | Ex.: guerreiro ou bardo — validar criação do zero |
| Validar **atributos finais** vs método + bônus do antecedente | Regra derivada (não só ids) |
| Magias de subclasse em JSON | Domínio da Vida ainda hardcoded no validador |

### 🔲 Secundário (só se a ficha guardar o campo)

| Campo | Nota |
|-------|------|
| Condições ativas | Referência Apêndice C + `conditions[]` na ficha |
| Descanso | Recuperação de dados de vida / recursos |
| Percepção passiva | Calculada — fórmula em `skills/rules/passive-perception.json` |

### ⛔ Fora do escopo da ficha

Apêndice B (criaturas), raridades de item mágico (LM), combate completo, multiclasse, tipos de dano/dado como referência solta, catálogo de itens mágicos. Ver seção final do doc anterior se precisar do detalhe.

---

## Campos da ficha

### Texto livre (sem JSON no acervo)

Nome, aparência, personalidade, história, notas.

### Escolhas na criação

| Campo | Schema | Status |
|-------|--------|--------|
| `speciesId` + `speciesChoices` | ✅ | |
| `backgroundId` | ✅ | |
| `classId`, `subclassId`, `classChoices` | ✅ | |
| `abilities` (6 valores finais) | ✅ | |
| `alignmentId` | ✅ | ex.: `neutral-good` |
| `abilityGeneration` | ✅ | `methodId` + `backgroundBoostId` opcional |
| `languageIds` | ✅ | inclui `common` |
| `feats[]`, perícias, equipamento, magias | ✅ | |

### Estado em jogo

Nível, PV, slots usados, recursos de classe, equipamento equipado — ver `data/characters/aelindra.json`.

### Calculado em runtime

Modificadores, proficiência, CA, CD de magia, bônus de perícia, características do nível, percepção passiva.

---

## Acervo

```
data/phb/
├── creation/           # Cap. 2 — alinhamento, atributos, idiomas
├── species/
├── backgrounds/
├── classes/ + subclasses/
├── feats/
├── skills/ + rules/
├── rules/              # D20, PV, proficiência
├── spells/ + by-class/
└── equipment/ + armor/ + weapons/

data/characters/
data/schema/
```

**Validação:**

```bash
npm run creation:all          # Cap. 2 criação
npm run validate:character    # fichas
npm run validate:references   # classes, antecedentes, skills
npm run rules:all             # PV, proficiência
npm run skills:all            # perícias
npm run spellcasting:all      # conjuração + PDF
```

---

## Modelo da ficha

```json
{
  "speciesId": "elf",
  "speciesChoices": { "lineageId": "high-elf", "keenSensesSkillId": "perception" },
  "backgroundId": "acolyte",
  "classId": "cleric",
  "subclassId": "life",
  "level": 3,
  "alignmentId": "neutral-good",
  "abilityGeneration": {
    "methodId": "standard-array",
    "backgroundBoostId": "two-and-one"
  },
  "languageIds": ["common", "elvish", "celestial"],
  "abilities": { "forca": 10, "destreza": 14, "constituicao": 13, "inteligencia": 10, "sabedoria": 16, "carisma": 8 },
  "spellcasting": { "cantrips": { "class": ["…"] }, "prepared": { "class": ["…"] }, "slotsMax": { "1": 4, "2": 2 } },
  "hp": { "current": 21, "max": 21, "temp": 0 },
  "startingPackages": { "classOption": "A", "backgroundOption": "a" },
  "equipment": [{ "itemId": "leather", "source": "class-starting", "equipped": true }]
}
```

Referência completa: `data/characters/aelindra.json`.

---

## Fluxo de criação (nível 1)

```mermaid
flowchart TD
  A[Espécie] --> B[Antecedente]
  B --> C[Classe]
  C --> D[Atributos]
  D --> E[Alinhamento + idiomas]
  E --> F[Perícias / salvaguardas]
  F --> G[Talento origem]
  G --> H[Equipamento]
  H --> I[Magias]
  I --> J[Ficha pronta]

  subgraph ok [Pronto]
    S1[species ✅]
    S2[backgrounds ✅]
    S3[classes ✅]
    S4[creation ✅]
    S5[feats ✅]
    S6[equipment ✅]
    S7[spells ✅]
  end

  A -.-> S1
  B -.-> S2
  C -.-> S3
  D -.-> S4
  E -.-> S4
  G -.-> S5
  H -.-> S6
  I -.-> S7
```

---

## Roadmap (só ficha do jogador)

### Fase 1 — Personagem nível 1

- [x] Espécies, antecedentes, classes, talentos, equipamento, magias
- [x] Perícias, PV/proficiência, regras D20
- [x] **Cap. 2** — `creation/` (alinhamento, atributos, idiomas)
- [x] Schema da ficha — `alignmentId`, `abilityGeneration`, `languageIds`
- [x] Aelindra atualizada com campos de criação
- [ ] Ficha nível 1 adicional (guerreiro ou bardo)
- [ ] Validador: atributos finais coerentes com método + antecedente

### Fase 2 — Progressão

- [x] Conjuração por nível, PV por nível
- [ ] Magias de subclasse estruturadas (tirar hardcode do validador)

### Fase 3 — Estado em jogo (opcional)

- [ ] Condições, descanso — se a ficha passar a rastrear

### Fora do roadmap

UI, exportação, motor de combate, Apêndice B, LM, multiclasse.

---

## Convenções de `id`

| Tipo | Exemplo |
|------|---------|
| Alinhamento | `neutral-good`, `lawful-neutral` |
| Idioma | `common`, `elvish`, `celestial` |
| Método de atributos | `standard-array`, `roll`, `point-buy` |
| Classe / espécie / etc. | Ver `index.json` de cada pasta |

---

## Próximo passo

1. **Ficha nível 1** de teste (classe sem conjuração ou conjurador simples).
2. **Validação derivada de atributos** — conferir base + bônus do antecedente vs `abilities` finais.
3. **Magias de subclasse** em JSON (ex.: Domínio da Vida por nível).
