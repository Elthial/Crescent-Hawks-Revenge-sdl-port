/* Original DS tables consumed by the tactical unit-control panel. */

#include "revenge/original_data.h"

const byte MovementRatingByWalkMP[0x09] =
	{ 0x00, 0x01, 0x01, 0x01, 0x02, 0x02, 0x03, 0x03, 0x04 };

const char *UnitNameTable[0x59] =
{
	"Locust", "Wasp", "Stinger", "Commando", "Javelin", "Spider",
	"UrbanMech", "Valkyrie", "Firestarter", "Jenner", "Ostscout",
	"Panther", "Assassin", "Cicada", "Clint", "Hermes II", "Vulcan",
	"Whitworth", "Blackjack", "Hatchetman", "Phoenix Hawk", "Vindicator",
	"Centurion", "Enforcer", "Hunchback", "Trebuchet", "Dervish",
	"Griffin", "Shadow Hawk", "Scorpion", "Wolverine", "Dragon", "Ostroc",
	"Ostsol", "Quickdraw", "Rifleman", "Catapult", "Crusader", "JagerMech",
	"Thunderbolt", "Archer", "Grasshopper", "Warhammer", "Marauder", "Orion",
	"Awesome", "Charger", "Goliath", "Victor", "Zeus", "BattleMaster",
	"Stalker", "Cyclops", "Banshee", "Atlas", "Rommel Tank", "Pegasus",
	"Drillson", "Mobile HQ", "APC", "Ammo Carrier", "Galleon", "Skulker",
	"Infantry", "Jump Infantry", "Elementals", "Puma", "Black Hawk",
	"Mad Cat", "Locust+", "Locust*", "Wasp+", "Wasp*", "Commando+",
	"Commando*", "Blackjack+", "Phoenix Hawk+", "Phoenix Hawk*", "Griffin+",
	"Griffin*", "Rifleman+", "Rifleman*", "Warhammer+", "Warhammer*",
	"Marauder+", "Jenner+", "Dragon+", "Shadow Hawk+", "BattleMaster+"
};

const char *PilotSurnameTable[0x3B] =
{
	"Youngblood", "Pearce", "Graham", "Anderson", "Reilly", "Casey",
	"Corrigan", "Hall", "Hunter", "Barth", "Tatum", "Ledesma", "Bellamy",
	"Latham", "Louie", "Christman", "Townsend", "Stewart", "Bouy", "Hill",
	"Accardi", "Briggs", "Lebling", "Galley", "Blank", "Meretzky",
	"Moriarty", "O'Neill", "Berlyn", "Kirsch", "Berez", "Dornbrook",
	"Montague", "Sgt. Krall", "Youngblood", "Anderson", "Pearce", "Romero",
	"Carpenter", "Cronenberg", "DePalma", "Dante", "Raimi", "Hooper",
	"Cunningham", "Chiun", "Toranaga", "Yamashita", "Ichi", "Hosaka",
	"Higa", "Sanjuro", "Takagi", "Jackson", "Lewis", "Wylie", "Morton",
	"Vandenburg", "Trainee"
};

const char *UnitAffiliationNameTable[0x04] =
	{ "Crescent Hawks", "Kell Hounds", "Fed. Suns Cav.", "Sword of Light" };
const char *PilotExperienceNameTable[0x04] =
	{ "Green", "Regular", "Veteran", "Elite" };
const char *HeatScaleDescriptionTable[0x07] =
	{ "None", "Warm", "Moderate", "Hot", "Dangerous", "Extreme", "Shutdown" };
const char *MovementDescriptionTable[0x05] =
	{ "None", "Slow", "Average", "Fast", "Very Fast" };
const char *DurabilityDescriptionTable[0x04] =
	{ "Light", "Medium", "Heavy", "Massive" };
const char *ConditionDescriptionTable[0x05] =
	{ "Stripped", "Battered", "Patched", "Breached", "Scorched" };
const char *FriendlyEquipmentDescriptionTable[0x02] =
	{ "L-K Missiles ", "FCS " };
const char *EnemyAssessmentTextTable[0x12] =
{
	"The long range weapons are misfiring.",
	"Smoke's pouring from its long range weapons!",
	"Its main guns are flaking out.",
	"Looks like the main weapons are down!",
	"Some of the smaller weapons are jammed.",
	"It's lost almost all of its small guns, sir!",
	"Nothing has scratched it yet, sir.",
	"It looks like the paint's chipped a bit.",
	"The 'Mech appears to be limping, sir!",
	"A few more leg hits and he'll stop dead!",
	"It's looking pretty beat up.",
	"His legs are blown off!",
	"I think he's out of ammo.",
	"The infantry are injured.",
	"I think he's overheated!",
	"The unit is moving slowly, sir!",
	"The unit is struggling to move!",
	"The unit is stopped dead!"
};
