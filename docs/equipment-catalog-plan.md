# Plano — Catálogo de equipamento (PHB 2024 / 5.5)

Documento de planejamento para completar **dados mecânicos** e a experiência do compêndio em **itens (gear), kits/ferramentas, focos, armas e armaduras**.

| | |
|--|--|
| **Repos** | dnd-api (seeds, views, DTOs) + dnd-front (UI do compêndio) |
| **Última revisão** | 2026-07-19 |
| **Status** | Fases 0–5 entregues; weapon DTO = `range` + `propertyDetails` + `mastery` (sem jsonb bruto na response) |
| **Relacionados** | [`product-roadmap.md`](product-roadmap.md) · [`data-model.md`](data-model.md) · front [`UX-UI-PLAN.md`](../../dnd-front/docs/UX-UI-PLAN.md) |

### Progresso desta entrega

- [x] Fase 0 — inventário truncados + Opção A (`S070` UPDATE) — scripts one-off removidos após apply
- [x] Fase 1 — 70 descriptions gear/focus (`S070`)
- [x] Fase 2 — `properties` no Item DTO + atributo na UI
- [x] Fase 3 — `propertyDetails` + `mastery` armas (API/UI)
- [x] Fase 4 — `versatileDamage` + range zarabatana (`S071`)
- [x] Fase 5 — custo/peso armadura (`V032` + UI)
- [ ] Fase 6 — QA + apply Supabase/prod

---

## 1. Problema

No PHB 2024, equipamento de aventureiro não é só nome + preço + peso:

- **Gear** (ácido, corda, caixa para fogo, esferas, kit de curandeiro…): ação (**Usar Objeto** / **Atacar**), CD quando houver, efeito mecânico.
- **Ferramentas / kits**: atributo associado, uso com CD, craft quando aplicável.
- **Armas**: propriedades com **texto de regra** + **maestria** com texto; dano; alcance; versátil (dado de duas mãos).
- **Armaduras**: CA, requisito de Força, desvantagem em Furtividade, vestir/despir, **custo e peso**.

Hoje o compêndio mostra a casca (nome, custo, peso, stats básicos) e **falha em entregar o miolo mecânico**, principalmente no gear.

---

## 2. Estado atual (auditoria)

### 2.1 Inventário no seed `S046_phb_item.sql`

| `item_type` | Qtd | `description` | `properties` JSONB |
|-------------|-----|---------------|-------------------|
| `gear` | ~80 | Quase todas **truncadas** (~45–60 chars, cortam no meio da frase) | Sempre `NULL` |
| `tool` | ~25 | Em geral **completas** (uso + CD) | Preenchido (`attribute`, `crafting`, `variants`) |
| `focus` | 2 | Truncadas | A verificar |
| `weapon` | ~38 | `NULL` (ok — mecânica em tabelas filhas) | IDs: `propertyIds`, `masteryId`, `range?` |
| `armor` | ~13 | `NULL` | `acFormula`, `propertyIds` |

Arquivo marcado *“Gerado automaticamente — não editar à mão”* — qualquer correção precisa de **estratégia de regeneração ou migration de conteúdo**, para não se perder no próximo dump.

### 2.2 Exemplos de erro de conteúdo (gear)

| Slug | Texto atual (quebrado) | O que o PHB exige (resumo) |
|------|------------------------|----------------------------|
| `caixa-para-fogo` | *“…aço contra fogo e material muito”* | Conteúdo + tempo para acender fogo |
| `corda` | *“…você pode dar um nó em”* | Usar Objeto, amarrar criatura, CD, escapar |
| `acido` | *“…você pode substituir um”* | Atacar com frasco, alcance, dano, splashes |
| `esferas-de-metal` | *“…você pode derramar”* | Área, terreno difícil / queda, CD |
| `corrente` | *“…você pode enrolar uma”* | Restringir, CD, escapar |
| `kit-de-curandeiro` | Cortado em *“Como uma ação”* | Estabilizar / curar usos |
| `cadeado` | *“…Sem a chave, uma”* | Abrir com CD / arrombar |
| `lupa` | *“…Vantagem em qualquer teste de”* | Vantagem em testes de Investigação próximos |

**Conclusão gear:** o modelo de texto livre em `description` basta se o texto estiver **completo**. Não há tabela `phb_item_action` — e **não é obrigatório** criar uma na Fase 1 se o PHB for bem representado em prosa estruturada (como magias/talentos).

### 2.3 Ferramentas (kits)

- Texto de uso com CD geralmente **ok** em `phb_item.description`.
- `phb_tool.use_description` existe no schema (possível duplicata).
- `properties` tem `attribute` / `crafting` / `variants`, mas **`ItemResponseDto` não expõe `properties`** → UI do compêndio não mostra atributo nem craft.

