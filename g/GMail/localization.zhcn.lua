--[[ $Id: localization.zhcn.lua 13144 2006-10-06 01:35:52Z hshh $ ]]--
if ( GetLocale() == "zhCN" ) then

GMAIL_HELP = "将你要发送的物品放入下面的格子,每样物品将自动通过分开的邮件发送出去.邮件标题将使用填写的主题加上物品描述.总的邮资显示在右上角.你也可以通过按住ALT键点击你的背包中的物品添加到邮件里.";

GMAIL_SEND = "发送批量邮件";
GMAIL_SENDBUTTON = "发送";
GMAIL_CANCELBUTTON = "取消";

GMAIL_SENDINFO = "你真的确定要发送这个批量邮件么? 总的邮资是:";
GMAIL_SENDINFO2 = "你将要发送:";
GMAIL_ITEMS = "个物品";
GMAIL_ABORT = "终止发送";

GMAIL_ITEMNUM = "这是批量发送邮件的第%d个物品, 共%d个.";
GMAIL_SENDING = "正在发送邮件 |c00FFFFFF%d|r/|c00FFFFFF%d|r...";
GMAIL_DONESENDING = "已发送 |c00FFFFFF%d|r 封邮件!";
GMAIL_ABORTED = "已终止. |c00FFFFFF%d|r/|c00FFFFFF%d|r 封邮件已发送.";
GMAIL_ERROR = "GMAIL 出错. 造成这个原因有可能是网络或服务器延迟, 或者你发送的物品是不能被邮件传递的, 请尝试使用正常途径发送邮件.";

GMAIL_INBOX_OPENSELECTED = "打开已选";
GMAIL_INBOX_OPENALL = "打开所有";
GMAIL_INBOX_OPENALLTITLE = "确定打开所有?";
GMAIL_INBOX_OPENALLCONFIRMATION = "你确定要打开所有邮件么?";
GMAIL_INBOX_DISPLAYPROCESSMESSAGES = "显示处理信息";

GMAIL_MASS_MAIL="批量邮件";
GMAIL_FORWARD="转发";

GMAIL_NOSUBJECT="<无标题>"
GMAIL_UNKNOWNSENDER="<未知发信者>"
GMAIL_OPEN_FORMAT1="GMail: 邮件 |c00FFFFFF%d|r/|c00FFFFFF%d|r 是付费邮件, 忽略."
GMAIL_OPEN_FORMAT2="GMail: 邮件 |c00FFFFFF%d|r/|c00FFFFFF%d|r 没有附带金钱或物品, 忽略."
GMAIL_OPEN_FORMAT3="GMail: 正在打开邮件 |c00FFFFFF%d|r/|c00FFFFFF%d|r: \"|c00FFFFFF%s|r\" 来自 |c00FFFFFF%s|r."
end