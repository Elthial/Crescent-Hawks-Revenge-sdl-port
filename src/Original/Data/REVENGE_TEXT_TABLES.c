// REVENGE_TEXT_TABLES.c
// Native C tables mechanically recovered from REVENGE.EXE.

#include "revenge/original/campaign_data.h"
#include "revenge/original/lance_editor_data.h"
#include "revenge/original/scene_data.h"

const char * const TitleTextTable[0x12] =
{
	"Developed by:", /* DS:2411[00] */
	"Westwood Associates", /* DS:2411[01] */
	"Produced by:", /* DS:2411[02] */
	"Tony Van", /* DS:2411[03] */
	"and Scott Berfield", /* DS:2411[04] */
	"Programming by:", /* DS:2411[05] */
	"Barry Green", /* DS:2411[06] */
	"and David R. Dettmer", /* DS:2411[07] */
	"Game Design by:", /* DS:2411[08] */
	"Tony Van", /* DS:2411[09] */
	"Scenario Design by:", /* DS:2411[0A] */
	"Michael Moore", /* DS:2411[0B] */
	"Music by:", /* DS:2411[0C] */
	"Paul S. Mudra", /* DS:2411[0D] */
	"and Dwight Okahara", /* DS:2411[0E] */
	"Art by:", /* DS:2411[0F] */
	"Joseph B. Hewitt IV", /* DS:2411[10] */
	"and Jenny Martin" /* DS:2411[11] */
};

const char * const MonthNameTextTable[0x0C] =
{
	"JAN", /* DS:2459[00] */
	"FEB", /* DS:2459[01] */
	"MAR", /* DS:2459[02] */
	"APR", /* DS:2459[03] */
	"MAY", /* DS:2459[04] */
	"JUN", /* DS:2459[05] */
	"JUL", /* DS:2459[06] */
	"AUG", /* DS:2459[07] */
	"SEP", /* DS:2459[08] */
	"OCT", /* DS:2459[09] */
	"NOV", /* DS:2459[0A] */
	"DEC" /* DS:2459[0B] */
};

const char * const MissionDateLabelTextTable[0x0C] =
{
	"Chara III (Pacifica), Lyran Commonwealth", /* DS:24A1[00] */
	"Lyons, Lyran Commonwealth", /* DS:24A1[01] */
	"Dieron, Draconis Combine", /* DS:24A1[02] */
	"Chara III (Pacifica), Lyran Commonwealth", /* DS:24A1[03] */
	"", /* DS:24A1[04] */
	"", /* DS:24A1[05] */
	"New Avalon, Federated Commonwealth", /* DS:24A1[06] */
	"", /* DS:24A1[07] */
	"", /* DS:24A1[08] */
	"Arc-Royal, Federated Commonwealth", /* DS:24A1[09] */
	"Kaesong, Draconis Combine", /* DS:24A1[0A] */
	"Luthien, Draconis Combine" /* DS:24A1[0B] */
};

const char ExitToDosPrompt[] = "Are you sure?\r\r Yes, exit to DOS\r No, return to game"; /* DS:2562 */

const char * const CampaignPathMenuTextTable[0x02] =
{
	"Two Lances", /* DS:25CD[00] */
	"Three Lances" /* DS:25CD[01] */
};

const char * const ScenarioVariantMenuTextTable[0x02] =
{
	"Drop Lance", /* DS:25D5[00] */
	"Land Ship" /* DS:25D5[01] */
};

const char * const AlternateScenarioMenuTextTable[0x02] =
{
	"Defend City", /* DS:25DD[00] */
	"Obey Orders" /* DS:25DD[01] */
};

const char * const MainMenuTextTable[0x03] =
{
	"New Game", /* DS:25E5[00] */
	"Load Game", /* DS:25E5[01] */
	"Game Options" /* DS:25E5[02] */
};

const char PilotIdentityPrefixText[] = "\r   "; /* DS:2B04 */
const char PilotNamePrefixText[] = " "; /* DS:2B09 */
const char DateCommaSpaceText[] = " "; /* DS:2B0B */
const char DateSpaceText[] = " "; /* DS:2B0D */
const char ScenarioCompleteHeadingText[] = "Scenario completed successfully"; /* DS:2B11 */
const char ScenarioFailedHeadingText[] = "Scenario completed unsuccessfully"; /* DS:2B31 */

