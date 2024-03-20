// inline styling

#set text(
  9pt, top-edge: 9pt, luma(10%),
  font: "Barlow",
  stretch: 87.5%,
  number-width: "tabular",
)
#show "₡": set text(font: "IBM Plex Sans", stretch: 100%)
#show "➡": set text(7.5pt, font: "Noto Sans CJK SC")

// block styling

#let leading = 3pt
#let top-edge = 9pt
#let line-height = leading + top-edge
#let block-spacing = line-height / 2 + leading

#set block(spacing: block-spacing)

#set par(leading: leading)

#show heading.where(level: 1): upper
#show heading.where(level: 1): set text(
  36pt, top-edge: 25.5pt,
  weight: 500, stretch: 75%,
)
#show heading.where(level: 1): it => {
  set block(below: 4 * line-height - leading - text.top-edge)
  colbreak(weak: true) + it
}

#let marked(marker, gap, content) = context block(
  inset: (left: -(gap + measure(marker).width)),
  spacing: block-spacing,
  grid(
    columns: (auto, 1fr),
    column-gutter: gap,
    marker, content
  )
)
#show heading.where(level: 2): it => {
  set text(9pt, rgb(255, 47, 23), weight: 400)
  marked(
    text(
      6pt, baseline: -0.75pt,
      font: "Noto Sans CJK SC",
      "▶"
    ),
    2pt,
    it.body
  )
}
#let design-note(text-fill: rgb(50, 165, 194), content) = {
  set text(text-fill, style: "italic")
  marked(text(tracking: -1pt, "//"), 2.5pt, content)
}

#set enum(numbering: "1", body-indent: 1em)

#let columns-full(count, body) = context {
  let line-height = text.size + par.leading
  let line-count = calc.ceil(
    (measure(body).height + par.leading) /
    (line-height * count)
  )
  block(
    height: line-height * line-count - par.leading,
    spacing: block-spacing,
    columns(count, gutter: (100% - measure(body).width * count) / count, block(body))
  )
}

#let footer(body) = {
  set text(
    7pt, top-edge: 6pt, rgb(133, 142, 140),
    style: "italic"
  )
  set par(leading: 3pt)
  body
}

// document styling

#set document(
  title: "24XX System Reference Document",
  author: "Jason Tocci"
)

#set page(paper: "us-statement")
#set columns(gutter: 18pt)

// ===================
// content begins here
// ===================

#set page(margin: 0pt)

#place(image("cover.png"))

// Typst currently doesn't support blending modes
// so this is a rough emulation
#block(
  width: 100%, height: 100%,
  inset: 18pt,
  fill: rgb(92.5%, 92.5%, 100%, 6%),
)[
  #set par(leading: 0pt)
  #set text(fill: rgb(70%, 70%, 100%, 22.5%))
  = #stack(
    {
      set text(125pt, top-edge: 89pt)
      h(-6pt)
      text(stretch: 87.5%)[24]
      text(stretch: 75%)[XX]
    },
    text(21pt, top-edge: 23.5pt)[
      #upper[System Reference Document]
    ]
  )
]

// page 1

#set page(
  margin: 18pt,
  columns: 2,
)

= Rules

*PLAY:* Players describe what their characters do. The GM advises when their action is impossible, demands a cost or extra steps, or presents a risk. Players can revise plans before committing so as to change goal/stakes. Only roll to _avoid risk_.

*ROLLING:* Roll a _skill die_ — d6 by default, higher with a relevant skill, or d4 if _hindered_ by injury or circumstances. If _helped_ by circumstances, roll an extra d6; if _helped_ by an ally, they roll their skill die and share the risk. Take the highest die.

#grid(
  columns: (auto, 1fr),
  column-gutter: 0.5em,
  row-gutter: leading,
  [*1–2*], [*Disaster.* Suffer the full risk. GM decides if you succeed at all. If risking death, you die.],
  [*3–4*], [*Setback.* A lesser consequence or partial   success. If risking death, you’re injured.],
  [*5+*], [*Success.* The higher the roll, the better.]
)

If success can’t get you what you want (_you make the shot, but it’s bulletproof!_), you’ll at least get useful info or set up an advantage.

