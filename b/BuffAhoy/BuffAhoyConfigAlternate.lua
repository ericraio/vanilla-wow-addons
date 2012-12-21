--Here is some information on Action bar slots, and which addons use which slots:

--ID#1-120 are the only ones that are available
--DEFAULT USE	 NO.	OTHER ADDONS						BUFFAHOY DEFAULT	BUFFAHOY Alternate
--default bar 1: 1-12 	--->Default UI bar
--default bar 2: 13-24 	--->CT Bar1 left-hotbar
--default bar 3: 25-36	--->CT Bar2 right-hotbar, blizz Side Bar
--default bar 4: 37-48	--->CT Bar3 left-sidebar, blizz Side Bar 2					Buff Seq 1-2
--default bar 5: 49-60	--->CT Bar4 right-sidebar, Popbar, blizz bottom right				MultiCast1-2
--default bar 6: 61-72	--->CT bar5 top-bar, Popbar, blizz bottom left					UTIL/SC/BC2,3
--Druid Cat Bar	 73-84	--->Telo's Bottombar (when not a druid?), druid Bear	MultiCast1-2
--		 85-96	--->Telo's BottomBar 					UTIL/SC/BC2,3
--Druid Bear Bar 97-108 --->Telo's Sidebar (when not druid?)
--		 109-120--->Telo's Sidebar, Cosmos Bottom Bar			Buff Seq 1-2





--Declarations
BCS1={}			--Declare Array, don't change this
BCS2={}			--Declare Array, don't change this
MCS1={}			--Declare Array, don't change this
MCS2={}			--Declare Array, don't change this

--Buff set 1 configuration
--This next variable is the action bar number of the first button in the first buffcast set.
--Change the number if you don't want BuffCast set 1 to use the range 37-42

BCS1[1]=37

--These all follow sequentially from the one defined above.  Don't change them unless you really
--know what you're doing.

BCS1[2]=BCS1[1]+1    	--party1
BCS1[3]=BCS1[2]+1	--party2
BCS1[4]=BCS1[3]+1	--party3
BCS1[5]=BCS1[4]+1	--party4
BCS1[6]=BCS1[5]+1	--pets

--This is the cooldown time (in seconds) before the cycle will reset (if you end mid-cycle, for example).
--You probably don't have to change this, but you can if you like.  Reccomended between 5 and 20 seconds.

BCS1["cooldown"]=60


--Buff set 2 configuration
--This next variable is the action bar number of the first button in the second buffcast set.
--Change the number if you don't want Buffcast set 2 to use the range 43-58

BCS2[1]=43  

--These all follow sequentially from the one defined above.  Don't change them unless you really
--know what you're doing.
BCS2[2]=BCS2[1]+1	--party1
BCS2[3]=BCS2[2]+1	--party2
BCS2[4]=BCS2[3]+1	--party3
BCS2[5]=BCS2[4]+1	--party4
BCS2[6]=BCS2[5]+1	--pets

BCS2["cooldown"]=60

--These next two variables are the action bar numbers of the 3rd and 4th Buff Sequences (each only 1 button long)
--You can change each independently
BCS3=71
BCS4=72
BCScooldown=20

--Utility Function Configuration
--These are the variables for the utility functions, Heal 1, Heal 2, Cleanse, and Protect
HZR1=65
HZR2=66
HZR3=67
CZR1=68
CZR2=69
PZR1=70


--MultiCast 1 Configuration
--This next variable is the action bar number of the first button in the first MultiCast set
--Change the number if you don't want MultiCast set 1 to use the range 53-57

MCS1[1]=49

--These all follow sequentially form the one defined above.  Don't change them unless you really
--know what you're doing

MCS1[2]=MCS1[1]+1
MCS1[3]=MCS1[2]+1
MCS1[4]=MCS1[3]+1
MCS1[5]=MCS1[4]+1
MCS1[6]=MCS1[5]+1

MCS1["cooldown"]=9

--MultiCast 2 Configuration
--This next variable is the action bar number of the first button in the second MultiCast set
--Change the number if you don't want MultiCast set 1 to use the range 58-62

MCS2[1]=55

--These all follow sequentially form the one defined above.  Don't change them unless you really
--know what you're doing

MCS2[2]=MCS2[1]+1
MCS2[3]=MCS2[2]+1
MCS2[4]=MCS2[3]+1
MCS2[5]=MCS2[4]+1
MCS2[6]=MCS2[5]+1

MCS2["cooldown"]=9

--These are the action bar numbers of the ShoutCastable spell slots
SCT1=61
SCT2=62
SCT3=63
SCT4=64


--These are the action bar numbers of the RaidCast spell slots.
--They are defaulted to the slots for BuffCast
RCPalSha=BCS1[1]
RCWarrior=BCS1[2]
RCMage=BCS1[3]
RCPriest=BCS1[4]
RCWarlock=BCS1[5]
RCRogue=BCS1[6]
RCHunter=BCS2[1]
RCDruid=BCS2[2]
RCPet1=BCS2[3]
RCcooldown=60;

--These are the action bar numbers of the RaidCast sequence 2 and 3 slots.  By default, they are the same numbers
--as BuffCast sequences 3 and 4.
RCS2=BCS3
RCS3=BCS4