const char * const CampaignMessageTextTable[CAMPAIGN_MESSAGE_COUNT] =
{
	"", /* DS:2B54[00] */
	"   \"I hope you find your father, Jason.  I really do.\"  With those words, Katrina "
	"Steiner gave you command of the Crescent Hawks, her elite combat lance.\r"
	"   You know in your heart that your father is still alive, although the Kurita "
	"forces who recently invaded Pacifica have made it appear as if he died.  You "
	"know the Kurita have a vendetta against the Kell Hounds, and it is up to you "
	"to warn the Hounds of an impending attack.  With luck, Morgan Kell may know "
	"something about your father's whereabouts.\r"
	"   Assisted by Rex Pearce, your second-in-command and your father's best friend, "
	"you have assembled a lance of four new 'Mechs and MechWarriors for your journey "
	"to the Kell Hounds' base.", /* DS:2B54[01] */
	"   Captain Stewart interrupts your reverie.  \"Jason, we're cleared for landing "
	"at the Kell Hound base and are ready for planetary descent.  Topographical scan "
	"of the area is complete, and the hardcopy is on its way to you.\"", /* DS:2B54[02] */
	"   \"Jason, unidentified AeroSpace fighters have appeared on our sensors, and "
	"they're closing fast!\"\r"
	"   You punch the general alarm.  \"Red alert!  All hands to battle stations!\"\r"
	"   Even as you give orders to man the weapons, you realize the fighters have "
	"a clear advantage, due to the Leopard's limited maneuverability during atmospheric "
	"entry.", /* DS:2B54[03] */
	"   \"Damage report, Mr. Stewart!\"\r"
	"   \"Hull breached, weapons failing... Engines are at critical!  We're going "
	"down!\"\r"
	"   \"All crew, prepare for emergency landing!\"", /* DS:2B54[04] */
	"   The DropShip crashes into a lake east of the Kell Hound base.  Half of the "
	"DropShip is flooded, making it impossible to get to two of your four 'Mechs.\r"
	"   Most of your crew has suffered only minor injuries; however, Victor Stewart "
	"- your pilot and fourth MechWarrior - is dead.", /* DS:2B54[05] */
	"   You scramble to the top of the sinking ship to get your bearings.  Through "
	"your binoculars, you spot a Kurita Locust about two kilometers down the road, "
	"headed towards the DropShip.  A few blasts from his laser to the port hull, "
	"and the ship will sink like a rock.  His twin machine guns will then easily "
	"pick off any swimmers.\r"
	"   Trapped on a metal island with no escape, you sweep the area once again, "
	"desperately hoping for some way out.", /* DS:2B54[06] */
	"   There!  You spot a damaged Kell Hound Jenner BattleMech on the western end "
	"of the lake.  You quickly punch up his comlink frequency.\r"
	"   \"Jenner pilot, this is Jason Youngblood of the Crescent Hawks.  We have crashlanded "
	"and are about to be attacked by a lone Kurita Locust two kilometers away and "
	"closing.  Can you intercept him?\"\r"
	"   \"Intercept?  I'd love to, but this Jenner is almost in pieces!  My sensor "
	"screens have been blown out!  I need help!\"", /* DS:2B54[07] */
	"   You think for a second.\r"
	"   \"All right.  Move where I tell you, and open fire on the Locust when he gets "
	"in range.  He should head straight for the DropShip.  If he hits us, we'll sink "
	"right to the bottom.  Got it?\"\r"
	"\"Got it, boss!  Point me in the right direction and watch me go!  Anderson out.\"", /* DS:2B54[08] */
	"   As the Locust blasts the hull, you duck down into the ship.  A few well placed "
	"shots breach the damaged armor and the DropShip sinks, along with your 'Mechs "
	"and your future.\r"
	"   'Mechs lose speed and accuracy when in water and wooded areas.  This hindrance "
	"to the Jenner's maneuverability and firepower cost you your career as a lance "
	"commander.", /* DS:2B54[09] */
	"   You were unable to help the Kell Hounds defend their base and have lost all "
	"credibility as a leader.  Katrina Steiner suspends your command of the Crescent "
	"Hawks.", /* DS:2B54[0A] */
	"   With the Locust gone, your men evacuate the DropShip.  You and Rex then enter "
	"the two remaining command 'Mechs.\r"
	"   When you open the bay doors, the DropShip floods and sinks, along with the "
	"two trapped 'Mechs.  You move across the lake to the south shore.", /* DS:2B54[0B] */
	"   You see the Jenner pilot being bandaged by Kurt.  He is Rick \"Grease\" Anderson, "
	"the MechWarrior who saved your lives.  You thank him and then ask about the "
	"Kurita assault.\r"
	"   \"Some Kurita commander named Chiun has gone nuts!  He claims to be honoring "
	"a vendetta or something.  The attack started about an hour ago and took us completely "
	"by surprise.  We've got almost every 'Mech out in defense, including half-repaired "
	"'Mechs like this Jenner here, and anybody who can pilot one in the cockpits! "
	" It's crazy!\"", /* DS:2B54[0C] */
	"   Grease winces as Kurt finishes bandaging his arm.  \"I was on recon when we "
	"were ambushed by the Kurita scum.  They're trying to take the base!\"\r"
	"   \"Only a couple 'Mechs were left behind to guard it.  If any Kurita units "
	"make it across this bridge, they'll easily break down our defenses.  You gotta "
	"help us defend this road, Jason!\"\r"
	"   You and Rex climb into your BattleMechs.  \"Kurt, that Locust was probably "
	"a scout for a Light Lance.  That means more will be here soon.  See if you can "
	"get the Jenner in better shape to help us out.  We'll need it when more Kurita "
	"'Mechs show up.\"", /* DS:2B54[0D] */
	"   Your death in combat has ended your career as a lance commander.  With more "
	"foresight, you might have stopped those two 'Mechs from entering the base.", /* DS:2B54[0E] */
	"   Rex climbs aboard your 'Mech after the battle is over.  \"Today is definitely "
	"not my lucky day,\" Rex mutters, referring to his destroyed 'Mech.\r"
	"   He takes a seat behind you and monitors the sensors.", /* DS:2B54[0F] */
	"   \"Jason, this is Kurt.  I thought you were going to defend the bridge!  I "
	"finished off the 'Mech that got away from you, but not before he blew apart "
	"the Jenner.  Consider our only other 'Mech wasted.  Graham out.\"", /* DS:2B54[10] */
	"   Your comlink crackles to life.\r"
	"   \"Kurt here.  This Jenner's pretty messed up.  But I think I can have it ready "
	"for combat by 14:30.  See you then.  Graham out.\"", /* DS:2B54[11] */
	"   Rex appears on your screen next.\r"
	"   \"Jason, I've located a 'Mech signal from the northeast.\"\r"
	"   \"Blake's blood, they just keep coming!  Could you make out what it is?\"", /* DS:2B54[12] */
	"   \"Looks like a Whitworth to me.  Probably the commander of that Light Lance "
	"we've been fighting.\"\r"
	"   \"Let's finish him off, Rex!\"", /* DS:2B54[13] */
	"   Your death in battle has permanently ended your career as a lance commander. "
	" Perhaps you will employ a different strategy in your next life.", /* DS:2B54[14] */
	"   \"Hey, Jason.  I've got some good news and some bad news.\"\r"
	"   \"The bad news is two Rommel tanks are headed towards you, escorting an APC. "
	" We have to destroy them all; otherwise, they'll cruise right into the base.\"", /* DS:2B54[15] */
	"   \"The tanks are tough customers, but the APC is the true threat.  Don't let "
	"it get past you.  That's a direct quote from the Kell Hound captain who gave "
	"us the order.\"\r"
	"   \"So what's the good news?\"  you ask.", /* DS:2B54[16] */
	"   \"The good news is I'll pilot that Whitworth!\"\r"
	"   \"Sorry, Kurt, I have to give that one to Rex.\"\r"
	"   \"Sure, he blows up his 'Mech, then he gets the Whit!\"\r"
	"   Kurt smiles, \"Good luck, guys.  Graham out.\"", /* DS:2B54[17] */
	"   \"The good news is I'll pilot that Whitworth!\"\r"
	"   \"You're on, Kurt.  We'll need your help against the tanks.\"\r"
	"   \"On my way.  Graham out.\"", /* DS:2B54[18] */
	"   \"Oh, um, there is no good news.  It just sounded better when I told you about "
	"the bad news.\"\r"
	"   \"Graham out.\"", /* DS:2B54[19] */
	"   Apparently, your 'Mechs sustained too much damage after multiple combats. "
	" Your lack of defensive skills has ended a promising career.", /* DS:2B54[1A] */
	"   \"The APC went down the main road, Jason!\"\r"
	"   \"All right, we need to get to the Kell Hound base immediately!  Since we "
	"let that APC through, we'll have to give them all the help we can.\"", /* DS:2B54[1B] */
	"   Kurt's voice echoes through the cockpit.  \"That's it!  The bridge is secure!\"\r"
	"   \"Okay, our job is done here, so let's get moving.  I want to be at the Kell "
	"Hound base by 1530 hours!\"", /* DS:2B54[1C] */
	"   The Kell Hound base is almost empty, with only a few scattered 'Mechs guarding "
	"the gate.  Captain Caitlin Shaw meets you at the gate with grave news.  The "
	"northern walls have been breached, and infantry squads are just now entering "
	"the base.", /* DS:2B54[1D] */
	"   In the center of the base are crates of invaluable Listen-Kill missiles that "
	"the Kurita must not discover.  She needs you to save the Listen-Kill missiles "
	"and destroy the infantry.\r"
	"   Captain Shaw asks you to take the transport truck to the research center, "
	"load the missiles, and get them out of the base.  She motions Rex and Kurt towards "
	"two UrbanMechs.  Their objective is to destroy the infantry before the infantry "
	"gets too close to the truck.", /* DS:2B54[1E] */
	"   You've never commanded a mission from a wheeled transport truck before, but "
	"you're going to try.  Sgt. Krall starts the truck and leans back towards you.\r"
	"   \"I'll start drivin' towards the research center to get the missiles, so you "
	"don't need to tell me how to get there.  I know the way.  After all the missiles "
	"are loaded up, I'll let ya know.  If those infantry units get close enough to "
	"shoot the ammo we're carryin', we're roasted!\r"
	"   Oh, yeah, one more thing, sir.  I drive faster than those UrbanMechs can "
	"run!\"\r"
	"   Sgt. Krall snorts in laughter and puts the truck in gear.", /* DS:2B54[1F] */
	" ", /* DS:2B54[20] */
	"   The infantry got too close too fast.  If the UrbanMechs could have kept them "
	"back, maybe you would have survived.", /* DS:2B54[21] */
	"   As the truck drives off the base, a few ground units pull around you in a "
	"defensive posture.  With both sides exhausted and night falling, the Kurita "
	"'Mechs pull back to rest and rearm.  The Kell Hounds do the same.", /* DS:2B54[22] */
	"   You and your MechWarriors are the guests of honor at the dinner.  Morgan "
	"Kell welcomes you and states that without your help the base might have been "
	"lost.\r"
	"   When the cheering dies down, you explain that without Grease Anderson's help "
	"the Crescent Hawks would all be dead and that he is one promising MechWarrior. "
	" The Kell Hounds roar with laughter, and Morgan whispers that Grease is not "
	"yet a trained MechWarrior, only a Tech.", /* DS:2B54[23] */
	"   \"Nonetheless, even the most elite of our MechWarriors will have a tough time "
	"tomorrow.  We just don't have the firepower to continue pushing them back.\"\r"
	"   You offer the use of the two 'Mechs at the bottom of the lake.  Morgan delegates "
	"a salvage crew to raise and repair them for the battle tomorrow.  With that "
	"promise in mind, you order the Crescent Hawks to their quarters.", /* DS:2B54[24] */
	"   The next day, you approach Captain Shaw with a plan.  Your lance might be "
	"able to break through the Kurita front lines, go deep into the plains, and destroy "
	"both their Dragon 'Mech and Mobile HQ.\r"
	"   This would sever their communications, disrupting the Kurita forces.  With "
	"luck, the Kurita commander might even be forced to retreat.", /* DS:2B54[25] */
	"   Shaw considers your \"gauntlet\" plan and offers some suggestions.  If your "
	"'Mechs do survive the gauntlet, they'll probably be in pretty poor shape, perhaps "
	"too damaged to destroy the Dragon 'Mech guarding the Mobile HQ.\r"
	"   However, if two light 'Mechs can flank the Dragon by using the road to the "
	"east, you would have it at a serious disadvantage.  No matter where it turned, "
	"it would have an enemy lance behind it.", /* DS:2B54[26] */
	"   She also brings up the Listen-Kill missiles.  \"You risked your lives to save "
	"them.  I've instructed our Techs to load them on your 'Mechs that have SRM missile "
	"launchers with them.  The two Javelins for the \"road run\" mission will also "
	"have them.", /* DS:2B54[27] */
	"   She also brings up the Listen-Kill missiles.  \"You risked your lives to save "
	"them.  I've instructed our Techs to load them on your 'Mechs that have SRM or "
	"LRM missile launchers.  The two Javelins for the \"road run\" mission will also "
	"have them.\"", /* DS:2B54[28] */
	"   Captain Shaw then asks for any volunteers for this hazardous mission.  MechWarrior "
	"Jessica Riley steps forward, along with Grease Anderson.\r"
	"   Rex looks them over, nods his approval and asks you, \"Which lance will you "
	"lead, Jason?\"", /* DS:2B54[29] */
	"   \"Hawk Lance, your mission is twofold.  First, you are to support the Kell "
	"Hound units north of the base.  Then, move north through the forest six kilometers "
	"until you reach Sector D of the Northern Area.  Stay hidden and wait until 0730.\"\r"
	"   \"At 0730, you will advance and attack the Dragon 'Mech.  You are to keep "
	"him facing south, as the Javelin Lance will soon appear to attack his rear. "
	" Using all available firepower, you are to destroy the enemy Dragon and then "
	"find and eliminate their Mobile HQ.\"", /* DS:2B54[2A] */
	"   The Gauntlet defeated you before you could even leave the base.  You should "
	"use the long-range firepower of your Fire Lance to better advantage.", /* DS:2B54[2B] */
	"   You notice something at your window.  You draw your pistol and turn.  Rex "
	"is knocking on your cockpit!  He must have jumped onto your 'Mech's leg sometime "
	"after he punched out.\r"
	"   You open the cockpit and he climbs into the back seat to take over the sensor "
	"readings.", /* DS:2B54[2C] */
	"   \"Hawk Leader, I'm getting transmissions from the other lance.  They were "
	"in position, but the Snakes have crippled them.  There goes our surprise attack.\"", /* DS:2B54[2D] */
	"   \"Javelin Lance, your mission is accomplished in two phases.\"\r"
	"   \"In Phase One you will quickly follow the road, which is now blocked by Kurita "
	"forces.  You must follow the left fork in the road to arrive at coordinate A30 "
	"before 0714, or you'll be too late for Phase Two.\"", /* DS:2B54[2E] */
	"   \"Phase Two will begin when you reach the Northern Area.  You are to remain "
	"hidden at coordinate E74 until 0730 hours.  At that time, the Hawk Lance should "
	"begin engaging the enemy Dragon 'Mech in Sector D.  Come out of hiding, and "
	"concentrate your missiles on its rear armor.  It won't stand a chance, Jason.\"", /* DS:2B54[2F] */
	"   In the face of superior firepower, you chose to engage in a firefight.  It "
	"appears to have been an unwise choice.", /* DS:2B54[30] */
	"   Grease comes out of hiding in the forest, and jumps onto your Mech's ladder. "
	" He settles into the seat behind you.  \"That's the second 'Mech I fried in 24 "
	"hours!  Do you think it's my luck that's bad... or my style?\"", /* DS:2B54[31] */
	"   \"Javelin Leader, this is Hawk Leader!  Where were you?  We could have won "
	"if you were on his flank!  We are heavily damaged and must retreat.  Advise "
	"you to continue assault anyway.  Maybe you'll get lucky.  Hawk Leader out.\"", /* DS:2B54[32] */
	"   \"Hawk Leader, target sector approximately six kilometers north.\"\r"
	"   \"Confirmed, Hawk Two.  Let's try to avoid enemy contact until zero hour. "
	" Leader out.\"\r"
	"   \"Roger that, Leader.  Hawk Two out.\"", /* DS:2B54[33] */
	" ", /* DS:2B54[34] */
	"   Outdistancing the Kurita roadblock, you and Grease head towards Kalahara's "
	"Ridge.", /* DS:2B54[35] */
	"   \"We're real close to the target, Jason.\"\r"
	"   \"Could you be a little more specific, Javelin Two?\"\r"
	"   \"Oh, yeah.  Approximately one klick west of us, Javelin Leader.\"\r"
	"   \"Roger.  Let's lay low and wait until 7:30.\"", /* DS:2B54[36] */
	"   Despite your superior accuracy and firepower, you failed to destroy the Kurita "
	"Dragon.  The academy should have trained you to use your resources more wisely.", /* DS:2B54[37] */
	"   A calm voice comes from your speaker.  \"So, you are the one who has made "
	"such an impression.  And now you threaten my Mobile Headquarters.  Who are you, "
	"MechWarrior?\"\r"
	"   \"I am Jason Youngblood of the Crescent Hawks.\"", /* DS:2B54[38] */
	"   \"I am Tai-sa Chiun.  Do you wish to honor us with a change of alliance, or "
	"simply surrender now?\"\r"
	"   Anger wells inside you as you reply, \"I do not serve tyrants, nor will I "
	"cease fighting you for as long as I live!\"", /* DS:2B54[39] */
	"   \"That was much like what your father said to me.\"\r"
	"   \"Where is my father!\"  you shout at his image.\r"
	"   \"I have given him the highest honor.  One I am about to give you.  Death "
	"by combat.\"", /* DS:2B54[3A] */
	"   Colonel Chiun was not impressed.  He expected more from the son of Jeremiah "
	"Youngblood.", /* DS:2B54[3B] */
	"   Chiun's grim face appears again.  \"You have won this battle, Youngblood. "
	" Because of your success today, the Coordinator asks for my return.  I will "
	"have my revenge, Youngblood.  I will not be cheated.\"", /* DS:2B54[3C] */
	"   \"I feel we will meet again.  I will not be denied the challenge of mortal "
	"combat against both father and son.  Until then...\"", /* DS:2B54[3D] */
	"   With Chiun's units retreating, the Hawks return to a hero's welcome at the "
	"base.  Morgan gratefully acknowledges your success and debriefs you and your "
	"men.\r"
	"   During the debriefing, Colonel Chiun's claims of your father's death come "
	"up.", /* DS:2B54[3E] */
	"   \"I trust Chiun as far as I can throw him,\"  Morgan says.  \"Your father has "
	"knowledge of a Star League cache on Pacifica they want, not to mention tremendous "
	"information about Steiner internal security.  Killing him is the last thing "
	"the Kurita would do.\"\r"
	"   \"Chiun tried to provoke you, hoping that your judgment on the battlefield "
	"would be affected.  It appears you focused your anger and used it against him, "
	"much as your father would have done.\"", /* DS:2B54[3F] */
	"   \"If your father is alive, he is probably being interrogated on Dieron, the "
	"Kurita prefect capitol.\"  You eagerly ask Morgan to help you raid the city to "
	"find him, but he holds up his hands in helplessness.\r"
	"   \"With the Fourth Succession War raging, neither you nor the Kell Hounds have "
	"the firepower to wage a full-scale assault on Dieron with any hope of success.\"", /* DS:2B54[40] */
	"   Morgan offers a suggestion, though.  \"If you were to lead two lances of assault "
	"vehicles on a quick raid of Dieron,\" he states, \"you might be able to rescue "
	"your father and get off the planet before the garrison has time to react.\"\r"
	"   \"I can arrange to get you the vehicles and some troops, if you like.\"", /* DS:2B54[41] */
	"   Rex and Kurt agree that any chance to get your father back is worth the risk. "
	" However, you realize the Crescent Hawks are lacking one MechWarrior.  You turn "
	"to Grease and ask if he knows anyone who would like the job.\r"
	"   All eyes turn to him as he responds.", /* DS:2B54[42] */
	"   \"Well, I know this Tech who's had some experience.  But the 'Mechs he pilots "
	"tend to get shot up a lot.\"\r"
	"   \"That's fine.  What I need is someone to drive a tank.\"\r"
	"   \"A tank?  Now there's a challenging machine to wreck!  Count me in!\"\r"
	"   You smile warmly.  \"Rick Anderson, you are now officially a member of the "
	"Crescent Hawks!\"", /* DS:2B54[43] */
	"   Morgan smiles and says \"Jason, you risked your own life to save ours, and "
	"the Kell Hounds never forget a favor.  Not only will I allow you to steal my "
	"favorite Tech, but I can increase the odds of saving your father.\"\r"
	"   \"What would suit your tactics better: three standard vehicle lances under "
	"your command, or two vehicle lances that are better armed and armored?\"", /* DS:2B54[44] */
	"   Inside the DropShip, your men go through last minute preparations for the "
	"assault.  The mission itself is clear: the ship will drop you off at 10:00 and "
	"will leave at 12:00, before enemy AeroSpace fighters can intercept it.  In that "
	"time, you must get to the city, free the prisoners, and return.\r"
	"   If you are not back by 12:00, the ship will be forced to leave, and you will "
	"be left behind.", /* DS:2B54[45] */
	"   Because of the covert nature of this mission, direct communications will "
	"be impossible.  Looking at Captain Shaw's disk of pre-recorded orders, you insert "
	"it into the holovid viewer.", /* DS:2B54[46] */
	"   \"This mission is code-named Operation Liberty.  Please open the map of the "
	"surrounding area and of the city.\"\r"
	"   \"Upon touchdown, you will see two paths leading to the city.  The mountain "
	"pass is longer, but is lightly defended.  The forest path is faster, but much "
	"more heavily patrolled.  Choose which way you feel is strategically best for "
	"your company.  Access this disk again for more instructions when you pass the "
	"mountain.\"", /* DS:2B54[47] */
	"   Tank tactics are much different from 'Mech tactics, especially when you are "
	"outnumbered.  The academy stressed maneuverability when facing a stronger enemy.", /* DS:2B54[48] */
	"   Somehow you managed to waste the two hours you were given.  This inexcusable "
	"action leads to your removal as leader of the Crescent Hawks.", /* DS:2B54[49] */
	"   Good job, Jason.  The clock is ticking, so I'll be brief.  Continue along "
	"your designated route and access the disk when you've entered the city.  Get "
	"both your vehicle and the APC inside the city gate before going further.", /* DS:2B54[4A] */
	"   Enemy reinforcements are something a commander must always expect.  Unfortunately, "
	"you seem to have learned this lesson the hard way.", /* DS:2B54[4B] */
	"   Before you could even get to the city, it was time for the DropShip to return. "
	" Fearing abandonment, you led your command back to the DropShip, and left Dieron.\r"
	"   Your earlier leadership skills were proven a fluke, and you were relieved "
	"of duty by Katrina Steiner.", /* DS:2B54[4C] */
	"   With the APC destroyed, you have no way of transporting the prisoners safely. "
	" Thus, the rescue mission has failed.  You will never know if your father is "
	"alive after all.", /* DS:2B54[4D] */
	"   While the APC waits in hiding, you quickly move your lance over to the Kurita "
	"'Mech Shop.\r"
	"   Inside the shop you find many incomplete 'Mechs and vehicles.  In the corner "
	"of the shop, you spot four brand-new Crusader 'Mechs.  Grease lets out a low "
	"whistle.  \"You think they'd mind if we took 'em out for a spin?\"  he says with "
	"a mischievous grin.\r"
	"   Within 10 minutes, your four MechWarriors are racing towards the town, and "
	"you access your next orders.", /* DS:2B54[4E] */
	"   Excellent!  Now that you have entered the city, bring the APC to the prison "
	"and shoot out the prison exercise yard at coordinate Y56.  Use the rest of your "
	"remaining forces to deal with any defenses in the city.  As soon as you load "
	"the prisoners in the APC, leave the city.\r"
	"   Remember, you have to be at the drop site by 1200 hours.\r"
	"   Good luck, Jason.", /* DS:2B54[4F] */
	"   After multiple encounters with the enemy, your vehicles have literally fallen "
	"apart.  Perhaps you should be more careful the next time you lead a rescue mission.", /* DS:2B54[50] */
	"   A rescue mission depends on two things: surprise and speed.  Your sacrifice "
	"of men and materials would have been censured... if you had survived.", /* DS:2B54[51] */
	"   You fought against both House Kurita and the clock, but neither one very "
	"well.  Abandoned on Dieron, the Crescent Hawks become an extinct species.", /* DS:2B54[52] */
	"   A couple of blasts from the laser cannon disintegrates the prison wall.  "
	"As the smoke clears, you see a stream of prisoners come out the excerise yard.\r"
	"   The APC opens its doors and the prisoners clamber aboard.  You hope your "
	"father is among them, but until you get to the DropShip you won't know.", /* DS:2B54[53] */
	"   With all the prisoners on board the APC, you give the command to retreat.\r"
	"   \"Getting in was easy, men,\" you say.  \"Getting out will be the hard part.\"", /* DS:2B54[54] */
	"   The overwhelming forces of the Dieron garrison have bested you.  The Crescent "
	"Hawks are imprisoned, never to be heard from again.", /* DS:2B54[55] */
	"   In the heat of battle, you notice the horizon light up as the DropShip takes "
	"off.  With no way to leave Dieron, you and your men are captured and imprisoned "
	"for life.", /* DS:2B54[56] */
	"   Your Comlink comes to life.\r"
	"   \"We meet again, Youngblood!  This time on my terms.\"\r"
	"   \"Chiun!\"  you gasp in recognition.\r"
	"   \"Instead of having to hunt you down, you have come to me.\"", /* DS:2B54[57] */
	"   \"Duel me, Youngblood.  Fight me to avenge the death of the Kell Hound MechWarriors, "
	"and your father.  Approach me.  I am in the Archer.\"", /* DS:2B54[58] */
	"   As close as you are to returning to your ship, you are still too late.  The "
	"DropShip lifts off precisely at 12:00, leaving you behind.  With no way to leave "
	"Dieron, you and your men are captured and imprisoned for life.", /* DS:2B54[59] */
	"   \"Twice I am robbed of the chance to prove my superior abilities in fair combat.\"\r"
	"   \"It seems you have a strange definition of 'fair', Chiun.  The odds are slightly "
	"in your favor.  Unless you want to try to take on our DropShip?\"", /* DS:2B54[5A] */
	"   \"Begone, Crescent Hawks.  You have waged and won a campaign I thought unwinnable. "
	" I will lose considerable prestige because of your victory today.  That is something "
	"I will make you pay for, Jason Youngblood.\"", /* DS:2B54[5B] */
	"   The DropShip opens its doors and your command quickly boards.  The ship immediately "
	"lifts off, leaving Dieron behind.\r"
	"   Once safely in space, you rush to the area reserved for the rescued prisoners. "
	" You anxiously search among their tired faces for your father.  Then you see "
	"him.  His emotionless eyes blaze to life as he recognizes you.  A moment later, "
	"Jeremiah's big arms engulf you in a bear hug.\r"
	"   With your father alive and safe, you feel a great weight lift off your shoulders. "
	" Neither of you can speak for a long time.", /* DS:2B54[5C] */
	"   In the days that pass, you and your father spend as much time together as "
	"possible.  Rex, Jeremiah and you trade stories of the adventures you have had "
	"since his abduction on Pacifica six months ago.\r"
	"   He is proud of your ability to command a lance, and doubly proud to see you "
	"as the leader of the Crescent Hawks AND working with the Kell Hounds, two things "
	"he spent his life working toward.", /* DS:2B54[5D] */
	"   When you return to Pacifica, your father leaves to be debriefed.  Shortly "
	"thereafter, Katrina Steiner appears with Morgan Kell at her side.\r"
	"   \"Jason, you have shown me much.  You have shown me courage, determination, "
	"leadership, intuition and loyalty.  All of these are rare skills, but rarer "
	"still in a man barely 20!\"", /* DS:2B54[5E] */
	"   \"In gratitude, I give you permission to make my lance your own.  The Crescent "
	"Hawks are now yours to command, Captain Youngblood.\"\r"
	"   Morgan adds, \"And I offer you the chance to become an independent unit of "
	"the Kell Hounds, free to pursue your own contracts, but under my command when "
	"I need you.\"", /* DS:2B54[5F] */
	"   You remember back six months ago when Katrina offered you a position in the "
	"LCAF, and how you were forced to turn it down to find your father.  But now "
	"he is safe.\r"
	"   You look back at your fellow MechWarriors.  Rex, Kurt and Grease all eagerly "
	"wait for your answer.", /* DS:2B54[60] */
	" ", /* DS:2B54[61] */
	"   As the months go by, your reputation and fame grow.  Your involvement in "
	"the Fourth Succession War with the Kell Hounds proves time after time your value "
	"to the Federated Commonwealth, the new alliance of Houses Steiner and Davion.\r"
	"   In February, 3030, Kurt Graham leaves the Crescent Hawks to create his own "
	"mercenary unit.", /* DS:2B54[62] */
	"   Almost a decade after the Fourth Succession War burns out, the War of 3039 "
	"ignites.  Hanse Davion includes the Crescent Hawks in many attempts to reclaim "
	"planets House Kurita invaded years before.\r"
	"   After the end of the War of 3039, Rex informs you of his plans to retire "
	"from the military life.  You wish him the best of luck, and name Rick \"Grease\" "
	"Anderson your new Lieutenant of the Fire Lance.", /* DS:2B54[63] */
	"   The New Avalon Institute of Science continues research on recovered Star "
	"League technology, and discovers a way to mass produce Listen-Kill Missiles. "
	" However, ECM software packages are quickly issued to all Kurita units, negating "
	"all advantages of the L-K missiles.", /* DS:2B54[64] */
	"   In late 3049, a new threat enters the Inner Sphere.  They are called the "
	"Clans, the descendants of the Star League members who left the Inner Sphere "
	"250 years ago.  They have returned, with superior fighting skills and weaponry,in "
	"an effort to regain the Inner Sphere.\r"
	"   In their initial invasion, they cut down over 30 'Mech regiments, making "
	"them appear unstoppable in their conquest.  In 3050, however, a minor victory "
	"at Rasalhague resulted in their leader being killed, and they halted to elect "
	"a new IlKahn, the Clan term for warlord.", /* DS:2B54[65] */
	"   Now the Clans have returned, and are more determined than ever.  In response "
	"to this deadly threat, the Crescent Hawks have been called to Arc-Royal to receive "
	"training in newly produced 'Mech and weapon technology.  Also receiving training "
	"is the new Lieutenant of your Scout Lance, Jen Pearce, Rex's daughter.", /* DS:2B54[66] */
	"   \"Greetings, Jason.  It's good to see you again.  You are to choose 12 new "
	"'Mechs for the three lances of your company.  These 'Mechs have the newest weapons "
	"and equipment we have to offer, and are unlike anything you have seen before. "
	" These Enhanced 'Mechs are noted by a + or * after their names to denote different "
	"weapon and equipment configurations.  Review each 'Mech's pros and cons before "
	"choosing.\"", /* DS:2B54[67] */
	"   \"Next, you are to report to the training area for practice with your new "
	"'Mechs.  You didn't expect me to just hand them over, did you?  You'll have "
	"to prove to me that you are worthy of them.\"\r"
	"   \"The Arc-Royal training arena is set up for six different courses.  You must "
	"successfully complete all six courses with your company before I will qualify "
	"you to use the 'Mechs.  These combats are simulated... there are no real deaths "
	"or losses.\"", /* DS:2B54[68] */
	"  \"You will be facing the Clans on the training field.  As of this date, we "
	"know nothing of their so-called OmniMechs, and are unable to simulate them. "
	" However, the Clans also use regular 'Mech designs, both enhanced and unenhanced. "
	" All of your training missions will be against standard, unenhanced 'Mechs.\"\r"
	"   \"Report to me the minute you finish all six missions.  Time is of the essence.\"", /* DS:2B54[69] */
	"   \"Jason, for this mission you will be entering the battlefield from the southwest "
	"and will move northeast to attack the town.  Your primary objective is to destroy "
	"the three fuel tanks at coordinates D01, D14 and D27.\"\r"
	"   \"Once the fuel tanks have been destroyed, exit the training grounds to the "
	"north.  You must have units from all three lances on the border to qualify for "
	"a successful mission.  You have 20 minutes to do this.\"", /* DS:2B54[6A] */
	"   \"Jason, your primary objective is to defend the two fuel tanks centered at "
	"coordinates I99 and I58.  A strong 'Mech force is known to be approaching your "
	"position from the west, and there are reports of other enemy units in your area, "
	"although their locations are not known.  You will have some artillery support "
	"at your disposal.\"\r"
	"   \"You are to destroy the enemy before they destroy the tanks.  You have 20 "
	"minutes to do this, or you will lose by default.\"", /* DS:2B54[6B] */
	"   \"Jason, enemy units are approaching from the north and west.  We believe "
	"they will try to outflank you and exit the field somewhere to the southeast. "
	" Do not allow any enemy 'Mechs to get by you.  You will have the use of strafers "
	"and the satellite.\"\r"
	"   \"If you destroy all of the enemy before any one of them reaches the southeast "
	"border, you will successfully complete this mission.  You have as much time "
	"as you need to accomplish this.\"", /* DS:2B54[6C] */
	"   \"Jason, you will be entering the battlefield from the north and the east. "
	" A strong enemy force is known to be in the area.  You must outflank them and "
	"exit at coordinate P09 to the southwest.  Inflict as much damage to the enemy "
	"as you can, but don't waste your strength in head-to-head combat.  You will "
	"have the satellite view available.\"\r"
	"   \"Getting to P09 with your unit will achieve a victory.  You have 15 minutes "
	"to accomplish this.\"", /* DS:2B54[6D] */
	"   \"Jason, defend the high ground at the center of the battlefield at all costs. "
	" We know a strong enemy company is in the area, but its position is unknown. "
	" This will probably be a fight to the death, but let's hope it doesn't come "
	"to that.  You will have air support, as well as the satellite view.\"\r"
	"   \"If you can discourage them long enough, you will successfully complete the "
	"mission.\"", /* DS:2B54[6E] */
	"   \"Jason, your orders are to take and hold the high ground at the center of "
	"the battlefield.  It may be impossible to destroy all enemy units in the area, "
	"so use good judgement on offensive techniques.\"\r"
	"   \"You will only have 20 minutes to get to coordinate M65 to complete this "
	"mission.  The satellite uplink is available, but will sometimes become jammed, "
	"as it might in actual combat.  Good luck.\"", /* DS:2B54[6F] */
	"   \"Jason, we have received orders to proceed immediately to Luthien, the capital "
	"of House Kurita.  The Clans are about to stage a massive attack.  We are to "
	"defend Luthien at all costs.\"", /* DS:2B54[70] */
	"   \"If Luthien falls, House Kurita will be decimated, leaving the entire Inner "
	"Sphere open for the Clans to pick apart, system by system.  Only by allying "
	"with the Kuritas can we hope to repel the Clans and hold the Inner Sphere.\"\r"
	"   \"Since it will take several jumps to get to Luthien, you must leave immediately. "
	" Take care until then, Jason.\"", /* DS:2B54[71] */
	"   En route to Luthien, the Kell Hound JumpShip arrives at a pirate jump point "
	"at Kaesong, a Clan-held system.  While the ship recharges its jump engines, "
	"you are summoned to the bridge in response to a distress message from the planet.", /* DS:2B54[72] */
	"   \"This is Gideon Braver Vandenburg of the Blazing Aces.  Second line Clan "
	"units have discovered our presence, and we are in desperate need of help.  We "
	"will hold out as long as we can, but their firepower is unbelievable!\"\r"
	"   \"This is Gideon Braver... \"", /* DS:2B54[73] */
	"   You act immediately and order a Union DropShip to land the Crescent Hawks "
	"on the planet while the JumpShip's engines recharge.  Over the protests of the "
	"Kell Hound Captain, you dash into the DropShip to lead the rescue mission.", /* DS:2B54[74] */
	"   Hours pass as you near the planet, hours of wondering if you will arrive "
	"too late to help.  As the DropShip approaches the atmosphere, Jen identifies "
	"a planetside firefight.  She estimates touchdown in ten minutes.\r"
	"   \"That's too long,\" you reply.  \"The Aces could be decimated in ten minutes.\"\r"
	"   Grease suggests a 'Mech Drop.  The Command Lance could be ejected from the "
	"ship, descend through the atmosphere, and land in the middle of the battle almost "
	"immediately.  The other two lances could join up when the ship lands.  The choice "
	"is up to you.", /* DS:2B54[75] */
	"   Grease appears as you strap into your 'Mech.\r"
	"   \"Lieutenant, let's get this drop underway!\"\r"
	"   \"Check, Boss!  Fasten your seat belts, extinguish all smoking materials, "
	"and hold on to your lunch!\"", /* DS:2B54[76] */
	"   A few minutes after leaving the 'Mech Bay, you hit the atmosphere.  As your "
	"'Mech screams helplessly down toward the planet, you decide this is not the "
	"safest way to get planetside, but certainly it is the quickest.\r"
	"   You spot a lone 'Mech fighting five others.  Those are bad odds at any time, "
	"but even worse against the Clans.  You should touch down any minute now...", /* DS:2B54[77] */
	"   The second line Clans were tougher than you thought.  Maybe you should have "
	"waited and attacked with the whole company.", /* DS:2B54[78] */
	"   \"Captain, we're about to land planetside, but Jen sees no signs of a firefight "
	"anymore.\"\r"
	"   No signs?  \"Lieutenant, I want the entire company out of this ship before "
	"the dust begins to settle.\"\r"
	"   \"Consider us there, Boss.\"", /* DS:2B54[79] */
	"   Perhaps you should have jumped earlier before reinforcements had time to "
	"show up.", /* DS:2B54[7A] */
	"   After the last Clan 'Mech is destroyed, you rush over to the smoldering Blazing "
	"Aces 'Mech.  Gideon Vandenburg crawls out of the cockpit, towards your lance.", /* DS:2B54[7B] */
	"   You get out of your 'Mech and attempt to give him first aid.  His wounds "
	"are severe, so he stops you from trying.  He starts to say something, but his "
	"voice is weak.  You bend closer to make out his words.", /* DS:2B54[7C] */
	"   \"You're too late.  The Aces... destroyed.  I've taken precautions, hidden "
	"the 'Mechs.  Tell Maria... rebuild the Aces.  She'll know what to do.\"  With "
	"one final shudder of breath, Gideon dies in your arms.", /* DS:2B54[7D] */
	"   \"Captain, I'm receiving another emergency transmission.  The town to the "
	"east is under Clan attack and the mayor's begging for our help.\"\r"
	"\"Also, the JumpShip is ready to go.  We have been ordered to return now!\"", /* DS:2B54[7E] */
	"   You make a funeral pyre for Vandenburg while considering your dilemma.  You "
	"have explicit orders from Morgan Kell to get to Luthien as soon as possible. "
	" However, you know the town will be decimated if you leave.  You need to make "
	"a decision.", /* DS:2B54[7F] */
	"   With the city in ruins, the remaining Clan forces on Kaesong destroy your "
	"company and take you captive.  Morgan Kell lists you as M.I.A.", /* DS:2B54[80] */
	"   In rescuing the city, you have also defended an advanced 'Mech repair facility, "
	"perhaps the target of the Clan attack.  Learning of your mission on Luthien, "
	"the Mayor arranges for all of your functioning 'Mechs to be fully repaired.", /* DS:2B54[81] */
	"   Soon, you are back at the DropShip.  The Kell Hound Captain is furious, but "
	"decides to let Morgan reprimand you when you arrive at Luthien.", /* DS:2B54[82] */
	"   Luthien.  Capital system of House Kurita.  This world represents everything "
	"you have hated since you were a child.  Now you are to ally with them in a joint "
	"effort to repel an uncommon common enemy.\r"
	"   Once planetside, Morgan demands you see him immediately.", /* DS:2B54[83] */
	"   \"Jason, how could you leave the city undefended?  Yes, you followed orders, "
	"but you should have more sense!  Many innocent lives and a repair center were "
	"lost due to your shortsightedness!\"", /* DS:2B54[84] */
	"   \"Jason, how could you disobey my orders?  Yes, you did the right thing in "
	"defending the city, but you weren't thinking about the big picture!  What if "
	"the Clans had arrived before you did?\"", /* DS:2B54[85] */
	"   \"However, your actions to save the Blazing Aces were justified.  Gideon Vandenburg "
	"will be sorely missed.\"", /* DS:2B54[86] */
	"   \"Here is the situation.  The Kell Hounds and Wolf's Dragoons are already "
	"deployed.  I need you to help defend the perimeter, a command under Kurita jurisdiction.\"", /* DS:2B54[87] */
	"   \"You are to obey your Kurita superior as you would me.  Show him the respect "
	"his rank deserves.\"\r"
	"   \"Now go to the briefing room to receive your orders from your new commander. "
	" Good luck, Jason.\"", /* DS:2B54[88] */
	"   \"Youngblood, enter.  I have waited a long time for this.\"\r"
	"   You look at the face, the eyes, and the decorations on his uniform.  There "
	"is no doubt that it is Chiun.\r"
	"   \"If you thought I was dead you have been mistaken, for I have not forgotten "
	"our last encounter.  Imagine my surprise when they put your file on my desk. "
	" Under my command.\"\r"
	"   Your years of training allow you to mask your true feelings towards Chiun. "
	" He is, by Morgan's order, your superior.", /* DS:2B54[89] */
	"   \"Youngblood, do not fear me.  It is now the Clans who are our enemy, not "
	"each other.  We must put our past behind us now.  I need you to show the same "
	"cunning and prowess against the Clans as you did me so many years ago.\"\r"
	"   \"These are your orders...\"", /* DS:2B54[8A] */
	"   \"You are to protect a shipment of military munitions being routed to Imperial "
	"City for its defense.  You will use your own Scout Lance, and you will command "
	"a lance of light 'Mechs.  Your heavy 'Mechs are to remain here for use later "
	"in our defense.\r"
	"   The transports are part of the Sword of Light regiment, and are not under "
	"your command.  They will leave on the western road when they have fully loaded. "
	" You are to protect them at all costs, using the satellite uplink and AeroSpace "
	"fighter support to your advantage.\"", /* DS:2B54[8B] */
	" ", /* DS:2B54[8C] */
	"   \"You have failed in the simple task I gave you.  You have grown old and soft, "
	"and are no longer the warrior you once were.  It is rumored more Clans are on "
	"the way.  You will find out if it is true soon enough.\"", /* DS:2B54[8D] */
	"   \"Excellent work, Youngblood.  However, it appears that forward elements of "
	"the Clan assault have cut off your retreat route.  The transports are safe, "
	"but you are not.\"", /* DS:2B54[8E] */
	"   \"We are sending a Planetlifter Air Transport to retrieve you.  I have also "
	"dispatched an Assault Lance to assist you.  Both will arrive soon.  You must "
	"defend yourself against the Clans until the Assault Lance appears.  The Assault "
	"lance will then direct you to the coordinates of the Planetlifter.\"\r"
	"   \"Youngblood, be careful.  The Clans have sworn to eliminate you.  We will "
	"attempt to keep the satellite uplink active at all times,  and we will provide "
	"as much air cover as we can.\"", /* DS:2B54[8F] */
	"   It appears you have seriously underestimated the firepower of the Clan 'Mechs "
	"and the skill of their Warriors.", /* DS:2B54[90] */
	"   As your units approach the westernmost ridge, you hear the whine of jets "
	"overhead.  The Planetlifter transports have arrived.  While fighters overhead "
	"keep the Clans back, the remains of your company are loaded and flown back to "
	"the Kurita command post.", /* DS:2B54[91] */
	"   \"Intelligence shows you are in the center of the main Clan advance.  They "
	"have managed to cut off your retreat, and are homing in on you.  Against my "
	"will, I have been ordered to pull you back.  Try to remain unseen until the "
	"Sword of Light Assault Lance appears.  They will have instructions for your "
	"retreat.\r"
	"   \"The satellite is still active, and we will attempt to provide some air cover.\"", /* DS:2B54[92] */
	" ", /* DS:2B54[93] */
	"   \"Due to your performance on the field, you are being relocated to the front "
	"to support the Kell Hound defense.  You are to anchor the Hound's northern flank, "
	"holding the river valley that leads to the Imperial City.  We expect the Clans "
	"to use the main road, but they may attempt to outflank us.\"\r"
	"   \"You are to use both your Command and Fire Lances, plus a Kurita Assault "
	"Lance.  Be advised, Youngblood, my son is in this lance.  See that you treat "
	"him with respect.  The satellite uplink may go down sporadically, so do your "
	"best.\"", /* DS:2B54[94] */
	"   With your death, the Crescent Hawks collapse, and the Clans push on to attack "
	"the Imperial City.  The Inner Sphere will surely fall.", /* DS:2B54[95] */
	"   Although you tried to stop them, the Clans broke through and entered the "
	"Imperial City.  With no units inside the city as defense, House Kurita crumbles. "
	" The Clans are sure to conquer the rest of the Inner Sphere.", /* DS:2B54[96] */
	"   \"Victory is in our grasp!  At this moment, the Coordinator and his unit, "
	"the Dragon's Claws, are engaging the Clans.\"\r"
	"   \"Return to the command post for further orders.\"", /* DS:2B54[97] */
	"   \"You are to hold back the Clans at all costs.  The Coordinator is leading "
	"the point attack, and his flank must be guarded.  You will use your Command "
	"and Fire Lances again as well as the Sword of Light Assault Lance to defend "
	"the northern plains.  You are the buffer between the Clans and the Imperial "
	"City.\"\r"
	"   \"Artillery is under your command, as well as the direct access to the uplink. "
	" The Clans will also be using their artillery, so keep moving!  The Clans must "
	"not get through.\r"
	"   \"I trust you to do this, Jason-san.\"", /* DS:2B54[98] */
	"   Your name will be honored in Inner Sphere history as one of the noble dead "
	"in the Battle of Luthien.", /* DS:2B54[99] */
	"   On the good side, you have immortalized the name of the Crescent Hawks in "
	"the battle of Luthien.  On the bad side, it is a footnote in a Clan Historian's "
	"book on the old Inner Sphere.", /* DS:2B54[9A] */
	"   \"You have succeeded is defending the Imperial City!  Our Coordinator has "
	"also struck the fatal blow against the invaders.  Now we must finish the work "
	"he has begun!\"", /* DS:2B54[9B] */
	"   \"The Clans are retreating to their DropShips.  It is expected if the gods "
	"are willing that we could conceivably capture their Galaxy Commander.  Otherwise, "
	"we are to decimate their 'Mechs in true Samurai form.\"\r"
	"   \"This is our chance to avenge our slain brothers and our honor.  You, Jason "
	"Youngblood, will lead your remaining 'Mech reserves and the Kell Hounds and "
	"attempt to capture the Galaxy Commander.\"", /* DS:2B54[9C] */
	"   The headstone reads:\r"
	"   Jason Youngblood, 3010-3052.  He gave his life to save the Inner Sphere.", /* DS:2B54[9D] */
	"   The Clans escape in their DropShips with their Galaxy Commander alive.  They "
	"have lost this battle, but the damage you have done was minor; the true loss "
	"would have been the death of their commander.", /* DS:2B54[9E] */
	"   You have succeeded in disabling the Galaxy Commander's BattleMech!  Taskashi "
	"Kurita and the Dragon's Claws surround the Mad Cat as a lone figure climbs out "
	"of the 'Mech's cockpit and addresses the Coordinator.", /* DS:2B54[9F] */
	"   \"I am Galaxy Commander Ilnay Techus.  I salute you, Taskashi Kurita, and "
	"your brave warriors, for the ferocity of their combat.  I admit my responsibility "
	"in this defeat, and yield my command to you.\"", /* DS:2B54[A0] */
	"   Taskashi Kurita's voice fills your cabin.  \"I accept your defeat, Techus. "
	" I will take what is rightfully mine, and your forces will now leave this planet.\"", /* DS:2B54[A1] */
	"   \"And what of my children?  Must they be destroyed?\"\r"
	"   You've heard rumors that Clansmen negotiate the lives of their families as "
	"terms of surrender.  Will the Coordinator be as merciless as the Clans?", /* DS:2B54[A2] */
	"   \"Your children are to survive, as it is dishonorable for us to order such "
	"a thing, unlike your barbaric culture.\"\r"
	"   The Galaxy Commander visibly stiffens.  \"What Clan are my men and I to become "
	"bonded to?\"\r"
	"   Taskashi's voice sounds unsure as he speaks.  \"We do not want you or your "
	"kind on Luthien!  Now, leave my homeland, and tell your IlKahn of your defeat!\"\r"
	"   With those words, the Clans retrieve their Commander and leave Luthien.", /* DS:2B54[A3] */
	"   After the defeat of the Clans, a massive celebration commences.  During the "
	"ceremonies of commemoration to the warriors who saved Luthien, Taskashi Kurita "
	"calls the Crescent Hawks forward to accept tribute for your defense of Luthien. "
	" According to tradition, your men approach, lay their personal weapons before "
	"him, and kneel.", /* DS:2B54[A4] */
	"   \"In recognition of your loyalty to House Kurita against the Clan assault, "
	"I am honored to present to the Crescent Hawks the Bushido Blade.  We present "
	"this medal to those warriors who have demonstrated great courage on the battlefield. "
	" Combating the technological superiority of the Clans required such courage.\"", /* DS:2B54[A5] */
	" ", /* DS:2B54[A6] */
	"   \"The Order of the Dragon is our highest honor.  Normally it is presented "
	"to our warriors who have made significant territorial gains.  However, this "
	"one time we will make an exception, due to the tremendous leadership your commanders "
	"have shown in preserving our own territory.  For this we are most grateful.\"", /* DS:2B54[A7] */
	" ", /* DS:2B54[A8] */
	"   \"In reverence, we offer the Watcher of the Dragon's Eye posthumously to those "
	"who so bravely gave their lives in defense of our own.  There is no greater "
	"honor than to die protecting those who would die for you.\"", /* DS:2B54[A9] */
	" ", /* DS:2B54[AA] */
	"   After the ceremony, you are called to the bridge of your DropShip, where "
	"Morgan Kell is waiting to give you an urgent message.", /* DS:2B54[AB] */
	"   \"Jason, you have made your father, Melissa Steiner, and myself proud of all "
	"you have done.  You have turned out not only to be an excellent MechWarrior "
	"and brilliant tactician, but also a true leader of men.\"", /* DS:2B54[AC] */
	"   \"Jason, when the Clans return, they will strike as we have never seen, and "
	"we need to be prepared.  The Crescent Hawks, under your command, can help combat "
	"them, but you are only one man.  What we need is for you to use your gift of "
	"teaching by example to show other MechWarriors what tactics to take in any circumstance.\"", /* DS:2B54[AD] */
	"   \"Melissa is asking you to return to Pacifica, to become the Training Instructor "
	"there.  There you can choose almost any combination of 'Mechs to run company "
	"training drills.  They have even programmed the computers to simulate the OmniMechs "
	"you fought.  Enjoy your tenure there, as every battle you simulate may help "
	"a MechWarrior in the future.\"", /* DS:2B54[AE] */
	"   \"I will contact Maria Vandenburg and tell her the sad news of her father's "
	"death, and pass on the cryptic message Gideon gave to you.  I'll also tell her "
	"you'll be at Pacifica, in case she needs to get in touch with you.\"\r"
	"   \"Until Fate brings us together again, Jason Youngblood.  It has been a rewarding "
	"experience to have you under my command.  I will always remember these times. "
	" Good luck, my friend\"", /* DS:2B54[AF] */
	"   Before you leave Luthien, you reflect on the irony of your situation.  Your "
	"adventures first began on the training grounds of Pacifica, and twenty years "
	"later they lead you back again.  Becoming the T.I. would mean a lot of changes, "
	"including the removal of the Crescent Hawks from active combat status.\r"
	"   But that thought is replaced by a better one.  You would be responsible for "
	"shaping the minds of future MechWarriors... MechWarriors who will have to fight "
	"the Clans again one day soon.  With the help of your pupils, the Inner Sphere "
	"may finally defeat the Clan invasion.  Only time will tell...\r"
	"\r"
	"                     THE END", /* DS:2B54[B0] */
	"   As Training Instructor, you may simulate almost any type of 'Mech company "
	"conflict.  There are over 50 types of mechs available in the battle computers, "
	"including three OmniMechs.  You may first choose your 'Mechs, and then choose "
	"the enemy side's.  All MechWarriors are considered Elite, with excellent gunnery "
	"skill.  When you wish to re-load the simulator, choose Load Game, and choose "
	"the last option, TRAINING GROUND." /* DS:2B54[B1] */
};

