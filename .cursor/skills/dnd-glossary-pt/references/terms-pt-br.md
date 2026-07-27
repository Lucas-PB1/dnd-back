# Termos PHB — PT-BR

| PT | EN | API path |
|----|-----|----------|
| Classe | Class | `/classes` |
| Subclasse | Subclass | `/subclasses` |
| Magia | Spell | `/spells` |
| Espécie | Species | `/species` |
| Antecedente | Background | `/backgrounds` |
| Talento | Feat | `/feats` |
| Perícia | Skill | `/skills` (+ nested em class/background) |
| Atributo | Ability | slugs `forca`, `destreza`, … |
| Armadura | Armor | `/armor` |
| Arma | Weapon | `/weapons` |
| Ferramenta | Tool | `/tools` |
| Item | Item | `/items` |
| Escola (magia) | Spell school | abjuração, evocação, … |
| Conjuração | Spellcasting | — |
| Traço (espécie) | Species trait | — |
| Estilo de luta | Fighting style | — |

## Exemplos de slug

| Recurso | slug API | name (PT) |
|---------|----------|-----------|
| Classe | `fighter` | Guerreiro |
| Classe | `wizard` | Mago |
| Magia | `bola-de-fogo` | Bola de Fogo |
| Espécie | `dwarf` | Anão |

## Atributos

| slug | nome |
|------|------|
| forca | Força |
| destreza | Destreza |
| constituicao | Constituição |
| inteligencia | Inteligência |
| sabedoria | Sabedoria |
| carisma | Carisma |

## Tendências / alinhamentos

Eixo de ordem: **Leal** (não Ordeiro), Neutro, Caótico. Eixo moral: Bom, Neutro, Mau.  
API: `GET /alignments` — slugs EN (`lawful-good`, …); `name` e abreviação em PT.

| slug | name | abbr |
|------|------|------|
| `lawful-good` | Leal e Bom | LB |
| `neutral-good` | Neutro e Bom | NB |
| `chaotic-good` | Caótico e Bom | CB |
| `lawful-neutral` | Leal e Neutro | LN |
| `true-neutral` | Neutro | N |
| `chaotic-neutral` | Caótico e Neutro | CN |
| `lawful-evil` | Leal e Mau | LM |
| `neutral-evil` | Neutro e Mau | NM |
| `chaotic-evil` | Caótico e Mau | CM |

## Classes e talentos (nomes PT)

| slug | name |
|------|------|
| `ranger` | Guardião |
| `artisan` (feat) | Artesão |

## Armaduras (exemplos)

| slug | name |
|------|------|
| `breastplate` | Couraça |
| `half-plate` | Meia-Placa |

## Condições

Preferir PT oficial: **Caído** (não `Prone`), Vantagem/Desvantagem, etc.

## Consistência

Preferir termos oficiais PHB 2024 PT-BR nos textos user-facing. Não inventar slug PT para classes (`guerreiro` ❌ → `fighter` ✅).
