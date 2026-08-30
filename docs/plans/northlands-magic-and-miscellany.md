# Northlands — Cap. 5 Magic and Miscellany (extração)

Fonte: extrato Cap. 5 (`docs/source/extracts/northlands/cap5.json`; scrape Beyond descartado após seed).
Edição: `northlands-heroes-2024-en`.
JSON máquina: [`docs/source/extracts/northlands/cap5.json`](../source/extracts/northlands/cap5.json) (86 itens, 78 magias).

## Status seeds

| Bloco | Seed | Status |
|-------|------|--------|
| Citação Cap. 5 | `N001` | feito |
| Mastery Pull + 7 armas | `N025` | feito |
| 4 armaduras + 7 gear (+ Talharpa) | `N028` | feito |
| 78 magias + listas (PT) | `N026`/`N027` + overlay `northlands-cap5-spells-pt.json` | feito |
| 86 itens mágicos (PT) | `N029` + overlay `northlands-cap5-magic-items-pt.json` | feito |
| Espírito Curador (XGE) | `N024` + Spirit Caller L5 | feito |
| Masterwork (cobertura) | `N034` | feito — attach `bonus=1` |
| Montarias / trenós / longships | `M003` + `N037` | feito — templates + itens de transporte (slug alinhado) |
| Bestiário Cap. 5 + Leviathan Avatar | `M004` | feito — inclui summon `leviathan-avatar` |

## Contagens

| Bloco | Qtd |
|-------|-----|
| Armas novas (tabela) | 7 |
| Itens mágicos (descrições) | 86 |
| Magias (descrições) | 78 |
| Entradas em spell lists | 208 (`N027`; “209” era falso alarme) |

## Equipment (resumo)

### Masterwork

Masterwork: +1 attack/damage if proficient; cost = base + 300 gp; ammo 5 gp.  
Armas mágicas já são qualidade obra-prima (podem receber a cobertura); o +1 **não se soma** aos bônus mágicos.  
No catálogo: cobertura anexável (`kind:coverage`, `masterwork:true`, `requiresTierBonus:true`); attach com `bonus=1`.

### Mastery — Pull

If you hit a creature with this weapon, you can pull the creature 5 feet toward yourself if it is Large or smaller. When you do so, you can also move back 5 feet without provoking Opportunity Attacks, and this does not use any of your normal movement speed.

### Armas

| Nome | Dano | Props | Mastery | Peso | Custo |
|------|------|-------|---------|------|-------|
| Seax | 1d4 Piercing | Finesse , Light | Graze | 2 lb. | 1 GP |
| Snaerispear | 1d6 Piercing | Finesse , Thrown (1d8, range 30/90) | Slow | 2 lb. | 5 GP |
| Atgeir | 1d10 Piercing | Heavy , Reach , Two-Handed | Pull | 7 lb. | 25 GP |
| Bearded Axe | 1d10 Slashing | Heavy , Versatile (1d12) | Cleave | 6 lb. | 30 GP |
| Breidox | 1d10 Slashing | Heavy , Reach , Two-Handed | Topple | 11 lb. | 45 GP |
| Bryntroll | 1d10 Slashing | Heavy , Reach , Two-Handed | Slow | 7 lb. | 35 GP |
| Ulfberht Blade | 1d8 Slashing | Versatile (1d10) | Graze , Sap | 3 lb. | 350 GP |

Armaduras / gear / montarias / longships: texto completo no JSON (`equipment.armorNotes`, `adventuringGearNotes`, `mountsNotes`, `longshipsNotes`). Inclui Beinagrind, Double Mail, Hardened Mail Shirt, Walrus Hide; Dog Sled / Ogre War Sled; Drakkar, Karvi, Knarr, Skeid, Snekkja.

## Magic items