const char PilotRosterHeadingText[] = "\r"; /* DS:47B4 */

char ScenarioResourcePathText[] = "SCENEx.DAT";
const char SceneFileTooLargeText[] = "SCENARIO FILE TOO BIG! 2048 MAX"; /* DS:2F0E */

const char * const GameOptionLabelTextTable[0x07] =
{
	"Music:\r", /* DS:46AE[00] */
	"Sounds:\r", /* DS:46AE[01] */
	"Voice:\r", /* DS:46AE[02] */
	"Input:\r", /* DS:46AE[03] */
	"Quit Scenario\r", /* DS:46AE[04] */
	"Exit to DOS\r", /* DS:46AE[05] */
	"Done" /* DS:46AE[06] */
};

const char * const GameOptionToggleTextTable[0x02] =
{
	"Off\r", /* DS:46CA[00] */
	"On\r" /* DS:46CA[01] */
};

const char * const NarrationModeLabelTextTable[0x03] =
{
	"Off\r", /* DS:46D2[00] */
	"Brief\r", /* DS:46D2[01] */
	"Verbose\r" /* DS:46D2[02] */
};

const char * const InputDeviceLabelTextTable[0x02] =
{
	"Keyboard\r", /* DS:46DE[00] */
	"Mouse\r" /* DS:46DE[01] */
};

