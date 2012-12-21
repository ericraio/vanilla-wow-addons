Name: HunterPetSkills
Author: Jake Bolton (ninmonkey) ninmonkeys@gmail.com - Talro of Stormreaver

About:
	Search an in-game database to find where the pet
	skill and rank you need is located. Type << /petskills >> for a list of commands.

Installation:
	Copy the HunterPetSkills directory into your "World of Warcraft\Interface\AddOns\" directory. (mod path should be: "World of Warcraft\Interface\AddOns\HunterPetSkills")
	
	Note: If the folder "addons" does not exist, then you must create it. In explorer(My Computer), you can right click and choose new->folder.)

Commands:
	/hunterpetskills
	/petskills
	/petskills help
	/sk
		shows help

	/sk skill <skill_name> <skill_rank> [<zone>]
		Lists beasts that have <skill_name> with rank <skill_rank> Optionally
		can try to search a zone. (If no results are found in the zone, it
		falls back on a search without zone)

Features: 
	-In game database of where beasts are located, based on skill and rank
	-Filter search results based on a zone name
	
Coming soon:	
	-View pet families
	-View pet families that can only learn claw
	-View pet families that can only learn bite
	-View pet families that can learn all skills
		
Example:

To display all beasts that know the skill bite (rank 1) type:
/petskills skill bite 1

/sk bite 1
/sk claw 2
/sk dive 3

Changelog:	
	Version 0.2.0
		-updated TOC to version 1500 for blizzard patch
		-added skill sprint
		-added skill dive
		-"skill" is optional, meaning you can type "/sk bite 1" or "/sk skill bite 1"
		-added ingame help to show sprint/dive are availible skills
		-updated readme
		-help output shows "skill" is optional by using brackets: "[skill]", as well as in the readme

	Version 0.1.3
		-updated for new blizz patch (interface 4216)

	Version 0.1.2:
		-updated interface number for blizzard's patch
		-colored help
		-cleaned up and shortened skill output
		-skill output is colored

	Version 0.1.1
		-/sk command added ( same thing as /petskills )
		-updated claw, bite, cower data for more detailed information

	Version 0.1
		-First release