| Nome | Slug | Raridade | Attune |
|------|------|----------|--------|
| Antlered Headband of Chernobog | `antlered-headband-of-chernobog` | Legendary (Requires Attunement by a Bard, Paladin, Sorcerer, or Warlock) | sim |
| Arm Ring of Self-Sacrifice | `arm-ring-of-self-sacrifice` | Rare (Requires Attunement) | sim |
| Arrow of Ice-Trapping | `arrow-of-ice-trapping` | Rare | — |
| Ashbraid | `ashbraid` | Very Rare (Requires Attunement) | sim |
| Bell-Ringing Greatclub | `bell-ringing-greatclub` | Uncommon | — |
| Belt of the Berserker | `belt-of-the-berserker` | Rare (Requires Attunement by a Barbarian with the Reckless Attack Class Feature) | sim |
| Berserker’s Mead | `berserkers-mead` | Rare | — |
| Blade of Insults | `blade-of-insults` | Rare (Requires Attunement by a Bard) | sim |
| Bygul’s Paw Boots | `byguls-paw-boots` | Uncommon | — |
| Cloak of Wide-Ranging | `cloak-of-wide-ranging` | Common | — |
| Defender Honey | `defender-honey` | Uncommon | — |
| Einherjar’s Drinking Horn | `einherjars-drinking-horn` | Uncommon | — |
| Feather Token | `feather-token` | Uncommon | — |
| Glacierpress Boots | `glacierpress-boots` | Very Rare | — |
| Goggles of Snowsight | `goggles-of-snowsight` | Uncommon | — |
| Goggles of Tracking | `goggles-of-tracking` | Uncommon | — |
| The Grave Blade | `the-grave-blade` | Fabled (5th-level and higher properties require attunement) | sim |
| Hel’s Coin | `hels-coin` | Common | — |
| Hjartarydi’s Belt | `hjartarydis-belt` | Uncommon | — |
| Hollow Eye | `hollow-eye` | Rare (Requires Attunement) | sim |
| Honey of the Hearth Fire | `honey-of-the-hearth-fire` | Uncommon | — |
| Honey of the Hive Warden | `honey-of-the-hive-warden` | Very Rare | — |
| Honey of the Norn-Blessed | `honey-of-the-norn-blessed` | Rare | — |
| Honey of Robust Health | `honey-of-robust-health` | Common | — |
| Honey of the Sacred Bear | `honey-of-the-sacred-bear` | Rare | — |
| Honey of the Skald’s Tongue | `honey-of-the-skalds-tongue` | Rare | — |
| Horn of Battle’s Call | `horn-of-battles-call` | Rare | — |
| Horn of the Hrimthursar | `horn-of-the-hrimthursar` | Rare | — |
| Horn of the Wild Hunt | `horn-of-the-wild-hunt` | Legendary | — |
| Icebreaker Axe | `icebreaker-axe` | Rare | — |
| Iced Steel Armor | `iced-steel-armor` | Uncommon | — |
| Iced Steel Weapon | `iced-steel-weapon` | Common | — |
| Incendiary Coal | `incendiary-coal` | Rare | — |
| Iron Traitor’s Arm Ring | `iron-traitors-arm-ring` | Very Rare | — |
| Kempdomr Axe | `kempdomr-axe` | Rare (Requires Attunement) | sim |
| Laekning Shield | `laekning-shield` | Uncommon | — |
| Mug of Friendship | `mug-of-friendship` | Common | — |
| Nine-Escape Knot | `nine-escape-knot` | Rare | — |
| Northlander’s Boots | `northlanders-boots` | Common (Requires Attunement) | sim |
| Ottaveggr Talharpa | `ottaveggr-talharpa` | Common | — |
| Potion of Near-Death Portent | `potion-of-near-death-portent` | Very Rare | — |
| Prismatic Ammunition | `prismatic-ammunition` | Uncommon | — |
| Prismatic Steel Armor | `prismatic-steel-armor` | Uncommon | sim |
| Prismatic Steel Weapon | `prismatic-steel-weapon` | Very Rare (Requires Attunement) | sim |
| Rage Hammer | `rage-hammer` | Uncommon (Requires Attunement by a Barbarian) | sim |
| Ravenflight Axe | `ravenflight-axe` | Uncommon (Requires Attunement) | sim |
| Reaver’s Lodestone | `reavers-lodestone` | Uncommon | — |
| Ring of the Cragtop Jarl (Jarlpact) | `ring-of-the-cragtop-jarl-jarlpact` | Very Rare (Requires Attunement) | sim |
| Ring of the Diving Bird | `ring-of-the-diving-bird` | Uncommon | — |
| Ring of the Forgefire Jarl (Jarlpact) | `ring-of-the-forgefire-jarl-jarlpact` | Very Rare (Requires Attunement) | sim |
| Ring of the Glacial Jarl (Jarlpact) | `ring-of-the-glacial-jarl-jarlpact` | Very Rare (Requires Attunement) | sim |
| Ring of Hospitality | `ring-of-hospitality` | Common | — |
| Ring of Ice-Shielding | `ring-of-ice-shielding` | Rare (Requires Attunement) | sim |
| Ring of Surtr | `ring-of-surtr` | Uncommon | — |
| Ring of the Tempest Jarl (Jarlpact) | `ring-of-the-tempest-jarl-jarlpact` | Legendary (Requires Attunement) | sim |
| Rod of Frostbite | `rod-of-frostbite` | Rare (Requires Attunement by a Spellcaster) | sim |
| Rostungr Armor | `rostungr-armor` | Very Rare | — |
| Rumbling Hammer | `rumbling-hammer` | Common (Requires Attunement) | sim |
| Salt of Thawing | `salt-of-thawing` | Common | — |
| Sail of Favorable Winds | `sail-of-favorable-winds` | Uncommon | — |
| Sealskin Armor | `sealskin-armor` | Uncommon (Requires Attunement) | sim |
| Seidr Rune Necklace | `seidr-rune-necklace` | Rare (Requires Attunement) | sim |
| Serpent Fin Oars | `serpent-fin-oars` | Uncommon | — |
| Shadow Blade | `shadow-blade` | Rare (Requires Attunement) | sim |
| Shield of the World Serpent | `shield-of-the-world-serpent` | Very Rare (Requires Attunement) | sim |
| Skinchanger Arm Ring | `skinchanger-arm-ring` | Fabled (5th-level and higher properties require attunement) | sim |
| Slip-Bane Bracelet | `slip-bane-bracelet` | Common | — |
| Songsteel Armor | `songsteel-armor` | Uncommon | — |
| Songsteel Shield | `songsteel-shield` | Uncommon | — |
| Songsteel Weapon | `songsteel-weapon` | Uncommon | — |
| Snowbirds | `snowbirds` | Uncommon | — |
| Storrbani | `storrbani` | Fabled (5th-level and higher properties require attunement) | sim |
| Stormbinder’s Cloak | `stormbinders-cloak` | Legendary (Requires Attunement) | sim |
| Stormhook | `stormhook` | Rare (Requires Attunement) | sim |
| Stormhorn | `stormhorn` | Rare | — |
| Sustaining Belt | `sustaining-belt` | Common | — |
| Tireless Armor | `tireless-armor` | Rare (Requires Attunement) | sim |
| Tireless Rower | `tireless-rower` | Very Rare | — |
| Titancall Dagger | `titancall-dagger` | Legendary (Requires Attunement) | sim |
| Tordalfr’s Rebuttal | `tordalfrs-rebuttal` | Fabled (5th-level and higher properties require attunement) | sim |
| Trollkin Unguent | `trollkin-unguent` | Rare | — |
| Tyr’s Crushing Might | `tyrs-crushing-might` | Rare | — |
| Valhallan Armor | `valhallan-armor` | Rare (Requires Attunement) | sim |
| Warrior Honey | `warrior-honey` | Common | — |
| Warhammer of Giant Felling | `warhammer-of-giant-felling` | Very Rare | — |
| Winged Helm of Wisdom | `winged-helm-of-wisdom` | Very Rare (Requires Attunement) | sim |

