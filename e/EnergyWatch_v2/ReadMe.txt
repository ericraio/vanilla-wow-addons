Displays energy ticks and combo points on a progress bar

EnergyWatch v2 : Usage - /ew option
options:
on : Enables EnergyWatch
off : Disables EnergyWatch
unlock : Allows you to move EnergyWatch
lock : Locks EnergyWatch
sound _ : Sets Sound on/off or custom
invert : Invert progress bar direction
scale _ : Scales EnergyWatch (0.25 - 3.0)
help _ : Prints help for certain options (below)
text _ : Sets the text on EnergyWatch
show _ : Set when EnergyWatch should be shown

EnergyWatch : Usage - /ew text string
the string may contain a few special replacements:
&e : Current Energy
&em : Maximum Energy
&c : Combox Points

EnergyWatch_v2 : Usage - /ew show option
option:
always : Always shown
combat : Shown in Combat
stealth : Shown in Combat and while Stealthed
stealthonly: Show only while stealthed
---

Author
------------------------
Repent -- Shadoh of Laughing Skull

Original Author
------------------------
Vector- - Kerryn of Laughing Skull

Changes 
1.0
--------------------------------------------------
Watching UNIT_ENERGY event. This will fix the problem with 
energy not correctly getting set on load. 
Removed the Event for UNIT_MANA. This is not need since we
are using UNIT_ENERGY.
You can now have your combo points shown on the energy bar. 
I find this extremely useful. When doing the text replacement 
use &c. For example, to show a text of Energy with combo points 
and Current Energy you could do.
/ew text Energy (&c) &e. At 100 energy and 2 combo points this would be 
Energy (2) 100

1.1
-------------------------------------------------
Changed the file to a zip file.

1.2
-------------------------------------------------
EnergyWatch will now work in druid stealth form.
If you reload your UI the energy bar will now be shown if it was before.

1.3
-------------------------------------------------
There is a new option, stealth only.  Type /ew show stealthonly.

1.4
------------------------------------------------
Updated for patch 1.9