### 2.4 Armas

**Já no DB e na API (parcial):**

- Categoria, dano, tipo de dano, custo, peso, `range`, lista de `propertyIds`, `masteryId`.

**Já no DB, fora da API/UI:**

| Fonte | Conteúdo |
|-------|----------|
| `phb_weapon_property` (`S018`) | `slug`, `name`, `description` **completos** (Acuidade, Leve, Arremesso…) |
| `phb_weapon_mastery` (`S019`) | `slug`, `name`, `description` **completos** (Ágil, Afligir, Derrubar…) |
| `phb_weapon_property_link` (`S048`) | N:N arma ↔ propriedade |

Hoje a API devolve só IDs; o front (`weapon-labels.ts`) **hardcoda labels** e **não mostra descrições**. Há divergência de tradução (ex.: mastery `vex` = “Afligir” no DB vs “Irritar” no front).

**Lacunas de modelagem (armas):**

- Dano **versátil** (ex. Espada Longa 1d8 / 1d10) não está no jsonb nem em coluna dedicada.
- Algumas armas à distância sem `range` no jsonb (ex. zarabatana).
- Entity TypeORM `PhbWeapon` não mapeia `mastery_id` (só via `item.properties`).

### 2.5 Armaduras

**Já na view/API:** categoria, CA, fórmula, Força, Furtividade, don/doff.

**No `phb_item`, fora da view `v_phb_armor` / DTO:**

- `cost`, `weight`
- `properties` (espelha CA / stealth)

Sem descrição PHB longa (armaduras no livro são majoritariamente tabela + notas curtas) — custo/peso são o gap principal na UI.

### 2.6 UI do compêndio (front)

| Superfície | O que mostra | O que falta |
|------------|--------------|-------------|
| Lista gear | Nome, tipo, custo, peso (+ teaser se description) | Teaser inútil se texto truncado |
| Detalhe gear | Hero + description | Texto completo / mecânica |
| Detalhe ferramenta | Igual gear | Atributo, craft, CD destacados |
| Detalhe arma | Stats + labels de propriedade/maestria | Textos de regra; versátil; labels da API |
| Detalhe armadura | CA / For / Furtividade / vestir | Custo, peso |
| Abas `/equipment` | Armas / Armaduras / Itens | OK como estrutura |

---

## 3. Taxonomia de erros

| ID | Tipo | Severidade | Onde | Sintoma |
|----|------|------------|------|---------|
| E1 | Conteúdo truncado | **Alta** | Seed gear (+ focus) | Meio da frase; regras de uso sumidas |
| E2 | Campo não exposto | **Alta** | API items | `properties` ausente no DTO |
| E3 | Join não feito | **Alta** | API weapons | Sem name/description de property/mastery |
| E4 | View incompleta | **Média** | `v_phb_armor` | Sem cost/weight |
| E5 | Modelagem incompleta | **Média** | Armas | Versátil / ranges faltantes |
| E6 | UI hardcode | **Média** | Front armas | Labels divergentes do DB; sem prosa |
| E7 | Duplicidade / drift | **Baixa** | tool `use_description` vs `item.description` | Duas fontes de verdade |
| E8 | Seed “não editar à mão” | **Processo** | `S046` etc. | Correção manual pode ser sobrescrita |
| E9 | Deploy DB | **Ops** | Prod (Supabase) | Seed/migration local ≠ produção |

---

## 4. Objetivo de produto

No compêndio, cada ficha de equipamento deve responder:

1. **O que é** (nome, tipo, custo, peso).
2. **Como se usa** (ação, alcance, CD, efeito) — em prosa PHB completa **ou** blocos estruturados equivalentes.
3. **Para armas:** cada propriedade e a maestria com **nome + descrição** vindos da API.
4. **Para armaduras:** tabela de CA completa + custo/peso.
5. **Para ferramentas:** atributo + uso (CD) + craft quando houver.

Dados de apresentação/mecânica vêm da **API** — o front não inventa regras nem traduz IDs quando o catálogo já tem nome oficial.

---

## 5. Desenho-alvo

### 5.1 Gear / focus — prioridade em texto completo

**Fase A (recomendada):** restaurar `phb_item.description` completo a partir do PHB 2024 PT-BR (fonte canônica do projeto).

Opcional depois (só se precisar filtrar/jogar regras na mesa):

```text
properties: {
  "actions": [
    { "kind": "use-object" | "attack" | "bonus-action", "summary": "..." }
  ],
  "checks": [{ "ability": "dex", "dc": 15, "context": "escapar" }],
  "damage": { "dice": "2d6", "type": "acid" }
}
```

