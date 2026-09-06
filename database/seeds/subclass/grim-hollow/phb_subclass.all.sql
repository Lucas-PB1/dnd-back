-- Grim Hollow Cap. 2 — subclasses (40)

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'carver-guild',
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  'Guilda do Escultor',
  'Abater monstros com ousadia e sem hesitar',
  'Desde o princípio dos tempos, os bravos encararam os olhos ferozes do perigo e combateram monstros. Os que sobreviveram foram aqueles que espertos o suficiente para se armar adequadamente e saber precisamente onde atacar—ou aqueles que sabiam quando fugir e voltar com um novo plano.',
  'Desde o princípio dos tempos, os bravos encararam os olhos ferozes do perigo e combateram monstros. Os que sobreviveram foram aqueles que espertos o suficiente para se armar adequadamente e saber precisamente onde atacar—ou aqueles que sabiam quando fugir e voltar com um novo plano.

Membros da Guilda do Escultor are the Caçadores de Monstros typically called upon when immediate danger threatens a settlement and there is no army or militia available. Os Escultores avançam unflinchingly toward death, armed with years of training and the knowledge passed down from those before them.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'devourer-guild',
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  'Guilda do Devorador',
  'Ganhar poder consumindo a carne de monstros',
  'O povo de Etharis don’t always speak highly of Caçadores de Monstros, and many consider them to be just as depraved and inhuman as the evils they vanquish. Many of the appalling tales about Caçadores de Monstros can be attributed, directly or indirectly, to the Devourer Guild, who are accused of being monstrous cannibals.',
  'O povo de Etharis don’t always speak highly of Caçadores de Monstros, and many consider them to be just as depraved and inhuman as the evils they vanquish. Many of the appalling tales about Caçadores de Monstros can be attributed, directly or indirectly, to the Devourer Guild, who are accused of being monstrous cannibals.

A verdade é barely any better. Devourers have spent their days consuming the flesh and blood of the monsters they slay, and, over time, their metabolism has changed to tolerate this disgusting practice. Devourers adopt mutations shortly after consuming their prey.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'occultist-guild',
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  'Guilda do Ocultista',
  'Caçar magos e adversários arcanos',
  'In Etharis, there are those who fear magic, and those who seek to understand it. Caçadores de Monstros from the Occultist Guild know folk from both sides are equally dangerous. An Occultist investigates the arcane, the supernatural, and the uncanny, while avoiding the influence of superstition or ideology. Despite their reputation as mage hunters, Occultists don’t burn their enemies at the stake—Occultists put them to the sword, as that’s what swords are for.',
  'In Etharis, there are those who fear magic, and those who seek to understand it. Caçadores de Monstros from the Occultist Guild know folk from both sides are equally dangerous. An Occultist investigates the arcane, the supernatural, and the uncanny, while avoiding the influence of superstition or ideology. Despite their reputation as mage hunters, Occultists don’t burn their enemies at the stake—Occultists put them to the sword, as that’s what swords are for.

