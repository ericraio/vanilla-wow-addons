StatRings - Proof of concept ring indicators
---------------------------------------------------------------------------
v0.3 - 2005-10-19 (Antiarc)
  * Gave a bunch of functionality to the template frames, so you can just set max value/current value and it flows between them nicely.
  * Added target health and combo point rings
  * Prettied it up a bit
  
v0.2 - 2005-10-17
  * Split template code into its own files
  * Much commenting in template LUA file
  * Added SetRingTextures method
  * Scaled rings a bit more appropriately for normal setups.
  * Linked to WorldFrame instead of UIParent
  * Updated ring colors to match player frame colors

v0.1 - 2005-10-16
  * First release

APPROACH DOCUMENT
---------------------------------------------------------------------------
So I sat down to figure out how to draw a partial ring within WoW, and
ended up a with a much nicer solution than the angled mask
approach. I'll be releasing some example code with it in once I finish
it off and clean it up, but I figured I'd explain what I came up with.

This approach requires two texture files, and six texture objects.

File 1: A ring quadrant
File 2: A 45 degree sliced square.

It's easiest to explain this with just a single quadrant, so let's
consider the top right quadrant of the ring, and an angle A, where 0
is no visible ring, and it increases from the top down to the right
(Like a clock).

The top left hand corner of this quadrant (the 'noon' position), we'll
call N (Nx,Ny)

The line from the center of the ring at angle A hits the inner edge of
the ring at point I (Ix,Iy), and the outer edge of the ring at point O
(Ox, Oy).

For a ring of inner and outer radius IR, and OR, those points are:

  Nx = 0, Ny = OR
  Ix = IR * sin(A), Iy = IR * cos(A)
  Ox = OR * sin(A), Oy = OR * cos(A)

ANGLES FROM 0-45 DEGREES
First draw the rectangular subset of the ring from the top left
corner, down to point I, the intersection with the inner edge of the
ring. This is your desired ring segment with a triangularish section
chopped off the end to the right.

Next draw the rectangular 'chip' from the top right corner of the
piece you just drew, down to point O, the outer edge of the ring. This
fills in the curved outer edge that was missing.

This leaves a missing triangular section that represents where the
angle slices across the ring. Stretch the 45 degree slice texture
across that between points I and O.

So, to summarize:
  * Draw ring subset N=(Nx, Ny) to I=(Ix, Iy)
  * Draw ring subset (Ix, Ny) to O=(Ox, Oy)
  * Stretch slice between I=(Ix, Iy) and O=(Ox, Oy)

ANGLES FROM 45-90 DEGREES

(This is different simply to keep the first rendered piece as
significant as possible.)

First draw the rectangular subset of the ring from the top left
corner, down to point O, the intersection with the outer edge of the
ring. This is your desired ring segment with a triangularish section
chopped off the end to the bottom.

Next draw the rectangular 'chip' from the bottom left corner of the
piece you just drew, over to point I, the inner edge of the ring. This
fills in the curved inner edge that was missing.

This leaves a missing triangular section that represents where the
angle slices across the ring. Stretch the 45 degree slice texture
across that between points I and O.

So, to summarize:
  * Draw ring subset N=(Nx, Ny) to O=(Ox, Oy)
  * Draw ring subset (Nx, Oy) to I=(Ix, Iy)
  * Stretch slice between I=(Ix, Iy) and O=(Ox, Oy)


COMPLETING THE CIRCLE
---------------------

This can be applied to the other quadrants by mirroring and/or
swapping the X and Y coordinates, and textures.  For a full circle
subset you need 6 texture objects, the three discussed here for the
active quadrant, and then three more (all set to the ring texture) for
the three other 'full' quadrants for a full ring.

An arbitrary ring subset (rather than starting at the noon position)
would require an adittional two or three textures (one more chip, one
more slice, and possibly one more ring subset, if the ring angle is
able to be larger than 270 degrees)
