Special Talent by Aquendyn

Improved Talent Frame.

You can see and interact with all three talent trees at once. Summary of your learned and planned talent points at the top. Plan your template.

Open Special Talent frame as you normally do for the default talent frame. That is, click the talent microbutton on your main bar or use a keybinding. (Open main menu, click keybinding. Look for Toggle Talent Pane, then assign a key.) If your character is under level 10, you may still open this frame with a keybinding, but the talent microbutton will not appear on the main bar until you reach level 10.

There are two modes when you click a talent, learning and planning. When you first open the Special Talent frame, you are in learning mode. You can switch between learning and planning by clicking on the checkbox by the labels Learned and Planned at the top of the frame. On each talent button, planned points for that talent are light blue in the bottom left of the button, and learned points are yellow or green in the bottom right.

In learning mode, clicking on a talent will attempt to learn that talent. Check "Force Shift-click to Learn" so that you must hold down Shift before you can learn a talent. This prevents accidentally learning a talent with just a click.
The total points in each talent tree are displayed to the right of the tree name and by the yellow Learned label near the top of the frame. You see something like 0/0/0, where each number corresponds to the left, center, and right talent tree. After the equal sign '=' says spent points out of total points for your level.

In planning mode, you do not actually learn the talents. Left-clicking on a talent will add a point to that talent, to that tree, and to your entire planned template. Right-clicking will subtract a point. You can also scroll mouse wheel up or down to plan or unplan a talent, respectively. Check "Force Shift-click to Learn" so that you can Shift-click to learn a talent in planning mode.
The total points in each talent tree are displayed to the left of the tree name and by the blue Planned label near the top of the frame. You see something like 0/0/0, where each number corresponds to the left, center, and right talent tree. After the equal sign '=' says spent points out of total points for level 60.

There are some rules in planning mode.
1. You can't add more than 51 points total to your planned template.
2. Darkened buttons cannot be clicked until you have put enough points into the lower tiers, if a prerequisite talent's rank is not full, or if you have used up 51 points.
3. You can't remove a talent if that means you won't have enough points to support the higher tiers. First, remove the talents from the higher tiers.
4. You can't remove a talent if a dependent talent is planned. First, unplan the dependent talents, then unplan the first talent.

Special Talent supports Talent Planner data to appear on tooltip. Either enable Talent Planner or extract its WebData.lua into SpecialTalentUI folder. If you don't use Blizzard's talent frame, second option will save you space and memory.

Minimize the frame by pressing the v button at the top right. Click on tabs at right side of frame to switch talent trees.
Maximize again by pressing the ^ button.

Drag the frame by dragging the portrait at the top-left.
Type /script SpecialTalentFrame_ResetDrag() to place the frame at the default location.

The zip file extracts files into two folders called SpecialTalent and SpecialTalentUI. The actual frame is loaded on demand. In the login screen, you must enable both addons or you will get the Blizzard's default talent frame. By default, both are enabled when you install this addon.


Version History

1.05
fixed missing SpecialTalentFrameSaved
always show talent microbutton

1.04
added support for Talent Planner data to appear on tooltip. either enable Talent Planner or extract its WebData.lua into SpecialTalentUI folder. if you don't use Blizzard's talent frame, second option is better.
allow option to minimize Special Talent Frame

1.03
fixed in planning mode correct isLearnable value when rank < maxRank (in SpecialTalent_GetTalentPrereqs )
reduce button alpha instead of desaturate
mouse wheel to plan or unplan talent
shift-click to learn in planning mode (must turn on Force Shift-click to Learn)
removed unnecessary files
notes in toc files are now more descriptive

1.02
shows learned and planned points allocated/max ( = 0/51)
option to learn only on shift-click
show planned points by tree name (0 :Frost: 0)
drag frame by dragging topleft portrait
SpecialTalentFrame_ResetDrag() to undo drag
planning mode enable/disable buttons like learning mode
planning mode checks for prereqs, dependents, tiers (tooltip may not show right info)

1.01
buttons made bigger
added planning mode
removed keybinding
saved variable for planned templates
added readme.txt

1.00
shows all three talent trees
