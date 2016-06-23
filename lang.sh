LANG='EN'
if [ $LANG == 'ES' ]; then
START='HOLA'
fi

if [ $LANG == 'EN' ]; then
declare -A LANG
START[LANG]='Hi everybody! 
This is a *bot* written in code *shell*
More functions made by @iicc1 and @Jarriz.

*Commands*
 *Users*:
  /start or /help _Start bot and get this message_.
  /info _Get shorter info message about this bot_.
  /getinfo <by reply> _Get info user by reply_.
  /calculator _Start a interactive calculator_.
  /cancel _Cancel any currently running interactive chats_.
  /echo <text> _The bot will send a echo message (markdown compatible)_.
  /myinfo _The bot will send your info user_.
  /getmembers _The bot will you send the count of members in the chat_.
  /calc <expr> _The bot will calculate the expression_.
  /kickme _You will be autokicked from the chat_.
  /ct <message> _Send a message to the bot admins_.
  
 *Admin*:
  /leavechat _The bot will leave the group with this command_.
  /broadcast <text> _The bot will send a broadcast (markdown compatible)_.
  /kick <by reply> _The bot will kick the user by reply (the user can back again)_.
  /ban <by reply> _The bot will ban the user by reply (the user cant back again)_.
  /unban <by reply> _The bot will unban the user by reply if is banned_.
  /infobot _The bot will reply the information of the bot_.
  /su <command> _Run a command in the console sending the reply_.
  /ip _The bot will send the IP Server_.
  /gban <by reply> _The user replied will be gbanned_.
  /ungban <by reply> _The user replied will be ungbanned_.
  
*Based* in [telegram-bot-bash](http://github.com/topkecleon/telegram-bot-bash)'
fi