Corpo completo de cada item: campo `body` no JSON.

## Spells

### Listas por classe (nomes)

#### bard

- **1º:** Freyja’s Allure; Freyja’s Grace; Drummer’s Cadence; Inbar’s Giant-Friend; Shield-Maiden’s Favor; Speechmaster’s Rune; Trickster’s Bluff
- **2º:** Call to Action; Infectious Skal; Melody of Sheltered Rest; Sailor’s Shanty; Thought Rune; Wotan’s Retribution
- **3º:** Bergelmir’s Provocation; Luckfingers; Murmurs of Doom; Shared Expertise; Sif’s Grace; Trollblood Infusion
- **4º:** Ode to Wrath; Pawn of the Wyrd; Skaldic Scolding; Song of the Shield Wall; Valhalla’s Cohort
- **5º:** Bearstormer; Bragi’s Theatrical Fall; Regenerative Hull

#### cleric

- **1º:** Freyja’s Allure; Ice Shape; Shield-Maiden’s Favor; Trickster’s Bluff
- **2º:** Disrupt the Wyrd; Glimpse the Wyrd; Reaver’s Rune; Reinforce Hull; Thought Rune; Valkyrie’s Vision; Wotan’s Retribution
- **3º:** Compel Avarice; Protection Rune; Sif’s Grace; Trollblood Infusion; Truth’s Blade; Valkyrie’s Guidance; Weave Detonation
- **4º:** Angrboda’s Fury; Beseech the Norns; Claws of the Bear; Ghostly Crew; Hearthfire; Noble Sacrifice; Pawn of the Wyrd; Song of the Shield Wall; Valhalla’s Cohort
- **5º:** Bound Fortunes; Bragi’s Theatrical Fall; Regenerative Hull
- **6º:** Sun Rune; Ensnared Threads
- **8º:** Awaken Ship Guardian; Jotun Form
- **9º:** Beast of Ragnarok; Wyrd Sight

