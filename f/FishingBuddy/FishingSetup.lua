-- FishingSetup
--
-- Load out translation strings and such

FishingBuddy = {};

FishingBuddy.VERSION = "0.8.6h";
FishingBuddy.CURRENTVERSION = 8600;

FishingBuddy.Colors = {};
FishingBuddy.Colors.RED   = "ffff0000";
FishingBuddy.Colors.GREEN = "ff00ff00";
FishingBuddy.Colors.BLUE  = "ff0000ff";
FishingBuddy.Colors.WHITE = "ffffffff";

-- debugging

FishingBuddy.printable = function(foo)
   if ( foo ) then
      if ( type(foo) == "table" ) then
	 return "table";
      elseif ( type(foo) == "boolean" ) then
	 if ( foo ) then
	    return "true";
	 else
	    return "false";
	 end
      else
	 return foo;
      end
   else
      return "nil";
   end
end

FishingBuddy.Output = function(msg, r, g, b)
   if ( DEFAULT_CHAT_FRAME ) then
      if ( not r ) then
	 DEFAULT_CHAT_FRAME:AddMessage(msg);
      else
	 DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
      end
   end
end

local FishingBuddy_Debugging = 1;
FishingBuddy.Debug = function(msg, fixlinks)
   if ( FishingBuddy_Debugging == 1 ) then
      if ( fixlinks ) then
	 msg = string.gsub(msg, "|", ";");
      end
      local name = FishingBuddy.Name or "Fishing Buddy";
      FishingBuddy.Output("|c"..FishingBuddy.Colors.RED..name.." DEBUG|r "..msg);
   end
end

FishingBuddy.Dump = function(thing)
   if ( FishingBuddy_Debugging == 1 ) then
      if ( DevTools_Dump ) then
	 DevTools_Dump(thing);
      else
	 FishingBuddy.Debug("Tried to dump a '"..FishingBuddy.printable(thing).."'.");
      end
   end
end

local function LoadTranslation(lang)
   local translation = FishingTranslations[lang];
   for tag,value in translation do
      if ( not FishingBuddy[tag] ) then
	 FishingBuddy[tag] = value;
      end
   end
end

local function FixupThis(tag, what)
   if ( type(what) == "table" ) then
      for idx,str in what do
	 what[idx] = FixupThis(tag, str);
      end
      return what;
   elseif ( type(what) == "string" ) then
      local pattern = "#([A-Z0-9]+)#";
      local s,e,w = string.find(what, pattern);
      while ( w ) do
	 local s1 = strsub(what, 1, s-1);
	 local s2 = strsub(what, e+1);
	 what = s1..FishingBuddy[w]..s2;
	 s,e,w = string.find(what, pattern);
      end
      return what;
   else
      FishingBuddy.Debug("tag "..tag.." type "..type(what));
      FishingBuddy.Dump(what);
   end
end

local function FixupStrings()
   local translation = FishingTranslations["enUS"];
   for tag,str in translation do      
      FishingBuddy[tag] = FixupThis(tag, str);
   end
end

local function FixupBindings(lang)
   local translation = FishingTranslations[lang];
   for tag,str in translation do      
      if ( string.find(tag, "^BINDING") ) then
	 setglobal(tag, FishingBuddy[tag]);
	 FishingBuddy[tag] = nil;
      end
   end
end

local locale = GetLocale();
LoadTranslation(locale);
if ( locale ~= "enUS" ) then
   LoadTranslation("enUS");
end
FixupStrings();
FixupBindings(locale);

-- dump the memory we've allocated for all the translations
FishingTranslations = nil;

FishingBuddy.BYWEEKS_TABLE =  {["Jan"] = 0, ["Apr"] = 13, ["Jul"] = 26, ["Oct"] = 39, ["Dec"] = 52};

FishingBuddy.KEYS_NONE = 0;
FishingBuddy.KEYS_SHIFT = 1;
FishingBuddy.KEYS_CTRL = 2;
FishingBuddy.KEYS_ALT = 3;
FishingBuddy.Keys = {};
FishingBuddy.Keys[FishingBuddy.KEYS_NONE] = FishingBuddy.KEYS_NONE_TEXT;
FishingBuddy.Keys[FishingBuddy.KEYS_SHIFT] = FishingBuddy.KEYS_SHIFT_TEXT;
FishingBuddy.Keys[FishingBuddy.KEYS_CTRL] = FishingBuddy.KEYS_CTRL_TEXT;
FishingBuddy.Keys[FishingBuddy.KEYS_ALT] = FishingBuddy.KEYS_ALT_TEXT;
