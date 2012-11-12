--[[   ____    ______      
      /\  _`\ /\__  _\   __
 __  _\ \ \/\_\/_/\ \/ /_\ \___ 
/\ \/'\\ \ \/_/_ \ \ \/\___  __\
\/>  </ \ \ \L\ \ \ \ \/__/\_\_/
 /\_/\_\ \ \____/  \ \_\  \/_/
 \//\/_/  \/___/    \/_/
 
 [=====================================]
 [  Author: Dandruff @ Whisperwind-US  ]
 [  xCT+ Version 3.x.x                 ]
 [  �2012. All Rights Reserved.        ]
 [====================================]]
 
local ADDON_NAME, addon = ...

-- =====================================================
-- CreateMergeSpellEntry(
--    class,       [string] - class name that spell belongs to
--    interval,       [int] - How often to update merged data (in seconds)
--    prep,           [int] - The minimum time to wait to update merged data
--  )
--    Creates a merge settings entry for a spell.
-- =====================================================
local function CreateMergeSpellEntry(class, interval, prep)
  return {
         class = class,
      interval = interval   or 3,
          prep = prep       or 0,
    }
end

-- List of Spells that need to be merged
addon.merges = {
-- death knight
  [55095]  = CreateMergeSpellEntry("DEATHKNIGHT"),      -- Frost Fever
  [55078]  = CreateMergeSpellEntry("DEATHKNIGHT"),      -- Blood Plague
  [48721]  = CreateMergeSpellEntry("DEATHKNIGHT", .5),  -- Blood Boil                                 (INSTANT)
  [49184]  = CreateMergeSpellEntry("DEATHKNIGHT", .5),  -- Howling Blast                              (INSTANT)
  [52212]  = CreateMergeSpellEntry("DEATHKNIGHT"),      -- Death and Decay
  
-- druid (damage)
  [8921]   = CreateMergeSpellEntry("DRUID"),            -- Moonfire
  [93402]  = CreateMergeSpellEntry("DRUID"),            -- Sunfire
  [5570]   = CreateMergeSpellEntry("DRUID"),            -- Insect Swarm
  [42231]  = CreateMergeSpellEntry("DRUID"),            -- Hurricane
  [50288]  = CreateMergeSpellEntry("DRUID"),            -- Starfall
  [78777]  = CreateMergeSpellEntry("DRUID"),            -- Wild Mushroom: Detonate	
  [61391]  = CreateMergeSpellEntry("DRUID", .5),        -- Typhoon                                    (INSTANT)
  [1822]   = CreateMergeSpellEntry("DRUID"),            -- Rake
  [62078]  = CreateMergeSpellEntry("DRUID", .5),        -- Swipe (Cat)                                (INSTANT)
  [779]    = CreateMergeSpellEntry("DRUID", .5),        -- Swipe (Bear)                               (INSTANT)
  [33745]  = CreateMergeSpellEntry("DRUID"),            -- Lacerate
  [1079]   = CreateMergeSpellEntry("DRUID"),            -- Rip
  [106830] = CreateMergeSpellEntry("DRUID", 4),         -- Thrash (Cat)
  [77758]  = CreateMergeSpellEntry("DRUID", 4),         -- Thrash (Bear)

-- druid (healing)
  [774]    = CreateMergeSpellEntry("DRUID"),            -- Rejuvenation
  [48438]  = CreateMergeSpellEntry("DRUID"),            -- Wild Growth
  [8936]   = CreateMergeSpellEntry("DRUID"),            -- Regrowth
  [33763]  = CreateMergeSpellEntry("DRUID"),            -- Lifebloom
  [44203]  = CreateMergeSpellEntry("DRUID"),            -- Tranquility
  [81269]  = CreateMergeSpellEntry("DRUID"),            -- Swiftmend (Efflorescence)

-- hunter
  [2643]   = CreateMergeSpellEntry("HUNTER", .5),       -- Multi-Shot                                 (INSTANT)
  [83077]  = CreateMergeSpellEntry("HUNTER", .5),       -- Serpent Sting (Instant Serpent Spread)     (INSTANT)
  [118253] = CreateMergeSpellEntry("HUNTER"),           -- Serpent Sting (Tick)
  [13812]  = CreateMergeSpellEntry("HUNTER"),           -- Explosive Trap
  [53301]  = CreateMergeSpellEntry("HUNTER"),           -- Explosive Shot (3 ticks merged as one)
  [63468]  = CreateMergeSpellEntry("HUNTER"),           -- Piercing Shots
  [3674]   = CreateMergeSpellEntry("HUNTER", 4),        -- Black Arrow                                (Every 2s for 20s)
  
-- mage
  [44461]  = CreateMergeSpellEntry("MAGE", .5),         -- Living Bomb                                (INSTANT)
  [44457]  = CreateMergeSpellEntry("MAGE", 4),          -- Living Bomb (DOT)                          (over 8 seconds)
  [2120]   = CreateMergeSpellEntry("MAGE", 4),          -- Flamestrike                                (Over 4 seconds)
  [12654]  = CreateMergeSpellEntry("MAGE"),             -- Ignite
  [11366]  = CreateMergeSpellEntry("MAGE"),             -- Pyroblast
  [31661]  = CreateMergeSpellEntry("MAGE", .5),         -- Dragon's Breath                            (INSTANT)
  [42208]  = CreateMergeSpellEntry("MAGE"),             -- Blizzard
  [122]    = CreateMergeSpellEntry("MAGE", .5),         -- Frost Nova                                 (INSTANT)
  [1449]   = CreateMergeSpellEntry("MAGE", .5),         -- Arcane Explosion                           (INSTANT)
  [83853]  = CreateMergeSpellEntry("MAGE"),             -- Combustion
  [11113]  = CreateMergeSpellEntry("MAGE"),             -- Blast Wave
  [83619]  = CreateMergeSpellEntry("MAGE", .5),         -- Flame Orb                                  (INSTANT)
  [120]    = CreateMergeSpellEntry("MAGE"),             -- Cone of Cold

-- monk (damage)
  [113656] = CreateMergeSpellEntry("MONK"),             -- Fists of Fury                              (Instant w/ every 1s for 4s)
  [107270] = CreateMergeSpellEntry("MONK", 2.5),        -- Spinning Crane Kick                        (Over 2s)
  [128531] = CreateMergeSpellEntry("MONK", 4),          -- Blackout Kick (DoT)                        (Every 1s for 4s)
  [117418] = CreateMergeSpellEntry("MONK", 4),          -- Fists of Fury                              (Every 1s for 4s)
  [121253] = CreateMergeSpellEntry("MONK", .5),         -- Keg Smash                                  (INSTANT)
  [115181] = CreateMergeSpellEntry("MONK", .5),         -- Breath of Fire                             (INSTANT)
  
-- monk (healing)
  [117640] = CreateMergeSpellEntry("MONK", 2.5),        -- Spinning Crane Kick (Heal)                 (Over 2s)
  [119611] = CreateMergeSpellEntry("MONK", 6),          -- Renewing Mist                              (Every 3s for 18s)
  [115175] = CreateMergeSpellEntry("MONK", 4.5),        -- Soothing Mist                              (Every 1s for 8s)
  [125953] = CreateMergeSpellEntry("MONK", 4.5),        -- Soothing Mist (Statue)                     (Every 1s for 8s)
  [132120] = CreateMergeSpellEntry("MONK", 6),          -- Enveloping Mist                            (Every 1s for 6s)
  [116670] = CreateMergeSpellEntry("MONK", .5),         -- Uplift                                     (INSTANT)
  [117895] = CreateMergeSpellEntry("MONK", 3),          -- Eminence (Monk)
  [126890] = CreateMergeSpellEntry("MONK", 3),          -- Eminence (Statue)
  [127722] = CreateMergeSpellEntry("MONK", 3),          -- Serpent's Zeal
  [128591] = CreateMergeSpellEntry("MONK", 3),          -- Blackout Kick (Heal??)
  
-- paladin (damage)
  [81297]  = CreateMergeSpellEntry("PALADIN"),          -- Consecration
  [53385]  = CreateMergeSpellEntry("PALADIN"),          -- Divine Storm
  [31803]  = CreateMergeSpellEntry("PALADIN"),          -- Censure
  [42463]  = CreateMergeSpellEntry("PALADIN"),          -- Seal of Truth
  [101423] = CreateMergeSpellEntry("PALADIN"),          -- Seal of Righteousness
  [31935]  = CreateMergeSpellEntry("PALADIN"),          -- Avenger's Shield

-- paladin (healing)
  [94289]  = CreateMergeSpellEntry("PALADIN"),          -- Protector of the Innocent
  [53652]  = CreateMergeSpellEntry("PALADIN"),          -- Beacon of Light
  [85222]  = CreateMergeSpellEntry("PALADIN"),          -- Light of Dawn
  [82327]  = CreateMergeSpellEntry("PALADIN"),          -- Holy Radiance
  [20167]  = CreateMergeSpellEntry("PALADIN"),          -- Seal of Insight (Heal)
  [121129] = CreateMergeSpellEntry("PALADIN", .5),      -- Daybreak                                   (INSTANT)
  [119952] = CreateMergeSpellEntry("PALADIN", 6.5),     -- Arcing Light                               (Every 2s for 17.5s)
  
-- priest (damage)
  [47666]  = CreateMergeSpellEntry("PRIEST"),           -- Penance (Damage Effect)
  [132157] = CreateMergeSpellEntry("PRIEST", .5),       -- Holy Nova (Damage Effect)                  (INSTANT)
  [589]    = CreateMergeSpellEntry("PRIEST"),           -- Shadow Word: Pain
  [34914]  = CreateMergeSpellEntry("PRIEST"),           -- Vampiric Touch 
  [2944]   = CreateMergeSpellEntry("PRIEST"),           -- Devouring Plague
  [127626] = CreateMergeSpellEntry("PRIEST", 6.5),      -- Devouring Plague (Poison?)
  [15407]  = CreateMergeSpellEntry("PRIEST"),           -- Mind Flay
  [49821]  = CreateMergeSpellEntry("PRIEST"),           -- Mind Seer (From Derap: first one is the cast)
  [124469] = CreateMergeSpellEntry("PRIEST"),           -- Mind Seer (the second one is the debuff that is applied to your target which lets you clip your mind sears like mind flay)
  [87532]  = CreateMergeSpellEntry("PRIEST"),           -- Shadowy Apparition
  [14914]  = CreateMergeSpellEntry("PRIEST"),           -- Holy Fire

-- priest (healing)
  [47750]  = CreateMergeSpellEntry("PRIEST"),           -- Penance (Heal)
  [139]    = CreateMergeSpellEntry("PRIEST"),           -- Renew
  [596]    = CreateMergeSpellEntry("PRIEST", .5),       -- Prayer of Healing                          (INSTANT)
  [64844]  = CreateMergeSpellEntry("PRIEST"),           -- Divine Hymn
  [32546]  = CreateMergeSpellEntry("PRIEST"),           -- Binding Heal
  [77489]  = CreateMergeSpellEntry("PRIEST"),           -- Echo of Light
  [34861]  = CreateMergeSpellEntry("PRIEST", .5),       -- Circle of Healing                          (INSTANT)
  [23455]  = CreateMergeSpellEntry("PRIEST", .5),       -- Holy Nova (Healing)                        (INSTANT)
  [33110]  = CreateMergeSpellEntry("PRIEST"),           -- Prayer of Mending
  [63544]  = CreateMergeSpellEntry("PRIEST"),           -- Rapid Renewal
  [88686]  = CreateMergeSpellEntry("PRIEST", 6),        -- Holy Word: Sanctuary                       (every 2 sec for 30 sec)
  [121148] = CreateMergeSpellEntry("PRIEST", 3),        -- Cascade                                    (INSTANT... over 3ish)
  [110745] = CreateMergeSpellEntry("PRIEST", 3),        -- Divine Star                                (INSTANT... over 3ish)
  [120692] = CreateMergeSpellEntry("PRIEST", 3),        -- Halo                                       (INSTANT... over 3ish)
  [7001]   = CreateMergeSpellEntry("PRIEST", 4),        -- Light Well                                 (every 2s for 6s)
  
-- rogue
  [51723]  = CreateMergeSpellEntry("ROGUE", .5),        -- Fan of Knives                              (INSTANT)
  [113780] = CreateMergeSpellEntry("ROGUE", .5),        -- Deadly Poison                              (INSTANT)
  [2818]   = CreateMergeSpellEntry("ROGUE"),            -- Deadly Poison (DOT)
  [8680]   = CreateMergeSpellEntry("ROGUE"),            -- Wound Poison
  [112974] = CreateMergeSpellEntry("ROGUE"),            -- Leeching Poison
  [121411] = CreateMergeSpellEntry("ROGUE", .5),        -- Crimson Tempest                            (INSTANT)
  [122233] = CreateMergeSpellEntry("ROGUE"),            -- Crimson Tempest (DOT)
  
-- shaman (damage)
  [421]    = CreateMergeSpellEntry("SHAMAN", .5),       -- Chain Lightning                            (INSTANT)
  [8349]   = CreateMergeSpellEntry("SHAMAN"),           -- Fire Nova
  [77478]  = CreateMergeSpellEntry("SHAMAN"),           -- Earthquake
  [51490]  = CreateMergeSpellEntry("SHAMAN"),           -- Thunderstorm
  [8187]   = CreateMergeSpellEntry("SHAMAN"),           -- Magma Totem
  [8050]   = CreateMergeSpellEntry("SHAMAN"),           -- Flame Shock
  [25504]  = CreateMergeSpellEntry("SHAMAN", .5),       -- Windfury Attack                            (INSTANT)

-- shaman (healing)
  [73921]  = CreateMergeSpellEntry("SHAMAN"),           -- Healing Rain
  [1064]   = CreateMergeSpellEntry("SHAMAN", .5),       -- Chain Heal                                 (INSTANT)
  [52042]  = CreateMergeSpellEntry("SHAMAN"),           -- Healing Stream Totem
  [51945]  = CreateMergeSpellEntry("SHAMAN"),           -- Earthliving
  [61295]  = CreateMergeSpellEntry("SHAMAN"),           -- Riptide

-- warlock (damage)
  [172]    = CreateMergeSpellEntry("WARLOCK"),          -- Corruption
  [87389]  = CreateMergeSpellEntry("WARLOCK"),          -- Corruption (Soulburn: Seed of Corruption)
  [27243]  = CreateMergeSpellEntry("WARLOCK"),          -- Seed of Corruption (DoT)
  [27285]  = CreateMergeSpellEntry("WARLOCK", .5),      -- Seed of Corruption (Explosion)             (INSTANT)
  [87385]  = CreateMergeSpellEntry("WARLOCK", .5),      -- Seed of Corruption (Explosion Soulburned)  (INSTANT)
  [30108]  = CreateMergeSpellEntry("WARLOCK"),          -- Unstable Affliction
  [348]    = CreateMergeSpellEntry("WARLOCK"),          -- Immolate
  [50590]  = CreateMergeSpellEntry("WARLOCK"),          -- Immolation (Aura)
  [980]    = CreateMergeSpellEntry("WARLOCK"),          -- Agony
  [42223]  = CreateMergeSpellEntry("WARLOCK"),          -- Rain of Fire
  [5857]   = CreateMergeSpellEntry("WARLOCK"),          -- Hellfire
  [47897]  = CreateMergeSpellEntry("WARLOCK"),          -- Shadowflame
  [47960]  = CreateMergeSpellEntry("WARLOCK"),          -- Shadowflame (DOT)
  [30213]  = CreateMergeSpellEntry("WARLOCK", .5),      -- Legion Strike (Felguard)                   (INSTANT)
  [89753]  = CreateMergeSpellEntry("WARLOCK"),          -- Felstorm (Felguard)
  [20153]  = CreateMergeSpellEntry("WARLOCK"),          -- Immolation (Infrenal)
  [108371] = CreateMergeSpellEntry("WARLOCK"),          -- Harvest Life
  [108451] = CreateMergeSpellEntry("WARLOCK"),          -- Soul Link
  [689]    = CreateMergeSpellEntry("WARLOCK"),          -- Drain Life
  
-- warlock (healing)
  [125314] = CreateMergeSpellEntry("WARLOCK"),          -- Harvest Life
  [108447] = CreateMergeSpellEntry("WARLOCK"),          -- Soul Link
  [89653]  = CreateMergeSpellEntry("WARLOCK"),          -- Drain Life
  
-- warrior
  [845]    = CreateMergeSpellEntry("WARRIOR", .5),      -- Cleave                                     (INSTANT)
  [46968]  = CreateMergeSpellEntry("WARRIOR", .5),      -- Shockwave                                  (INSTANT)
  [6343]   = CreateMergeSpellEntry("WARRIOR", .5),      -- Thunder Clap                               (INSTANT)
  [1680]   = CreateMergeSpellEntry("WARRIOR"),          -- Whirlwind
  [50622]  = CreateMergeSpellEntry("WARRIOR"),          -- Bladestorm
  [52174]  = CreateMergeSpellEntry("WARRIOR", .5),      -- Heroic Leap                                (INSTANT)
  
-- spammy items (old) ITEM CLASS CURRENTLY DOES NOTHING
  [109858] = CreateMergeSpellEntry("ITEM", 2.5),        -- Speaking of Rage - proc'd by: Vishanka, Jaws of the Earth (Heroic)
}