const char FocusUnitText[] = "Go To Unit"; /* DS:46E6 */
const char FocusLanceText[] = "Go To Lance"; /* DS:46F1 */

static char DisabledUnitNarrationTextTable_00[] = "My 'Mech is crippled!";
static char DisabledUnitNarrationTextTable_01[] = "My 'Mech can't move.";
static char DisabledUnitNarrationTextTable_02[] = "No go.  Legs shot off.";
char * const DisabledUnitNarrationTextTable[0x03] =
{
	DisabledUnitNarrationTextTable_00,
	DisabledUnitNarrationTextTable_01,
	DisabledUnitNarrationTextTable_02
};

static char DestroyedUnitNarrationTextTable_00[] = "All movement capability is gone.";
static char DestroyedUnitNarrationTextTable_01[] = "I can't move.";
static char DestroyedUnitNarrationTextTable_02[] = "I'm incapacitated.";
char * const DestroyedUnitNarrationTextTable[0x03] =
{
	DestroyedUnitNarrationTextTable_00,
	DestroyedUnitNarrationTextTable_01,
	DestroyedUnitNarrationTextTable_02
};

static char ScenarioEventNarrationTextTable_00[] = "Too much damage!  I'm punching out!";
static char ScenarioEventNarrationTextTable_01[] = "My unit's gonna blow!";
static char ScenarioEventNarrationTextTable_02[] = "This ride's destroyed.  I'm getting out!";
static char ScenarioEventNarrationTextTable_03[] = "Life support has failed!  I'm gonna die!";
static char ScenarioEventNarrationTextTable_04[] = "My reactor's failed and I can't punch out! I'm roasting!";
static char ScenarioEventNarrationTextTable_05[] = "Say goodbye to my family for me...";
static char ScenarioEventNarrationTextTable_06[] = "All enemies out of scanning range.";
static char ScenarioEventNarrationTextTable_07[] = "No units in line of sight.";
static char ScenarioEventNarrationTextTable_08[] = "I can't see anyone to attack.";
static char ScenarioEventNarrationTextTable_09[] = "We've boarded the APC, Sir.";
static char ScenarioEventNarrationTextTable_0A[] = "Infantry is aboard the APC.";
static char ScenarioEventNarrationTextTable_0B[] = "We are now in the APC, Sir.";
static char ScenarioEventNarrationTextTable_0C[] = "The long range weapons are misfiring.";
static char ScenarioEventNarrationTextTable_0D[] = "Smoke's pouring from its long range weapons!";
static char ScenarioEventNarrationTextTable_0E[] = "Its main guns are flaking out.";
static char ScenarioEventNarrationTextTable_0F[] = "Looks like the main weapons are down!";
static char ScenarioEventNarrationTextTable_10[] = "Some of the smaller weapons are jammed.";
static char ScenarioEventNarrationTextTable_11[] = "It's lost almost all of its small guns, sir!";
static char ScenarioEventNarrationTextTable_12[] = "Nothing has scratched it yet, sir.";
static char ScenarioEventNarrationTextTable_13[] = "It looks like the paint's chipped a bit.";
static char ScenarioEventNarrationTextTable_14[] = "The 'Mech appears to be limping, sir!";
static char ScenarioEventNarrationTextTable_15[] = "A few more leg hits and he'll stop dead!";
static char ScenarioEventNarrationTextTable_16[] = "It's looking pretty beat up.";
static char ScenarioEventNarrationTextTable_17[] = "His legs are blown off!";
static char ScenarioEventNarrationTextTable_18[] = "I think he's out of ammo.";
static char ScenarioEventNarrationTextTable_19[] = "The infantry are injured.";
static char ScenarioEventNarrationTextTable_1A[] = "I think he's overheated!";
static char ScenarioEventNarrationTextTable_1B[] = "The unit is moving slowly, sir!";
static char ScenarioEventNarrationTextTable_1C[] = "The unit is struggling to move!";
static char ScenarioEventNarrationTextTable_1D[] = "The unit is stopped dead!";
char * const ScenarioEventNarrationTextTable[0x1E] =
{
	ScenarioEventNarrationTextTable_00,
	ScenarioEventNarrationTextTable_01,
	ScenarioEventNarrationTextTable_02,
	ScenarioEventNarrationTextTable_03,
	ScenarioEventNarrationTextTable_04,
	ScenarioEventNarrationTextTable_05,
	ScenarioEventNarrationTextTable_06,
	ScenarioEventNarrationTextTable_07,
	ScenarioEventNarrationTextTable_08,
	ScenarioEventNarrationTextTable_09,
	ScenarioEventNarrationTextTable_0A,
	ScenarioEventNarrationTextTable_0B,
	ScenarioEventNarrationTextTable_0C,
	ScenarioEventNarrationTextTable_0D,
	ScenarioEventNarrationTextTable_0E,
	ScenarioEventNarrationTextTable_0F,
	ScenarioEventNarrationTextTable_10,
	ScenarioEventNarrationTextTable_11,
	ScenarioEventNarrationTextTable_12,
	ScenarioEventNarrationTextTable_13,
	ScenarioEventNarrationTextTable_14,
	ScenarioEventNarrationTextTable_15,
	ScenarioEventNarrationTextTable_16,
	ScenarioEventNarrationTextTable_17,
	ScenarioEventNarrationTextTable_18,
	ScenarioEventNarrationTextTable_19,
	ScenarioEventNarrationTextTable_1A,
	ScenarioEventNarrationTextTable_1B,
	ScenarioEventNarrationTextTable_1C,
	ScenarioEventNarrationTextTable_1D
};

