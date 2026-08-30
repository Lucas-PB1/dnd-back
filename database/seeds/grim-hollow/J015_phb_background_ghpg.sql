-- Grim Hollow Cap. 3 — antecedentes jogáveis (PHB 2024 style)

INSERT INTO rpg.phb_background (
  slug, name, description, tagline, summary,
  feat_id, source_citation_id, equipment_gold_option,
  tool_proficiency_description, tool_proficiency_kind, tool_item_id, tool_category_id,
  language_choice_count
)
VALUES
(
  'gh-agent-of-the-augustine',
  'Agente da Augustine',
  'You’ve used your education and knowledge from working on behalf of the Augustine Trading Company. You’ve been generally held in high regard by those who can use the knowledge you’ve gained, while others look upon your work for the organization as unsavory. Your training, however, makes you a versatile problem-solver.

You’ve learned your craft from smugglers, merchants, blackmailers, and brigands who came before you. You may still work for the organization, or your may have had to cut ties for being too honest, too dishonest, or just in the wrong place at the wrong time. Whatever your connections, you have traveled more than most people in Etharis can ever dream of.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: insightful-collector.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'insightful-collector'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Forgery Kit',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-falsificacao'),
  NULL,
  0
),
(
  'gh-antiquarian',
  'Antiquário',
  'You are fascinated with studying history and identifying ancient artifacts, relics, and texts. You seek to gather rare and lost items to add to your collection or the collections of others. Your skill with identifying the properties of artifacts and historical objects makes you an adept problem-solver, especially when ancient relics and languages are involved.

Funding expeditions to search for these artifacts is often expensive, meaning you seldom travel without the backing of a wealthy patron or organization. These groups, like the Antiquarians they fund, have motives that range from the beneficent to the sinister. If you diverge from the intended goals of your benefactors, you might find yourself unfunded at best and hunted at worst.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: skilled.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'skilled'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Tinker’s Tools',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-funileiro'),
  NULL,
  0
),
(
  'gh-beast-hunter',
  'Caçador de Feras',
  'You make your living by trapping, hunting, and killing vicious beasts. Your efforts might provide meat and furs for settlements or for trade. When a nearby beast is particularly vicious, you become a community’s best defense against the destruction wildlife can cause. While you hunt mundane beasts, you know there are more dangerous and supernatural creatures roaming the darkness.

You and your fellow hunters are often as brutish as the creatures you hunt, heavily scarred from close encounters with your prey. In order to take down your prey, you must think and react as they might.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: blood-hound.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'blood-hound'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Leatherworker’s Tools',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-coureiro'),
  NULL,
  0
),
(
  'gh-beggar',
  'Mendigo',
  'Many who fall on hard times have no other option than begging for coppers. Considered the lowest rung of society, you are looked down upon in either pity or contempt by other members of society, when they bother to notice you at all. For your part, you see people at their best and at their worst—a more honest representation than they show their peers or superiors.

If you are from a major metropolis of Etharis, you might be much more than you appear. You may act as an informant, spy, distraction, or worse—working right under the noses of those who treat you as part of the scenery. This might make you wealthier than you let on, and people in the know treat you with a modicum of respect and caution.

I was told everything I was doing on my raids was for the glory of Clan Völgr and for the well-being of the entire world. The speakers of the Prismatic Circle told us that the Great Wyrm Gormadraug was wakening, and we had to ensure its continued slumber. But the things I’ve seen. The blood and the sacrifices. It was all too much.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: survivor.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'survivor'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Disguise Kit',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-disfarce'),
  NULL,
  0
),
(
  'gh-chapter-knight',
  'Cavaleiro de Capítulo',
  'Knights of the Charneault Kingdom are more than soldiers. You’re an exemplar of the virtues that maintain peace and prosperity in the realm. Through training and study, you’ve dedicated your life to upholding noble ideals such as strength, bravery, charity, temperance, and tradition. Your shield bears a coat of arms which symbolizes the tenets to which you’re sworn—those of your household or Knight Chapter. If you are still a squire, yet to accomplish your first quest, your shield is blank.

You might receive many honors during your journeys, though much will be expected of you. Folk may look to you as a protector, leader, or keeper of traditions—or you may be feared as a stern justiciar of the Crown’s justice. The path of a knight is difficult and perilous, and not all who walk it maintain their virtues.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: savage-attacker.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'savage-attacker'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Choose one kind of Musical Instrument',
  'choice',
  NULL,
  (SELECT id FROM rpg.phb_tool_category WHERE slug = 'instrument'),
  0
),
(
  'gh-courtier',
  'Cortesão',
  'You were either born into a role within the courts or power structures of your area, or you worked your way into the company of the powerful or elite through perseverance, skill, trickery, or some combination of those. You draw upon the power of your institutions to gain what you need—but you’re always at the mercy of those institutions as well.

You may have a specialized role within the system, such as a court jester or sommelier. Or you may occupy a more generic role as a hanger-on, whose role is undefined but whose power rests in simply being connected to someone with the power to get what is needed.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: skilled.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'skilled'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Musical Instrument or Artisan’s Tools',
  'choice',
  NULL,
  (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'),
  0
),
(
  'gh-disgraced-raider',
  'Saqueador Desonrado',
  'You were a raider associated with one of the greatly feared Valikan clans . The terror you and your allies struck within sailing distance of your homeland was massive and palpable. The risks were great, but the respect was undeniable.

You lost that respect, however, when something went wrong. Perhaps you lost your nerve and fled the battlefield. Perhaps you lost your mind and killed when you were only supposed to capture. Perhaps you saw the terror you inspired in others as a moral failing rather than a point of honor. Regardless, you were cast out of your clan and told never to return. You now travel Etharis having to live with what you’ve done and the shame (or honor) of your clan’s shunning.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: savage-attacker.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'savage-attacker'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Navigator’s Tools',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-navegador'),
  NULL,
  0
),
(
  'gh-envoy',
  'Enviado',
  'You are the official representative of a government or other powerful group, traveling to further the objectives of the group you represent. You must be ready at a moment’s notice to travel to the next town, or to other parts of the world. Such travel requires not just social skills but also a strong drive and a hardy disposition.

Your responsibilities change based on the organization you represent and their goals: forge alliances or maintain existing ones, establish business ties, oversee far-ranging projects, etc. However, many of your tasks are reactive: responding to a noble’s threats, securing defensive pacts in times of conflict, or bolstering border defenses. Everywhere you go, something is at stake.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: skilled.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'skilled'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Calligrapher’s Supplies',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'suprimentos-de-caligrafo'),
  NULL,
  0
),
(
  'gh-executioner',
  'Carrasco',
  'You were employed as an executioner by some group or organization in a position of power. Your legally sanctioned murders have given you a strong arm and a knowledge of death and fatal blows.

You may have worked for the Crimson Court, dispatching those who work against the nobility (if their blood is not worth draining). You may have worked for the Arcanist Inquisition, putting unrepentant mages to death. You may have carried out sanctioned sacrifices for the Prismatic Circle.

For some reason, you left your career: maybe you were wracked by guilt, maybe the group you worked for fell out of power, maybe you displeased your bosses, or maybe you decided to move on to a different occupation. But your actions have stayed with you, and your time as a dealer of death have made a lasting impact.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: deathbound.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'deathbound'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Smith’s Tools',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-ferreiro'),
  NULL,
  0
),
(
  'gh-explorer',
  'Explorador',
  'You pursue a life traversing the wilds, driven by wanderlust or the orders of a distant patron. For you, there is no greater pursuit than to discover the lost, forgotten, and unseen reaches of the world. You may travel unaccompanied or lead companions, establishing encampments in remote areas or living completely off the land. You might lead pioneers looking to settle uncharted lands.

You may help establish settlements in the areas you explore, but before long, your attention wanders, and the call of the unknown beckons too strongly to ignore. And when that happens, you blaze a new trail into the darkness, rushing headlong into whatever thrills await.

In the seedier parts of the city, I’ve seen rats the size of wechselkind strolling down the alleys like they’re tax-paying citizens. I saw a swarm of ‘em eat a family as they were sitting down for dinner. Some people say Walstein is a ruin overflowing with monsters. Well, I say they should take a good look at Liesech. Maybe not a ruin, but definitely not lacking in the monster department.

- Freelance Exterminator in Liesech',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: alert.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'alert'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Navigator’s Tools',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-navegador'),
  NULL,
  0
),
(
  'gh-exterminator',
  'Exterminador',
  'Etharis is overrun with vermin, but you focus on the pests of the four-legged variety. In the cities these are generally rats and other rodents. In the country, the pests might come in the form of raccoons or other critters that steal food and destroy structures piece by piece.

You’ve trained in the arts of getting pests away from people and coin away from clients. You may run an honest business, helping farmers and shop owners eliminate potentially life-threatening pests. Or you may introduce those pests in the first place, then solve the problem you created, skipping town before your ploy is discovered.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: magic-initiate.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Poisoner’s Kit',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-veneno'),
  NULL,
  0
),
(
  'gh-fey-blessed',
  'Abençoado pelas Fadas',
  'The powerful and fickle faerie-folk of your area have taken note of you, and your existence pleases them. Whether you were born under a lucky star, had a favorable run-in with a nature spirit, or simply were in the right place at the right time, the fey favor you with small gifts and boons. You find small trinkets in your shoes when you wake up in the morning. Beasts of the forest and field are more receptive to your presence and your training. Will this blessing somehow turn into a curse later in your life?

People you encounter instantly recognize your connection with the Realm of Faerie. Sometimes this works to your favor, as folks seem entranced by your glowing personality. Others see your power as a curse just waiting to seep into their lives. And they may not be wrong!',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: magic-initiate.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Choose one kind of Musical Instrument',
  'choice',
  NULL,
  (SELECT id FROM rpg.phb_tool_category WHERE slug = 'instrument'),
  0
),
(
  'gh-free-swords-mercenary',
  'Mercenário das Espadas Livres',
  'Mud, blood, and coin have been your entire life since joining the Company of Free Swords. You may have been recruited from a fighting pit in Unterland, joined as a fugitive to escape justice, or been found as a babe in the mud and raised as a Free Sword. Your history before joining the Company doesn’t matter now. Your comrades are your family. Violence is your trade.

The infantry ranks of the Free Swords live by the unspoken rule of Etharis—it’s a place where only the strong survive. Your ambitions may stretch only as far as your payment for enduring the next battle. Few expect anything more from you. Yet a hidden ideal may truly drive your actions, or you may hope to lead your own company one day.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: free-sword-mercenarys-will.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'free-sword-mercenarys-will'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Gaming Set (your choice)',
  'choice',
  NULL,
  NULL,
  0
),
(
  'gh-heretic',
  'Herege',
  'You have learned that the dominant religious beliefs of your region are lies. The corrupting forces may be in charge, but you will not rest until you have shown their lies as corrupt and untrue. Your beliefs, and your willingness to speak that truth, have put you in danger from the authorities.

You travel the road or live in hiding, trying to stay one step ahead of those who wish to silence you. You sometimes find those who believe as you do, and in those moments of unity you find peace and safety. But it is only a matter of time before your outspoken opposition to the status quo puts you in danger again.

Her parents wailed the day little Inga disappeared, even though she was the youngest of their twelve brood. They got over it quick enough. Then, twenty years later, when they’ve got great-grandkids running around, Inga turns up on their doorstep—and she hadn’t aged a day. Worse yet, she seems off. Like she knows things. I’m keeping my cats away from their yard just in case. I expect the Inquisitors to investigate soon. Because I told them about her.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: magic-initiate.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Disguise Kit',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-disfarce'),
  NULL,
  0
),
(
  'gh-inquisitor-of-the-faithful',
  'Inquisidor dos Fiéis',
  'You are a servant of the Watchers of the Faithful, hunting down heretics and blasphemers within your own faith, cultists of sinister powers, or other threats to your divine order. Divine justice does not discriminate, and you have mercilessly punished crimes both mundane and supernatural—tasks that come with little glory.

Your home is the road, and you must travel to wherever rumors of the sinful and the deviant take you. Corruption is just as likely to fester within as without, so you must be ever watchful of those who travel with you. Those found guilty, wherever they hail from and whatever their reason, must be faced without mercy.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: convincing-inquisitor.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'convincing-inquisitor'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Navigator’s Tools',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-navegador'),
  NULL,
  0
),
(
  'gh-lapsed-inquisitor',
  'Inquisidor Desviado',
  'You spent years traveling the countryside as a member of the Arcanist Inquisition, seeking out heretics and blasphemers, daemons and arcanists. Your work uncovered hidden evil that likely saved the lives of countless innocents. However, on more than one occasion, your or others’ zeal brought low innocents.

After a crisis of conscience, you left the ranks of the inquisitors. Leaving the Inquisition is itself a dangerous prospect, but you could no longer abide. Maybe someone you love and care for is starting to show arcane affinities that would have led to their destruction. Maybe you are. Maybe the last investigation you carried out opened your eyes to new realities. Now you are living with a target on your back. Your former peers don’t take kindly to people leaving their ranks. Those you persecuted have not forgotten your deeds. But life must still be lived, and there’s more than one way to find and destroy the evil in the world.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: convincing-inquisitor.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'convincing-inquisitor'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Navigator’s Tools',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-navegador'),
  NULL,
  0
),
(
  'gh-one-of-the-taken',
  'Um dos Tomados',
  'On the fringes of the civilized world, parents warn their children not to wander away from their homes, especially at night. The many creatures that haunt the forests, from the faerie-folk to the minions of the Great Beast, spell doom for the innocent who stray too far into the darkness. You failed to heed your parents’ warnings, and you were taken. In fact, those who know of your experience use that word to describe you: Taken.

You do not remember what happened to you while you were away, but through some mysterious and possibly fortunate circumstances, you wandered back into town after months or years of going missing. Maybe the fairies whisked you off to some magical realm. Maybe evil cultists of an Arch Daemon held you prisoner, planning to sacrifice you to their dark leader when the time was right, and you found a way to escape. Maybe one of the Beast’s warped and feral minions took a liking to you and kept you as a pet. Whatever your story, you can’t remember your time away. But that doesn’t mean you weren’t changed by it.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: magic-initiate.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Woodcarver’s Tools',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-carpinteiro'),
  NULL,
  0
),
(
  'gh-physician',
  'Médico',
  'Your skills treating the sick and injured have given you a vast knowledge of illnesses and remedies based on the latest science—or the most recent theories from those who like to push the limits of what science might allow.

You may have come into the field in a variety of ways and with a variety of specialties. You might have learned at an institute with the finest medical minds in all of Etharis. Or you might have learned your skills through trial and error, as the poor residents of the surrounding area come to you based on rumors of your preternatural healing powers that are rather mundane.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: triage-expert.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'triage-expert'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Herbalism Kit',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-herbalismo'),
  NULL,
  0
),
(
  'gh-pioneer',
  'Pioneiro',
  'There is still land in Etharis where no one has lived before, and pioneers are the hardy folk who set out to tame that land for the first time. You’ve learned to find a suitable area to live, set up the beginnings of a village, build the dwellings needed for settlers, then move on.

You have weathered punishing storms, migrations, and harsh winters. You and yours have adapted to the environment. Everything you own is built with your own two hands, and your aptitude in working with natural materials has provided you with shelter, tools, and clothing.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: survivor.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'survivor'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Carpenter’s or Mason’s Tools',
  'choice',
  NULL,
  NULL,
  0
),
(
  'gh-pit-fighter',
  'Lutador de Arena',
  'Unterland was the first of the provinces to host blood-sport arenas, back in the days before the formation of the Bürach Empire . Since then, the practice has been driven underground, but, like poison spreading silently throughout a healthy body, it has infiltrated nearly every major city.

Ostensibly illegal, you can almost always find small groups of desperate individuals putting their lives on the line for the amusement and enrichment of others. This hidden network of arenas has recently been organized into the self-proclaimed Pit Fighter’s Guild and developed a series of coded phrases and symbols to identify its members. You follow the unspoken rule of Etharis: only the strong survive.

So few survive the Pox that you don’t often hear what it’s like. Well let me tell you. It’s like dying and being reborn so many times. The pain is unbearable, until it isn’t. The hallucinations are like dreams. And then when it passes, people look at you like you’re a ghost, like you’re an apparition haunting your own decimated body.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: savage-attacker.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'savage-attacker'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Gaming Set (your choice)',
  'choice',
  NULL,
  NULL,
  0
),
(
  'gh-pox-touched',
  'Tocado pela Peste',
  'When you fell ill with the Weeping Pox, you assumed you would die from it, as had so many before you. Your neighbors shunned you, fearing that you would spread the disease to them and their families. Then a miracle happened. A stranger came to you and offered to help. The stranger brought forth strange medicines, providing you with curative draughts and elixirs. And just as the disease reached its worst stages, the symptoms began to vanish. Before long, you were cured of the disease.

The sores and scars of the disease, however, still play across your body—an unsubtle reminder of the terrible scourge you survived. The stranger left you after the treatments concluded, but you retained some of the knowledge that the healer used while caring for you. Those who marvel at your recovery also fear you: they harbor some suspicion that you made deals with dark powers to drive away the disease.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: triage-expert.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'triage-expert'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Herbalism Kit',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-herbalismo'),
  NULL,
  0
),
(
  'gh-prisoner',
  'Prisioneiro',
  'Something from your past landed you in prison. Your transgressions might be real or imagined, against a just society or a corrupt one. Regardless of how you became a prisoner, you have learned to survive within your environment.

As a prisoner, you’ve had to learn to deal with guards, other prisoners, and the unpleasant environment. Part of that survival was learning to find, craft, or steal small items that make your incarceration more tolerable. Whether your release was long ago or about to happen, your time as a Prisoner has changed you.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: alert.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'alert'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Thieves’ Tools',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-ladrao'),
  NULL,
  0
),
(
  'gh-released-thrall',
  'Servo Libertado',
  'Valikan raiders search for many things: food, goods, weapons, and thralls. You were one of those taken by the clans because you had skills that the clan lacked in their cold northern home. Once you arrived, you were given a choice: join the clan or find your own way home. You chose the latter.

You then had to find your way through the cold and dangerous lands of Valika —and whatever other lands separated you from your home. You had to be ever watchful of other threats, hiding when danger presented itself. No place is safe, and you must take every opportunity to advance toward your goals.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: survivor.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'survivor'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Artisan’s Tools (your choice)',
  'choice',
  NULL,
  (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan'),
  0
),
(
  'gh-scion-of-the-thaumaturge',
  'Herdeiro do Taumaturgo',
  'You served a mysterious organization simply called the Thaumaturge. You received orders to perform tasks that ranged from the mundane to the inscrutable. Your contact assured you that even if the tasks made no sense, you were serving the greater good of your home, and of all Etharis.

Your tasks led you to new locations. You secretly met with other members of the organization, and you looked to the stars to give you signs and portents about the future. You may still be performing these tasks, or years may have passed since your last contact, but you know that there are forces beyond understanding that pull on people’s strings and make them dance.',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: fortuneofthe-thaumaturge.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'fortuneofthe-thaumaturge'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Cartographer’s Tools',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-cartografo'),
  NULL,
  0
),
(
  'gh-syndicate-smuggler',
  'Contrabandista do Sindicato',
  'Goods from one side of Etharis often fetch a fair price on the other side. Transporting such goods are a hassle—dealing with the bureaucracy of customs and taxes is an even larger one. Thankfully, as a representative of the Ebon Syndicate, you are there to eliminate at least part of the hassle.

Whether you move goods by land, sea, river, or air, crossing borders and avoiding detection are your specialty. Sometimes having a way to hide goods is the game. Other times falsifying paperwork or bribing guards does the trick. However you manage to do it, you get what people want into their hands for the right price.

//',
  'Antecedente Grim Hollow',
  'Antecedente Grim Hollow (PHB 2024). Talento de origem: resolutionofthe-syndicate.

Regra opcional (GH Cap. 1): os aumentos de atributo da herança não precisam ser limitados pelas sugestões do antecedente.',
  (SELECT id FROM rpg.phb_feat WHERE slug = 'resolutionofthe-syndicate'),
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  50,
  'Forgery Kit',
  'fixed',
  (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-falsificacao'),
  NULL,
  0
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  feat_id = EXCLUDED.feat_id,
  source_citation_id = EXCLUDED.source_citation_id,
  equipment_gold_option = EXCLUDED.equipment_gold_option,
  tool_proficiency_description = EXCLUDED.tool_proficiency_description,
  tool_proficiency_kind = EXCLUDED.tool_proficiency_kind,
  tool_item_id = EXCLUDED.tool_item_id,
  tool_category_id = EXCLUDED.tool_category_id;
