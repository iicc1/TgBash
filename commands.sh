#!/bin/bash
# Edit your commands in this file.

# This file is public domain in the USA and all free countries.
# Elsewhere, consider it to be WTFPLv2. (wtfpl.net/txt/copying)

if [ "$1" = "source" ];then
	# Place the token in the token file
	TOKEN=$(cat token)
	# Set INLINE to 1 in order to receive inline queries.
	# To enable this option in your bot, send the /setinline command to @BotFather.
	INLINE=0
	# Enabling root privileges to send files in any location
	FILE_REGEX='/'
else
	if ! tmux ls | grep -v send | grep -q $copname; then
		[ ! -z ${URLS[*]} ] && {
		curl -s ${URLS[*]} -o $NAME
			send_file "${CHAT[ID]}" "$NAME" "$CAPTION"
			rm "$NAME"
		}
		[ ! -z ${LOCATION[*]} ] && send_location "${CHAT[ID]}" "${LOCATION[LATITUDE]}" "${LOCATION[LONGITUDE]}"

		# Inline
		if [ $INLINE == 1 ]; then
			# inline query data
			iUSER[FIRST_NAME]=$(echo "$res" | sed 's/^.*\(first_name.*\)/\1/g' | cut -d '"' -f3 | tail -1)
			iUSER[LAST_NAME]=$(echo "$res" | sed 's/^.*\(last_name.*\)/\1/g' | cut -d '"' -f3)
			iUSER[USERNAME]=$(echo "$res" | sed 's/^.*\(username.*\)/\1/g' | cut -d '"' -f3 | tail -1)
			iQUERY_ID=$(echo "$res" | sed 's/^.*\(inline_query.*\)/\1/g' | cut -d '"' -f5 | tail -1)
			iQUERY_MSG=$(echo "$res" | sed 's/^.*\(inline_query.*\)/\1/g' | cut -d '"' -f5 | tail -6 | head -1)

			# Inline examples
			if [[ $iQUERY_MSG == photo ]]; then
				answer_inline_query "$iQUERY_ID" "photo" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg"
			fi

			if [[ $iQUERY_MSG == sticker ]]; then
				answer_inline_query "$iQUERY_ID" "cached_sticker" "BQADBAAD_QEAAiSFLwABWSYyiuj-g4AC"
			fi

			if [[ $iQUERY_MSG == gif ]]; then
				answer_inline_query "$iQUERY_ID" "cached_gif" "BQADBAADIwYAAmwsDAABlIia56QGP0YC"
			fi
			if [[ $iQUERY_MSG == github ]]; then
				answer_inline_query "$iQUERY_ID" "article" "GitHub" "https://github.com/iicc1/TgBash"
			fi
		fi
	fi
	
    	echo $MESSAGE | grep "^/echo"
        if [ $? == 0 ]; then
	 MESSAGE=$(echo $MESSAGE | cut -d " " -f2-)
		send_markdown_message "${CHAT[ID]}" "$MESSAGE"
	fi

	# User commands
	case $MESSAGE in
		'/start')
			send_action "${CHAT[ID]}" "typing"
			start_inline_keyboard "${CHAT[ID]}" "Hi everybody! 
This is a *bot* written in code *shell*
More functions made by @iicc1 and @Jarriz.

*Commands*
 *Users*:
  /start _Start bot and get this message_.
  /info _Get shorter info message about this bot_.
  /getinfo <by reply> _Get info user by reply_.
  /question _Start interactive chat_.
  /cancel _Cancel any currently running interactive chats_.
  /echo <text> _The bot will send a echo message (markdown compatible)_.
  /myinfo _The bot will send your info user_.
  /kickme _You will be autokicked from the chat_.
  
 *Admin*:
  /leavechat _The bot will leave the group with this command_.
  /broadcast <text> _The bot will send a broadcast (markdown compatible)_.
  /kick <by reply> _The bot will kick the user by reply (the user can back again)_.
  /ban <by reply> _The bot will ban the user by reply (the user cant back again)_.
  /unban <by reply> _The bot will unban the user by reply if is banned_.
  /infobot _The bot will reply the information of the bot_.
  
*Based* in [telegram-bot-bash](http://github.com/topkecleon/telegram-bot-bash)"
			;;
			
		'/question')
			startproc "./question"
			;;
		
		'/getinfo')
			send_markdown_message "${CHAT[ID]}" "*User* @${REPLY_USERNAME}
*ID* ${REPLY_ID}" "$reply"
			;;
			
		'/info')
			send_markdown_message "${CHAT[ID]}" "This is a bashbot of *Telegram* written entirely in *bash*.
More info [here](https://github.com/iicc1/TgBash)" "$reply"
			;;
     			
     		'/kickme')
     			kick_chat_member "${CHAT[ID]}" "${USER[ID]}"
     			unban_chat_member "${CHAT[ID]}" "${USER[ID]}"
     			;;
     			
     		'/myinfo')
			send_markdown_message "${CHAT[ID]}" "*ID* ${USER[ID]}
*User* @${USER[USERNAME]}
*Name* ${USER[FIRST_NAME]}
*Last name* ${USER[LAST_NAME]}"
			;;

		'/cancel')
			if tmux ls | grep -q $copname; then killproc && send_markdown_message "${CHAT[ID]}" "*Command canceled*.";else send_markdown_message "${CHAT[ID]}" "*No command is currently running*.";fi
			;;
			
		*)
			if tmux ls | grep -v send | grep -q $copname;then inproc; else send_message "${CHAT[ID]}" "" "safe";fi
			;;
	esac
	
	
	# Admin commands
	if [ $ADMIN == 1 ]; then
	
	  echo $MESSAGE | grep "^/broadcast"
        	if [ $? == 0 ]; then
	 		MESSAGE=$(echo $MESSAGE | cut -d " " -f2-)
			send_markdown_message "${CHAT[ID]}" "*Broadcast delivered*" "$reply"
  	 	shift
			for f in $(cat count);do send_markdown_message ${f//COUNT} "$MESSAGE"; $sleep;done
    		fi
    	
	case $MESSAGE in
	 	'/leavechat')
			send_markdown_message "${CHAT[ID]}" "*CHAT LEAVED*"
   			leave_chat "${CHAT[ID]}"
     			;;
     			
     		'/kick')
			kick_chat_member "${CHAT[ID]}" "${REPLY_ID}"
			unban_chat_member "${CHAT[ID]}" "${REPLY_ID}"
			;;
			
		'/ban')
			kick_chat_member "${CHAT[ID]}" "${REPLY_ID}"
			;;
			
		'/unban')
			unban_chat_member "${CHAT[ID]}" "${REPLY_ID}"
			;;
			
		'/infobot')
			send_markdown_message "${CHAT[ID]}" "*Name* @${BOT_NAME}
*Username* @${BOT_USERNAME}
*ID* @${BOT_ID}" "$reply"
			;;
	esac
    fi
fi
