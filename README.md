Tg BASH
-
This is a testing repo of [Telegram-Bot-Bash](https://github.com/topkecleon/telegram-bot-bash)

Using dependences [Json](https://github.com/dominictarr/JSON.sh) and [Tmux](http://github.com/tmux/tmux)

## Instructions
### Create your first bot

1. Message @botfather https://telegram.me/botfather with the following
text: `/newbot`
   If you don't know how to message by username, click the search
field on your Telegram app and type `@botfather`, you should be able
to initiate a conversation. Be careful not to send it to the wrong
contact, because some users has similar usernames to `botfather`.

   ![botfather initial conversation](http://i.imgur.com/aI26ixR.png)

2. @botfather replies with `Alright, a new bot. How are we going to
call it? Please choose a name for your bot.`

3. Type whatever name you want for your bot.

4. @botfather replies with `Good. Now let's choose a username for your
bot. It must end in `bot`. Like this, for example: TetrisBot or
tetris_bot.`

5. Type whatever username you want for your bot, minimum 5 characters,
and must end with `bot`. For example: `telesample_bot`

6. @botfather replies with:

    Done! Congratulations on your new bot. You will find it at
telegram.me/telesample_bot. You can now add a description, about
section and profile picture for your bot, see /help for a list of
commands.

    Use this token to access the HTTP API:
    <b>123456789:AAG90e14-0f8-40183D-18491dDE</b>

    For a description of the Bot API, see this page:
https://core.telegram.org/bots/api

7. Note down the 'token' mentioned above.

8. Type `/setprivacy` to @botfather.

   ![botfather later conversation](http://i.imgur.com/tWDVvh4.png)

9. @botfather replies with `Choose a bot to change group messages settings.`

10. Type `@BotName_bot` (change to the username you set at step 5
above, but start it with `@`)

11. @botfather replies with

    'Enable' - your bot will only receive messages that either start
with the '/' symbol or mention the bot by username.
    'Disable' - your bot will receive all messages that people send to groups.
    Current status is: ENABLED

12. Type `Disable` to let your bot receive all messages sent to a
group. This step is up to you actually.

13. @botfather replies with `Success! The new status is: DISABLED. /help`

### Install TgBash
Clone the repository:
```
git clone https://github.com/iicc1/TgBash.git
```

Run ./bot.sh start and paste the token then.

### Available commands
``` bash
# Users
  /start Start bot and get this message.
  /info Get shorter info message about this bot.
  /getinfo <by reply> Get info user by reply.
  /question Start interactive chat.
  /cancel Cancel any currently running interactive chats.
  /echo <text> The bot will send a echo message (markdown compatible).
  /myinfo The bot will send your info user.
  /getmembers The bot will you send the count of members in the chat.
  /calc <expr> The bot will calculate the expression.
  /kickme You will be autokicked from the chat.
  
# Admins
  /leavechat The bot will leave the group with this command.
  /broadcast <text> The bot will send a broadcast (markdown compatible).
  /kick <by reply> The bot will kick the user by reply (the user can back again).
  /ban <by reply> The bot will ban the user by reply (the user cant back again).
  /unban <by reply> The bot will unban the user by reply if is banned.
  /infobot The bot will reply the information of the bot.
  /gban <by reply> The user replied will be gbanned.
  /ungban <by reply> The user replied will be ungbanned.
  /ip Get the IP of your server.
```

### Receive data
You can read incoming data using the following variables:

* ```$MESSAGE```: Incoming messages.
 * ```$MESSAGE[ID]```: Get message ID from the message
* ```$CAPTION```: Captions.
*  ```$BOT```: This array contains the name, username and user of the bot.
 * ```${BOT[NAME]}```: Bot name
 * ```${BOT[USER]}```: Bot user
 * ```${BOT[ID]}```: Bot ID
*  ```$CHAT```: This array contains the chat ID and chat title.
 * ```${CHAT[ID]}```: Chat ID
 * ```${CHAT[TITLE]}```: Chat title
 * ```${CHAT[TYPE]}```: Chat type
* ```$USER```: This array contains the first name, lastname, username and user id of the current user.
 * ```${USER[ID]}```: User id
 * ```${USER[FIRST_NAME]}```: User's first name
 * ```${USER[LAST_NAME]}```: User's last name
 * ```${USER[USERNAME]}```: Username
*  ```$REPLY```: This array contains information about reply.
 * ```$reply```: Indicate if the message send by the bot will be reply or not
 * ```${REPLY[ID]}```: Get ID by reply
 * ```${REPLY[FIRST_NAME]}```: Get first name by reply
 * ```${REPLY[LAST_NAME]}```: Get last name by reply
 * ```${REPLY[USERNAME]}```: Get username by reply
*  ```$MEMBERS```: This array contains information about the members.
 *  ```${MEMBERS[COUNT]}```: Get the number of members in the chat
* ```$iUSER```: This array contains the information of the user in inline queries.
 * ```${iUSER[FIRST_NAME]}```: Get first name
 * ```${iUSER[LAST_NAME]}```: Get last name
 * ```${iUSER[USERNAME]}```: Get username
* ```$iQUERY```: This array contains information of inline queries.
 * ```${iQUERY[ID]}```: Contains ID
 * ```${iQUERY[MSG]}```: Contains msg
* ```$NEW_MEMBER```: This array contains the information of new members joined/added.
 * ```${NEW_MEMBER[ID]}```: Get ID
 * ```${NEW_MEMBER[FIRST_NAME]}```: Get first name
 * ```${NEW_MEMBER[LAST_NAME]}```: Get last name
 * ```${NEW_MEMBER[USERNAME]}```: Get username
* ```$OUT_MEMBER```: This array contains the information of members kicked/autokicked
 * ```${OUT_MEMBER[ID]}```: Get ID
 * ```${OUT_MEMBER[FIRST_NAME]}```: Get first name
 * ```${OUT_MEMBER[LAST_NAME]}```: Get last name
 * ```${OUT_MEMBER[USERNAME]}```: Get username
* ```$URLS```: This array contains documents, audio files, stickers, voice recordings and stickers stored in the form of URLs.
 * ```${URLS[AUDIO]}```: Audio files
 * ```${URLS[VIDEO]}```: Videos
 * ```${URLS[PHOTO]}```: Photos (maximum quality)
 * ```${URLS[VOICE]}```: Voice recordings
 * ```${URLS[STICKER]}```: Stickers
 * ```${URLS[DOCUMENT]}```: Any other file
* ```$CONTACT```: This array contains info about contacts sent in a chat.
 * ```${CONTACT[NUMBER]}```: Phone number
 * ```${CONTACT[FIRST_NAME]}```: First name
 * ```${CONTACT[LAST_NAME]}```: Last name
 * ```${CONTACT[ID]}```: User id
* ```$LOCATION```: This array contains info about locations sent in a chat.
 * ```${LOCATION[LONGITUDE]}```: Longitude
 * ```${LOCATION[LATITUDE]}```: Latitude

### Usage
To send messages use the ```send_message``` function:
```
send_message "${CHAT[ID]}" "lol"
```
To send markdown put the following strings before the text, depending on the parsing mode you want to enable:
```
send_markdown_message "${CHAT[ID]}" "*This is a text in bold in markdown*"
```
```
send_markdown_message "${CHAT[ID]}" "_This is a text in italic in markdown_"
```
- More information about markdown messages [here](https://core.telegram.org/bots/api#markdown-style)

HTML Format:
```
send_html_message "${CHAT[ID]}" "<b>This is a text in bold in html</b>"
```
```
send_html_message "${CHAT[ID]}" "<i>This is a text in italic in html</i>"
```
- More information about html messages [here](https://core.telegram.org/bots/api#html-style)

Also, you can indicate if the message It's a reply
``` bash
# It's a example, you can use reply with send message or markdown and html
send_markdown_message "${CHAT[ID]}" "*Replying*" "$reply"
```

Sending message without notifications or sounds:
``` bash
# Compatible with markdown
send_silently_message "${CHAT[ID]}" "You can't receive this message with notification..."
```

This function also allows a third parameter that disables additional function parsing (for safety use this when reprinting user input):
```
send_message "${CHAT[ID]}" "text" "safe"
```
To send images, videos, voice files, photos ecc use the ```send_photo``` function (remember to change the safety Regex @ line 14 of command.sh to allow sending files only from certain directories):
```
send_file "${CHAT[ID]}" "./doge.jpg" "Lool"
```
To send custom keyboards use the ```send_keyboard``` function:
```
send_keyboard "${CHAT[ID]}" "Text that will appear in chat?" "Yes" "No"
```
To send locations use the ```send_location``` function:
```
send_location "${CHAT[ID]}" "Latitude" "Longitude"
```
To send venues use the ```send_venue``` function:
```
send_venue "${CHAT[ID]}" "Latitude" "Longitude" "Title" "Address" "optional foursquare id"
```
To forward messages use the ```forward``` function:
```
forward "${CHAT[ID]}" "from_chat_id" "message_id"
```
To send a chat action use the ```send_action``` function.
Allowed values: typing for text messages, upload_photo for photos, record_video or upload_video for videos, record_audio or upload_audio for audio files, upload_document for general files, find_location for locations.
```
send_action "${CHAT[ID]}" "action"
```

To create interactive chats, write (or edit the question script) a normal bash (or C or python) script, chmod +x it and then change the argument of the startproc function to match the command you usually use to start the script.
The text that the script will output will be sent in real time to the user, and all user input will be sent to the script (as long as it's running or until the user kills it with /cancel).
To open up a keyboard in an interactive script, print out the keyboard layout in the following way:
```
echo "Text that will appear in chat? mykeyboardstartshere \"Yes, sure\" \"No, highly unlikely\""
```
Same goes for files:
```
echo "Text that will appear in chat? myfilelocationstartshere /home/user/doge.jpg"
```
And locations:
```
echo "Text that will appear in chat. mylatstartshere 45 mylongstartshere 45"
```
And venues:
```
echo "Text that will appear in chat. mylatstartshere 45 mylongstartshere 45 mytitlestartshere my home myaddressstartshere Diagon Alley N. 37"
```
You can combine them:
```
echo "Text that will appear in chat? mykeyboardstartshere \"Yep, sure\" \"No, highly unlikely\" myfilelocationstartshere /home/user/doge.jpg mylatstartshere 45 mylongstartshere 45"
```
Please note that you can either send a location or a venue, not both. To send a venue add the mytitlestartshere and the myaddressstartshere keywords.

The following commands allows users to interact with your bot via *inline queries*.
In order to enable **inline mode**, send `/setinline` command to [@BotFather](https://telegram.me/botfather) and provide the placeholder text that the user will see in the input field after typing your bot’s name.
Also, edit line 12 from `commands.sh` putting a "1".
Note that you can't modify the first two parameters of the function `answer_inline_query`, only the ones after them.

To send messsages or links through an *inline query*:
```
answer_inline_query "$iQUERY[ID]" "article" "Title of the result" "Content of the message to be sent"
```
To send photos in jpeg format and less than 5MB, from a website through an *inline query*:
```
answer_inline_query "$iQUERY[ID]" "photo" "A valid URL of the photo" "URL of the thumbnail"
```
To send standard gifs from a website (less than 1MB) through an *inline query*:
```
answer_inline_query "$iQUERY[ID]" "gif" "gif url"
```
To send mpeg4 gifs from a website (less than 1MB) through an *inline query*:
```
answer_inline_query "$iQUERY[ID]" "mpeg4_gif" "mpeg4 gif url"
```
To send videos from a website through an *inline query*:
```
answer_inline_query "$iQUERY[ID]" "video" "valid video url" "Select one mime type: text/html or video/mp4" "URL of the thumbnail" "Title for the result"
```
To send photos stored in Telegram servers through an *inline query*:
```
answer_inline_query "$iQUERY[ID]" "cached_photo" "identifier for the photo"
```
To send gifs stored in Telegram servers through an *inline query*:
```
answer_inline_query "$iQUERY[ID]" "cached_gif" "identifier for the gif"
```
To send mpeg4 gifs stored in Telegram servers through an *inline query*:
```
answer_inline_query "$iQUERY[ID]" "cached_mpeg4_gif" "identifier for the gif"
```
To send stickers through an *inline query*:
```
answer_inline_query "$iQUERY[ID]" "cached_sticker" "identifier for the sticker"
```


##  Uses of bot.sh
``` bash
# Starting the bot without tmux
./bot.sh

# Starting the bot with tmux (always running)
./bot.sh tmux

# Attach tmux session
./bot.sh attach

# Kill tmux session
./bot.sh kill

# Send available arguments
./bot.sh args

# Change from pwrtelegram api to telegram api or vice versa.
./bot.sh api

# Get help
./bot.sh help

# Users count
./bot.sh count

# Sending broadcasts to all users
./bot.sh broadcast "Hey everybody! This is a *broadcast*."
```

