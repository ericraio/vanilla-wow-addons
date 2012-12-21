
lazyr.about = {}

function lazyr.about.OnShow()
   local text = "About LazyRogue v"..lazyr.version.."."
   LazyRogueAboutFrameTitle:SetText(text)

   text = [[
              >>>> This is LazyRogue by Ithilyn <<<<

               >>> Dev team: Ithilyn, FreeSpeech <<<

Please see http://ithilyn.com and http://ui.worldofwar.net/ui.php?id=1574 for documentation, discussion, and new releases.  Or just google for LazyRogue.

To use LazyRogue, create a macro with:

/lazyrogue

and put it on your action bar.  Repeatedly hit the macro in battle.


Please welcome FreeSpeech to the LazyRogue dev team as of 3.1!

Here's a huge thanks to the following people on ui.worldofwar.net for their suggestions and/or bug reports:

Sketchy, Tannon, Feylon, Golonator, FreeSpeech, Flarin, Malthas, Tragath, cennis, LoSE, ekimmike, Goldan, Nexela, Shadayim, DohMan, Kalpoth, mfrnka, seigert, ubernoob, Xylan, jrollette, Kalondo, KarynAngel, pmize, Polysporin, ZZZyZZyyZ, devoulin, Kamoshi, Pankrat, ravagernl, Skypainter, Speedo, Tsnark, vleaflet, Dean, Eid, Mainline.

And also thanks to the following folks for their comments and support:

Jough, Lonewolf, devilsbones, Eres, Lichbane, avngr, Madeena, Sirthomo, Xioustic, Areden, Badah, Bruderklaus, Korrigan, Ninox, peeweesweden, Smaddy, Ulyssis, Warrook, Alp, daddymk, El faldo, Grimflower, Houma, HuntingYouDown, lokyst, Mafiaso, Mima, nimmsis, psm, Shanley, sinibyte, Bendyr, blaxdal, cwsonline, dayara, deskmonkey, Doogal, DwFMagik, Emort, Gweeny, HansSolo, Hexore, JohnnieV, jointrob, LaoTseu, Mania, MightyMaximus, mujii, nelar, nytekat, OmniBlade, Oraivec, ploof, pluisman, Puppen, rakxzo, routerboy, samadhi, serefine, sinspinr, spdkils, Stabalot, strivken, Swick, Synastar, Thortok2000, Viscount, zeallanon.

If I missed you, drop me a note at ithilyn@ithilyn.com.
]]
   LazyRogueAboutFrameForm:SetText(text)
end

function lazyr.about.OnHide()
end