const char SceneNarrationSeparatorText[] = ": "; /* DS:478D */

const char * const UnitAllegianceLabelTextTable[0x02] =
{
	"Friendly ", /* DS:30CB[00] */
	"Enemy " /* DS:30CB[01] */
};

const char UnknownUnitLabel[] = "Empty"; /* DS:30D3 */
const char UnitStatusSpace[] = " "; /* DS:30D9 */
const char UnitRosterSeparator[] = "/"; /* DS:30DB */
const char UnitStatusSeparator[] = " J"; /* DS:30DD */

const char * const UnitStatHeaderTextTable[0x06] =
{
	"LNG", /* DS:30F2[00] */
	"MED", /* DS:30F2[01] */
	"CLS", /* DS:30F2[02] */
	"SPD", /* DS:30F2[03] */
	"EXP", /* DS:30F2[04] */
	"GUN" /* DS:30F2[05] */
};

static const byte UnitClassTypeList_00[] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x07, 0x09, 0x0A, 0xFF };
static const byte UnitClassTypeList_01[] = { 0x0F, 0x11, 0x12, 0x14, 0x15, 0x16, 0x17, 0x1B, 0x1C, 0x1E, 0xFF };
static const byte UnitClassTypeList_02[] = { 0x1F, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x2A, 0x2B, 0x2C, 0xFF };
static const byte UnitClassTypeList_03[] = { 0x2D, 0x2E, 0x31, 0x32, 0x33, 0x36, 0xFF };
static const byte UnitClassTypeList_04[] = { 0x45, 0x47, 0x49, 0x55, 0x4B, 0x4C, 0x4E, 0x57, 0x56, 0x50, 0x52, 0x54, 0x58, 0x46, 0x48, 0x4A, 0x4D, 0x4F, 0x51, 0x53, 0xFF };
static const byte UnitClassTypeList_05[] = { 0x42, 0x43, 0x44, 0x41, 0xFF };
static const byte UnitClassTypeList_06[] = { 0xBA, 0x6A, 0x32, 0x2E, 0x89, 0x16, 0xC7, 0x01, 0xB4, 0x30, 0xCD, 0x21, 0x8B, 0x2E, 0x02, 0x00, 0x8B, 0x1E, 0x2C, 0x00, 0x8E, 0xDA, 0xA3, 0x7D, 0x00, 0x8C, 0x06, 0x7B, 0x00, 0x89, 0x1E, 0x77, 0x00, 0x89, 0x2E, 0x91, 0x00, 0xC7, 0x06, 0x81, 0x00, 0xFF };
const byte * const UnitClassTypeLists[0x07] =
{
	UnitClassTypeList_00,
	UnitClassTypeList_01,
	UnitClassTypeList_02,
	UnitClassTypeList_03,
	UnitClassTypeList_04,
	UnitClassTypeList_05,
	UnitClassTypeList_06
};

