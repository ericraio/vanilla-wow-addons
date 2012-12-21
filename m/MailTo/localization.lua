-- English text strings

-- Binding Configuration
BINDING_HEADER_MAILTO   = "MailTo"
BINDING_NAME_MAILTOLOG  = "Display MailTo log"
BINDING_NAME_MAILTOEX   = "Display Inbox expirations"
BINDING_NAME_MAILTOMAIL = "Toggle MailTo Inbox window"

-- MailTo option list with text
MAILTO_OPTION = { alert=  {flag='noalert', name="Delivery alert"},
                  auction={flag='noauction', name="Auction click"},
                  chat=   {flag='nochat',  name="Chat click"},
                  coin=   {flag='nocoin',  name="Coin letters"},
                  ding=   {flag='noding',  name="Ding sound"},
                  click=  {flag='noclick', name="Inventory"},
                  login=  {flag='nologin', name="Login notice"},
                  shift=  {flag='noshift', name="Shift-click"},
                  trade=  {flag='notrade', name="Trade click"},
                }
MAILTO_DAYS = {icon=28, long=3, new=7, short=1, soon=3, warn=2}

-- Message text
MAILTO_ON =         "%s has been turned on."
MAILTO_OFF =        "%s has been turned off."
MAILTO_TIME =       "The time for '%s' expiration has been set to %s"
MAILTO_TOOLTIP =    "Click to select recipient."
MAILTO_CLEARED =    "The MailTo list has been cleared!"
MAILTO_LISTEMPTY =  "Empty list."
MAILTO_LISTFULL =   "Warning: List is full!"
MAILTO_ADDED =      " added to MailTo list."
MAILTO_REMOVED =    " removed from MailTo list."
MAILTO_F_ADD =      "(Add %s)"
MAILTO_F_REMOVE =   "(Remove %s)"
MAILTO_YOU =        "you"
MAILTO_DELIVERED =  "delivered."
MAILTO_DUE =        "due in %d min."
MAILTO_SENT =       "%s sent to %s by %s is %s"
MAILTO_NEW =        "%s%s from %s delivered to %s"
MAILTO_NONEW =      "No new mail items found."
MAILTO_NEWMAIL =    "(possible new mail)"
MAILTO_LOGEMPTY =   "The mail log is empty."
MAILTO_NODATA =     "No inbox data."
MAILTO_NOITEMS =    "No items in inbox."
MAILTO_NOTFOUND =   "No items found."
MAILTO_INBOX =      "#%d, %s, from %s"
MAILTO_EXPIRES =    " expires in "
MAILTO_EXPIRED =    " has expired!"
MAILTO_UNDEFINED =  "Undefined command, "
MAILTO_RECEIVED =   "Received %s from %s, %s"
MAILTO_SALE =       "%s bought %s for %s (net=%s)."
MAILTO_NONAME =     "Missing name."
MAILTO_NODESC =     "Missing description."
MAILTO_MAILOPEN =   "Mailbox is open."
MAILTO_MAILCHECK =  "Mailbox not checked."
MAILTO_TITLE =      "MailTo  Inbox"
MAILTO_SELECT =     "Select:"
MAILTO_SERVER =     "Server"
MAILTO_SERVERTIP =  "Check to select characters on other servers"
MAILTO_FROM =       "From: "
MAILTO_EXPIRES2 =   "Expires in "
MAILTO_EXPIRED2 =   "Has expired!"
MAILTO_LOCATE =     "Locating items matching '%s':"
MAILTO_REMOVE2 =    "Removed %s of %s."
MAILTO_BACKPACK =   "No empty backpack slot for split."
MAILTO_EMPTYNEW =   "You may have new mail..."
MAILTO_MAIL =       "Mail"
MAILTO_INV =        "Inv"
MAILTO_BANK =       "Bank"
MAILTO_SOLD =       "Auction successful"
MAILTO_OUTBID =     "Outbid"
MAILTO_CANCEL =     "Auction cancelled"
MAILTO_CASH =       "Received cash: Total=%s, Sales=%s, Refunds=%s, Other=%s"
