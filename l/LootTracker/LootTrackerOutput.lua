--===========================================================================--
----------------------------  LootTracker by PNB  ----------------------------
--===========================================================================--
-- LootTrackerOutput.lua
--
-- Debug methods
--===========================================================================--

------------------------------------------------------------------------------
-- Globals
-- These values are global, but not saved when the session ends.
------------------------------------------------------------------------------

LT_CurrentIndentString  = "";
LT_Indent               = "   ";

LT_WriteBuffer = "";
LT_BufferCurrentIndent = "";


------------------------------------------------------------------------------
-- Message
-- Writes a system message to the chat frame
------------------------------------------------------------------------------
function LT_Message(msg)

    -- Make sure the chat frame we're adding messages to exists
    if (DEFAULT_CHAT_FRAME) then
        -- Get the information for system messages
        local info = ChatTypeInfo["SYSTEM"];
        
        local settings = LT_GetSettings();

        local chatColor = {r=info.r,g=info.g,b=info.b};
        if (settings.ChatColor ~= nil) then
            chatColor = settings.ChatColor;
        end

        -- Add the message as a system message
        DEFAULT_CHAT_FRAME:AddMessage(LT_CurrentIndentString .. msg, chatColor.r, chatColor.g, chatColor.b, info.id);
    end

end


------------------------------------------------------------------------------
-- MessageIndent
-- Indent all following Message() calls.
------------------------------------------------------------------------------

function LT_MessageIndent()

    LT_CurrentIndentString = LT_CurrentIndentString .. LT_Indent;

end


------------------------------------------------------------------------------
-- MessageUnindent
-- Unindent all following Message() calls.
------------------------------------------------------------------------------

function LT_MessageUnindent()

    local indentSize = strlen(LT_Indent);
    local currentIndentSize = strlen(LT_CurrentIndentString);

    LT_CurrentIndentString = strsub(LT_CurrentIndentString, 1, currentIndentSize - indentSize);

end


------------------------------------------------------------------------------
-- StdOut
------------------------------------------------------------------------------

LT_StdOut = {
    Write=LT_Message, 
    Indent=LT_MessageIndent, 
    Unindent=LT_MessageUnindent
};


------------------------------------------------------------------------------
-- BufferWrite
------------------------------------------------------------------------------

function LT_BufferWrite(text)

    LT_WriteBuffer = LT_WriteBuffer .. LT_BufferCurrentIndent .. text .. "\n";

end


------------------------------------------------------------------------------
-- BufferIndent
------------------------------------------------------------------------------

function LT_BufferIndent()

    LT_BufferCurrentIndent = LT_BufferCurrentIndent .. LT_Indent;

end


------------------------------------------------------------------------------
-- BufferUnindent
------------------------------------------------------------------------------

function LT_BufferUnindent()

    local indentSize = strlen(LT_Indent);
    local currentIndentSize = strlen(LT_BufferCurrentIndent);

    LT_BufferCurrentIndent = strsub(LT_BufferCurrentIndent, 1, currentIndentSize - indentSize);

end


------------------------------------------------------------------------------
-- BufferOut
------------------------------------------------------------------------------

LT_BufferOut = {
    Write=LT_BufferWrite, 
    Indent=LT_BufferIndent, 
    Unindent=LT_BufferUnindent
};


------------------------------------------------------------------------------
-- FormatMessageTable
-- Formats and outputs a table object.
------------------------------------------------------------------------------

function LT_FormatMessageTable(t, prefix, output)

    if (output == nil) then
        LT_DebugMessage(2, "Redirecting to standard output in LT_FormatMessageTable");
        output = LT_StdOut;
    end

    if (prefix == nil) then
        output.Write("{");
    else
        output.Write(prefix);
    end
    
    output.Indent();
    
    foreach(t, function(k,v)
        LT_FormatMessageKeyValue(k, v, output);
    end);
    
    output.Unindent();
    
    if (prefix == nil) then
        output.Write("}");
    end
    
end


------------------------------------------------------------------------------
-- FormatMessageKeyValue
-- Formats and outputs a key,value pair.
------------------------------------------------------------------------------

function LT_FormatMessageKeyValue(key, value, output)

    if (output == nil) then
        LT_DebugMessage(2, "Redirecting to standard output in LT_FormatMessageKeyValue");
        output = LT_StdOut;
    end

    local prefix = key .. ": ";
    
    if (type(value) == "table") then
        LT_FormatMessageTable(value, prefix, output);
    else
        output.Write(prefix .. tostring(value));
    end

end


------------------------------------------------------------------------------
-- FormatMessage
-- Formats and outputs an object depending on its type.
------------------------------------------------------------------------------

function LT_FormatMessage(value, output)

    if (output == nil) then
        LT_DebugMessage(2, "Redirecting to standard output in LT_FormatMessage");
        output = LT_StdOut;
    end

    if (type(value) == "table") then
        LT_FormatMessageTable(value, nil, output);
    else
        output.Write(tostring(value));
    end

end


------------------------------------------------------------------------------
-- DebugMessage
-- Displays a message only if debug mode is enabled
------------------------------------------------------------------------------

function LT_DebugMessage(level, message)

    local settings = LT_GetSettings();
    local levelThreshold = settings.DebugLevel;
    if (levelThreshold == nil) then
        levelThreshold = 1;
    end

    if (levelThreshold >= level) then
        LT_Message(message);
    end
    
end

