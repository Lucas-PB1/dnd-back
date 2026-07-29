# Mecânica de classes — acompanhamento

Checklist da passagem **classe-base + subclasses** no padrão Pistoleiro / Bárbaro / Guerreiro:

1. Catálogo e recursos (fórmulas, recuperação)
2. Domínio puro + slice de combate / bônus nas rolagens
3. Ações e toggles que disparam **rolagem** ou gasto de recurso
4. Efeitos numéricos nas rolagens; o resto vira **nota** para a mesa
5. UI na ficha
6. Testes + migrate/seed

## Critério (mesa, não VTT)

**Não** é objetivo manter estado de jogo completo (turno a turno, posição no mapa, rastrear alvo, condições persistidas, “1× por turno” no servidor, etc.).

**É** objetivo: na ficha, **rolar como na mesa** — d20/dano/salvaguarda com os bônus certos, gastar o recurso quando a rolagem usa o poder, e devolver texto claro do que o jogador/Mestre aplica à mão.

| Faz | Não faz |
|-----|---------|
| Rolagem + modificadores + crítico | Simular o tabuleiro / iniciativa automática de todos |
| Gastar recurso quando a rolagem consome | Validar “já usei neste turno” |
| Nota: “mova metade do deslocamento”, “mesmo alvo” | Persistência de posição ou alvo |
| Toggle na UI (Furtivo, Golpe Psiônico, …) | Motor de condições/efeitos de duração |

**Critério “feito”:** recursos + rolagens + UI no padrão acima.

**Última revisão:** 2026-07-29

Legenda: `[x]` feito · `[~]` parcial · `[ ]` não conferido

---

## Resumo

| Classe | Slug | Status |
|--------|------|--------|
| Pistoleiro | `gunslinger` | `[x]` feito |
| Bárbaro | `barbarian` | `[x]` feito |
| Guerreiro | `fighter` | `[x]` feito |
| Bardo | `bard` | `[ ]` |
| Bruxo | `warlock` | `[ ]` |
| Clérigo | `cleric` | `[ ]` |
| Druida | `druid` | `[ ]` |
| Feiticeiro | `sorcerer` | `[ ]` |
| Guardião | `ranger` | `[ ]` |
| Ladino | `rogue` | `[ ]` |
| Mago | `wizard` | `[ ]` |
| Monge | `monk` | `[ ]` |
| Paladino | `paladin` | `[ ]` |

**Progresso:** 3 feitas · **10** por conferir (PHB) + subclasses Valda das classes não feitas.

---

## Feitas / parciais

### Pistoleiro (`gunslinger`) — `[x]`

- Domínio, risco, manobras, armas de fogo, UI (`combat-maneuvers-panel`)
- Subclasses: Olho Morto, Grande Apostador, Agente Secreto, Pistoleiro Arcano, Tiro de Trucagem, Chapéu Branco

### Bárbaro (`barbarian`) — `[x]`

- Fúria, Imprudente, recursos, subclasses PHB + painel UI
- Subclasses PHB: Árvore do Mundo, Berserker, Coração Selvagem, Fanático
- Valda: Mago Musculoso — conferir se entrou no mesmo pacote ou ficou só catálogo

### Guerreiro (`fighter`) — `[x]`

- [x] Base: Recuperar Fôlego, Mente Tática, Surto, Indomável e Ataques Estudados
- [x] Manobras BM: dado, gasto, CD, notas, Aparar/Reunir e Implacável
- [x] Combatente Psíquico: Golpe, Campo, Movimento, Salto, Resguardo, Baluarte e Mestre
- [x] Explorador de Masmorras: Chute, Matar Monstro e Precauções (5 usos)
- [x] Campeão e Cavaleiro Místico: bônus numéricos nas rolagens + notas de mesa
- [x] UI: ações/toggles e atualização dos recursos

Fora de escopo de propósito: controlar 1×/turno, rastrear alvo, posição,
condições do inimigo ou Regeneração como tick automático.

Subclasses PHB: Campeão, Cavaleiro Místico, Combatente Psíquico, Mestre da Batalha  
Valda: Explorador de Masmorras (`dungeoneer`)

