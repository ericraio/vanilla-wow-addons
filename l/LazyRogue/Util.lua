-- Utilities

function lazyr.SplitArgs(line)
   local args = {}
   for arg in string.gfind(line, "[^%s]+") do
      table.insert(args, arg)
   end
   return args
end

-- Helper regex function.  Returns true/false if the pattern matched,
-- and sets the globals lazyr.match1, 2, 3, 4, 5, 6  per your parenthesis matching.
function lazyr.re(text, re)
   local starts, ends
   starts, ends, lazyr.match1, lazyr.match2, lazyr.match3, lazyr.match4, lazyr.match5, lazyr.match6 = string.find(text, re)
   return starts
end

function lazyr.chat(msg, r, g, b)
   if (not r) then
      r = .9
      g = .6
      b = .05
   end
   DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b)
end

function lazyr.p(msg)
   if (lazyr.mock) then
      return
   end
   lazyr.chat("## LazyRogue: "..msg)
   lazyr.trace(msg)
end

function lazyr.d(msg)
   if (lazyr.mock) then
      return
   end
   if (lazyr.perPlayerConf.debug) then
      lazyr.chat("### LazyRogue: "..msg, .8, .5, 0)
   end
   lazyr.trace(msg)
end

-- provide optional Tracer module support, for debugging problems
function lazyr.trace(msg)
   if (tracer) then
      tracer.Log("LazyRogue", msg)
   end
end

function lazyr.nonil(str)
   if (not str) then
      str = ""
   end
   return str
end

function lazyr.IdAndNameFromLink(link)
   local name
   if (not link) then
      return ""
   end
   for id, name in string.gfind(link, "|c%x+|Hitem:(%d+):%d+:%d+:%d+|h%[(.-)%]|h|r$") do
      return tonumber(id), name
   end
   return nil
end