#### druid

- **Cantrip:** Aegir’s Breath
- **1º:** Coldheart; Extinguish; Ice Shape; Icewalker; Talons of the Eagle
- **2º:** Aspect of the Narwhal; Billowing Sails; Encase in Ice; Eyes of the Raven; Melody of Sheltered Rest; Reinforce Hull
- **3º:** Freezing Fog; Repair Hull; Trollblood Infusion; Wall of Snow
- **4º:** Claws of the Bear; Earthsail; Fiery Siege; Pawn of the Wyrd
- **5º:** Bearstormer; Branch and Root of Yggdrasil; Regenerative Hull; Whiteout
- **6º:** Hungry Jaws of Fenris; Sun Rune; Ensnared Threads
- **7º:** Summon Leviathan Avatar
- **8º:** Awaken Ship Guardian
- **9º:** Beast of Ragnarok; Wyrd Sight

#### paladin

- **1º:** Freyja’s Grace; Shield-Maiden’s Favor; Trickster’s Bluff
- **2º:** Call to Action; Reaver’s Rune; Valkyrie’s Vision
- **3º:** Bone-Chilling Smite; Sif’s Grace; Truth’s Blade; Valkyrie’s Guidance
- **4º:** Fiery Siege; Noble Sacrifice; Pawn of the Wyrd; Song of the Shield Wall; Storm Maiden’s Edge; Valhalla’s Cohort

#### ranger

- **1º:** Extinguish; Icewalker; Shield-Maiden’s Favor
- **2º:** Billowing Sails; Giantbane; Giantdodge; Valkyrie’s Vision
- **3º:** Repair Hull; Shared Expertise; Wall of Snow
- **4º:** Claws of the Bear; Hearthfire; Pawn of the Wyrd; Storm Maiden’s Edge
- **5º:** Fenris’s Howl

#### sorcerer

- **Cantrip:** Aegir’s Breath
- **1º:** Extinguish; Freyja’s Allure; Freyja’s Grace; Ice Shape; Inbar’s Giant-Friend
- **2º:** Aspect of the Narwhal; Billowing Sails; Encase in Ice; Wotan’s Retribution
- **3º:** Bergelmir’s Provocation; Compel Avarice; Giant’s Teeth; Luckfingers; Protection Rune; Repair Hull; Weave Detonation
- **4º:** Angrboda’s Fury; Earthsail; Fiery Siege; Fist of the Frost Jarl; Ghostly Crew; Hearthfire; Pawn of the Wyrd
- **5º:** Bearstormer; Bragi’s Theatrical Fall; Regenerative Hull; Whiteout
- **6º:** Sun Rune; Ensnared Threads
- **7º:** Summon Leviathan Avatar
- **8º:** Jotun Form

#### warlock

- **Cantrip:** Aegir’s Breath
- **1º:** Freyja’s Grace; Inbar’s Giant-Friend; Loki’s Escape; Trickster’s Bluff
- **2º:** Glimpse the Wyrd; Wotan’s Retribution
- **3º:** Bergelmir’s Provocation; Murmurs of Doom; Sif’s Grace; Trollblood Infusion
- **4º:** Fist of the Frost Jarl; Pawn of the Wyrd
- **5º:** Bragi’s Theatrical Fall
- **9º:** Beast of Ragnarok; Wyrd Sight

#### wizard

- **Cantrip:** Aegir’s Breath
- **1º:** Extinguish; Freyja’s Allure; Ice Shape; Pawn of the Wyrd; Speechmaster’s Rune
- **2º:** Aspect of the Narwhal; Billowing Sails; Encase in Ice; Fire Rune; Reaver’s Rune; Reinforce Hull; Wotan’s Retribution
- **3º:** Bergelmir’s Provocation; Compel Avarice; Giant’s Teeth; Luckfingers; Protection Rune; Repair Hull; Thought Rune; Weave Detonation
- **4º:** Angrboda’s Fury; Earthsail; Fiery Siege; Fist of the Frost Jarl; Ghostly Crew; Hearthfire
- **5º:** Bearstormer; Bragi’s Theatrical Fall; Regenerative Hull; Whiteout
- **6º:** Sun Rune; Ensnared Threads
- **7º:** Summon Leviathan Avatar
- **8º:** Jotun Form
- **9º:** Beast of Ragnarok

