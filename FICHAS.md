# Objetivo: fichas de personagem

Este repositório extrai o **Livro do Jogador 2024 (PT-BR)** para JSON estruturado. O objetivo **atual** é montar a **biblioteca de regras** em `data/phb/` e **testar** se os dados fecham (schemas, referências cruzadas, checagens contra o PDF).

As fichas em `data/characters/` são **casos de teste de integração** — personagens de exemplo que provam que espécie + antecedente + classe + magia + equipamento referenciam o acervo corretamente. **Não** é objetivo deste repo gerar UI, exportar PDF ou implementar motor de jogo.

No futuro, uma aplicação poderia consumir esses JSON; isso fica fora do escopo imediato.

---

## O que uma ficha precisa cobrir

No sistema 2024, uma ficha completa reúne escolhas do jogador com valores calculados a partir das regras.

### Identidade e origem

| Campo | Origem no livro | Status dos dados |
|-------|-----------------|------------------|
| Nome, aparência, personalidade | Jogador | — |
| Espécie (traços, tamanho, velocidade) | Cap. 4 | ✅ `data/phb/species/` (10) |
| Antecedente (talento de origem, perícias, ferramenta) | Cap. 4 | ✅ `data/phb/backgrounds/` (16) |
| Idiomas (regras de criação) | Cap. 4 | **Falta extrair** (não há campo estruturado nas espécies) |

### Classe e progressão

| Campo | Origem no livro | Status dos dados |
|-------|-----------------|------------------|
| Classe, nível, subclasse | Cap. 3 | ✅ `data/phb/classes/`, `subclasses/` |
| Características por nível | Cap. 3 | ✅ `features[]` |
| Tabela de espaços de magia / truques | Cap. 3 | ✅ `progression` nas 8 classes conjuradoras |
| PV máximos por nível (`hitDie` + progressão) | Cap. 2 | ✅ `hitPoints` nas classes + `rules/hp.json` |
| Bônus de proficiência por nível | Cap. 1 | ✅ `rules/proficiency-bonus.json` + `character-advancement.json` |
| Perícias, salvaguardas, especialização | Cap. 1 + classe + antecedente | ✅ `skillIds` / `savingThrowIds` nas classes e antecedentes |

### Atributos e perícias

| Campo | Origem no livro | Status dos dados |
|-------|-----------------|------------------|
| Seis atributos e modificadores | Cap. 1 + criação | ✅ `rules/ability-modifiers.json` |
| Bônus de proficiência (regra geral) | Cap. 1 | ✅ `rules/proficiency-bonus.json` |
| Perícias (lista e regras) | Cap. 1 | ✅ `skills/index.json` (18 + exemplos de uso) |
| Testes de atributo e salvaguardas | Cap. 1 | ✅ `rules/ability-checks.json`, `saving-throws.json`, `d20-tests.json` |
| CD de magia / ataque mágico | Cap. 7 | ✅ regras em `spells/rules/intro.json` |

### Combate e recursos

| Campo | Origem no livro | Status dos dados |
|-------|-----------------|------------------|
| CA, iniciativa, deslocamento | Classe + espécie + armadura | Armaduras ✅; espécie ✅ |
| Ataques, dano, armas | Cap. 6 | ✅ `weapons/`, `armor/` |
| Condições ativas | Apêndice B | **Falta extrair** |
| Descanso, PV temporários | Cap. 1 | **Falta** |

### Magia e talentos

| Campo | Origem no livro | Status dos dados |
|-------|-----------------|------------------|
| Truques e magias conhecidas/preparadas | Cap. 3 + 7 | ✅ magias + `spells/by-class/` (8 listas) |
| Espaços de magia gastos | Cap. 3 | ✅ `progression.spellSlots` / `pactSlots` |
| Talentos (origem, geral, estilo de luta, dádiva épica) | Cap. 5 | ✅ `data/phb/feats/` |
| Invocações, canalizar divindade, etc. | Cap. 3 | ✅ em `features[]` (texto) |

### Equipamento

| Campo | Origem no livro | Status dos dados |
|-------|-----------------|------------------|
| Itens, armas, armaduras, ferramentas | Cap. 6 | ✅ `equipment/`, `armor/`, `weapons/` |
| Pacotes iniciais da classe | Cap. 3 | ✅ `startingEquipment` nas classes |
| Dinheiro (PO) | Cap. 6 | ✅ `equipment/rules/coins.json` |

---

## O que já existe no repositório

```
data/phb/
├── index.json          # índice de classes e subclasses
├── classes/            # 12 classes
├── subclasses/         # 48 subclasses
├── feats/              # 75 talentos + regras
├── backgrounds/        # 16 antecedentes + índice + regras
├── species/            # 10 espécies + índice + regras
├── equipment/          # equipamento, ferramentas, montarias, serviços
├── armor/              # armaduras
├── weapons/            # armas
├── spells/             # 391 magias + índice + regras de conjuração
│   └── by-class/       # 8 listas por classe (truques + círculos 1–9)
├── skills/             # 18 perícias + 6 atributos (índice com ids)
├── rules/              # Cap. 1–2: testes de D20, PV, evolução, proficiência
└── ...

data/characters/        # fichas de personagem (instâncias)
data/schema/            # JSON Schema de cada tipo de dado
```

