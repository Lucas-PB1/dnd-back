-- Grim Hollow Cap. 1 — heritages jogáveis (wizard GH) + índice de traços

INSERT INTO rpg.phb_species (
  slug, name, creature_type, size, speed, description, summary, tagline, source_meta
)
VALUES
(
  'gh-dragonborn',
  'Draconato',
  'Humanoide',
  'Dragonborn are typically tall and solidly built, with most standing well over 1.8 m tall and averaging almost 250 pounds. Your size is Médio.',
  '9 m.',
  'Dragonborn walk with pride through a world that greets them with equal parts fear and admiration. Their powerful resemblance to dragons makes them remarkable among other common folk. Thick scales cover their bodies, sharp claws tip their fingers, fangs line their jaws. They do not possess the legendary size or impressive wings of their presumed ancestors, but to be dragonborn is to be blessed with the breath and beauty of a dragon.

Some claim that the dragonborn must be the most ancient among all heritages. During the Era of Expansion, humanity discovered a kingdom already shattered in Etharis’s most southern regions. Not even the dragonborn themselves could recount the history that had led to the destruction of their once-great capital—the granite city of Ember Cairn. When dragonborn prayed, they were met with silence from their gods. They dwelled in the ruins of their own inheritance.

It was not difficult for humans to settle the southern lands that would become Castinella. Disillusion and desperation caused the dragonborn to abandon their ancestral lands and scatter across Etharis, searching for the answers as to why their gods fell silent. It was in this same period human missionaries began teaching their own religions to the dragonborn that remained—of the Aetheric War and the Divine Seraphs. The dragonborn came to believe that their gods had not abandoned them but had been destroyed by the Aether Kindred. With a new faith to fill the void of their lost beliefs, the dragonborn of Castinella became among the most zealous adherents of the Eternal Dogma.

Castinella awarded the dragonborn a small region of their ancestral land to call their own. From this humble start, they rebuilt the ancient city of Ember Cairn. Those who were scattered across the continent began to undertake pilgrimages to the city, where they were encouraged to embrace worship of the Divine Seraphs. With their ancient prayers seemingly answered at last, many dragonborn were drawn to become clerics, missionaries, and inquisitors, spreading their new beliefs with burning passion—and more often than not with burning fire.

Your draconic heritage marks you as a unique folk among the other heritages of Etharis.

Age. Young Dragonborn grow quickly. They walk hours after hatching, attain the size and development of a 10-year-old human child by the age of 3, and reach adulthood by 15. Dragonborn live to be about 80.

Size. Dragonborn are typically tall and solidly built, with most standing well over 6 feet tall and averaging almost 250 pounds. Your size is Medium.

Speed. 30 feet.

Traditional Dragonborn Traits

For most Dragonborn, a unique physiology defines and shapes their innate capabilities.',
  'Herança comum em Etharis — equivalente às “raças” tradicionais, mas com traços modulares escolhidos na criação.',
  'Herança comum',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"common"}'::jsonb
),
(
  'gh-dwarf',
  'Anão',
  'Humanoide',
  'Dwarves stand between 4 and 1.5 m tall and average about 150 pounds. Your size is Médio.',
  '9 m. Your Speed is not reduced by wearing heavy armor. You can reduce your Speed by 1.5 m to gain an extra traditional trait.',
  'Ancient and dauntless as the mountains they call home, the dwarves first appeared in Etharis long before recorded history. As talented and diligent crafters, the dwarves forged their kingdoms in the valleys and foothills of the two oldest mountains on the continent: the Rock-Teeth and the Grey Spine. Beneath these vast ranges ran rich veins of mithral and gold. The dwarves who mined and crafted these metals quickly became famous across Etharis.

During the wars of the Era of Expansion, the dwarves barricaded themselves within their greatest capitals: the tiered city of Stehlenwald and the mountain stronghold of Grabenstein. Both fortress cities were once thought impregnable. The dwarves of Grabenstein fought valiantly for their homelands, withstanding multiple sieges until eventually their walls were ruined, their thanedoms uprooted, and their rich mines claimed by human warlords. These conquerors’ descendants would later lay the groundwork for the Bürach Empire.

The dwarven kingdom of Stehlenwald endured. Rather than share the fate of their northern cousins, the Stehlenwald dwarves dug deeper into the heart of the mountain. There, miners laid eyes upon a new metal, impenetrable to the weapons of their enemies: adamantine. With armor and weapons crafted from adamantine, dwarf battalions managed to push the invaders back to their homelands, but at a great cost. The population of Stehlenwald was decimated by war and famine. Isolation within the mountains was the only option for survival for those who remained.

By the time of the rise of human kingdoms, the proud dwarves of Stehlenwald had recovered from war. They emerged from the mountains at last to discover the political landscape had dramatically changed, leaving them surrounded and vastly outnumbered by the armies of the Bürach Empire. Realizing there was only one way for his people to survive and prosper, the dwarf king struck a deal with the Bürach Empire. The dwarves would surrender their lands and become members of the empire, as long as they could govern themselves independently.

Great numbers of dwarves still cannot forgive the great loss of life and sovereignty their ancestors once endured. It’s a common phrase in Etharis that it’s easier to move a mountain than a dwarf. But though deep wounds still exist in the Bürach Empire, dwarves have become among the most prosperous and accepted peoples in all nations of Etharis.

Typically short and stout, Dwarves are among the most recognizable folk of Etharis.

Age. Dwarves physically mature by their late teens, but are considered young until they reach the age of 50. On average, they live about 350 years.

Size. Dwarves stand between 4 and 5 feet tall and average about 150 pounds. Your size is Medium.

Speed. 30 feet. Your Speed is not reduced by wearing heavy armor. You can reduce your Speed by 5 feet to gain an extra traditional trait.

May your drink be strong and your hammer strike true.

Traditional Dwarf Traits

Dwarves are known for their natural resilience and for the degree to which they have adapted to living in the deeps beneath hills and mountains, where few other folks can thrive.',
  'Herança comum em Etharis — equivalente às “raças” tradicionais, mas com traços modulares escolhidos na criação.',
  'Herança comum',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"common"}'::jsonb
),
(
  'gh-elf',
  'Elfo',
  'Humanoide',
  'Elves range from under 5 to over 1.8 m tall and often have slender builds. Your size is Médio.',
  '9 m.',
  'The proud and elegant elves were among the first people to dwell in the forests of Etharis. Their long history is entwined with fables from the distant past. Tall, graceful, and extraordinarily beautiful, these ancient folk believe they are descended from the nature spirits who cultivated the mortal realm. The elves claim the forests and river lands of Caer Neiada as their ancestral home, in what is now the Charneault Kingdom. Within those deep woods they created magnificent domains, ever taking guidance and blessing from the ageless spirits of the forest.

Many elves are blessed with keen eyesight and a talent for archery. Their deep knowledge of the woodlands and their affinity with the fey enable them to conceal themselves effortlessly within their own domains. Their deadly and nimble armies made them a force to be reckoned with in the early days of Etharis. However, their unchallenged dominion over the forests combined with their long lives made the elves arrogant, setting themselves above and away from other folk—especially humans, who they considered primitive and barbaric. And so the elves failed to recognize the humans as a plausible threat.

The Era of Expansion cost the elves dearly. Their kingdoms were shattered, with many of their forests reduced to ash and blackened stumps. Though their battle prowess never dimmed, the elves found themselves outnumbered and unable to repel war-hungry armies burning and lumbering their sheltering woodlands. They instead retreated deep into their forests on the outskirts of human civilization, where they believed the Spirits of Nature would still protect them. When the elves eventually reemerged, they formed a pact with humankind that birthed the Charneault Kingdom.

In the end, the sorrow of the elves for their lost paradise empowered them to recreate that beauty in music and arts. They have crafted heartbreaking songs of a lost past that echo among the trees in the night. In these ballads they call themselves the ulufey, meaning mortal fey and the descendants of the fey sidhe. The faerie courts who had once guided the elves were not vanquished in the Era of Expansion and many hope such Spirits of Nature will aid in restoring elven lands to their ancient grace.

Though elves might pass as humans at a distance, their fine features typically make them immediately recognizable to other folk.

Age. Although elves reach physical maturity at about the same age as humans, the elven understanding of adulthood goes beyond physical growth to encompass worldly experience. An Elf typically claims adulthood and an adult name around the age of 100, and can live to be 750 years old.

Size. Elves range from under 5 to over 6 feet tall and often have slender builds. Your size is Medium.

Speed. 30 feet.

Traditional Elf Traits

The ancient traditions followed by many Elves reflect a mastery of mind, body, and magic.',
  'Herança comum em Etharis — equivalente às “raças” tradicionais, mas com traços modulares escolhidos na criação.',
  'Herança comum',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"common"}'::jsonb
),
(
  'gh-gnome',
  'Gnomo',
  'Humanoide',
  'Gnomes are between 3 and 1.2 m tall and average about 40 pounds. Your size is Pequeno.',
  '9 m. You can reduce your Speed by 1.5 m to gain an extra traditional trait.',
  'Ingenious and full of energy, gnomes are thought to be distant cousins of the dwarves. Shorter than their dwarf kin and less bulky, these small-framed folk are often known for their ever-working brains and great aptitude for invention. Gnomes are clever, curious, sometimes mischievous, but culturally very diligent.

Gnomes have created some of the most impressive mechanical wonders of Etharis. Cannons, automatons, flintlocks, and explosives are all reputed to be results of gnomish crafting. The process of tinkering is as important as the result. Gnomes create new inventions simply to prove it can be done. It’s said among other folk that if you’re looking for a gnome in a populated city, you need only wait for the explosion to guide your steps.

During the Era of Expansion, gnomes fled their settlements outside the sheltering mountains to seek the protection of dwarf cities such as Stehlenwald. There, they shared the fate of their dwarf cousins as human armies besieged the soaring stone walls of the city. While the dwarves eventually gazed upon adamantine, the ingenious minds of the gnomes hatched other plans with the gifts from the mountains.

Gnome alchemists worked day and night, mixing chemicals and powders, until they invented a new weapon: explosives. As the adamantine-clad dwarves charged the besieging human armies, they were supported by the sound of explosions as gnome artillery hurled cannonballs and dynamite at the enemy. Beneath the barrage, the human forces were quickly broken. The effects of the never-before-seen explosives struck fear into their minds, as if witnessing a new and terrible sorcery. A first great battle had been won, but the losses for both gnomes and dwarves were great. So did the gnomes follow the dwarves of Stehlenwald into their centuries-long isolation—and when the dwarf king voluntarily brought his people into the Bürach Empire, the gnomes followed.

Curiously, gnomes have an affinity with the natural world. Those who did not flee for the safety of mountains were called back to their ancestral homes deep in Etharis’s forests. Perhaps this suggests a common ancestor with the elves, also.

Most Gnomes are marked by the slight features and long lives that are common among their kind.

Age. Gnomes are physically mature by 18, and most are expected to settle down into an adult life by around age 40. They can live to almost 500 years.

Size. Gnomes are between 3 and 4 feet tall and average about 40 pounds. Your size is Small.

Speed. 30 feet. You can reduce your Speed by 5 feet to gain an extra traditional trait.

They’re grubby little folk, always smeared with ash and blackpowder. Couldn’t ask for better engineers though.

Traditional Gnome Traits

For many Gnomes, an instinctive quickness of body and mind shapes their approach to life and learning.',
  'Herança comum em Etharis — equivalente às “raças” tradicionais, mas com traços modulares escolhidos na criação.',
  'Herança comum',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"common"}'::jsonb
),
(
  'gh-halfling',
  'Halfling',
  'Humanoide',
  'Halflings average about 0.9 m tall and weigh about 40 pounds. Your size is Pequeno.',
  '9 m. You can reduce your Speed by 1.5 m to gain an extra traditional trait.',
  'Over the centuries in which humankind proved an unstoppable force in conquering Etharis, humans earned the enmity of most other folk. All who tried to oppose them were met with violence. One group, however, chose not to contest human ascendancy and instead survived by adapting to human hegemony.

The Era of Expansion did not affect the halflings of Etharis as it did the folk of other heritages. Halflings hold less value for mundane riches like gold or jewels and were therefore happy paying tithes to stronger and better-armed humans who offered them protection. Though brave and spirited, halflings lack the ambition for nation building. Their humble shires easily adapted to becoming breadbaskets for human-made empires and kingdoms. Halflings also fit into human culture perfectly by acquiring useful positions such as merchants, advisors, teachers, or scholars. Even though the halflings did not agree with the violent ways of humans, they kept their silence and ensured their survival.

Halflings are a resilient but peaceful people. What most of these tiny folk seek in life is a quiet place to settle, far away from conflict and war. They enjoy good music, fine food, and a good laugh when they can, and have a passion for lore, learning, and wild tales. But this does not mean that halflings are unable to fend for themselves in a dangerous world. They’re courageous folk when standing against foes they cannot elude or escape, and accounts of halfling adventurers seeking ancient and hidden knowledge are some of the most famous stories among their kind.

Halflings have long used the lore they gather to build impressive libraries on specific subjects. Within the countless volumes of these libraries lie generations of knowledge pertaining to the interests and passions of these folk, including domestic crafts, nature, and history.

Whatever their approach to life, most Halfling characters are defined by their diminutive stature.

Age. A Halfling reaches adulthood at the age of 20 and generally lives into the middle of their second century.

Size. Halflings average about 3 feet tall and weigh about 40 pounds. Your size is Small.

Speed. 30 feet. You can reduce your Speed by 5 feet to gain an extra traditional trait.

The halflings prove trickier than I first suspected, though content enough with current arrangements. I wouldn’t push things.

Traditional Halfling Traits

Many Halflings possess innate instincts of courage and curiosity, even if only a few get the chance to use them.',
  'Herança comum em Etharis — equivalente às “raças” tradicionais, mas com traços modulares escolhidos na criação.',
  'Herança comum',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"common"}'::jsonb
),
(
  'gh-human',
  'Humano',
  'Humanoide',
  'Humans vary widely in height and build, from barely 1.5 m to well over 1.8 m tall. Your size is Médio.',
  '9 m.',
  'While ancient heritages such as the elves and the dwarves claim to have raised the first kingdoms in Etharis, humans dominate those lands in the current age. Humans can be found everywhere, from the frozen and inhospitable tundra of the North to the scorched plains of the South. First recorded emerging from temperate forests in the lands that are now the Bürach Empire, humans were not considered a threat by the dominant folk of the continent. Left unchecked, their numbers quickly grew. And in the end, the humans’ adaptable nature and adventurous mindset led them to expand beyond their homelands.

The period written in history as the Era of Expansion is often portrayed as an endless eruption of violence that lasted centuries as humans spread to every corner of Etharis. Rather, the Era of Expansion describes many separate conflicts that occurred in the wake of human migration. Humans didn’t send armies initially, but settlers. They cut trees from the Grove Maze to build homes. They journeyed to the reaches of Valika to escape their own kingdoms in the south. When they claimed the lands already populated by other folk, war became inevitable. By the time the great kingdoms of the elves and dwarves recognized the danger of human migration, it was already too late. The bloodshed that followed changed Etharis forever.

The success of humans is owed to their adaptability. They live shorter lives than many other peoples, causing their cultural customs to fade quicker and preventing them from becoming stifled by their own traditions. Every human culture has been touched by another heritage in the lands they’ve come to settle. In the duchies of the Charneault Kingdom, humans pay homage to the Spirits of Nature as taught to them by the elves. The modern fortresses and cities in the Bürach Empire incorporate dwarven stonework and architecture. To this day, humans are considered the dominant folk across all Etharis, controlling most of the land and sea. But their realms are far from homogeneous, each with their own history and mix of folk from other heritages.

Of all human vices, ambition is thought to be the most insidious. Humans still dominate positions of power within their societies. Many have asserted their claim to the High Throne of Altenheim, wishing to control the most powerful empire in the world. Known as the Era of Descent, the years that followed the Era of Expansion have been witness to the decline of each human domain. While many commoners believe it to be the death of the gods that began this downfall, folk of other heritages whisper that it was human hubris. When there were no more realms to conquer, humanity turned their greed, ambition, and violence upon themselves.

Humans present a wide range of physical traits, but their brief lifespans have long defined their collective ambition.

Age. Humans reach adulthood in their late teens and live less than a century.

Size. Humans vary widely in height and build, from barely 5 feet to well over 6 feet tall. Your size is Medium.

Speed. 30 feet.

Traditional Human Traits

Though Humans are no more drawn to violence than any other folk, many possess an innate ambition, a hunger for exploration, and a willingness to stand against danger.',
  'Herança comum em Etharis — equivalente às “raças” tradicionais, mas com traços modulares escolhidos na criação.',
  'Herança comum',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"common"}'::jsonb
),
(
  'gh-dreamer',
  'Sonhador',
  'Humanoide',
  'Dreamers typically range from 5 to 1.8 m in height, and have solid builds. Your size is Médio.',
  '9 m.',
  'History repeats itself. Long before humans had their Eras of Expansion and Descent, and even before the time of elves and dwarves, another civilization had risen and fallen. Where the dwarves of Stehlenwald live today once stood the seat of a nameless empire thought to have surpassed any to have arisen since. For centuries, it lived only in the mythologies of elves and dwarves. In some stories, the downfall occurred when mortals try to challenge the gods. In other tales, the empire was devoured entirely in the first cataclysm that was the Aetheric War.

Nevertheless, something survived.

As the humans laid claim to Etharis, the Stehlenwald dwarves were forced to dig deeper into their mountain strongholds to withstand the siege. Deep in the dark, even beneath the adamantine that proved to be their salvation, the dwarves found sealed chambers of mysterious origin. With the seals broken, an ancient spell was lifted, and the inhabitants of the chambers began to stir from their millennia-long slumber.

In the days before the calamity that wiped out their civilization, a group of mystics known as dreamers foresaw the danger and devised a plan to survive it. Time passes differently in dreams, and those ancients were able to use the magic of oneiromancy to free themselves from the flow of time. Suspended between reality and dreams while sealed deep underground, they could live in a state of perpetual slumber for as long as necessary, outlasting the aftermath of the disaster that would wipe out the rest of their kind.

The plan worked. But living for so long within the world of dreams had unforeseen consequences. Upon waking, the dreamers found that they could no longer differentiate between dreams and memories, with both fading quickly from their minds. The result was the emergence of a new people with no knowledge of their own history—only half-formed images and dreamlike impressions of a place and time that may or may not have existed.

Now the dreamers struggle to adapt in a world that was not made for them. Whatever their history, they have proven to be quick-witted and strong, able to easily adapt to a new and unknown world. Their long slumber has seemingly left them energized, and able to work even beyond the legendary endurance of the dwarves. Even so, sleep is where the dreamers still feel most at home, and they have a habit of quickly dozing off whenever no immediate task presents itself.

Dreamers bear a general resemblance to other humanoids, but their distinct features make them stand out.

Age. The magic that kept the Dreamers in stasis during their long slumber has also served to preserve their bodies from natural aging. Dreamers mature at the age of 18 and can live to be 250 years old.

Size. Dreamers typically range from 5 to 6 feet in height, and have solid builds. Your size is Medium.

Speed. 30 feet.

Traditional Dreamer Traits

Their long sleep and the lingering dreams that come with it shape the minds and instincts of many Dreamers.',
  'Herança rara — povo pouco comum em Etharis, com traços modulares.',
  'Herança rara',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"rare"}'::jsonb
),
(
  'gh-grudgel',
  'Rancoroso',
  'Humanoide',
  'Grudgels are taller and stockier than many other humanoids, typically ranging from 6 to 2.1 m in height, and weighing 200 pounds or more. Your size is Médio.',
  '9 m.',
  'Legends in Etharis speak of an age of orcs. This ancient heritage has its roots in Etharis’ North, from where history claims they spread to terrorize other cultures. Orcs, as the term has become understood, were formidable warriors with endless thirst for battle. Yet tales of their armies nearly conquering all Etharis are almost certainly the propaganda of fearful outside cultures.

Those same legends speak of how the orcs abandoned their lands en masse—not because of enemy incursions or natural disaster, but because of some mysterious calling from their ancestors to sail west across the sea. While it’s agreed that orcs did flee Etharis in a great fleet, their legacy calling to Thorgard av Holgar a century later, it seems apocryphal that an entire heritage could simply disappear across the sea. Indeed, the truth is more complex than any of those old tales can tell.

The descendants of the orcs call themselves grudgels. Their lack of resemblance to the dreadful legends about their ancestors causes the uneducated to assume orcs and grudgels are different. But what truly separates them is merely time and evolving culture.

Grudgels are an imposing folk whose physical presence has not diminished since the legends of orc warriors. Yet even where they are most populous among the Valikan Clans, grudgels are no more or less predisposed to battle or taking the path of the warrior than any other folk. Grudgels are also talented artisans, wanderers, magic weavers, and star gazers. They alone hold the secrets of forging stryllum, a strange substance that occurs when starlight is solidified into glass. Grudgels are hard-working, peaceable among friends, and have a knack for keeping calm under pressure. But they’re more than capable of defending themselves against the threats of the wilderness and folk looking for a fight.

Outside of the North, grudgels remain rare enough in Etharis that folk are less likely to meet one than hear fearful rumors regarding their kind. While a grudgel working as a bodyguard or mercenary can make use of such rumors, the one thing that seemingly connects all grudgels is a shared disinterest in discussing or hearing the ancient legends of the orcs. But whether this extends from wanting to distance themselves from the violent past of their kin, or from some secret knowledge of why the orcs vanished from Etharis, only they know.

The Grudgels’ ancient heritage marks them as distinct figures among the folk of Etharis.

Age. Grudgels reach adulthood at about the age of 16, and can live to their seventh decade or more.

Size. Grudgels are taller and stockier than many other humanoids, typically ranging from 6 to 7 feet in height, and weighing 200 pounds or more. Your size is Medium.

Speed. 30 feet.

Traditional Grudgel Traits

Many Grudgels are shaped by living as wanderers and by a long-held fascination with crafting and magic.',
  'Herança rara — povo pouco comum em Etharis, com traços modulares.',
  'Herança rara',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"rare"}'::jsonb
),
(
  'gh-laneshi',
  'Laneshi',
  'Humanoide',
  'Laneshi are typically 5 to 1.8 m tall and have slender builds. Your size is Médio.',
  '9 m. You have a Swim Speed of 9 m.',
  'Deep beneath the waves off the eastern shores of Etharis lies the Llana’Shi Empire, home to the mysterious people called the laneshi by surface dwellers. Appearing incredibly alien to other common folk, these pale humanoids with manes of kelp-like hair are creatures of the sea, able to converse with the flora and fauna of the depths. Laneshi dwell within a culture that views the world in terms of absolutes and a sense of underlying duality. Day or night. Acceptance or rejection. Friend or foe. Their culture is also entwined along the line between life and death. They commune with spirits for guidance and are unafraid to meet their mortal demise. All things must have their place in laneshi society, which is built on a rigid caste system reflecting this view.

The mystic caste comprises all laneshi born as twins, a common occurrence among their people. The first-born twin is always inducted into the mystic caste, while the other is consecrated as their sibling’s spirit guide. Using a powerful necromantic ritual, the second twin is sacrificed, its soul bound within the body of the other. Each member of the mystic caste is therefore possessed of two souls—one living and one dead—which grants them vision into the spirit world and heightens their necromantic abilities. Mystics oversee funeral rites, crafting, construction, recordkeeping, and food preparation. The heavier duties of members from this caste are even performed with the aid of undead labor—a nightmarish vision for surface-dwelling folk.

The warrior caste of the laneshi oversee not just warfare but diplomacy, farming, and the raising and educating of children. The warrior caste is roughly double the size of the mystic caste, structured as a meritocracy, with great deeds leading to greater status.

Laneshi warriors skirmish constantly with their deep-dwelling neighbors. But at the same time, the rulers of the Llana’Shi Empire have begun to focus on the surface world for unknown reasons. Perhaps some new and greater threat stirs in the dark depths of the sea, and the laneshi seek aid from their air-breathing cousins. Or perhaps there’s truth in the fearful whispers that these aquatic visitors have wrought blasphemous pacts with ancient evils, and the laneshi search for new lands to conquer to appease the hunger of an unnamable master.

Among the other folk of Etharis, Laneshi are unique in their appearance and their aquatic nature.

Age. Laneshi mature quickly, reaching adulthood at around 14, and can live up to 150 years.

Size. Laneshi are typically 5 to 6 feet tall and have slender builds. Your size is Medium.

Speed. 30 feet. You have a Swim Speed of 30 feet.

Traditional Laneshi Traits

Their unique undersea culture shapes the talents and drives of many Laneshi.',
  'Herança rara — povo pouco comum em Etharis, com traços modulares.',
  'Herança rara',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"rare"}'::jsonb
),
(
  'gh-ogresh',
  'Ogrês',
  'Humanoide',
  'Young Ogresh typically stand 6 to 2.1 m tall, and sport a distinctively wide and heavy build. A young Ogresh usually ranges between 200 and 300 pounds, while an older Ogresh can reach upward of 700 to 800 pounds. Your size is Médio.',
  '9 m.',
  'The more populous cultures of Etharis all have stories about the ogresh, although few have seen these gentle giants in person. Tales describe them as solitary, wise figures who often serve as founts of information and advice for nearby communities. Adventure tales abound in which a protagonist receives counsel from an ogresh before setting off on their quest, even as others describe royal advisors with a distinctive set of broad features. These tales are not without merit, as ogresh can be worldly from their travels in their younger years. Yet even outside the scope of such stories, those who know the ogresh often view them as something of an exotic oddity.

In truth, the scarcity of the ogresh is a result of their particular biology. Young ogresh mature slowly, and during an extended youth that might last decades, they are driven by a deep-seated sense of wanderlust. This feeling compels them to travel in search of a suitable area to settle—one holding ample natural resources, a local population of sentient creatures, and a lack of other ogresh nearby. Once they decide upon an area, an ogresh enters the second stage of their life, which is marked by a drastically increased appetite and a mostly sedentary lifestyle. More than a single ogresh could easily deplete the surplus of a small village, so the reason for their wanderlust is a simple case of biological necessity.

Given their reliance on other folk for survival, it comes as no surprise that many ogresh are masters of social interaction. But some folk maintain that the ogresh ability to glean insight from others has an unnatural quality to it, revealing more to the ogresh than most creatures would willingly share.

He’s a fantastic investigator. Most suspects confess as soon as they see him, and the rest spill after a few moments of conversation.

An ogresh’s formidable size and slow aging makes them stand out in settled lands.

Age. Ogresh reach maturity around age 25 but are considered youthful by their kin for decades afterward. They can live as long as 300 years.

Size. Young Ogresh typically stand 6 to 7 feet tall, and sport a distinctively wide and heavy build. A young Ogresh usually ranges between 200 and 300 pounds, while an older Ogresh can reach upward of 700 to 800 pounds. Your size is Medium.

Speed. 30 feet.

Traditional Ogresh Traits

A wandering lifestyle, and an innate ability to read other creatures, shapes and defines many Ogresh.',
  'Herança rara — povo pouco comum em Etharis, com traços modulares.',
  'Herança rara',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"rare"}'::jsonb
),
(
  'gh-accursed',
  'Amaldiçoado',
  'Humanoide',
  'Accursed can range in size from under 0.9 m to 1.8 m or more, with a wide range of body types to match. Your size is Pequeno or Médio, as you determine.',
  '9 m. If you are Pequeno, you can reduce your Speed by 1.5 m to gain an extra trait.',
  'The accursed are the rarest and least understood of all the heritages of Etharis—because each accursed is effectively a heritage unto themself. Whether created by unique magic, brought to the world through planar gates or extradimensional portals, or representing one of the last members of a heritage thought to have been lost to history, an accursed is a creature whose traits are all freely chosen with a specific character concept in mind.

Accursed are so named not because their birth or creation was the result of magical malfeasance, a hag’s bargain, a corrupted scroll, or any of the other typical senses of “curse” in the game. Rather, accursed reflects the grim sense of how most other folk in the campaign will view such a character, especially those who don’t take the time to learn more about the character’s life and outlook. This heritage is intended to encourage players to decide who their character is with a maximum amount of creativity. It’s a sort of “catch-all” for unique characters who don’t fit into another heritage, but can still fit into Grim Hollow.

Accursed typically don’t represent a people or a culture and are often entirely unique unto themselves. One player might create an accursed character taking the form of a halfling-sized talking raven who hatched from a petrified basilisk egg during a full moon. In all the world, there is no one else quite like them, and the combination of heritage traits chosen by the player of that accursed character reflects as such. Another player might choose the accursed heritage to reflect the form and capabilities of a lizardfolk—a heritage that doesn’t canonically exist in Grim Hollow. Whether that accursed character represents a wanderer who set out from a lost lizardfolk enclave deep in the Black Mire, or a character born to elf parents cursed by an evil mage, their selection of heritage traits defines their unique place in the world.

The unique nature of each Accursed is reflected in a breadth of form and longevity.

Age. Accursed that strongly resemble other humanoids might have a longevity only slightly different than those other folk. However, unusual Accursed might age quickly or live effectively ageless lives until cut down by tragedy.

Size. Accursed can range in size from under 3 feet to 6 feet or more, with a wide range of body types to match. Your size is Small or Medium, as you determine.

Speed. 30 feet. If you are Small, you can reduce your Speed by 5 feet to gain an extra trait.

Traditional Accursed Traits

The unique nature behind your creation or the evolution of your exceedingly rare kind dictates the traits that define you. If you resemble or once lived as one of the standard heritages of Etharis, you might choose one or more of the traits of that heritage as a starting point. But you are free to choose any traits as you determine, creating a character whose unique nature shapes their experience in the world.',
  'Herança eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
  'Herança eldritch',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"eldritch"}'::jsonb
),
(
  'gh-arisen',
  'Reerguido',
  'Humanoide',
  'Arisen can be any size, from compact constructs 0.6 m tall, to towering figures topping 2.1 m. Your size is Pequeno or Médio, as you determine.',
  '9 m. If you are Pequeno, you can reduce your Speed by 1.5 m to gain an extra traditional trait.',
  'The arisen are spoken of in fearful whispers across Etharis, all too often proclaimed unnatural entities that can be neither trusted nor redeemed. For although they are humanoids, each arisen is a unique construct created by magic, mysterious science, or both.

Arisen are never born in their current form. They are not undead, nor have they been raised from death by divine magic. Rather, each arisen is constructed and given the gift of life, usually by a creator. Arisen are people, to be sure. They have unique personalities, intellects, and experiences, as all humanoids. But do they possess souls? That is an existential question that all arisen must grapple with.

Arisen are made from mostly organic matter. They are not machines, though many possess mechanical parts in small or large measures. One arisen may have a single mechanized limb, while another’s organs are held in a cluster of jars. An arisen may have wires protruding from their body that connect to an arcane power supply grafted into their back, while another appears entirely mundane save for some scars and the arcane gems held within their eye sockets.

Some arisen are entirely constructed, built according to some specification or plan. Others start out innocuously through experimentation to replace living limbs or organs, with repeated experiments inexorably pushing a creature to lose all connection to themself. Still others might be the result of a living creature who died or was grievously injured before being “reassembled.” But no matter the process that spawned them, the creation of an arisen is often traumatic, typically held as fractured memories of arcane laboratories and the first flickering of consciousness, or as the vague nightmares that are all that remains of a former life.

Their rarity among the peoples of Etharis and the grim rumors that swirl around them most often leave arisen socially isolated. But not all arisen are driven to nihilism by the bleakness of their creation and their lives. For from that trauma, many develop a sense of introspection that drives an intense curiosity and a philosophical viewpoint on matters of life, mortality, and their own place in the world.

Each Arisen character is shaped by the unique nature of the magic or circumstances that created them.

Age. Some Arisen age slowly, the artificial nature of their bodies sloughing off the worst effects of age to leave them hale even into their second or third century. Others age more quickly, worn down by the unnatural magic that imbues them well before their sixtieth year.

Size. Arisen can be any size, from compact constructs 2 feet tall, to towering figures topping 7 feet. Your size is Small or Medium, as you determine.

Speed. 30 feet. If you are Small, you can reduce your Speed by 5 feet to gain an extra traditional trait.

If the whirring engine didn’t give it away, the rotting flesh would have.

Traditional Arisen Traits

The artificial forms that all Arisen share often establish the baseline of their talents and instincts.',
  'Herança eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
  'Herança eldritch',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"eldritch"}'::jsonb
),
(
  'gh-dhampir',
  'Dhampir',
  'Humanoide',
  'A Dhampir is the same size as the humanoid they were spawned from. You are Pequeno or Médio, as you determine.',
  '9 m. If you are Pequeno, you can reduce your Speed by 1.5 m to gain an extra traditional trait.',
  'A dhampir is marked by a forbidding birthright—a humanoid half-cursed with vampirism, living as a mortal but touched by a dreaded immortal power. A dhampir possesses many of the grim features of their undead sires, but their mortal nature lets them avoid vampiric vulnerabilities. Like their creators, dhampir crave the blood of the living, but are not controlled by such cravings if their will is strong enough to resist it.

Always spawned from creatures of other heritages, dhampir are incredibly rare and vary widely in form and temperament. The only thing all dhampir truly share is the legacy of their unnatural creation. True vampires are the embodiment of death, mimicking life by twisting cadavers into undead or spreading their curse to spawn more of their own kind. But vampires cannot naturally reproduce or create anything truly living. Dhampir are thus most often the result of some form of necromantic accident—a dying child revived by fell magic, an apothecary mixing herbs with vampire blood, or a failed attempt to find a cure for vampirism.

Whatever their origins, most dhampir experience an existence rooted in trauma, and often pervaded by loneliness. Commoners who fear dhampir view them as blood-hungry monsters, despite the fact that most sustain their life with normal food and drink. At the same time, vampires revile them as thin-blooded weaklings. A dhampir’s life is thus usually spent searching for somewhere to belong, whether fitting into mortal society or trying to appease their blood-drinking forebears.

A dhampir who chooses life among mortals is often wracked by guilt. Their craving for blood can come to feel all-consuming as they cling to their humanity and empathy. Dhampir are made to feel like monsters by those who are superstitious of them. Yet commoners who care for a dhampir as family can never truly understand their struggle against the monster within.

Other dhampir decide to indulge their bloodlust. They may even vie for position among the nobility of Ostoya. Despite lacking conventional parentage, a dhampir may form a familial bond with the vampire they regard as their sire. Vampires who exploit this relationship can gain a valuable ward who is able to walk in sunlight and blend more easily with mortal society. A dhampir in this position may become a spy, steward, or herald of their master. But they understand that they will never achieve positions of actual power in vampire society.

The physical nature of a Dhampir is shaped by the creature they once were, and by the nature of their curse.

Age. The curse that creates a Dhampir makes them ageless, letting them ignore the passage of time—though they can succumb to death in many other ways.

Size. A Dhampir is the same size as the humanoid they were spawned from. You are Small or Medium, as you determine.

Speed. 30 feet. If you are Small, you can reduce your Speed by 5 feet to gain an extra traditional trait.

Traditional Dhampir Traits

The vampiric features they inherit inevitably mark the Dhampir as who they are.',
  'Herança eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
  'Herança eldritch',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"eldritch"}'::jsonb
),
(
  'gh-disembodied',
  'Desencarnado',
  'Humanoide',
  'Disembodied appear as translucent versions of their former selves, their nearly insubstantial nature reducing their weight to a quarter of what it was. Your size is Pequeno or Médio, as you determine.',
  '9 m. If your size is Pequeno, you can reduce your Speed by 1.5 m to gain an extra traditional trait.',
  'To allow one’s mind to touch the planes is the ultimate dream of many an arcane spellcaster, and nowhere has that dream come closer to reality than in the lost city of Ulmyr’s Gate. Founded in the Bürach Empire by a group of ambitious wizards who chafed under the limitations imposed upon them by government bureaucracy, Ulmyr’s Gate boasted free study for all mages who sought sanctuary within its walls. The Great College dedicated to magical study in the city quickly became a sanctum for mages of all disciplines from across Etharis, creating a golden age of magic within its walls.

That golden age came crashing down in a single night, when the founding mages of Ulmyr’s Gate attempted an ambitious ritual intended to part the veil and create a permanent portal to the Ethereal Plane. Instead, their magic tore a gaping rift in the fabric of reality, and in an instant the entire city was tipped into the void between worlds. Ulmyr’s Gate and all its citizens were presumed destroyed. The incident triggered another inquisition against hubristic arcanists who tampered in things mortals were not meant to know. Then, life in the empire went on.

Years later, stories began to surface of frightening apparitions sighted in the region where Ulmyr’s Gate once stood. These haunting folk seemed oddly blurred or indistinct. Witnesses reporting that they would vanish as suddenly as they appeared. Gradually, it became clear that these poor souls were the survivors of the Ethereal Rift, now trapped between worlds and trying to retain their tenuous grasp on the Material Plane.

Those residents of lost Ulmyr’s Gate who have mustered the strength to return to the world have been named the disembodied by the sages who have studied them. These rare individuals have left or fled their former home, crossing through the Ethereal Rift to roam the mortal world. Though they resemble the people they once were, they are both more and less—creatures of two realms, often haunted by memories of the city’s destruction, of which they rarely if ever speak.

Though their presence in the world is shaped by magic, the forms of the Disembodied appear much as they did before the disaster that spawned them.

Age. The Disembodied mature at a much slower rate than the Humanoids they once were, with their life expectancy doubled or even tripled.

Size. Disembodied appear as translucent versions of their former selves, their nearly insubstantial nature reducing their weight to a quarter of what it was. Your size is Small or Medium, as you determine.

Speed. 30 feet. If your size is Small, you can reduce your Speed by 5 feet to gain an extra traditional trait.

The day Ulmyr’s Gate fell, the area eerily was quiet…for a time.

Traditional Disembodied Traits

Most Disembodied retain a touch of the ethereal magic that marks them as creatures of two worlds.',
  'Herança eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
  'Herança eldritch',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"eldritch"}'::jsonb
),
(
  'gh-downcast',
  'Relegado',
  'Humanoide',
  'Downcast generally range from 5 to 1.8 m tall and have a wide range of body types. Your size is Médio.',
  '9 m.',
  'At the conclusion of the Gods’ End, a thousand souls fell to Etharis like burning stars from the sky. The downcast had once been part of the celestial legions, but the death of the gods sent shockwaves through the heavens. Cast down to the mortal realm, these former angels found themselves bereft of power and left to live out their now-mortal existence among the people of the world.

In the absence of the gods, the Arch Seraphs of each deity descended upon the mortal realm, taking upon themselves the burden of imposing order on a world cast into disarray. The Arch Seraphs were the most powerful lieutenants among the angelic hosts, strong enough to retain a semblance of their divine power following the tragedy. But an angel is not a god. An Arch Seraph cannot embody every aspect of a divine domain. Some became consumed with enforcing narrow virtues. Others have turned from grace entirely, choosing to embody vice rather than virtue, and becoming feared as Arch Daemons.

The downcast, are far fewer in number than when they first arrived. Many succumbed to despair and sickness after their fall from grace. Of those who remain, some still serve the Arch Seraphs in their twisted crusades, hoping to reclaim what they have lost. Others have turned their backs on their former comrades to seek their own goals, fully embracing mortal life. And more than a few feel embittered enough by their fall that they have been gleefully accepted by the Arch Daemons as agents to spread fear and destruction in the world.

Physically, the downcast still possess the beauty of their angelic forms, although they no longer shine as brightly as before. For most, the mark of the divine still lingers as a visible glow within their eyes, or faintly glowing Celestial runes on their otherwise unblemished skin. Others have been marked by their shift in morality, manifesting cracked skin or devilish horns.

Though mortal, Downcast are still touched by the celestial nature that has been taken from them.

Age. Stripped of their immortality, the Downcast nevertheless possess long lifespans to rival even the elves. A Downcast reaches maturity in their late teens, but can live up to 800 years.

Size. Downcast generally range from 5 to 6 feet tall and have a wide range of body types. Your size is Medium.

Speed. 30 feet.

Brother Adovald is no longer welcome in the sanctuary. When last we spoke, he had some…unkind words for the Arch Seraphs.

Traditional Downcast Traits

Many Downcast channel magic driven by the vestiges of celestial power that still flow through them.',
  'Herança eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
  'Herança eldritch',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"eldritch"}'::jsonb
),
(
  'gh-wechselkind',
  'Wechselkind',
  'Humanoide',
  'Built to resemble a child, Wechselkind are between 2 and 0.9 m tall and weigh between 35 and 55 pounds. Your size is Pequeno.',
  '9 m. You can reduce your Speed by 1.5 m to gain an extra traditional trait.',
  'A mother hears a sound in the night and worriedly checks on her sleeping toddler. Nothing appears amiss. But weeks later, an unseen glamour fades and a horror is revealed: the child has been stolen by the faerie, and a wechselkind is left in their place. For the faerie are callous and unchanging beings, and nothing inspires their fascination—and their envy—more than the malleable, bright spark of a young humanoid child.

A wechselkind is a construct crafted of wood, clay, and ceramic in the form of a small child, animated by faerie magic and concealed in illusion that makes them appear identical to a stolen mortal babe. Once that glamour fades and the lie is revealed, a wechselkind is most often cast out by the stolen child’s family, if not destroyed. Occasionally, though, a family takes pity on the poor creature and attempts to raise them, only to find that while their mind develops normally, a wechselkind is forever bound in the unchanging form of a childlike doll.

Whether nurtured or shunned, most wechselkind eventually find themselves living as outcasts, and learning to fend for themselves as best they can. The residual magic of their faerie glamour allows a wechselkind to conceal themself for short periods, whether in the guise of the child they replaced or an adult halfling, gnome, or other person of similar stature. With few physical needs, a wechselkind can easily wander from settlement to settlement, watching the people they encounter with envious eyes, and hoping for a place to finally fit in.

With the spread of the Weeping Pox, many wechselkind have emerged from hiding. With their immunity to disease, they’re able to aid healers in plague-stricken regions, gaining a measure of respect—or even admiration—from those able to see beyond their tragic origins. However, even wechselkind who are accepted among other folk often remain wary, fearing that once their usefulness is at an end, they might be cast out once more.

Enchanted with powerful faerie magic, Wechselkind are unique among other Humanoids.

Age. Wechselkind do not age as normal creatures do, forever trapped in the doll-like visage of their creation. Their maximum age is a function of natural wear and damage, and they are immune to magical aging effects.

Size. Built to resemble a child, Wechselkind are between 2 and 3 feet tall and weigh between 35 and 55 pounds. Your size is Small.

Speed. 30 feet. You can reduce your Speed by 5 feet to gain an extra traditional trait.

They’re astoundingly quick studies and eager assistants. Thankfully, our patients don’t seem to mind the splinters.

Traditional Wechselkind Traits

The magical and artificial nature shapes the aptitudes and innate features of all Wechselkind.',
  'Herança eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
  'Herança eldritch',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"eldritch"}'::jsonb
),
(
  'gh-wulven',
  'Wulven',
  'Humanoide',
  'Wulven are the same general height as others of their original heritage, but are often stockier, more muscular, or lither, depending on the nature of the curse that touches them. Your size is Pequeno or Médio, as you determine.',
  '9 m. If you are Pequeno, you can reduce your Speed by 1.5 m to gain an extra traditional trait.',
  'Across wilderness and settled lands, in forest hamlets and farmsteads, the fear of lycanthropy runs deep. But few folk ever come to realize that the hulking stranger they passed on the trade road at dusk, the forest hermit who appeared from nowhere to warn of unseen danger ahead, or the druidic acolyte protecting a sacred spring do not share their fears. For these folk have already been touched by the lycanthropic curse, and have accepted the bestial gifts it bestows.

Wulven are the natural-born children or descendants of an individual cursed with lycanthropy, not inheriting the curse in full but touched by its feral nature. Those afflicted in this way are commonly associated with werewolves in the minds of commoners, inspiring the name given to them. But wulven are equally likely to be descended from werebears, wererats, wereravens, or even rarer lycanthropes.

The weaker trace of lycanthropy handed down to a wulven means they do not take animal or hybrid form. They are as calm and personable as any folk, suffering no loss of control or mindless bloodlust under the full moon. However, the feral nature of the beast they carry within them drives most wulven to lives of solitude and the quiet of the wilderness.

Wulven embody the mysticism of the primal world, rather than its savagery. Where they wander through forest and scrubland, their wild look and solitary nature sees them often mistaken for fey spirits, druids, or actual lycanthropes. Many make lives for themselves as members of druidic enclaves or as protectors of small, isolated communities. Some become emissaries or champions of the fey courts, though the touch of cursed magic in the wulven makes some fey distrust them. But in the end, most wulven live as outlanders, cautious around folk they don’t know for fear of their solitary nature and subtly bestial features being misunderstood.

Wulven can arise among any other culture or folk, and draw on the physical features of those folk.

Age. Wulven mature at the same rate as others of their original heritage, but the magic that spawns them lessens the debilitating effects of aging, and they remain fit even in their later years.

Size. Wulven are the same general height as others of their original heritage, but are often stockier, more muscular, or lither, depending on the nature of the curse that touches them. Your size is Small or Medium, as you determine.

Speed. 30 feet. If you are Small, you can reduce your Speed by 5 feet to gain an extra traditional trait.

Traditional Wulven Traits

Many Wulven channel the natural instincts—and often the natural fierceness—of the creature their curse links them to.',
  'Herança eldritch — origem sobrenatural ou amaldiçoada; sistema modular de 8 traços (combate, exploração e interpretação).',
  'Herança eldritch',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage","heritageCategory":"eldritch"}'::jsonb
),
(
  'gh-heritage-traits',
  'Traços de herança',
  'Referência',
  '—',
  '—',
  'Lista completa dos traços modulares de herança do Grim Hollow (combate, exploração e interpretação). Cada traço pode ser tomado mais de uma vez para benefícios aprimorados.',
  'Catálogo de traços modulares GH — escolha 8 ao criar um personagem com herança.',
  'Referência GH',
  '{"editionSlug":"grim-hollow-players-guide-2024-en","book":"Grim Hollow: Player''s Guide","language":"pt","citationSlug":"grim-hollow-players-guide-2024-en:chapter-1-heritages-traits","source":"grim-hollow","kind":"heritage-trait-index","catalogOnly":true}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  creature_type = EXCLUDED.creature_type,
  size = EXCLUDED.size,
  speed = EXCLUDED.speed,
  description = EXCLUDED.description,
  summary = EXCLUDED.summary,
  tagline = EXCLUDED.tagline,
  source_meta = EXCLUDED.source_meta;