---

## Não conferidas (PHB)

### Bardo (`bard`) — `[ ]`

- [ ] Classe-base (Inspiração Bárdica, etc.)
- [ ] Bravura (`valor`)
- [ ] Dança (`dance`)
- [ ] Conhecimento (`lore`)
- [ ] Glamour (`glamour`)

### Bruxo (`warlock`) — `[ ]`

- [ ] Classe-base (Magia de Pacto, Invocações)
- [ ] Arquifada (`archfey`)
- [ ] Celestial (`celestial`)
- [ ] Grande Antigo (`great-old-one`)
- [ ] Ínfero (`fiend`)
- [ ] Valda: Eu do Futuro (`future-you-patron`)

### Clérigo (`cleric`) — `[ ]`

- [ ] Classe-base (Canalizar Divindade, etc.)
- [ ] Vida (`life`)
- [ ] Luz (`light`)
- [ ] Trapaça (`trickery`)
- [ ] Guerra (`war`)

### Druida (`druid`) — `[ ]`

- [ ] Classe-base (Forma Selvagem, etc.)
- [ ] Terra (`land`)
- [ ] Lua (`moon`)
- [ ] Estrelas (`stars`)
- [ ] Mar (`sea`)

### Feiticeiro (`sorcerer`) — `[ ]`

- [ ] Classe-base (Pontos de Feitiçaria / Metamágica)
- [ ] Aberrante (`aberrant`)
- [ ] Dracônica (`draconic`)
- [ ] Mecânica (`clockwork`)
- [ ] Selvagem (`wild-magic`)

### Guardião (`ranger`) — `[ ]`

- [ ] Classe-base (Inimigo Favorito, etc. PHB 2024)
- [ ] Andarilho Feérico (`fey-wanderer`)
- [ ] Caçador (`hunter`)
- [ ] Senhor das Feras (`beast-master`)
- [ ] Vigilante das Sombras (`gloom-stalker`)

### Ladino (`rogue`) — `[ ]`

- [ ] Classe-base (Ataque Furtivo, Ação Astuta, Expertise)
- [ ] Adaga Espiritual (`soulknife`)
- [ ] Assassino (`assassin`)
- [ ] Ladrão (`thief`)
- [ ] Trapaceiro Arcano (`arcane-trickster`)
- [ ] Valda: Perseguidor Aracnídeo (`arachnoid-stalker`)

### Mago (`wizard`) — `[ ]`

- [ ] Classe-base (grimório, preparação, recuperação arcana)
- [ ] Abjurador (`abjurer`)
- [ ] Adivinhador (`diviner`)
- [ ] Evocador (`evoker`)
- [ ] Ilusionista (`illusionist`)

### Monge (`monk`) — `[ ]`

- [ ] Classe-base (Pontos de Foco, Artes Marciais, etc.)
- [ ] Elementos (`elements`)
- [ ] Mão Espalmada (`open-hand`)
- [ ] Misericórdia (`mercy`)
- [ ] Sombras (`shadow`)
- [ ] Valda: Guerreiro das Ruas (`warrior-of-the-street`)

### Paladino (`paladin`) — `[ ]`

- [ ] Classe-base (Canalizar, Imposição das Mãos, Aura, etc.)
- [ ] Anciões (`ancients`)
- [ ] Devoção (`devotion`)
- [ ] Glória (`glory`)
- [ ] Vingança (`vengeance`)
- [ ] Valda: Juramento da Folia (`oath-of-revelry`)

---

## Ordem sugerida (próximas)

Marciais / half-casters costumam destravar a mesa mais rápido:

1. Ladino  
2. Monge  
3. Paladino  
4. Guardião  
5. Clérigo  
6. Bardo  
7. Feiticeiro  
8. Bruxo  
9. Mago  
10. Druida  

Ajustar sob pedido da mesa.

---

## Como atualizar

1. Ao fechar uma classe: marcar `[x]` no resumo e nos checkboxes; anotar gaps em “parcial” se houver.
2. Gaps do Guerreiro: riscar aqui quando fechados (não só no chat).
3. Backlog geral da API: [`backlog.md`](backlog.md).
