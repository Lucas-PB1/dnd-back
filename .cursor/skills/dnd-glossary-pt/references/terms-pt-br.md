# Termos PHB — PT-BR

Fonte de verdade de nomes oficiais: `docs/Glossário de Termos Traduzidos V. 5.1.26.xlsx` (Livro do X). Em conflito com convenção antiga do repo, prevalece o glossário.

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

## Classes (glossário)

| slug | name |
|------|------|
| `barbarian` | Bárbaro |
| `bard` | Bardo |
| `cleric` | Clérigo |
| `druid` | Druida |
| `fighter` | Guerreiro |
| `monk` | Monge |
| `paladin` | Paladino |
| `ranger` | Patrulheiro (override de mesa; glossário Livro do X traz Guardião) |
| `rogue` | Ladino |
| `sorcerer` | Feiticeiro |
| `warlock` | Bruxo |
| `wizard` | Mago |

## Termos que já causaram drift (usar estes)

| EN | PT correto | Evitar |
|----|------------|--------|
| Bardic Inspiration | Inspiração de Bardo | Inspiração Bárdica |
| Cutting Words | Palavras de Interrupção | Palavras Cortantes |
| Step of the Wind | Passos do Vento | Passo do Vento |
| Divine Spark | Centelha Divina | Centelha: … |
| Inspiring Movement | Movimento Inspirador | Resposta Ágil |
| Coordinated Movement | Movimento Coordenado | Gingado Coordenado |
| Innate Sorcery | Feitiçaria Inata | Ira Feiticeira |
| Metamagic | Metamagia | Metamágica |
| Healing Light | Luz Medicinal | Luz Curativa |
| Tides of Chaos | Marés do Caos | Maré de Caos |
| Bastion of Law | Bastião da Lei | Baluarte da Ordem |
| Ranger | **Patrulheiro** (override de mesa) | Guardião (Livro do X) |

## Armaduras (exemplos)

| slug | name |
|------|------|
| `breastplate` | Couraça |
| `half-plate` | Meia-Placa |

## Condições

Preferir PT oficial: **Caído** (não `Prone`), Vantagem/Desvantagem, etc.

## Consistência

Preferir termos do glossário Livro do X nos textos user-facing. Não inventar slug PT para classes (`guerreiro` ❌ → `fighter` ✅).