Não bloquear a Fase A por isso: prosa completa já desbloqueia o compêndio.

### 5.2 Tools

Expor no `ItemResponseDto` (ou DTO de detalhe):

```ts
properties: {
  attribute?: string;      // ex. "dex"
  crafting?: unknown;
  variants?: unknown;
} | null
description: string | null
// opcional: useDescription da phb_tool se divergir
```

UI: faixa “Uso” + badge de atributo + craft.

### 5.3 Weapons — enriquecer resposta

Evoluir `WeaponResponseDto` (detalhe e lista) — **contrato atual**:

```ts
{
  // existente…
  versatileDamage: string | null;
  range: { normal: number | null; max: number | null } | null;
  propertyDetails: Array<{
    slug: string;
    name: string;
    description: string;
  }>;
  mastery: {
    slug: string;
    name: string;
    description: string;
  } | null;
}
```

Implementação atual: resolve `propertyIds` / `masteryId` / `range` / `versatileDamage` a partir do jsonb interno de `phb_item.properties` + tabelas `phb_weapon_property` / `phb_weapon_mastery`. **Não** expor o jsonb bruto na response.

Opcional futuro: joins via `phb_weapon_property_link` como fonte canônica e jsonb só como cache.

### 5.4 Armor — completar view/DTO

Estender `v_phb_armor` (migration `V0xx`):

- `cost` / `cost_text` (de `phb_item.cost`)
- `weight`
- opcional: `properties` jsonb

Mapper + front hero.

### 5.5 UI (padrão catálogo existente)

Alinhar a classes/talentos/magias:

- Hero com stats.
- Seção **Descrição / Uso** com `PhbProse`.
- Armas: `CollapsibleCard` por propriedade + card de maestria.
- Lista: teaser das primeiras ~120 chars da description **completa**.

---

## 6. Plano de execução (fases)

### Fase 0 — Inventário e processo (½–1 dia)

- [ ] Script que lista gear com `description` truncada (heurística: não termina em `.` / `!` / `?`, ou length &lt; N).
- [ ] Decidir pipeline do seed:
  - **Opção A:** migration `S07x_fix_item_descriptions.sql` com `UPDATE … WHERE slug =` (seguro p/ prod, não depende do gerador).
  - **Opção B:** regenerar `S046` a partir da fonte e documentar o gerador.
- [ ] Recomendação: **Opção A para conteúdo** + atualizar gerador depois (Opção B) para evitar regressão.
- [ ] Checklist de apply em **local + Supabase prod** ([`DEPLOY.md`](DEPLOY.md), skill `postgres-apply-catalog`).

### Fase 1 — Gear + focus: textos completos (2–4 dias)

Escopo por lotes (facilita review):

| Lote | Exemplos | Notas |
|------|----------|-------|
| 1.1 Consumíveis / ataque | ácido, fogo alquímico, água benta, óleo, veneno… | Ação Atacar, dano, área |
| 1.2 Usar Objeto / controle | corda, corrente, esferas, manacal, rede… | CD, condições |
| 1.3 Sobrevivência / utilidade | caixa para fogo, cobertor, cantil, ração, tenda… | Tempo / benefício |
| 1.4 Kits de aventureiro avulsos | kit de curandeiro, kit de escalada, lupa, lanterna… | Usos / Vantagem |
| 1.5 Contentores / resto | aljava, saca, estojo, balde… | Capacidade (muitos já ok) |
| 1.6 Focus | orbe, varinha, etc. | Completar truncados |

Entrega:

- [ ] Migration/seed de `UPDATE` das descriptions.
- [ ] Apply local; smoke `GET /items/:slug` para amostra (ácido, corda, caixa-para-fogo, kit-de-curandeiro).
- [ ] Front já consome `description` — validar UI sem mudança grande.
- [ ] Apply prod após review.

**Critério de aceite:** 0 gear/focus com description truncada pela heurística da Fase 0; detalhe mostra uso mecânico legível.

### Fase 2 — Tools na API + UI (1 dia)

- [ ] Expor `properties` (e alinhar `phb_tool.use_description` se necessário — uma fonte canônica).
- [ ] Detalhe de item tipo `tool`: atributo, uso, craft.
- [ ] Card da lista: teaser do uso (CD).
- [ ] Testes de mapper/query.

**Critério de aceite:** Ferramentas de Carpinteiro (etc.) mostram atributo + CD sem hardcode no front.

### Fase 3 — Armas: propriedades e maestria (1–2 dias)

