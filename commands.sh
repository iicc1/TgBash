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
	# Set to .* to allow sending files from all locations
	FILE_REGEX='/home/user/allowed/.*'
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
	
	echo $MESSAGE | grep "^/broadcast"
        if [ $? == 0 ]; then
	 MESSAGE=$(echo $MESSAGE | cut -d " " -f2-)
		send_markdown_message "${CHAT[ID]}" "*Broadcast delivered*."
  	 shift
		for f in $(cat count);do send_markdown_message ${f//COUNT} "$MESSAGE"; $sleep;done
    	fi
    	
    	echo $MESSAGE | grep "^/echo"
        if [ $? == 0 ]; then
	 MESSAGE=$(echo $MESSAGE | cut -d " " -f2-)
		send_markdown_message "${CHAT[ID]}" "$MESSAGE"
	fi


	case $MESSAGE in
		'/question')
			startproc "./question"
			;;
		'/info')
			send_markdown_message "${CHAT[ID]}" "This is bashbot, the *Telegram* bot written entirely in *bash*."
			;;
		'/start')
			send_action "${CHAT[ID]}" "typing"
			send_markdown_message "${CHAT[ID]}" "Hi ${USER[FIRST_NAME]} 
This is a *bot* written in *shell*
Here you have the commands.

*Available commands*:
 /start _Start bot and get this message_.
 /info _Get shorter info message about this bot_.
 /question _Start interactive chat_.
 /cancel _Cancel any currently running interactive chats_.
 /kickme _You will be autokicked from the chat_.
 /leavechat _The bot will leave the group with this command_.
 /broadcast <text> _The bot will send a broadcast (markdown compatible)_.
 /echo <text> _The bot will send a echo message (markdown compatible)_.
 /myinfo _The bot will send your info user_.
 
*Based* in [telegram-bot-bash](http://github.com/topkecleon/telegram-bot-bash)
Repository of this bot [HERE](https://github.com/iicc1/TgBash)
"
			;;
			
		'/leavechat')
			send_markdown_message "${CHAT[ID]}" "*CHAT LEAVED*"
   			leave_chat "${CHAT[ID]}"
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
fi