const char * const UnitClassLabelTextTable[0x07] =
{
	"Light", /* DS:32F8[00] */
	"Medium", /* DS:32F8[01] */
	"Heavy", /* DS:32F8[02] */
	"Assault", /* DS:32F8[03] */
	"Enhanced", /* DS:32F8[04] */
	"Omni", /* DS:32F8[05] */
	"Cancel" /* DS:32F8[06] */
};

const char * const TrainingDeploymentLabelTextTable[0x04] =
{
	"Pacifica Training Facilities", /* DS:3314[00] */
	"Instructor: Jason Youngblood", /* DS:3314[01] */
	"Seek & Destroy", /* DS:3314[02] */
	"Scenario files open..." /* DS:3314[03] */
};

const char * const TrainingControlLabelTextTable[0x04] =
{
	"Choose Friendly", /* DS:3324[00] */
	"Choose Enemy", /* DS:3324[01] */
	"Game Options", /* DS:3324[02] */
	"Begin Training" /* DS:3324[03] */
};

const char * const ScenarioVariantDescriptionTextTable[0x04] =
{
	"The Gauntlet", /* DS:3334[00] */
	"The Road Run", /* DS:3334[01] */
	"Mountain Pass", /* DS:3334[02] */
	"Forest Path" /* DS:3334[03] */
};