*LOAD:* Carry as much as makes sense, but more than one _bulky_ item may hinder you at times.

*ADVANCEMENT:* After a job, each character increases a skill (_none ➡ d8 ➡ d10 ➡ d12_) and gains d6 credits (₡).

*DEFENSE:* Say how one of your items _breaks_ to turn a hit into a brief _hindrance_. _Broken_ gear is useless until repaired.

*HARM:* Injuries take time and/or medical attention to heal. If killed, make a new character to introduce ASAP. Favor inclusion over realism.

// allow this paragraph to overflow a bit to the right to ensure that it doesn't go to the second column
#block(inset: (right: -1.5pt))[*GM:* Describe characters in terms of behaviors, risks, and obstacles, not skill dice. Lead the group in setting lines not to cross in play. _Fast-forward, pause,_ or _rewind/redo_ for pacing and safety; invite players to do likewise. Present dilemmas you don’t know how to solve. Move spotlight to give all time to shine. Test as needed for bad luck (e.g., run out of ammo, or into guards) — roll a die to check for (1– 2) trouble or (3–4) signs of it. Improvise rulings to cover gaps in rules; on a break, revise unsatisfactory rulings as a group.]

= Characters

#design-note[SRD design notes start with two slashes, like this. Other paragraphs are player/GM-facing text.]

#design-note[Characters start with 6ish skill increases and/or credits in items, possibly combining “specialty” and “origin” (or “3 skill increases” as a stand-in).]

== Choose your character’s *specialty*.

*FACE:* Skilled in _Reading People_ (d8), _Deception_ (d8). Take an _extensive disguise wardrobe_.

*MUSCLE:* Skilled in _Intimidation_ (d8) and either _Hand-to-hand_ (d8) or _Shooting_ (d8). Take a _sword_, _firearm_, or _cyber-arm_.

*PSYCHIC:* Skilled in _Telepathy_ (d8, sense surface thoughts), _Telekinesis_ (d8, as strong as your arms), or pick one at d10. Take a _bottle of PsychOut_ (amplify powers; addictive).

*MEDIC:* Skilled in _Medicine_ (d8), _Electronics_ (d8). Take a _medkit_ and _cyber-surgery tools_ (_bulky_).

*SNEAK:* Skilled in _Climbing_ (d8), _Stealth_ (d8). Take _climbing gear_ and _night vision goggles_.

*TECH:* Skilled in _Hacking_ (d8), _Electronics_ (d8). Take _repair tools_ and a _custom computer_ (_bulky_).

== Choose your character’s *origin*.

*ALIEN:* Invent 2 traits, like _electric current_, _wings_, _natural camouflage_, or _six-limbed_.

*ANDROID:* You have an upgrade-ready cyber-body. Take _synth skin_ (looks human) or a _case_ (break harmlessly for _defense_). Increase 1 skill.

*HUMAN:* Apply 3 skill increases (from _no skill ➡ d8 ➡ d10 ➡ d12_). You can take new skills and/or increase skills you already have.

== Choose or invent *skills* (if prompted by origin).

_Climbing, Connections, Deception, Electronics, Engines, Explosives, Hacking, Hand-to-hand, Intimidation, Labor, Persuasion, Piloting, Running, Shooting, Spacewalking, Stealth, Tracking_

#design-note[Characters who start with broader skills should start with fewer skills, or with less useful skills.]

// page 2

= Gear

#design-note[If an item costs less than a new video game system, the only cost is the time it takes to get it.]

== Take a *_comm_* (smartphone) and ₡2. Most items and upgrades cost ₡1 each. Ignore microcredit transactions like a knife or a meal.

*ARMOR:* _Vest_ (break once for _defense_), _battle armor_ (₡2, _bulky_, break up to 3×), _hardsuit_ (₡3, _bulky_, break up to 3×, vacuum-rated, mag boots).

*CYBERNETICS:* _Cyber-ear_ (upgrade with _echolocation, vocal stress detector_), _cyber-eye_ (upgrade with _infrared, telescopic, x-ray_), _cyber-limb_ (upgrade with _fast, strong, compartments, tool or weapon implant_), _cranial jack_ (upgrade with _sensory data backup, skill increase_), _healing nanobots, toxin filter, voice mimic_.

