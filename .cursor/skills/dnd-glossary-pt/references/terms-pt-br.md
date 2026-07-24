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

## Consistência

Preferir termos oficiais PHB 2024 PT-BR nos textos user-facing. Não inventar slug PT para classes (`guerreiro` ❌ → `fighter` ✅).