Knowledge and magic give Occultists an edge over their mystical adversaries. Their spells are used to detect and defend against dangerous arcana, and, above all, magic is used to destroy monsters that can’t be harmed by steel.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'trapper-guild',
  (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
  'Guilda do Armadilheiro',
  'Eliminar monstros com armadilhas astutas',
  'Legends say that the founding members of the Trapper Guild were game hunters who had grown bored of stalking common elk and dreamed of taking down bigger game. Trappers take pride in their kills and the ingenuity exhibited when a trap works perfectly.',
  'Legends say that the founding members of the Trapper Guild were game hunters who had grown bored of stalking common elk and dreamed of taking down bigger game. Trappers take pride in their kills and the ingenuity exhibited when a trap works perfectly.

The legacy of the Trapper Guild is a consistent testament to the benefits of lying in wait. The element of surprise is paramount to the trapper, whose kit can flourish before the hunter and monster even meet. Preparation is key, and the resourceful trapper has devices to assist in bringing down even the strongest foes.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'pathofthe-fractured',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  'Caminho do Fraturado',
  'Duas personalidades valem mais que uma',
  'Barbarians are defined by their rage, channeling it to unleash brief but potent destruction. Few are brave or unwise enough to study esoteric psychological techniques that split their rage from the rest of their psyche, dividing their identity into two parts: ego and id. When their ego is in control, the Fractured—as these Barbarians are known—possess self-control and cunning beyond most other Barbarians. When they allow their id to take control, their countenance turns monstrous and their bodies swell with the power of rage made physically manifest.',
  'Barbarians are defined by their rage, channeling it to unleash brief but potent destruction. Few are brave or unwise enough to study esoteric psychological techniques that split their rage from the rest of their psyche, dividing their identity into two parts: ego and id. When their ego is in control, the Fractured—as these Barbarians are known—possess self-control and cunning beyond most other Barbarians. When they allow their id to take control, their countenance turns monstrous and their bodies swell with the power of rage made physically manifest.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'pathofthe-primal-spirit',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  'Caminho do Espírito Primal',
  'Fúria ao lado de um espírito bestial',
  'Many Barbarians are in tune with the natural world, but few are as mystically intertwined with it as those who walk the Path of the Primal Spirit. These Barbarians forge powerful connections with beasts and nature spirits, inspiring such ethereal beings to manifest and journey on far-flung adventures.',
  'Many Barbarians are in tune with the natural world, but few are as mystically intertwined with it as those who walk the Path of the Primal Spirit. These Barbarians forge powerful connections with beasts and nature spirits, inspiring such ethereal beings to manifest and journey on far-flung adventures.

Barbarians who follow this path have a deep reverence for the cycle of the natural world. Such Barbarians are as likely to accept quests and pleas for aid from local wildlife as they are from people. This respect for animals and spirits doesn’t cross into naivety—few understand the delicate balance between the needs of predator and prey better than those who walk the Path of the Primal Spirit.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'pathofthe-wrathful-dead',
  (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
  'Caminho dos Mortos Irados',
  'Canalizar a fúria dos mortos inquietos',
  'Barbarians who walk the Path of the Wrathful Dead commune with the spirits of the deceased and channel their spectral powers. These Barbarians are often preoccupied with the dead whispering in their ears, which urge them to act upon the whims and emotions of the haunting spirits. Some who walk this path learn to master the powers gifted to them; others find they’ve become servants to the unending chorus clamoring for their attention.',
  'Barbarians who walk the Path of the Wrathful Dead commune with the spirits of the deceased and channel their spectral powers. These Barbarians are often preoccupied with the dead whispering in their ears, which urge them to act upon the whims and emotions of the haunting spirits. Some who walk this path learn to master the powers gifted to them; others find they’ve become servants to the unending chorus clamoring for their attention.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'collegeof-adventurers',
  (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
  'Colégio dos Aventureiros',
  'Ser mestre de várias classes',
  'Bardos do College of Adventurers learn from heroes of old and stories of legend. Bards are jacks of all trades, and, for the College of Adventurers, this statement rings even truer. They combine all the skills of their companions into one, allowing them to be versatile and supportive. Embora não tenham a direct goal, many adventurer-studying Bards live to tell tales of other heroes or seek to create their own. Histórias de grandes feitos, of desperate cunning, of magical anomalies, or of godly might fuel these Bards.',
  'Bardos do College of Adventurers learn from heroes of old and stories of legend. Bards are jacks of all trades, and, for the College of Adventurers, this statement rings even truer. They combine all the skills of their companions into one, allowing them to be versatile and supportive. Embora não tenham a direct goal, many adventurer-studying Bards live to tell tales of other heroes or seek to create their own. Histórias de grandes feitos, of desperate cunning, of magical anomalies, or of godly might fuel these Bards.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'collegeof-fools',
  (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
  'Colégio dos Tolos',
  'Rir do terror dos inimigos',
  'Laugh at Your Foes’ Terror',
  'Laugh at Your Foes’ Terror

It’s commonly believed the College of Fools is merely a front for a cult of Beleth. Bards in the College would say their relationship with the Arch Daemon of Fear is much more complicated. These Bards choose to laugh at Etharis’s many horrors rather than be dismayed by them—a whimsical, if ghoulish, philosophy. Their delight in other creatures’ terror encourages their obscene antics and cruel jests. One person’s trick is another person’s terror, after all.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'collegeof-requiems',
  (SELECT id FROM rpg.phb_class WHERE slug = 'bard'),
  'Colégio dos Réquiens',
  'Cantar a melodia que encerra o mundo',
  'Sing the Songs of the Dead',
  'Sing the Songs of the Dead

Performing macabre melodies filled with grief-stricken chords and mournful refrains, the College of Requiems stirs the very bones of the dead. Requiem Bards weave necromantic magic into their funerary songs to control and empower a host of Undead minions.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'eldritch-domain',
  (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
  'Domínio Eldritch',
  '',
  'Wield the Power that Killed the Gods',
  'Wield the Power that Killed the Gods

Even the most benevolent divine beings operate outside the bounds of mortal comprehension. These eldritch forces sing a siren song that calls to mortal worshippers through lucid dreams and terrible whispers. The Eldritch Domain empowers the followers of the unknown and distant forces of chaos, divine entities of eldritch oblivion, and dead gods.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'inquisition-domain',
  (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
  'Domínio da Inquisição',
  '',
  'Cleanse the Heretics',
  'Cleanse the Heretics

The Inquisition Domain reflects the order of the multiverse and the rejection of tainted magic—so far as certain celestial powers see it. Only the divine casters are pure and fit for use.

Since arcane magic is strong enough to challenge the gods, divine beings of this domain, such as the Arch Seraph Empyreus, demand magic-using mortals be kept in check. Most zealots root out all arcanists, while some strike fragile truces when complete removal isn’t feasible.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'purification-domain',
  (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
  'Domínio da Purificação',
  '',
  'Purge Sickness with Suffering',
  'Purge Sickness with Suffering

The Purification Domain believes sickness, mutation, and other forms of bodily corruption are signs of a corresponding spiritual malady. Virtue can’t exist alongside impurity. The wickedness of humanity and other mortal, sentient creatures is a contagion that manifests plagues such as the Weeping Pox. When there’s a risk of such corruption spreading, there’s only one surefire way to contain the rot and atone for the sins that led to this point: Burn it out.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'circleof-blood',
  (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
  'Círculo do Sangue',
  '',
  'Wreak Bloody Havoc',
  'Wreak Bloody Havoc

The Circle of Blood is a keeper of the old ways. They remember how ancient Druids performed sacrificial rituals under a blood-red moon to appease the uncaring forces of nature. These Druids trade blood for life in a delicate balance to bolster their allies and destroy their enemies.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'circleof-entropy',
  (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
  'Círculo da Entropia',
  '',
  'Become an Instrument of Decay and Ruin',
  'Become an Instrument of Decay and Ruin

Druids of the Circle of Entropy see doom como constant of the natural world. Lives end, works erode, and the civilizations of Etharis ultimately come to ruin. The inevitable end of the old brings opportunity for the new. These fatalistic Druids see themselves as agents of ruin, ending those whose time has passed to make space fou aqueles quese time has yet to come.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'circleof-mutation',
  (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
  'Círculo da Mutação',
  '',
  'Mutate Into an Apex Predator',
  'Mutate Into an Apex Predator

Druids of the Circle of Mutation believe that nature should be improved in order to compete with the unnatural world. Their order hides in the darkest corners of swamps and forests, conducting experiments to warp the structure of their domain. They go unheard from for months, emerging from the wilds with twisted vines and mutated creatures at their side. These Druids have earned the scorn of other circles, discredited as those who have lost their way. In the eyes of these Druids, those who wish to preserve nature as it is simply fear what change brings.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'bulwark-warrior',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  'Guerreiro Baluarte',
  'Provocar inimigos, proteger aliados',
  'Those who learn the fighting prowess of the Bulwark Warriors protect their allies from certain death. Bulwark Warriors guard their allies by provoking their enemies. With endurance and strength as their primary skills, these warriors are prepared to take lethal strikes for their compatriots.',
  'Those who learn the fighting prowess of the Bulwark Warriors protect their allies from certain death. Bulwark Warriors guard their allies by provoking their enemies. With endurance and strength as their primary skills, these warriors are prepared to take lethal strikes for their compatriots.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'living-crucible',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  'Crisol Vivo',
  'Aprimorar proezas marciais com alquimia',
  'Fighters who become Living Crucibles have discovered an external means of power. While most Fighters train in martial traditions or study the art of war, Living Crucibles hone their craft of alchemy to endure compounds poisonous to others. In exchange for this rigorous physical and mental preparation, these Fighters are able to temporarily push their bodies past their natural limits. Under the influence of their alchemical compounds, these warriors can see in darkness, enhance their speed, inure themselves to magical attacks, and more.',
  'Fighters who become Living Crucibles have discovered an external means of power. While most Fighters train in martial traditions or study the art of war, Living Crucibles hone their craft of alchemy to endure compounds poisonous to others. In exchange for this rigorous physical and mental preparation, these Fighters are able to temporarily push their bodies past their natural limits. Under the influence of their alchemical compounds, these warriors can see in darkness, enhance their speed, inure themselves to magical attacks, and more.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'nightwatcher',
  (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'),
  'Vigia Noturno',
  '',
  'Take Back the Night',
  'Take Back the Night

Nightwatchers come from humble origins, often toiling as guards or investigators. Undaunted by dangers in the darkness, they stand firm against the growing night. Ever vigilant, they use the darkness to surprise and overwhelm foes much greater than themselves.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'warriorofthe-leaden-crown',
  (SELECT id FROM rpg.phb_class WHERE slug = 'monk'),
  'Guerreiro da Coroa de Chumbo',
  '',
  'Harness the Will to Resist',
  'Harness the Will to Resist

In contrast to the esoteric ideals of other orders, Warriors of the Leaden Crown have practical aims: the self-governance of all people. These Monks see history como series of clashes between groups of powerful beings where Humanoideees are at best collateral damage and at worst disposable pawns. To break this cycle of dependence and destruction, Warriors of the Leaden Crown master mental abilities to fight against the otherworldly powers of the multiverse and protect Humanoidee sovereignty.

One component of this plan involves training to do battle with powerful planar foes. The other equally important component is ensuring that Humanoidee societies are prepared to overthrow those already dominating them. To that end, these Monks seek political positions that place them in or near decision-making roles where they can influence others to fight back against Arch Seraphs, Arch Daemons, and Primordials.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'warriorof-pride',
  (SELECT id FROM rpg.phb_class WHERE slug = 'monk'),
  'Guerreiro do Orgulho',
  '',
  'Prove Your Superiority',
  'Prove Your Superiority

Monks who become Warriors of Pride value themselves above all. These monks focus on mastering their form, ego, and their destructive power. They display monastic aesthetics publicly with the intention of gaining the respect and admiration of “lesser beings.”

The prideful traditions of this order include adorning themselves with jewelry, hiding their scars, and commanding respect from those who would oppose them.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'warriorof-regret',
  (SELECT id FROM rpg.phb_class WHERE slug = 'monk'),
  'Guerreiro do Arrependimento',
  '',
  'Atone for Past Mistakes',
  'Atone for Past Mistakes

No one is born intent on bringing evil into this world, yet many lives are transformed by the suffering inflicted upon them. Warriors of Regret are haunted by the shadows of evil deeds done.

Through training and reflection, Warriors of Regret accept their past can’t be erased. Instead, they focus on forging remorse and grief into a weapon against their foes. Though their misdeeds follow their every step, Warriors of Regret are not powerless to atone for them.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'oathof-pestilence',
  (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
  'Juramento da Pestilência',
  '',
  'Gain Força Through Suffering',
  'Gain Força Through Suffering

Clad in grime-soaked armor and wielding rusting weapons, Oath of Pestilence Paladins spread corruption, disease, and filth. Bound by an oath that infests their bodies with all manner of plagues, these heralds of decay lumber forward with unholy toughness and grim resolve.

These Paladins share o seguinte tenets:',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'oathof-slaughter',
  (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
  'Juramento do Massacre',
  '',
  'Revel in Unbridled Violence',
  'Revel in Unbridled Violence

The only truth of war is death. The only virtue is to kill. The only victory is to survive. Heroism, honor, and glory are illusions. This is the creed of Tormach, Arch Daemon of Wrath, but this philosophy rings true for all warriors who devote themselves, body and soul, to the thrill of combat and the delight of bloodshed. Such champions find themselves at the forefront of armies, using the most violent methods at their disposal to bring battles to a swift close … or drawing out the war to sate their own appetites.

Paladins who take the Oath of Slaughter share o seguinte tenets:',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'oathof-zeal',
  (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
  'Juramento do Fanatismo',
  '',
  'Eliminate Threats to Ideological Purity',
  'Eliminate Threats to Ideological Purity

The Oath of Zeal is taken by paladins consumed by hatred for a specific group or ideology. Zealots, as these Paladins are sometimes called, pursue an inquisition against their enemies at all costs. They abandon compassion and honor as impediments to the more important work of ridding the world of those they deem dangerous or heretical.

These Paladins share o seguinte tenets:',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'green-reaper',
  (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
  'Ceifador Verde',
  '',
  'Slay with Nature’s Venom',
  'Slay with Nature’s Venom

Green Reapers are assassins who specialize in harnessing the toxic elements of flora and fauna. These Rangers often work as killers for hire utilizing their extensive knowledge to end lives discreetly or with gory panache, dependendo de the poison used and the client’s wishes. Green Reapers exhibit a morbid curiosity when encountering a toxin they’re unfamiliar with, typically followed by an enthusiastic application of the substance on their next foe.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'primordial-archer',
  (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
  'Arqueiro Primordial',
  '',
  'Channel the Wrath of the Wilds',
  'Channel the Wrath of the Wilds

In the areas of Etharis where nature still holds sway, many cling to the ancient customs of woodland hunters and witches. Marking themselves with wild plants and bone needles, theirs is a tradition of cunning, cruelty, and reprisal against all trespassers. Unlike the Druids, these wood witches twist natural magic into hexes, imbuing their weapons with nature’s fury.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'vermin-lord',
  (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
  'Senhor dos Vermes',
  'Medium Swarm of Tiny Beasts, Unaligned',
  'Grow Powerful from Força in Numbers',
  'Grow Powerful from Força in Numbers

Vermin Lords cultivate loyal hordes of disease-bearing rodents to help them battle greater evils. For many of these Rangers, that greater evil is some kind of societal ill, but a rare few see their fellow Humanoideees as an infestation that threatens the natural world. Regardless of their goal, they make their homes in sewers, slums, and other forgotten places where they are free to plot against their enemies and tend to their verminkin.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'highway-rider',
  (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'),
  'Cavaleiro da Estrada',
  '',
  'A Steed Makes the Best Partner in Crime',
  'A Steed Makes the Best Partner in Crime

Stalking the backroads, the Highway Rider strikes fear into the heart of every traveler and penny-pinching merchant. They run down their prize astride a swift and loyal steed—and then make a quick getaway.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'misfortune-bringer',
  (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'),
  'Portador da Desgraça',
  '',
  'Curse Those You’re About to Strike',
  'Curse Those You’re About to Strike

You’ve matched your penchant for illicit activities with the ability to mark your enemies for mishap and misfortune. Whether you were imbued with magic by spending time among the Fey or you learned the art of cursing from a long line of hedge Wizards, you are a Misfortune Bringer. Although not universal, many Misfortune Bringers possess heterochromia iridum, eyes of two different colors, and they use only one when glaring at targets they intend to curse.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'sanguine-thief',
  (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'),
  'Ladrão Sanguíneo',
  '',
  'Eliminate Your Prey with Blood Magic',
  'Eliminate Your Prey with Blood Magic

In dark alleyways across Etharis, deals are made in coin and blood, but a few enterprising Rogues have posed the question: “Why not both?” Sanguine Thieves are assassins who harness the power of Sangromancia to fuel their abilities, finding new and innovative ways to utilize the blood they see all too frequently in their line of work.

Sanguine Thieves learn to draw upon the vita of their victims, extending their ability to use blood magic beyond the limits of their own vitality. When cornered, Sanguine Thieves can unleash this power in a hail of crimson darts or fade before a foe’s blade, leaving nothing behind but a red mist.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'apocalypse-sorcery',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  'Feitiçaria do Apocalipse',
  '',
  'Hasten or Stall the End of the World',
  'Hasten or Stall the End of the World

Apocalypse Sorcerers have seen the shape of things to come. They may have visions of the Great Beast ushering in the end of Etharis or dreams of Gormadraug waking and devouring the land.

These prophecies besiege Apocalypse Sorcerers, plaguing and empowering in equal measure. Some find relief in putting these revelations into writing, producing texts that read as incoherent but slowly seep into the mind as sensible, even inevitable. When the apocalypse-bringer is freed to travel across Etharis unburdened, undoing the works of gods and men, magic will swell and pool, ripe for the taking. This sign of the end is also their gift.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'haunted-sorcery',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  'Feitiçaria Assombrada',
  '',
  'Commune with the Dead',
  'Commune with the Dead

Unlike other Sorcerers, the circumstances of your birth were mundane and you have no arcane inheritance passed down from strange ancestors. Instead, you gained your sorcerous powers after you survived an experience that left you near death. Since that experience, you’ve had a preternatural sense for danger and a ghostly companion that either can’t, or won’t, leave you alone. Some Haunted, as Sorcerers who share your origin are called, develop cordial relationships with their phantom, while others find their spectral companion to be a relentless nuisance.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'wretched-bloodline-sorcery',
  (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
  'Feitiçaria da Linhagem Maldita',
  '',
  'Wield Your Curse Like a Weapon',
  'Wield Your Curse Like a Weapon

With every promise whispered to a fairy, every contract signed with a devil, and every pact made with the dead, there’s a chance someone doesn’t keep their end of the bargain. The vengeance of immortal beings lasts much longer than one lifetime, and the lingering magic of these curses can affect the mortal’s descendants.

These inherited magical afflictions may manifest como plague, deformity, or aversion to the sun. In such families, children may be born who learn to master the latent magic within their inherited curses, turning their banes into personal boons—these sorcerers are known collectively as the Wretched.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'the-coven',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  'O Pacto das Bruxas',
  '',
  'Curse and Befuddle with Hag Magic',
  'Curse and Befuddle with Hag Magic

Hags dwell in the deep places of Etharis, from the primordial forests of Valika to the putrid streets of Liesech. These creatures, though rarely benevolent, are willing to bargain with mortals in exchange for furthering their own capricious goals.

Warlocks often find themselves with a single Hag como sponsor. Should this Hag have a coven, it can lead to the peculiar situation of Warlock agents acting against other Hags or their Warlocks within the coven. But such is the politics of the Realm of Faerie.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'the-first-vampire-patron',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  'Patrono do Primeiro Vampiro',
  '',
  'Wield the Power of Undeath',
  'Wield the Power of Undeath

Você tem made a pact with a powerful vampire cursed by the gods or born como creature of the night. Hundreds of haunted beings serve this vampire, so why enter a pact with you? Because você pode act in the light of day unhindered? To cull weaker vampires?',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'the-parasite-patron',
  (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
  'Patrono do Parasita',
  '',
  'Become One with a Cosmic Being',
  'Become One with a Cosmic Being

Your patron is a cosmic parasite, draining the vitality of entire peoples and worlds. Upon forging a pact with such a patron, you become host to one of its nascent offspring. As you grow in power, the boundary between your identity and the parasitic larva within blurs.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'daemonologist',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  'Daemonologista',
  '',
  'Steal Scraps of Divine and Infernal Power',
  'Steal Scraps of Divine and Infernal Power

Through theological study, or perhaps an induction into a secretive cabal, Daemonologists have learned to cast divine magic without the need for faith or bargains. Their grimórios are scribed with prayer fragments and blasphemous hymns, enabling them to siphon scraps of power from both Arch Seraphs and Arch Daemons. From their heretical research, they’ve come to believe such otherworldly beings are two sides of the same divine kin.

Daemonology is rarely practiced. If the nature of their abilities is discovered, they risk being persecuted not only by superstitious folk but also by celestial and infernal powers.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'plague-doctor',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  'Médico da Peste',
  '',
  'Plague Your Enemies with Magical Concoctions',
  'Plague Your Enemies with Magical Concoctions

Blending spellcasting with science, you distill your magic into concoctions that harm or heal. Plague Doctors often wear grotesque masks protecting them from their toxic ingredients. Many fearfully regard the mask como sign of pestilence, making Plague Doctors a source of both hope and trepidation.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

INSERT INTO rpg.phb_subclass (
  slug, class_id, name, tagline, summary, description, source_citation_id
)
VALUES (
  'sangromancer',
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  'Sangromante',
  'Derramar sangue por poder',
  'Você estuda uma escola incomum de magia conhecida como Sangromancia ou magia de sangue.',
  'Você estuda uma escola incomum de magia conhecida como Sangromancia ou magia de sangue. Apesar da reputação sombria, não há nada inerentemente maligno na prática — embora as exigências sobre quem a domina sejam macabras. Como Sangromante, sua magia exige mais que conhecimento: exige sacrifício. Outros magos podem encará-lo com ceticismo ou hostilidade, mas ninguém nega a potência da sua arte.',
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes')
)
ON CONFLICT (slug) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  source_citation_id = EXCLUDED.source_citation_id;