*TOOLS:* _Flamethrower (bulky), low-G jetpack, med scanner, mini drone, repair tools, survey pack_ (climbing gear, flare gun, tent; _bulky_).

*WEAPONS:* _Grenades_ (4, any of _fragmentation, flashbang, smoke, EMP_), _pistol, rifle (bulky), shotgun (bulky), stun baton, tranq gun_.

#block(inset: (right: -1.5pt))[== *Starships* have basic versions of these functions; upgrades cost ₡10 each. In an emergency, players pick an action to perform or _help_ with.]

*COMMS:* Upgrade with _eavesdropper, jammer, tachyon burst_ (no lag in-system).

*CRAFTS:* Comes with _escape pod_. Upgrade with _fighter, shuttle_ (reentry-rated).

*DRIVE:* FTL jump and sublight speeds. Upgrade with _longer jumps, faster speed, greater agility_.

*EQUIPMENT:* _Vac suits_ for crew. Upgrade with _armory, heavy loader, mining gear, tow cable_.

*HULL ARMOR:* Break harmlessly for _defense_. Upgrade with _reentry-rated, sun shielding_.

*SENSORS:* Upgrade with _deep-space, life-sign scan, planetary survey, tactical vessel scan_.

*WEAPONS:* Deflector turrets. Upgrade with _laser cutter, military-grade turret, torpedos_.

= Details

#design-note[Additional character and setting details often need to be customized for specific settings (especially when aliens and fashion are involved). Feel free to draw from these options, which should work in a range of sci-fi settings.]

== Invent or roll for *personal details*.

*SURNAME*

#columns-full(4)[
  + Acker
  + Black
  + Cruz
  + Dallas
  + Engel
  + Fox
  + Gee
  + Haak
  + Iyer
  + Joshi
  + Kask
  + Lee
  + Moss
  + Nash
  + Park
  + Qadir
  + Singh
  + Tran
  + Ueda
  + Zheng
]

*NICKNAME*

#columns-full(4)[
  + Ace
  + Bliss
  + Crater
  + Dart
  + Edge
  + Fuse
  + Gray
  + Huggy
  + Ice
  + Jinx
  + Killer
  + Lucky
  + Mix
  + Nine
  + Prof
  + Red
  + Sunny
  + Treble
  + V8
  + Zero
]

*DEMEANOR*

#columns-full(2)[
  + Anxious
  + Appraising
  + Blunt
  + Brooding
  + Calming
  + Casual
  + Cold
  + Curious
  + Dramatic
  + Dry
  + Dull
  + Earnest
  + Formal
  + Gentle
  + Innocent
  + Knowing
  + Pricky
  + Reckless
  + Terse
  + Weary
]

*SHIP NAME*

#columns-full(2)[
  + _Arion_
  + _Blackjack_
  + _Caleuche_
  + _Canary_
  + _Caprice_
  + _Chance_
  + _Darter_
  + _Falkor_
  + _Highway Star_
  + _Moonshot_
  + _Morgenstern_
  + _Phoenix_
  + _Peregrine_
  + _Restless_
  + _Silber Blaze_
  + _Stardust_
  + _Sunchaser_
  + _Swift_
  + _Thunder Road_
  + _Wayfarer_
]

// back page

#set page(
  margin: (top: 18pt - block-spacing),
  footer-descent: 6pt,
  footer: footer[
    Version 1.41.typ.2 • Text, layout & 24XX logo all CC BY Jason Tocci • Art CC BY Beeple (Mike Winkelmann) • Typst version CC BY Paro
  ],
)

#place(hide[= The Back Page])

#block(
  fill: rgb(37, 101, 136),
  inset: (bottom: line-height),
  outset: (x: 7pt, top: block-spacing)
)[
  #set text(white, style: "italic")
  #text(tracking: -1pt, "//") *THE PREMISE:* Explain the basics of the setting. If it’s not made clear elsewhere, give a reason for the characters to stick together, and hint at what they’ll spend their time doing.
]

#design-note[*THE BACK PAGE:* If you’d like to mimic the style of the original micro RPGs this SRD is based on, the back page (or the left half of one side of a letter-sized sheet of paper) can fit 4 tables of 20 items each. A GM can use these to generate ideas for an improvised session, like, “[Name] has hired you for [Job] at [Location], but there’s a [Twist]!” An example table is offered below.]