- [ ] Queries/mappers: carregar properties + mastery com name/description.
- [ ] DTO enriquecido; Swagger atualizado.
- [ ] Entity `mastery_id` opcional se ajudar o join.
- [ ] Front: remover dependência de `weapon-labels` para nomes oficiais; `PhbProse` / cards colapsáveis.
- [ ] Corrigir labels divergentes (fonte = DB).

**Critério de aceite:** Detalhe da Adaga lista Acuidade, Arremesso, Leve + maestria Ágil **com texto de regra**.

### Fase 4 — Armas: lacunas de modelagem (1 dia)

- [ ] Adicionar `versatileDamage` (coluna ou jsonb) p/ armas versáteis.
- [ ] Completar `range` faltante (zarabatana etc.).
- [ ] Expor no DTO + UI (stat “Versátil” / alcance).
- [ ] Seeds + testes.

### Fase 5 — Armaduras: custo/peso (½–1 dia)

- [ ] Migration view `v_phb_armor` + entity + DTO.
- [ ] Front hero: Custo, Peso.
- [ ] Smoke lista/detalhe.

### Fase 6 — Polimento do hub e QA (½–1 dia)

- [ ] Teasers consistentes nas 3 abas.
- [ ] Empty states (“Sem descrição”) só quando genuinamente vazio.
- [ ] Busca `q` já cobre name/slug — avaliar buscar também em description (opcional).
- [ ] Checklist manual (abaixo).
- [ ] Commit + push + apply prod.

---

## 7. Checklist de QA (manual)

### Gear

- [ ] Ácido — ataque, dano, efeito
- [ ] Corda — Usar Objeto + CD
- [ ] Caixa para Fogo — como acende / tempo
- [ ] Kit de Curandeiro — usos
- [ ] Esferas de Metal — área / CD
- [ ] Cadeado — abrir sem chave

### Tools

- [ ] Uma ferramenta artesão — atributo + CD
- [ ] Instrumento / kit de ladrão se existirem no seed

### Armas

- [ ] Adaga — 3 propriedades + maestria com texto
- [ ] Espada Longa — versátil (após Fase 4)
- [ ] Arco Longo — alcance + munição texto

### Armaduras

- [ ] Couro — CA + custo + peso
- [ ] Talas / plate — Força + desvantagem furtividade

### Regressão

- [ ] Inventário da ficha / `ItemPicker` continua ok com DTO estendido
- [ ] Paginação/busca `/equipment` intactas

---

## 8. Fora de escopo (neste plano)

- Simular efeitos na **mesa** (aplicar ácido no combate, gastar uso do kit) — isso é game loop, ver `game-advanced-plan.md`.
- Magia / itens mágicos além do PHB básico.
- Reescrever todo o gerador automático de seeds antes da Fase 1 (só documentar + migration de conteúdo).
- Traduções alternativas; fonte = PT-BR do catálogo já usado no projeto.

---

## 9. Riscos e mitigações

| Risco | Mitigação |
|-------|-----------|
| Seed regenerado apaga `UPDATE` manuais | Migration versionada `S07x` / `U07x` + atualizar gerador |
| Texto PHB longo demais no jsonb | Preferir `description` TEXT; jsonb só para filtros |
| Payload de lista de armas pesado | Enriquecer **detalhe**; lista pode continuar com IDs + names curtos |
| Prod sem migration | Checklist apply Supabase no mesmo PR/release |
| Divergência front hardcode × DB | Remover hardcode na mesma PR da Fase 3 |

---

## 10. Ordem sugerida de PRs

1. **api:** migration descriptions gear (lote 1.1–1.3) + apply notes  
2. **api+front:** tools `properties` + UI  
3. **api+front:** weapon properties/mastery enriched DTO + UI  
4. **api+front:** versatile/range + armor cost/weight  
5. **api:** restantes lotes de description + QA  

Cada PR deve ser deployável e melhorar algo visível no compêndio.

---

## 11. Definição de pronto (épico)

- [ ] Nenhum gear/focus do seed com description truncada (heurística automatizada no CI ou script documentado).
- [ ] Detalhe de item mostra uso mecânico completo quando o PHB tem.
- [ ] Tools expõem atributo/uso via API.
- [ ] Armas mostram propriedades e maestria com texto oficial da API.
- [ ] Armaduras mostram custo e peso.
- [ ] Sem labels de regra hardcoded no front para esses catálogos.
- [ ] Local + produção com o mesmo conteúdo aplicado.

---

## 12. Próximo passo imediato

Começar pela **Fase 0** (script de truncados + decisão Opção A migration) e em seguida **Fase 1 lote 1.1** (consumíveis: ácido etc.) — maior impacto visual no problema reportado (“internamente não aparece nada” / uso mecânico).