**Volume atual:** ~586 arquivos de regras do PHB (caps. 3–7 + origens).

**Validação automatizada hoje:**

| Comando | Cobre |
|---------|--------|
| `npm run spellcasting:all` | listas por classe, progressão, PDF |
| `npm run validate:references` | skills, antecedentes, classes (schemas + ids) |
| `npm run validate:character` | fichas em `data/characters/` (incl. PV fixo) |
| `npm run rules:all` | PV nas classes + regras Cap. 1/2 (schema + cruzamentos) |

---

## Lacunas críticas para fichas

Prioridade para conseguir **criar personagem nível 1** e **subir de nível** sem o PDF:

### Extração de dados (PHB)

1. ~~**Regras base (Cap. 1)** — atributos, testes de atributo, proficiência, salvaguardas.~~ ✅ Parcial — falta combate, descanso, ações.
2. **Glossário / condições (Apêndice B)** — necessário para aplicar efeitos em jogo.
3. **Idiomas (Cap. 4)** — regras de quantos idiomas o personagem conhece na criação.
4. ~~**Tabelas de PV por nível**~~ ✅ `rules/hp.json` + `hitPoints` nas 12 classes.
5. **Multiclasse (Apêndice A)** — se fichas precisarem de mais de uma classe.

### Ficha de teste (`data/characters/`)

- [x] **`character.schema.json`** — escolhas, estado e **fonte** de cada elemento
- [x] **Exemplo** — `aelindra.json` (clériga elfa nível 3)
- [x] **`validate:character`** — contagens vs tabela de progressão e referências ao PHB

A ficha **não** duplica o livro; prova que os JSON referenciam uns aos outros corretamente.

| Referência | Na ficha |
|------------|----------|
| antecedente → talento | `feats[].featId` + `magicInitiate` |
| espécie → traços | `speciesId` + `speciesChoices` (linhagem, Sentidos Aguçados) |
| classe → magias | `spellcasting.cantrips/prepared` por chave de origem |
| pacotes iniciais | `startingPackages` + `equipment[].source` |

### Melhorias nos dados atuais (sem novo capítulo)

- Listas de magia por classe (`spells/by-class/`). ✅
- Tabelas de progressão de conjuração (truques, preparadas, slots). ✅
- Índice mestre do PHB (além do `index.json` só de classes).
- Limpeza residual: `species/rules/intro.json` (texto corrompido), legendas de arte em `spells/rules/intro.json`.
- Validador permanente para **todos** os JSON do PHB (hoje só conjuração).

## Modelo conceitual da ficha

A ficha **não** duplica texto do livro. Guarda **escolhas do jogador**, **estado de jogo** e **referências por origem**; traços completos vêm de `data/phb/species/{id}.json` + `speciesChoices`.

```json
{
  "speciesId": "elf",
  "speciesChoices": { "lineageId": "high-elf", "keenSensesSkillId": "perception" },
  "spellcasting": {
    "cantrips": {
      "class": ["…4 truques (3 da tabela + Taumaturgo)"],
      "magic-initiate": ["luz", "resistencia"],
      "elf-lineage": ["prestidigitacao-arcana"]
    },
    "prepared": {
      "class": ["…6 magias da tabela, nível 3"],
      "magic-initiate": ["escudo-da-fe"],
      "life-domain": ["auxilio", "bencao", "curar-ferimentos", "restauracao-menor"],
      "elf-lineage": ["detectar-magia"]
    },
    "slotsMax": { "1": 4, "2": 2 }
  },
  "startingPackages": { "classOption": "A", "backgroundOption": "a" },
  "equipment": [{ "itemId": "leather", "source": "class-starting", "equipped": true }]
}
```

Ver ficha completa: `data/characters/aelindra.json`.

### Campos calculados (não persistir, ou cachear)

Derivados em tempo de execução a partir dos JSON do PHB:

- Modificadores de atributo
- Bônus de proficiência
- **Texto dos traços de espécie** (Visão no Escuro, Transe, linhagem…) a partir de `speciesId` + `speciesChoices`
- CA (armadura + treinamento + escudo + efeitos)
- CD de magia e bônus de ataque mágico
- Perícias com bônus total
- Características ativas no nível atual (`features` filtradas por `level`)
- Talentos elegíveis no próximo nível

---

## Fluxo de criação de personagem

```mermaid
flowchart TD
  A[Escolher espécie] --> B[Escolher antecedente]
  B --> C[Escolher classe]
  C --> D[Distribuir atributos]
  D --> E[Perícias e proficiências]
  E --> F[Talento de origem]
  F --> G[Equipamento inicial]
  G --> H[Truques / magias iniciais]
  H --> I[Ficha pronta]

  subgraph dados_phb [data/phb]
    S1[species ✅]
    S2[backgrounds ✅]
    S3[classes ✅]
    S4[feats ✅]
    S5[equipment ✅]
    S6[spells ✅]
    S6b[by-class ✅]
  end

  A -.-> S1
  B -.-> S2
  C -.-> S3
  F -.-> S4
  G -.-> S5
  H -.-> S6
  H -.-> S6b
```