const char * const UnitEditorSectionLabelTextTable[0x04] =
{
	"Briefing Room", /* DS:3344[00] */
	"Personnel", /* DS:3344[01] */
	"Mech Bay", /* DS:3344[02] */
	"Exit" /* DS:3344[03] */
};

const char * const ScenarioRouteLabelTextTable[0x04] =
{
	"Longer Distance", /* DS:3358[00] */
	"Lighter Defenses", /* DS:3358[01] */
	"Shorter Distance", /* DS:3358[02] */
	"Heavier Defenses" /* DS:3358[03] */
};

const char * const UnitEditorSectionButtonLabelTextTable[0x04] =
{
	"COMMAND", /* DS:3368[00] */
	"FIRE", /* DS:3368[01] */
	"SCOUT", /* DS:3368[02] */
	"EXIT" /* DS:3368[03] */
};

const char * const TrainingDeploymentRosterLabelTextTable[0x02] =
{
	"Arc-Royal Training Facilities", /* DS:3378[00] */
	"Arena reserved for the Crescent Hawks" /* DS:3378[01] */
};

const char * const UnitRosterColumnLabelTextTable[0x03] =
{
	"COMMAND LANCE", /* DS:3380[00] */
	"FIRE LANCE", /* DS:3380[01] */
	"SCOUT LANCE" /* DS:3380[02] */
};