#design-note[*ADDING TO RULES:* This SRD is very brief, with the hope experienced RPG players will fill in the gaps confidently, and RPG newcomers will be free of too many preconceived notions. Anything left vague is deliberately open to interpretation. (Like: Can you get help dice from an ally AND circumstances on one roll? Your call!) Expand or clarify as needed. My own principles for new rules are to minimize addition and subtraction, avoid too much bookkeeping (on top of tracking credits, hindrances, number of bulky items, and which items are broken), and strive to use terms either self-evident in meaning or invitingly vague.]

== *Roll d20 for a contact, client, rival, or target.*

+ Arcimboldo, quirky tech dealer & tinkerer
+ Aurora, wealthy collector of unique items
+ Blackout, quiet evidence removal specialist
+ Bleach, wry janitor android turned assassin
+ Bron, dour security chief with a metal arm
+ Bullet, no-nonsense android gun runner
+ Carryout, cocky courier with fast cyber-legs
+ Fisher, eager street kid looking for a crew
+ Ginseng, people-loving drug dealer
+ Hot Ticket, extremely cautious fence
+ Kaiser, grinning loan shark in a silver suit
+ Osiris, tired, street-level sawbones
+ Powder Blue, android fixer, generous rates
+ Reacher, sharp mercenary tac squad leader
+ Rhino, thickheaded, bighearted bodyguard
+ Sam, plucky journalist, likely to get killed
+ Shifter, hard-working chop-shop owner
+ Walleye, businesslike information broker
+ Whistler, smiling cabbie/getaway driver
+ “X,” unflappable broker for an unnamed corp

== *Roll d6 to try to find a job. Spend ₡1 to re-roll.*

#grid(
  columns: (auto, 1fr),
  column-gutter: 0.5em,
  row-gutter: leading,
  [1–2], [_Nothing. Owe somebody to get in on a job._],
  [3–4], [_Found a job, but something seems off._],
  [5-6], [_Choose between 2 jobs._]
)

#v(6pt)

#block(inset: (right: 1.5pt))[#design-note[*FINDING JOBS:* Many teams don’t need to look for paying work (e.g., military units). If your game does use this setup, though, dangerous jobs should pay more to cover 1–3 credits in “expenses” for medical treatment, fixing/ replacing broken gear, re-rolling unsavory jobs, or getting through dry spells with no jobs. Also, in the table above, the phrase “owe somebody” is intentionally vague, but may be worth clarifying or alluding to elsewhere (e.g., put a loan shark in your “Contacts” table).]]

#design-note[*JOBS:* The list of jobs (or missions, situations, quests, etc.) should be tailored for your setting, and suggest scenarios where every character’s skills will be useful. Common job templates include “deal with an unusual threat,” “investigate something seemingly inexplicable,” or “retrieve a thing from a location for a person.” They serve as “gameable lore” — elements that hint at a setting, ready-made for use in play.]

#design-note(text-fill: rgb(50, 145, 73))[*LICENSE:* This SRD is released under a Creative Commons Attribution 4.0 license (#underline[CC BY 4.0]). You’re welcome to use this text and layout in your own game, provided you do the following:]

#design-note(text-fill: rgb(50, 145, 73))[GIVE CREDIT: See that tiny text along the bottom of the page? That’s where I cram the version number and credit for licensed content (like the cover art). You’re welcome to put it elsewhere in your game, but be sure to include it somewhere — like, “24XX rules are CC BY Jason Tocci.”]

#design-note(text-fill: rgb(50, 145, 73))[USE 24XX, NOT 2400: You can say your game is “compatible with 2400” or “for use with 2400,” but please don’t use material directly from 2400, or name your game so it looks like it’s part of my 2400 series (unless you have explicit approval).]

#design-note(text-fill: rgb(50, 145, 73))[NO BIGOTRY: Please don’t use any text from this game, the 24XX logo, or my name in any product that promotes or condones white supremacy, racism, misogyny, ableism, homophobia, transphobia, or other bigotry against marginalized groups.]