---

## Roadmap sugerido

Roadmap orientado a **extração + validação**. Itens de produto (UI, motor de regras) estão em [Fora do escopo imediato](#fora-do-escopo-imediato).

### Fase 1 — Dados para personagem nível 1 ✅

- [x] Extrair **espécies** e **antecedentes** (Cap. 4)
- [x] Schemas: `species.schema.json`, `background.schema.json`
- [x] Dados de classe, talento, equipamento, magia (caps. 3, 5, 6, 7)
- [x] Índice de perícias (`skills/index.json`) e normalização de `skillIds` / `itemId`
- [x] Schema da ficha de teste: `character.schema.json`
- [x] Ficha-exemplo `data/characters/aelindra.json` + `validate:character`

### Fase 2 — Progressão e magia (extração)

- [x] Tabelas de conjuração nas 8 classes conjuradoras (truques, preparadas, slots)
- [x] `spells/by-class/*.json` + pipeline `spellcasting:all`
- [ ] Tabelas de **PV por nível** nas 12 classes
- [ ] Magias de subclasse/domínio estruturadas (hoje muitas só em `features[].description`)
- [ ] Multiclasse — **extrair** Apêndice A (se precisar testar com ficha multiclasse)

### Fase 3 — Regras de jogo (extração)

- [ ] **Cap. 1** — atributos, criação, perícias, proficiência, combate, descanso
- [ ] **Apêndice B** — condições (glossário)
- [ ] **Idiomas** (Cap. 4) — regras de criação
- [ ] Mais **fichas de teste** (nível 1, outra classe, sem conjuração) para achar lacunas

### Fase 4 — Qualidade do acervo

- [x] Validador da conjuração (Ajv + checagens + PDF)
- [x] Validadores de referências e fichas (`validate:references`, `validate:character`)
- [ ] Validador único de **todo** o PHB (sem depender de PDF no dia a dia)
- [ ] Índice mestre `data/phb/manifest.json`
- [ ] Limpeza residual (`species/rules/intro.json`, legendas em `spells/rules/intro.json`)

---

## Convenções úteis para fichas

| Tipo | Padrão de `id` | Exemplo |
|------|----------------|---------|
| Espécie | slug PT ou EN | `elf`, `elfo` |
| Antecedente | slug | `acolyte`, `acolito` |
| Classe | inglês | `cleric` |
| Subclasse | inglês | `life` |
| Magia | slug PT | `curar-ferimentos` |
| Perícia | inglês (kebab) | `medicine`, `religion` |
| Atributo | português (slug) | `sabedoria`, `destreza` |
| Talento | inglês | `alert` |
| Item | inglês | `chain-mail` |

Os dados atuais já usam `id` em inglês para classes/talentos/itens e slug PT para magias. **Novas fichas devem seguir os `id` dos arquivos existentes** — consultar os `index.json` de cada capítulo.

---

## Fora do escopo imediato

### Produto / aplicação (não é o foco agora)

- **UI ou exportação de ficha** (PDF, HTML, planilha)
- **Motor de jogo** — subir de nível, calcular CA, aplicar condições em tempo real
- Qualquer sistema que *consuma* os JSON pode vir depois; este repo entrega os dados e os testes

### Outros livros

- **Itens mágicos completos** — catálogo no Livro do Mestre, não no Jogador.
- **Monstros e NPCs** — Livro dos Monstros.
- **Campanhas e cenário** — outros produtos.

A ficha de teste pode referenciar um item mágico por nome, mas o banco de dados de itens mágicos seria outro livro.

---

## Próximo passo recomendado

**Fase 1 concluída.** Ritual daqui pra frente: **extrair capítulo → schema + validate → ficha de teste (se fizer sentido)**.

| Prioridade | O quê | Para quê |
|------------|--------|----------|
| **1** | **Cap. 1** + **Apêndice B** | Regras base e condições que faltam no acervo |
| **2** | **PV por nível** nas 12 classes | Completar progressão além de conjuração |
| **3** | **Magias de subclasse** em JSON estruturado | Tirar do texto (ex.: Domínio da Vida) e validar sem constantes no script |
| **4** | **Mais fichas de teste** | Ex.: guerreiro nível 1, bardo nível 1 — achar buracos nos dados |
| **5** | **`manifest.json`** + validador único do PHB | Um comando que valida todo o acervo |

**Não** é próximo passo: UI, exportação, lógica de app de mesa.

Comandos úteis hoje:

```bash
npm run spellcasting:all      # conjuração + PDF
npm run validate:references   # classes, antecedentes, skills
npm run validate:character    # fichas em data/characters/
```