const char FriendlyEnemySuffixText[] = "COMPANY";
const char TrainingCategoryHeadingText[] = "'Mechs"; /* DS:3390 */
const char * const TrainingCategoryLabelTextTable[0x02] =
{
	"OK", /* DS:3397[00] */
	"Re-select" /* DS:3397[01] */
};

const char TrainingScenarioHeadingText[] = "Choose an Arena Scenario"; /* DS:339F */
static char TrainingScenarioLabelTextTable_00[] = " Attack Town";
static char TrainingScenarioLabelTextTable_01[] = " Defend Town";
static char TrainingScenarioLabelTextTable_02[] = " Enemy Advance";
static char TrainingScenarioLabelTextTable_03[] = " Advance Fast";
static char TrainingScenarioLabelTextTable_04[] = " Hold Ground";
static char TrainingScenarioLabelTextTable_05[] = " Seize Position";
char * const TrainingScenarioLabelTextTable[0x06] =
{
	TrainingScenarioLabelTextTable_00,
	TrainingScenarioLabelTextTable_01,
	TrainingScenarioLabelTextTable_02,
	TrainingScenarioLabelTextTable_03,
	TrainingScenarioLabelTextTable_04,
	TrainingScenarioLabelTextTable_05
};

const char NoSelectionOptionsText[] = "None are available at this time."; /* DS:33D0 */
const char TrainingUnitSelectionPrompt[] = "  You must have at least a leader in the command lance of both the friendly and enemy companies before you can begin training."; /* DS:33F1 */

const char * const PilotSurnameTextTable[0x3B] =
{
	"Youngblood", /* DS:3E92[00] */
	"Pearce", /* DS:3E92[01] */
	"Graham", /* DS:3E92[02] */
	"Anderson", /* DS:3E92[03] */
	"Reilly", /* DS:3E92[04] */
	"Casey", /* DS:3E92[05] */
	"Corrigan", /* DS:3E92[06] */
	"Hall", /* DS:3E92[07] */
	"Hunter", /* DS:3E92[08] */
	"Barth", /* DS:3E92[09] */
	"Tatum", /* DS:3E92[0A] */
	"Ledesma", /* DS:3E92[0B] */
	"Bellamy", /* DS:3E92[0C] */
	"Latham", /* DS:3E92[0D] */
	"Louie", /* DS:3E92[0E] */
	"Christman", /* DS:3E92[0F] */
	"Townsend", /* DS:3E92[10] */
	"Stewart", /* DS:3E92[11] */
	"Bouy", /* DS:3E92[12] */
	"Hill", /* DS:3E92[13] */
	"Accardi", /* DS:3E92[14] */
	"Briggs", /* DS:3E92[15] */
	"Lebling", /* DS:3E92[16] */
	"Galley", /* DS:3E92[17] */
	"Blank", /* DS:3E92[18] */
	"Meretzky", /* DS:3E92[19] */
	"Moriarty", /* DS:3E92[1A] */
	"O'Neill", /* DS:3E92[1B] */
	"Berlyn", /* DS:3E92[1C] */
	"Kirsch", /* DS:3E92[1D] */
	"Berez", /* DS:3E92[1E] */
	"Dornbrook", /* DS:3E92[1F] */
	"Montague", /* DS:3E92[20] */
	"Sgt. Krall", /* DS:3E92[21] */
	"Youngblood", /* DS:3E92[22] */
	"Anderson", /* DS:3E92[23] */
	"Pearce", /* DS:3E92[24] */
	"Romero", /* DS:3E92[25] */
	"Carpenter", /* DS:3E92[26] */
	"Cronenberg", /* DS:3E92[27] */
	"DePalma", /* DS:3E92[28] */
	"Dante", /* DS:3E92[29] */
	"Raimi", /* DS:3E92[2A] */
	"Hooper", /* DS:3E92[2B] */
	"Cunningham", /* DS:3E92[2C] */
	"Chiun", /* DS:3E92[2D] */
	"Toranaga", /* DS:3E92[2E] */
	"Yamashita", /* DS:3E92[2F] */
	"Ichi", /* DS:3E92[30] */
	"Hosaka", /* DS:3E92[31] */
	"Higa", /* DS:3E92[32] */
	"Sanjuro", /* DS:3E92[33] */
	"Takagi", /* DS:3E92[34] */
	"Jackson", /* DS:3E92[35] */
	"Lewis", /* DS:3E92[36] */
	"Wylie", /* DS:3E92[37] */
	"Morton", /* DS:3E92[38] */
	"Vandenburg", /* DS:3E92[39] */
	"Trainee" /* DS:3E92[3A] */
};

const char * const PilotGivenNameTextTable[0x3B] =
{
	"Jason", /* DS:3F7E[00] */
	"Rex", /* DS:3F7E[01] */
	"Kurt", /* DS:3F7E[02] */
	"\"Grease\"", /* DS:3F7E[03] */
	"", /* DS:3F7E[04] */
	"", /* DS:3F7E[05] */
	"", /* DS:3F7E[06] */
	"", /* DS:3F7E[07] */
	"Chuck", /* DS:3F7E[08] */
	"Clark", /* DS:3F7E[09] */
	"Nance", /* DS:3F7E[0A] */
	"Carmen", /* DS:3F7E[0B] */
	"Tomas", /* DS:3F7E[0C] */
	"Mitchel", /* DS:3F7E[0D] */
	"Donald", /* DS:3F7E[0E] */
	"Christopher", /* DS:3F7E[0F] */
	"Wade", /* DS:3F7E[10] */
	"Stewart", /* DS:3F7E[11] */
	"Robert", /* DS:3F7E[12] */
	"Joseph", /* DS:3F7E[13] */
	"Gabby", /* DS:3F7E[14] */
	"Amanda", /* DS:3F7E[15] */
	"Darrel", /* DS:3F7E[16] */
	"Stewart", /* DS:3F7E[17] */
	"Marco", /* DS:3F7E[18] */
	"Stefan", /* DS:3F7E[19] */
	"\"Brain\"", /* DS:3F7E[1A] */
	"Geoff", /* DS:3F7E[1B] */
	"Marcus", /* DS:3F7E[1C] */
	"Stella", /* DS:3F7E[1D] */
	"J.P.", /* DS:3F7E[1E] */
	"Michell", /* DS:3F7E[1F] */
	"Carl", /* DS:3F7E[20] */
	"", /* DS:3F7E[21] */
	"Jason", /* DS:3F7E[22] */
	"\"Grease\"", /* DS:3F7E[23] */
	"Jen", /* DS:3F7E[24] */
	"", /* DS:3F7E[25] */
	"", /* DS:3F7E[26] */
	"", /* DS:3F7E[27] */
	"", /* DS:3F7E[28] */
	"", /* DS:3F7E[29] */
	"", /* DS:3F7E[2A] */
	"", /* DS:3F7E[2B] */
	"", /* DS:3F7E[2C] */
	"", /* DS:3F7E[2D] */
	"", /* DS:3F7E[2E] */
	"", /* DS:3F7E[2F] */
	"", /* DS:3F7E[30] */
	"", /* DS:3F7E[31] */
	"", /* DS:3F7E[32] */
	"", /* DS:3F7E[33] */
	"", /* DS:3F7E[34] */
	"", /* DS:3F7E[35] */
	"", /* DS:3F7E[36] */
	"", /* DS:3F7E[37] */
	"", /* DS:3F7E[38] */
	"", /* DS:3F7E[39] */
	"" /* DS:3F7E[3A] */
};

const char * const PilotExperienceLabelTextTable[0x04] =
{
	"Green", /* DS:40B3[00] */
	"Regular", /* DS:40B3[01] */
	"Veteran", /* DS:40B3[02] */
	"Elite" /* DS:40B3[03] */
};

const char * const PilotGunneryLabelTextTable[0x04] =
{
	"Excellent", /* DS:40C3[00] */
	"Good", /* DS:40C3[01] */
	"Fair", /* DS:40C3[02] */
	"Light" /* DS:40C3[03] */
};

const char * const UnitMovementClassLabelTextTable[0x05] =
{
	"None", /* DS:412D[00] */
	"Slow", /* DS:412D[01] */
	"Average", /* DS:412D[02] */
	"Fast", /* DS:412D[03] */
	"Very Fast" /* DS:412D[04] */
};

const char * const UnitArmorConditionLabelTextTable[0x06] =
{
	"Light", /* DS:4141[00] */
	"Medium", /* DS:4141[01] */
	"Heavy", /* DS:4141[02] */
	"Massive", /* DS:4141[03] */
	"Stripped", /* DS:4141[04] */
	"Battered" /* DS:4141[05] */
};

const char UnitStatusEquipmentSeparator[] = "BAP "; /* DS:45F8 */
