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
| Guardião | `ranger` | `[x]` feito |
| Ladino | `rogue` | `[x]` feito |
| Mago | `wizard` | `[ ]` |
| Monge | `monk` | `[x]` feito |
| Paladino | `paladin` | `[x]` feito |

**Progresso:** 7 feitas · **6** por conferir (PHB) + subclasses Valda das classes não feitas.

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

O Dado de Superioridade só é rolado/gasto pela ação de manobra; o resultado entra
no dano manualmente, então não existe um segundo caminho na rolagem de dano.

Fora de escopo de propósito: controlar 1×/turno, rastrear alvo, posição,
condições do inimigo ou Regeneração como tick automático.

Subclasses PHB: Campeão, Cavaleiro Místico, Combatente Psíquico, Mestre da Batalha  
Valda: Explorador de Masmorras (`dungeoneer`)

### Ladino (`rogue`) — `[x]`

- [x] Base: Ataque Furtivo, Golpe Astuto, Mira Firme, Esquiva Sobrenatural, Evasão, Talento Confiável, Mente Escorregadia e Golpe de Sorte
- [x] Adaga Espiritual: dados psiônicos, aptidão, sussurros, lâminas, teleguiado, teleporte, véu e Rasgar Mente
- [x] Assassino: iniciativa, Assassinar, dano surpresa, veneno e Golpe Mortal
- [x] Ladrão: Mão Leve no catálogo, Ataque Escondido, cargas de item mágico e notas de mesa
- [x] Trapaceiro Arcano: conjuração de 1/3, Mãos Mágicas e Ladrão de Magias
- [x] Perseguidor Aracnídeo: Golpe Venenoso, Correia/Teia, Sentido de Aranha e Paralisar
- [x] UI: painel, toggles de ataque/dano/perícia/salvaguarda e atualização de recursos

Fora de escopo de propósito: persistir alvo/turno, posição, duração de condições,
invisibilidade ou limite de uma vez por turno. A ficha rola, gasta recursos e
descreve o efeito que jogador e Mestre aplicam na mesa.

### Monge (`monk`) — `[x]`

- [x] Base: Artes Marciais (Ataque Desarmado sintético, dado 1d6→1d12, melhor de FOR/DES sem armadura/escudo), Ataque Extra, Movimento sem Armadura, Evasão e Sobrevivente Disciplinado (proficiência em todas as salvaguardas)
- [x] Foco: Torrente de Golpes, Defesa Paciente, Passo do Vento e Golpe Atordoante (CD 8 + SAB + PB) gastando Pontos de Foco
- [x] Mão Espalmada: Técnica da Mão Espalmada (CD de Caído/empurrão)
- [x] Combatente dos Elementos: Explosão Elemental à distância com o dado de Artes Marciais
- [x] Misericórdia: Mão de Cura e Mão de Dolo (SAB + dado de Artes Marciais)
- [x] Combatente das Sombras: Passo da Sombra
- [x] Guerreiro das Ruas (Valda): notas de mesa
- [x] UI: `combat-monk-panel`, Ataque Desarmado nas Ações e atualização de Foco

O catálogo já trazia `focusPoints` (máx = nível, recupera em curto/longo) e a Defesa
sem Armadura DES+SAB; o dado de Artes Marciais e a CD de Foco vivem no código.

Fora de escopo de propósito: rastrear 1×/turno da Mão de Dolo, posição do teleporte,
duração das condições e restauração automática de Foco na iniciativa.

---

### Paladino (`paladin`) — `[x]`

- [x] Base: Mãos Consagradas (reserva = 5 × nível, com Curar Veneno por 5 PV), Ataque Extra, Aura de Proteção (+CAR nas salvaguardas, 9 m no nível 18) e Golpes Radiantes (+1d8 Radiante corpo a corpo no nível 11)
- [x] Destruição Divina (Divine Smite): gasta um espaço de magia na rolagem de dano para +2d8 Radiante (+1d8 por círculo acima do 1º; +1d8 vs Corruptor/Morto-vivo), debitando o slot no estado
- [x] Canalizar Divindade: Sentido Divino, Repudiar Inimigos (CD 8 + CAR + PB) e a opção do juramento gastando usos de Canalizar
- [x] Devoção, Glória, Anciões e Vingança: notas de mesa e nome/efeito da Canalizar do juramento
- [x] Valda: Juramento da Folia (`oath-of-revelry`) — notas de mesa
- [x] UI: `combat-paladin-panel`, seletor de Golpe Divino no card de ataque e reservas de cura/Canalizar

O catálogo já trazia a progressão half-caster (CAR) e `channelDivinity`; a reserva de
Mãos Consagradas usa o recurso `layOnHands` com máximo = 5 × nível ajustado no runtime.

Fora de escopo de propósito: alcance/alvos das auras, duração de Voto de Inimizade e
demais efeitos de 1 minuto, e persistência de quem está dentro da aura.

---

### Guardião (`ranger`) — `[x]`

- [x] Base: Inimigo Favorito (usos gratuitos de Marca do Predador = PB), Ataque Extra, Errante (+3 m), Incansável (1d8 + SAB PV temporários), Véu da Natureza, Caçador Preciso (vantagem vs marcado) e Matador de Inimigos Favoritos (dado d10)
- [x] Marca do Predador: cast gratuito com concentração + toggle de dano 1d6/1d10 no acerto
- [x] Caçador: Assassino de Colossos (+1d8) e notas de Hordas/Defesas
- [x] Andarilho Feérico: Golpes Terríveis (+1d4/+1d6), Reforços Feéricos e Andarilho Nebuloso
- [x] Vigilante das Sombras: +SAB na Iniciativa, Golpe Terrível (+2d6/+2d8 gastando uso) e notas
- [x] Senhor das Feras: nota de Companheiro Primal / comandar a fera
- [x] UI: `combat-ranger-panel`, toggles de Marca/Colossos/Terríveis e botão de Golpe Terrível

Recursos novos de classe: `favoredEnemy`, `tireless`, `naturesVeil`. Subclasses já tinham
`dread-strike`, `fey-reinforcements` e `misty-wanderer` no catálogo.

Fora de escopo de propósito: estado do Companheiro Primal, rastrear 1×/turno, alcance do
Destruidor de Hordas e duração do Véu da Natureza além da nota de mesa.

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

### Mago (`wizard`) — `[ ]`

- [ ] Classe-base (grimório, preparação, recuperação arcana)
- [ ] Abjurador (`abjurer`)
- [ ] Adivinhador (`diviner`)
- [ ] Evocador (`evoker`)
- [ ] Ilusionista (`illusionist`)

---

## Ordem sugerida (próximas)

Marciais / half-casters costumam destravar a mesa mais rápido:

1. Clérigo  
2. Bardo  
3. Feiticeiro  
4. Bruxo  
5. Mago  
6. Druida  

Ajustar sob pedido da mesa.

---

## Como atualizar

1. Ao fechar uma classe: marcar `[x]` no resumo e nos checkboxes; anotar gaps em “parcial” se houver.
2. Gaps do Guerreiro: riscar aqui quando fechados (não só no chat).
3. Backlog geral da API: [`backlog.md`](backlog.md).