### Descrições (índice)

| Nome | Slug | Nível | Escola | Classes |
|------|------|-------|--------|---------|
| Aegir’s Breath | `aegirs-breath` | 0 | Evocation | druid, sorcerer, warlock, wizard |
| Angrboda’s Fury | `angrbodas-fury` | 4 | Transmutation | cleric, sorcerer, wizard |
| Aspect of the Narwhal | `aspect-of-the-narwhal` | 2 | Transmutation | druid, sorcerer, wizard |
| Awaken Ship Guardian | `awaken-ship-guardian` | 8 | Conjuration | cleric, druid |
| Bearstormer | `bearstormer` | 5 | Illusion | bard, druid, sorcerer, wizard |
| Beast of Ragnarok | `beast-of-ragnarok` | 9 | Conjuration | cleric, druid, warlock, wizard |
| Bergelmir’s Provocation | `bergelmirs-provocation` | 3 | Enchantment | bard, sorcerer, warlock, wizard |
| Beseech the Norns | `beseech-the-norns` | 4 | Divination | cleric |
| Billowing Sails | `billowing-sails` | 2 | Evocation | druid, ranger, sorcerer, wizard |
| Bone-Chilling Smite | `bone-chilling-smite` | 3 | Necromancy | paladin |
| Bound Fortunes | `bound-fortunes` | 5 | Necromancy | cleric |
| Bragi’s Theatrical Fall | `bragis-theatrical-fall` | 5 | Illusion | bard, cleric, sorcerer, warlock, wizard |
| Branch and Root of Yggdrasil | `branch-and-root-of-yggdrasil` | 5 | Conjuration | druid |
| Call to Action | `call-to-action` | 2 | Enchantment | bard, paladin |
| Claws of the Bear | `claws-of-the-bear` | 4 | Transmutation | cleric, druid, ranger |
| Coldheart | `coldheart` | 1 | Necromancy | druid |
| Compel Avarice | `compel-avarice` | 3 | Enchantment | cleric, sorcerer, wizard |
| Disrupt the Wyrd | `disrupt-the-wyrd` | 2 | Abjuration | cleric |
| Drummer’s Cadence | `drummers-cadence` | 1 | Enchantment | bard |
| Earthsail | `earthsail` | 4 | Transmutation | druid, sorcerer, wizard |
| Encase in Ice | `encase-in-ice` | 2 | Conjuration | druid, sorcerer, wizard |
| Ensnared Threads | `ensnared-threads` | 6 | Divination | cleric, druid, sorcerer, wizard |
| Extinguish | `extinguish` | 1 | Transmutation | druid, ranger, sorcerer, wizard |
| Eyes of the Raven | `eyes-of-the-raven` | 2 | Transmutation | druid |
| Fenris’s Howl | `fenriss-howl` | 5 | Necromancy | ranger |
| Fiery Siege | `fiery-siege` | 4 | Transmutation | druid, paladin, sorcerer, wizard |
| Fire Rune | `fire-rune` | 2 | Evocation | wizard |
| Fist of the Frost Jarl | `fist-of-the-frost-jarl` | 4 | Evocation | sorcerer, warlock, wizard |
| Freezing Fog | `freezing-fog` | 3 | Transmutation | druid |
| Freyja’s Allure | `freyjas-allure` | 1 | Enchantment | bard, cleric, sorcerer, wizard |
| Freyja’s Grace | `freyjas-grace` | 1 | Abjuration | bard, paladin, sorcerer, warlock |
| Ghostly Crew | `ghostly-crew` | 4 | Necromancy | cleric, sorcerer, wizard |
| Giantbane | `giantbane` | 2 | Transmutation | ranger |
| Giantdodge | `giantdodge` | 2 | Abjuration | ranger |
| Giant’s Teeth | `giants-teeth` | 3 | Conjuration | sorcerer, wizard |
| Glimpse the Wyrd | `glimpse-the-wyrd` | 2 | Divination | cleric, warlock |
| Hearthfire | `hearthfire` | 4 | Abjuration | cleric, ranger, sorcerer, wizard |
| Hungry Jaws of Fenris | `hungry-jaws-of-fenris` | 6 | Transmutation | druid |
| Ice Shape | `ice-shape` | 1 | Conjuration | cleric, druid, sorcerer, wizard |
| Icewalker | `icewalker` | 1 | Transmutation | druid, ranger |
| Inbar’s Giant-Friend | `inbars-giant-friend` | 1 | Illusion | bard, sorcerer, warlock |
| Infectious Skal | `infectious-skal` | 2 | Enchantment | bard |
| Jotun Form | `jotun-form` | 8 | Transmutation | cleric, sorcerer, wizard |
| Loki’s Escape | `lokis-escape` | 1 | Illusion | warlock |
| Luckfingers | `luckfingers` | 3 | Enchantment | bard, sorcerer, wizard |
| Melody of Sheltered Rest | `melody-of-sheltered-rest` | 2 | Abjuration | bard, druid |
| Murmurs of Doom | `murmurs-of-doom` | 3 | Necromancy | bard, warlock |
| Noble Sacrifice | `noble-sacrifice` | 4 | Abjuration | cleric, paladin |
| Ode to Wrath | `ode-to-wrath` | 4 | Enchantment | bard |
| Pawn of the Wyrd | `pawn-of-the-wyrd` | 4 | Divination | bard, cleric, druid, paladin, ranger, sorcerer, warlock, wizard |
| Protection Rune | `protection-rune` | 3 | Evocation | cleric, sorcerer, wizard |
| Reaver’s Rune | `reavers-rune` | 2 | Evocation | cleric, paladin, wizard |
| Regenerative Hull | `regenerative-hull` | 5 | Abjuration | bard, cleric, druid, sorcerer, wizard |
| Reinforce Hull | `reinforce-hull` | 2 | Abjuration | cleric, druid, wizard |
| Repair Hull | `repair-hull` | 3 | Transmutation | druid, ranger, sorcerer, wizard |
| Sailor’s Shanty | `sailors-shanty` | 2 | Enchantment | bard |
| Shared Expertise | `shared-expertise` | 3 | Transmutation | bard, ranger |
| Shield-Maiden’s Favor | `shield-maidens-favor` | 1 | Abjuration | bard, cleric, paladin, ranger |
| Sif’s Grace | `sifs-grace` | 3 | Conjuration | bard, cleric, paladin, warlock |
| Skaldic Scolding | `skaldic-scolding` | 4 | Enchantment | bard |
| Song of the Shield Wall | `song-of-the-shield-wall` | 4 | Abjuration | bard, cleric, paladin |
| Speechmaster’s Rune | `speechmasters-rune` | 1 | Evocation | bard, wizard |
| Storm Maiden’s Edge | `storm-maidens-edge` | 4 | Evocation | paladin, ranger |
| Summon Leviathan Avatar | `summon-leviathan-avatar` | 7 | Conjuration | druid, sorcerer, wizard |
| Sun Rune | `sun-rune` | 6 | Evocation | cleric, druid, sorcerer, wizard |
| Talons of the Eagle | `talons-of-the-eagle` | 1 | Transmutation | druid |
| Thought Rune | `thought-rune` | 2 | Evocation | bard, cleric, wizard |
| Trickster’s Bluff | `tricksters-bluff` | 1 | Conjuration | bard, cleric, paladin, warlock |
| Trollblood Infusion | `trollblood-infusion` | 3 | Transmutation | bard, cleric, druid, warlock |
| Truth’s Blade | `truths-blade` | 3 | Divination | cleric, paladin |
| Valhalla’s Cohort | `valhallas-cohort` | 4 | Conjuration | bard, cleric, paladin |
| Valkyrie’s Guidance | `valkyries-guidance` | 3 | Divination | cleric, paladin |
| Valkyrie’s Vision | `valkyries-vision` | 2 | Divination | cleric, paladin, ranger |
| Wall of Snow | `wall-of-snow` | 3 | Evocation | druid, ranger |
| Weave Detonation | `weave-detonation` | 3 | Divination | cleric, sorcerer, wizard |
| Whiteout | `whiteout` | 5 | Conjuration | druid, sorcerer, wizard |
| Wotan’s Retribution | `wotans-retribution` | 2 | Conjuration | bard, cleric, sorcerer, warlock, wizard |
| Wyrd Sight | `wyrd-sight` | 9 | Divination | cleric, druid, warlock |

Corpo completo: `spells[].body` no JSON. Healing Spirit (Spirit Caller) — conferir se aparece nas listas/descrições ao refinar.

## Próximo passo (refino)

1. Traduzir PT-BR + slugs alinhados ao glossário
2. Seeds `northlands-heroes` (itens + magias + `phb_spell_class` + mastery Pull)
3. Wiring mesa só onde couber o padrão economy/cast existente
